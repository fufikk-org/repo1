namespace Weibel.Packaging;

using Microsoft.Warehouse.Document;

page 70115 "COL Package Dimension List"
{
    ApplicationArea = All;
    Caption = 'Package Dimension List';
    PageType = List;
    SourceTable = "COL Package Dimension";
    UsageCategory = None;
    PopulateAllFields = true;
    DelayedInsert = true;
    DataCaptionFields = "Document Type", "Document No.";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                FreezeColumn = "Package Type Code";

                field("Document Type"; Rec."Document Type")
                {
                    Visible = false;
                    Editable = false;
                    ValuesAllowed = "Sales Order", "Service Order";
                }
                field("Document No."; Rec."Document No.")
                {
                    Visible = false;
                    Editable = false;
                }
                field("Package No."; Rec."Package No.")
                {
                    ShowMandatory = true;
                }
                field("Package Type Code"; Rec."Package Type Code")
                {
                    ShowMandatory = true;
                }
                field(Description; Rec.Description)
                {
                }
                field(Length; Rec.Length)
                {
                }
                field(Width; Rec.Width)
                {
                }
                field(Height; Rec.Height)
                {
                }
                field("Gross Shipment Weight"; Rec."Gross Shipment Weight")
                {
                }
                field("Warehouse Shipment No."; Rec."COL Warehouse Shipment No.")
                {
                }
                field("COL Source Line"; Rec."COL Source Line")
                {
                    Editable = false;
                }
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Rec.SetupNewLine(BelowxRec, xRec);
    end;
}
