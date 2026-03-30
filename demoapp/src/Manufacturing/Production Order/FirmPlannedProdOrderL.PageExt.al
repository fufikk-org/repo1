namespace Weibel.Manufacturing.Document;

using Microsoft.Manufacturing.Document;
using Weibel.Common;

pageextension 70215 "COL Firm Planned Prod. Order.L" extends "Firm Planned Prod. Order Lines"
{
    layout
    {
        addafter("Variant Code")
        {
            field("COL Product Life Cycle"; Rec."COL Product Life Cycle")
            {
                ApplicationArea = Suite;
                Importance = Additional;
            }
        }
    }

    trigger OnModifyRecord(): Boolean
    var
        ProductionOrder: Record "Production Order";
        FieldSelect: Codeunit "COL Field Select Mgt";
    begin
        if not GuiAllowed() then
            exit;

        ProductionOrder.Get(Rec.Status, Rec."Prod. Order No.");
        if (ProductionOrder."COL Internal Status" = ProductionOrder."COL Internal Status"::Released) then
            FieldSelect.CheckIfModifyAllowed(Rec, xRec);
    end;
}
