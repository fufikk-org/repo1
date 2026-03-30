namespace Weibel.Inventory.Reports;

using Microsoft.Sales.Document;
using Microsoft.Service.Document;
using Microsoft.Inventory.Transfer;
using Microsoft.Foundation.Address;
using System.Utilities;

report 70104 "COL Service Shipment Label"
{
    Caption = 'Service Shipment Label';
    UsageCategory = None;
    DefaultRenderingLayout = Rdlc;

    dataset
    {
        dataitem(ServiceHeader; "Service Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = filter(Order));
            RequestFilterFields = "No.";

            column(DocumentNo; ServiceHeader."No.")
            {
            }
            column(ShipName; ServiceHeader."Ship-to Name")
            {
            }
            column(ShipAddress1; ServiceHeader."Ship-to Address")
            {
            }
            column(ShipAddress2; ServiceHeader."Ship-to Address 2")
            {
            }
            column(ShipPostCodeAndCity; ServiceHeader."Ship-to Post Code" + ' ' + ServiceHeader."Ship-to City")
            {
            }
            column(ShipCountry; CountryTxt)
            {
            }
            column(ShipContact; ServiceHeader."Ship-to Contact")
            {
            }
            column(OrderNoCap; OrderNoLbl + ServiceHeader."No.")
            {
            }
            column(PoCap; PONoLbl + ServiceHeader."External Document No.")
            {
            }

            dataitem(ServiceOrderCopies; Integer)
            {
                DataItemTableView = sorting(Number) order(ascending);

                column(CopyNo; ServiceOrderCopies.Number)
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
                if CountryRegion.Get(ServiceHeader."Ship-to Country/Region Code") then
                    CountryTxt := CountryRegion.Name
                else
                    CountryTxt := ServiceHeader."Ship-to Country/Region Code";
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
            LayoutFile = './src/LabelReports/Layout/COLServiceShipmentLabel.rdl';
        }
    }

    var
        CountryRegion: Record "Country/Region";
        CountryTxt: Text;
        NoOfLabels: Integer;
        OrderNoLbl: Label 'Sales Order No.:';
        PONoLbl: Label 'PO:';
}