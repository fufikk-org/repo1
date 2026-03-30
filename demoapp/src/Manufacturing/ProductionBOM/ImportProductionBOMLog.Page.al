namespace Weibel.Manufacturing.ProductionBOM;

page 70227 "COL Import Production BOM Log"
{
    ApplicationArea = All;
    Caption = 'Import Production BOM Log';
    PageType = List;
    SourceTable = "COL Import Production BOM Log";
    UsageCategory = Lists;
    ObsoleteState = Pending;
    ObsoleteReason = 'Replaced by functionality in src/Manufacturing/ImportBOMLines';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies Import Log No.';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Error"; Rec.Error)
                {
                    ToolTip = 'Specifies the value of the Error field.';
                }
                field("Run Date Time"; Rec."Run Date Time")
                {
                    ToolTip = 'Specifies the value of the Run Date Time field.';
                }
                field("Run by User"; Rec."Run by User")
                {
                    ToolTip = 'Specifies the value of the Run by User field.';
                }
            }
        }
    }
}
