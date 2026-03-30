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

    protected var
        COLCreatePickHandler: Codeunit "COL Create Pick Handler";
        COLPickZoneCodeFilter: Code[20];
        COLLocationCode: Code[10];
        COLRoutingLinkCode: Text;
        COLWorkCenterCode: Text[250];

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
        ProductionOrder: Record "Production Order";
        RecordMatch: Boolean;
    begin
        WhseWorksheetLine.SetRange("Whse. Document Type", WhseWorksheetLine."Whse. Document Type"::Production);
        WhseWorksheetLine.SetRange("Source Document", WhseWorksheetLine."Source Document"::"Prod. Consumption");
        if WhseWorksheetLine.FindSet() then
            repeat
                ProductionOrder.Get(ProductionOrder.Status::Released, WhseWorksheetLine."Whse. Document No.");
                RecordMatch := COLCreatePickHandler.CheckRoutCodes(COLWorkCenterCode, WhseWorksheetLine."COL Routing Link Code", ProductionOrder."Routing No.");
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
