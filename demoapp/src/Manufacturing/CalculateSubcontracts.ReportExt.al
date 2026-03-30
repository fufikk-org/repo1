
namespace Weibel.Manufacturing.Planning;

using Microsoft.Manufacturing.Planning;
using Microsoft.Manufacturing.Document;

reportextension 70100 "COL Calculate Subcontracts" extends "Calculate Subcontracts"
{
    dataset
    {
        modify("Prod. Order Routing Line")
        {
            trigger OnBeforeAfterGetRecord()
            begin
                // Requirement 244
                if SkipRoutingLine() then
                    "Prod. Order Routing Line"."COL Skip Routing Line" := true;
                // CurrentReport.Skip(); - not working properly
                // Update 2026-01-05: see comment on the field.
            end;
        }
    }

    requestpage
    {
        layout
        {
            addlast(Content)
            {
                group("COL General")
                {
                    Caption = 'General';
                    field("COL Include Previous Operation Finished"; COLIncludePrevOperationFinished)
                    {
                        ApplicationArea = All;
                        Caption = 'Include only if prev. operation is finished';
                        ToolTip = 'Specifies whether to include only the routing lines where the previous operation is finished.';
                    }
                }
            }
        }
    }

    protected var
        COLIncludePrevOperationFinished: Boolean;

    local procedure SkipRoutingLine(): Boolean
    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
    begin
        if not COLIncludePrevOperationFinished then
            exit(false);

        if "Prod. Order Routing Line"."Previous Operation No." = '' then
            exit(false);

        if not ProdOrderRoutingLine.Get("Prod. Order Routing Line".Status,
                                        "Prod. Order Routing Line"."Prod. Order No.",
                                        "Prod. Order Routing Line"."Routing Reference No.",
                                        "Prod. Order Routing Line"."Routing No.",
                                        "Prod. Order Routing Line"."Previous Operation No.") then
            exit(false);

        // If the previous operation is not finished, skip the record
        exit(ProdOrderRoutingLine."Routing Status" <> ProdOrderRoutingLine."Routing Status"::Finished);
    end;
}