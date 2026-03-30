namespace Weibel.Inventory.Reports;

using Microsoft.Sales.Document;
using Microsoft.Service.Document;
using Microsoft.Inventory.Transfer;
using System.Utilities;
using Microsoft.Foundation.Address;

report 70102 "COL Shipment Label"
{
    Caption = 'Shipment Label';
    UsageCategory = None;
    DefaultRenderingLayout = Rdlc;

    dataset
    {
        dataitem(SalesHeader; "Sales Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = filter(Order));

            dataitem(SalesOrderCopies; Integer)
            {
                DataItemTableView = sorting(Number) order(ascending);

                trigger OnPreDataItem()
                begin
                    if NoOfLabels <= 0 then
                        NoOfLabels := 1;
                    SetRange(Number, 1, NoOfLabels);
                end;
            }

            trigger OnPreDataItem()
            begin
                if DocumentType <> Enum::"COL Shipment Label Doc. Type"::"Sales Order" then
                    CurrReport.Break();
                SetRange("No.", DocumentNo);
            end;

            trigger OnAfterGetRecord()
            begin
                AddHeader(SalesHeader);
            end;
        }

        dataitem(ServiceHeader; "Service Header")
        {
            DataItemTableView = sorting("Document Type", "No.") where("Document Type" = filter(Order));

            dataitem(ServiceOrderCopies; Integer)
            {
                DataItemTableView = sorting(Number) order(ascending);

                trigger OnPreDataItem()
                begin
                    if NoOfLabels <= 0 then
                        NoOfLabels := 1;
                    SetRange(Number, 1, NoOfLabels);
                end;
            }
            trigger OnPreDataItem()
            begin
                if DocumentType <> Enum::"COL Shipment Label Doc. Type"::"Service Order" then
                    CurrReport.Break();
                SetRange("No.", DocumentNo);
            end;

            trigger OnAfterGetRecord()
            begin
                AddHeader(ServiceHeader);
            end;
        }

        dataitem(TmpDoc; Integer)
        {
            DataItemTableView = sorting(Number) order(ascending);
            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = sorting(Number) order(ascending);
                column(DocumentNo; TempSalesHeader."No.")
                {
                }
                column(ShipName; TempSalesHeader."Ship-to Name")
                {
                }
                column(ShipAddress1; TempSalesHeader."Ship-to Address")
                {
                }
                column(ShipAddress2; TempSalesHeader."Ship-to Address 2")
                {
                }
                column(ShipPostCodeAndCity; TempSalesHeader."Ship-to Post Code" + ' ' + TempSalesHeader."Ship-to City")
                {
                }
                column(ShipCountry; CountryTxt)
                {
                }
                column(ShipContact; TempSalesHeader."Ship-to Contact")
                {
                }
                column(OrderNoCap; OrderNoLbl + TempSalesHeader."No.")
                {
                }
                column(PoCap; PONoLbl + TempSalesHeader."External Document No.")
                {
                }
                column(CopyNo; CopyLoop.Number)
                {
                }

                trigger OnPreDataItem()
                begin
                    if NoOfLabels <= 0 then
                        NoOfLabels := 1;
                    SetRange(Number, 1, NoOfLabels);
                end;
            }

            trigger OnPreDataItem()
            begin
                if NoOfLabels <= 0 then
                    NoOfLabels := 1;
                SetRange(Number, 1, TempSalesHeader.Count);
            end;

            trigger OnAfterGetRecord()
            begin
                if TmpDoc.Number = 1 then
                    TempSalesHeader.FindSet()
                else
                    TempSalesHeader.Next();

                if CountryRegion.Get(TempSalesHeader."Ship-to Country/Region Code") then
                    CountryTxt := CountryRegion.Name
                else
                    CountryTxt := TempSalesHeader."Ship-to Country/Region Code";
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
                    field(DocumentTypeCtrl; DocumentType)
                    {
                        Caption = 'Document Type';
                        ToolTip = 'Specifies document type';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            Clear(DocumentNo);
                        end;
                    }
                    field(DocumentNoCtrl; DocumentNo)
                    {
                        Caption = 'Document No.';
                        ToolTip = 'Specifies document No.';
                        ApplicationArea = All;

                        trigger OnValidate()
                        var
                            SalesHeader: Record "Sales Header";
                            ServiceHeader: Record "Service Header";
                        begin
                            if DocumentNo <> '' then
                                case DocumentType of
                                    Enum::"COL Shipment Label Doc. Type"::"Sales Order":
                                        SalesHeader.Get(Enum::"Sales Document Type"::Order, DocumentNo);
                                    Enum::"COL Shipment Label Doc. Type"::"Service Order":
                                        ServiceHeader.Get(Enum::"Service Document Type"::Order, DocumentNo);
                                end;
                        end;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            SalesHeader: Record "Sales Header";
                            ServiceHeader: Record "Service Header";
                        begin
                            case DocumentType of
                                Enum::"COL Shipment Label Doc. Type"::"Sales Order":
                                    begin
                                        SalesHeader.SetRange("Document Type", Enum::"Sales Document Type"::Order);
                                        if Page.RunModal(Page::"Sales Order List", SalesHeader) = Action::LookupOK then
                                            DocumentNo := SalesHeader."No.";
                                    end;
                                Enum::"COL Shipment Label Doc. Type"::"Service Order":
                                    begin
                                        ServiceHeader.SetRange("Document Type", Enum::"Service Document Type"::Order);
                                        if Page.RunModal(Page::"Service Orders", ServiceHeader) = Action::LookupOK then
                                            DocumentNo := ServiceHeader."No.";
                                    end;
                            end;
                        end;
                    }
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
            LayoutFile = './src/LabelReports/Layout/COLSalSerShipmentLabel.rdl';
        }
    }

    var
        TempSalesHeader: Record "Sales Header" temporary;
        CountryRegion: Record "Country/Region";
        DocumentType: Enum "COL Shipment Label Doc. Type";
        DocumentNo: Code[20];
        CountryTxt: Text;
        NoOfLabels: Integer;
        OrderNoLbl: Label 'Sales Order No.:';
        PONoLbl: Label 'PO:';

    procedure InitRequest(NewDocumentType: Enum "COL Shipment Label Doc. Type"; NewDocumentNo: Code[20])
    begin
        DocumentType := NewDocumentType;
        DocumentNo := NewDocumentNo;
        NoOfLabels := 1;
    end;

    local procedure AddHeader(Rec: Record "Sales Header")
    begin
        TempSalesHeader."Document Type" := TempSalesHeader."Document Type"::Order;
        TempSalesHeader."No." := Rec."No.";
        TempSalesHeader."Ship-to Name" := Rec."Ship-to Name";
        TempSalesHeader."Ship-to Address" := Rec."Ship-to Address";
        TempSalesHeader."Ship-to Address 2" := Rec."Ship-to Address 2";
        TempSalesHeader."Ship-to Post Code" := Rec."Ship-to Post Code";
        TempSalesHeader."Ship-to City" := Rec."Ship-to City";
        TempSalesHeader."Ship-to Country/Region Code" := Rec."Ship-to Country/Region Code";
        TempSalesHeader."Ship-to Contact" := Rec."Ship-to Contact";
        TempSalesHeader."External Document No." := Rec."External Document No.";
        if not TempSalesHeader.Insert() then
            TempSalesHeader.Modify();
    end;

    local procedure AddHeader(Rec: Record "Service Header")
    begin
        TempSalesHeader."Document Type" := TempSalesHeader."Document Type"::Order;
        TempSalesHeader."No." := Rec."No.";
        TempSalesHeader."Ship-to Name" := Rec."Ship-to Name";
        TempSalesHeader."Ship-to Address" := Rec."Ship-to Address";
        TempSalesHeader."Ship-to Address 2" := Rec."Ship-to Address 2";
        TempSalesHeader."Ship-to Post Code" := Rec."Ship-to Post Code";
        TempSalesHeader."Ship-to City" := Rec."Ship-to City";
        TempSalesHeader."Ship-to Country/Region Code" := Rec."Ship-to Country/Region Code";
        TempSalesHeader."Ship-to Contact" := Rec."Ship-to Contact";
        TempSalesHeader."External Document No." := Rec."External Document No.";
        if not TempSalesHeader.Insert() then
            TempSalesHeader.Modify();
    end;
}