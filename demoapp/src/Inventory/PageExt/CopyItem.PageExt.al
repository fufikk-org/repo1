namespace Weibel.Inventory.Item;

using Microsoft.Inventory.Item;

pageextension 70190 "COL Copy Item" extends "Copy Item"
{
    layout
    {
        addafter(General)
        {
            group("COL Weibel")
            {
                Visible = NewProcess;
                Caption = 'Weibel';
                field("COL Item Template Code"; Rec."COL Item Template Code")
                {
                    ApplicationArea = All;
                }
                field("COL Production BOM"; Rec."COL Production BOM")
                {
                    ApplicationArea = All;
                }
                field("COL Routing"; Rec."COL Routing")
                {
                    ApplicationArea = All;
                }
                field("COL Links"; Rec."COL Links")
                {
                    ApplicationArea = All;
                }
                field("COL Notes"; Rec."COL Notes")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter(ItemVariants)
        {
            field("COL Variant Links"; Rec."COL Variant Links")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies, if the variant links should be copied. This option requires that ''Item Variants'' is selected.';
            }
        }

        modify(TargetNoSeries)
        {
            Visible = not NewProcess;
        }
        modify(NumberOfCopies)
        {
            Visible = not NewProcess;
        }

    }

    var
        NewProcess: Boolean;

    trigger OnOpenPage()
    begin
        NewProcess := Rec."COL New Process";
    end;

}
