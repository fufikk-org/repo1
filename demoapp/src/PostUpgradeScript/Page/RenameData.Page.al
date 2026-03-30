namespace Weibel.UpgradeScript;

using Weibel.UpgradeScript;

page 70218 "COL Rename Data"
{
    ApplicationArea = All;
    Caption = 'Rename Data';
    PageType = List;
    SourceTable = "COL Rename Data";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.', Comment = '%';
                }
                field("Rename Type"; Rec."Rename Type")
                {
                    ToolTip = 'Specifies the value of the Rename Type field.', Comment = '%';
                }
                field("Old No."; Rec."Old No.")
                {
                    ToolTip = 'Specifies the value of the Old No. field.', Comment = '%';
                }
                field("New No."; Rec."New No.")
                {
                    ToolTip = 'Specifies the value of the New No. field.', Comment = '%';
                }
                field(Selected; Rec.Selected)
                {
                    ToolTip = 'Specifies the value of the Selected field.', Comment = '%';
                }
                field(Processed; Rec.Processed)
                {
                    ToolTip = 'Specifies the value of the Processed field.', Comment = '%';
                }
                field("Error"; Rec.Error)
                {
                    ToolTip = 'Specifies the value of the Error field.', Comment = '%';
                }
                field("Error Description"; Rec."Error Description")
                {
                    ToolTip = 'Specifies the value of the Error Description field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("COL Process Rename Data")
            {
                ApplicationArea = All;
                Caption = 'Select';
                Image = Process;
                ToolTip = 'Select lines.';

                trigger OnAction()
                var
                    RenameData: Record "COL Rename Data";
                begin
                    CurrPage.SetSelectionFilter(RenameData);
                    RenameData.ModifyAll(Selected, true, false);
                end;
            }
            action("COL DeSelect")
            {
                ApplicationArea = All;
                Caption = 'Deselect';
                Image = Process;
                ToolTip = 'Select lines.';

                trigger OnAction()
                var
                    RenameData: Record "COL Rename Data";
                begin
                    CurrPage.SetSelectionFilter(RenameData);
                    RenameData.ModifyAll(Selected, false, false);
                end;
            }
            action("COL Process selected data")
            {
                ApplicationArea = All;
                Caption = 'Process selected data';
                Image = Process;
                ToolTip = 'Process selected data.';

                trigger OnAction()
                var
                    RenameDataProcess: Codeunit "COL Rename Data Process";
                begin
                    RenameDataProcess.Run();
                end;
            }
        }
    }
}
