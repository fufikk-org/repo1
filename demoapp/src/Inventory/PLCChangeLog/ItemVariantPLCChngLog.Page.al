page 70133 "COL Item Variant PLC Chng. Log"
{
    PageType = List;
    SourceTable = "COL Item Variant PLC Chng. Log";
    Caption = 'Item Variant PLC Change Log';
    ApplicationArea = All;
    Editable = false;
    SourceTableView = sorting("Item No.", "Variant Code", "Entry No.") order(descending);
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Old PLC"; Rec."Old PLC")
                {
                    ApplicationArea = All;
                }
                field("New PLC"; Rec."New PLC")
                {
                    ApplicationArea = All;
                }
                field("Changed By"; Rec."Changed By")
                {
                    ApplicationArea = All;
                }
                field("Date Changed"; Rec."Date Changed")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}