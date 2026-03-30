namespace Weibel.Kardex;

page 70240 "COL Kardex Log Lines"
{
    ApplicationArea = All;
    Caption = 'Kardex Log Lines';
    PageType = List;
    SourceTable = "COL Kardex Log Line";
    UsageCategory = History;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    Editable = FieldEditableSwitch;
                }
                field("Send Messages"; Rec."Send Messages")
                {
                    Editable = FieldEditableSwitch;
                }
                field("Response Messages"; Rec."Response Messages")
                {
                    Editable = FieldEditableSwitch;
                }
                field("Error Response Messages"; Rec."Error Response Messages")
                {
                    Editable = FieldEditableSwitch;
                }
                field("Skip Update From File"; Rec."Skip Update From File")
                {
                }
                field("Inventory Document Updated"; Rec."Inventory Document Updated")
                {
                    Editable = FieldEditableSwitch;
                }
                field("Delete Confirmed"; Rec."Delete Confirmed")
                {
                    Editable = FieldEditableSwitch;
                }
                field(Type; Rec."Type")
                {
                    Editable = FieldEditableSwitch;
                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    Editable = FieldEditableSwitch;
                }
                field("Journal Template Name"; Rec."Journal Template Name")
                {
                    Editable = FieldEditableSwitch;
                }
                field("Ad Hoc"; Rec."Ad Hoc")
                {
                    Editable = FieldEditableSwitch;
                }
                field("Ad Hoc No."; Rec."Ad Hoc No.")
                {
                    Editable = FieldEditableSwitch;
                }
                field("Whs. Type"; Rec."Whs. Type")
                {
                    Editable = FieldEditableSwitch;
                }
                field("No."; Rec."No.")
                {
                    Editable = FieldEditableSwitch;
                }
                field("Send Date And Time"; Rec."Send Date And Time")
                {
                    Editable = FieldEditableSwitch;
                }
                field("Received Date And Time"; Rec."Received Date And Time")
                {
                    Editable = FieldEditableSwitch;
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    Editable = FieldEditableSwitch;
                }
                field("Last Modified User"; Rec."Last Modified User")
                {
                    Editable = FieldEditableSwitch;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(HandleMessage)
            {
                ApplicationArea = All;
                Caption = 'Send Delete Kardex Log';
                Image = Print;
                ToolTip = 'Send Delete Log request to Kardex';

                trigger OnAction()
                var
                    KardexMgt: Codeunit "COL Kardex Mgt.";
                begin
                    KardexMgt.SendDeleteReqToKardex(Rec);
                end;
            }
        }
    }

    var
        FieldEditableSwitch: Boolean;
}
