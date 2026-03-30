namespace Weibel.Warehouse.Activity;

using Microsoft.Warehouse.Activity;
using Microsoft.Warehouse.Worksheet;
using Microsoft.Manufacturing.Routing;
using Microsoft.Manufacturing.Document;
using Microsoft.Manufacturing.WorkCenter;
using Weibel.Manufacturing.Routing.Handler;
using Microsoft.Warehouse.Structure;

reportextension 70103 "COL Create Pick" extends "Create Pick"
{
    dataset
    {
        modify("Integer")
        {
            trigger OnBeforePreDataItem()
            begin
                COLOnBeforePreDataItem();
            end;

            trigger OnAfterPreDataItem()
            begin
                SetPickWhseWkshLineCustomFilter();
            end;
        }
    }

    requestpage
    {
        layout
        {
            modify(PrintPick)
            {
                trigger OnAfterValidate()
                begin
                    if PrintPick then
                        COLPrintWarPick := false;
                end;
            }
            addafter(PrintPick)
            {
                field("COL Work Center Code"; COLWorkCenterCode)
                {
                    Caption = 'Work Center Code';
                    ToolTip = 'Specifies the Work Center Code to be used for the document creation.';
                    TableRelation = "Work Center";
                    ApplicationArea = All;
                }
                field("COL Routing Link Code"; COLRoutingLinkCode)
                {
                    Caption = 'Routing Link Code';
                    ToolTip = 'Specifies the Routing Link Code to be used for the document creation.';
                    TableRelation = "Routing Link";
                    ApplicationArea = All;
                }
                field("COL PrintWarPick"; COLPrintWarPick)
                {
                    Caption = 'Print Warehouse Pick';
                    ToolTip = 'Print Warehouse Pick for all documents.';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if COLPrintWarPick then
                            PrintPick := false;
                    end;
                }
            }
            addafter(PerZone)
            {
                field("COL Pick Zone Code Filter"; COLPickZoneCodeFilter)
                {
                    Caption = 'Pick Zone Code Filter';
                    ToolTip = 'Specifies the zone from which the Picks should be created.';
                    ApplicationArea = All;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Zone: Record Zone;
                    begin
                        Zone.SetRange("Location Code", COLLocationCode);
                        if Page.RunModal(0, Zone) = Action::LookupOK then
                            COLPickZoneCodeFilter := Zone.Code;
                    end;

                    trigger OnValidate()
                    var
                        Zone: Record Zone;
                    begin
                        if COLPickZoneCodeFilter <> '' then
                            if COLLocationCode <> '' then
                                Zone.Get(COLLocationCode, COLPickZoneCodeFilter);
                    end;
                }
            }
        }

        trigger OnOpenPage()
        begin
            Clear(COLRoutingLinkCode);
            COLOnAfterOpenRequestPage();

        end;
    }

    trigger OnPreReport()
    begin
        COLStaticCreatePicSM.InitCreatePick(UserId());
    end;

    trigger OnPostReport()
    var
        filterVal: Text;
    begin
        if COLPrintWarPick then begin
            filterVal := COLStaticCreatePicSM.GetPickToPrintFilter(UserId());
            PrintPickWarehouse(filterVal);
        end;
    end;

    protected var
        COLCreatePickHandler: Codeunit "COL Create Pick Handler";
        COLStaticCreatePicSM: Codeunit "COL Create Pic SM";
        COLPickZoneCodeFilter: Code[20];
        COLLocationCode: Code[10];
        COLRoutingLinkCode: Text;
        COLWorkCenterCode: Text[250];
        COLPrintWarPick: Boolean;

    local procedure PrintPickWarehouse(FilterTxt: Text)
    begin
        if FilterTxt = '' then
            exit;

        COLStaticCreatePicSM.PrintPickWarehouse(FilterTxt);
    end;

    local procedure SetPickWhseWkshLineCustomFilter()
    begin
        if (COLRoutingLinkCode = '') and (COLWorkCenterCode = '') then
            exit;

        if COLRoutingLinkCode <> '' then
            // COLRoutingLinkCode += '|'''''; // Filter on the specific and empty Routing Link Code.
            PickWhseWkshLine.SetFilter("COL Routing Link Code", COLRoutingLinkCode)
        else begin
            SetWorkCenterFilterField();
            PickWhseWkshLine.SetRange("COL Valid Work Center", true);
        end;
    end;

    local procedure SetWorkCenterFilterField()
    var
        WhseWorksheetLine: Record "Whse. Worksheet Line";
        ProductionLine: Record "Prod. Order Line";
        RecordMatch: Boolean;
    begin
        WhseWorksheetLine.SetRange("Whse. Document Type", WhseWorksheetLine."Whse. Document Type"::Production);
        WhseWorksheetLine.SetRange("Source Document", WhseWorksheetLine."Source Document"::"Prod. Consumption");
        if WhseWorksheetLine.FindSet() then
            repeat
                ProductionLine.Get(ProductionLine.Status::Released, WhseWorksheetLine."Whse. Document No.", WhseWorksheetLine."Whse. Document Line No.");
                RecordMatch := COLCreatePickHandler.CheckProdRoutCodes(COLWorkCenterCode, ProductionLine);
                WhseWorksheetLine."COL Valid Work Center" := RecordMatch;
                WhseWorksheetLine.Modify();
            until WhseWorksheetLine.Next() = 0;
    end;

    internal procedure COLSetLocationCode(NewLocationCode: Code[10])
    begin
        COLLocationCode := NewLocationCode;
    end;

    internal procedure COLGetZoneFilterCode(): Code[20]
    begin
        exit(COLPickZoneCodeFilter);
    end;

    [IntegrationEvent(true, false)]
    local procedure COLOnAfterOpenRequestPage()
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure COLOnBeforePreDataItem()
    begin
    end;
}
