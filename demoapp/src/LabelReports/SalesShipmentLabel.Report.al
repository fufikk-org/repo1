namespace Weibel.Inventory.Reports;

using Microsoft.Sales.Document;
using Microsoft.Service.Document;
using Microsoft.Inventory.Transfer;
using Microsoft.Foundation.Address;
using System.Utilities;

report 70103 "COL Sales Shipment Label"
{
    Caption = 'Sales Shipment Label';
    UsageCategory = None;
    DefaultRenderingLayout = Rdlc;

    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = filter(Order));
            RequestFilterFields = "No.";

            column(DocumentNo; SalesHeader."No.")
            {
            }
            column(ShipName; SalesHeader."Ship-to Name")
            {
            }
            column(ShipAddress1; SalesHeader."Ship-to Address")
            {
            }
            column(ShipAddress2; SalesHeader."Ship-to Address 2")
            {
            }
            column(ShipPostCodeAndCity; SalesHeader."Ship-to Post Code" + ' ' + SalesHeader."Ship-to City")
            {
            }
            column(ShipCountry; CountryTxt)
            {
            }
            column(ShipContact; SalesHeader."Ship-to Contact")
            {
            }
            column(OrderNoCap; OrderNoLbl + SalesHeader."No.")
            {
            }
            column(PoCap; PONoLbl + SalesHeader."External Document No.")
            {
            }

            dataitem(SalesOrderCopies; Integer)
            {
                DataItemTableView = sorting(Number) order(ascending);

                column(CopyNo; SalesOrderCopies.Number)
                {
                }

                trigger OnPreDataItem()
                begin
                    if NoOfLabels <= 0 then
                        NoOfLabels := 1;
                    SetRange(Number, 1, NoOfLabels);
                end;
            }

            trigger OnAfterGetRecord()
            begin
                if CountryRegion.Get(SalesHeader."Ship-to Country/Region Code") then
                    CountryTxt := CountryRegion.Name
                else
                    CountryTxt := SalesHeader."Ship-to Country/Region Code";
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(NoOfLabelsCtrl; NoOfLabels)
                    {
                        Caption = 'No. of Labels';
                        ToolTip = 'Specifies how many labels should be printed for the document.';
                        ApplicationArea = All;
                    }
                }
            }
        }

        trigger OnOpenPage()
        begin
            if NoOfLabels = 0 then
                NoOfLabels := 1;
        end;
    }


    rendering
    {
        layout(Rdlc)
        {
            Type = RDLC;
            LayoutFile = './src/LabelReports/Layout/COLShipmentLabel.rdl';
        }
    }

    var
        CountryRegion: Record "Country/Region";
        CountryTxt: Text;
        NoOfLabels: Integer;
        OrderNoLbl: Label 'Sales Order No.:';
        PONoLbl: Label 'PO:';
}