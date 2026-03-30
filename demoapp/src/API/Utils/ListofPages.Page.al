namespace Weibel.Utilities;

using System.Reflection;

page 70193 "COL List of Pages"
{
    ApplicationArea = All;
    Caption = 'Pages';
    PageType = List;
    SourceTable = AllObjWithCaption;
    UsageCategory = Administration;
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Object ID"; Rec."Object ID")
                {
                    ToolTip = 'Specifies the value of the Object ID field.';
                }
                field("Object Name"; Rec."Object Name")
                {
                    ToolTip = 'Specifies the value of the Object Name field.';
                }
                field("Object Caption"; Rec."Object Caption")
                {
                    ToolTip = 'Specifies the value of the Object Caption field.';
                }
            }
        }
    }
}
