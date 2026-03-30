namespace Weibel.Manufacturing.Document;

using Weibel.Common;
using Microsoft.Manufacturing.Document;

pageextension 70167 "COL Prod. Order Routing" extends "Prod. Order Routing"
{
    layout
    {
        addafter(Description)
        {
            field("COL Lock"; Rec."COL Lock")
            {
                ApplicationArea = All;
            }
        }
        addlast(Control1)
        {
#pragma warning disable AA0218
            field("COL Routing Status"; Rec."Routing Status")
            {
                ApplicationArea = All;
            }
#pragma warning restore AA0218
            field("COL Purchase Order No."; Rec."COL Purchase Order No.")
            {
                ApplicationArea = All;
            }
            field("COL Purchase Invoice No."; Rec."COL Purchase Invoice No.")
            {
                ApplicationArea = All;
            }
            field("COL In Progress Date-Time"; Rec."COL In Progress Date-Time")
            {
                ApplicationArea = All;
                Visible = false;
                Editable = not Rec."COL Lock";
            }
            field("COL In Progress Set By User"; Rec."COL In Progress Set By User")
            {
                ApplicationArea = All;
                Visible = false;
                Editable = not Rec."COL Lock";
            }
            field("COL Finished Date-Time"; Rec."COL Finished Date-Time")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
            field("COL Finished By User"; Rec."COL Finished By User")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
            field("COL Prod. Order Item No."; Rec."COL Prod. Order Item No.")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
            field("COL Prod. Order Variant Code"; Rec."COL Prod. Order Variant Code")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
            field("COL Prod. Order Quantity"; Rec."COL Prod. Order Quantity")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
            field("COL Prod. Order Rem. Quantity"; Rec."COL Prod. Order Rem. Quantity")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
            }
            field("COL Prod. Order Fin. Quantity"; Rec."COL Prod. Order Fin. Quantity")
            {
                ApplicationArea = All;
                Editable = false;
                Visible = false;
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
