namespace Weibel.Inventory.LegacyItems;

page 70192 "COL Legacy Items"
{
    ApplicationArea = All;
    Caption = 'Legacy Items';
    PageType = List;
    SourceTable = "COL Legacy Item";
    UsageCategory = Lists;
    InsertAllowed = false;
    DeleteAllowed = true;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("NAV Item No."; Rec."NAV Item No.")
                {
                }
                field("NAV Item Description"; Rec."NAV Item Description")
                {
                }
                field("NAV Item Description 2"; Rec."NAV Item Description 2")
                {
                }
                field("Item No."; Rec."Item No.")
                {
                }
                field("Item Description"; Rec."Item Description")
                {
                    Visible = false;
                }
                field("Item Description 2"; Rec."Item Description 2")
                {
                    Visible = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                }
                field("Variant Description"; Rec."Variant Description")
                {
                    Visible = false;
                }
                field("Variant Description 2"; Rec."Variant Description 2")
                {
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ImportLegacyItems)
            {
                ApplicationArea = All;
                Caption = 'Import Legacy Items';
                Image = XMLFile;
                ToolTip = 'Import legacy items from an xml file.';
                RunObject = xmlport "COL Import Legacy Items";

            }
        }

        area(Promoted)
        {
            actionref(ImportLegacyItems_Promoted; ImportLegacyItems) { }
        }
    }
}
