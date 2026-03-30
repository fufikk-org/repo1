namespace Weibel.Warehouse.Structure;

using Microsoft.Warehouse.Structure;
using System.Utilities;
using System.Environment.Configuration;

page 70272 "COL Bin Content FactBox"
{
    ApplicationArea = All;
    Caption = 'Bin Contents';
    PageType = ListPart;
    SourceTable = "Bin Content";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Bin Code"; Rec."Bin Code")
                {
                    ToolTip = 'Specifies the bin where the items are picked or put away.';
                }
                field(Fixed; Rec."Fixed")
                {
                    ToolTip = 'Specifies that the item (bin content) has been associated with this bin, and that the bin should normally contain the item.';
                }
                field(Default; Rec.Default)
                {
                    ToolTip = 'Specifies if the bin is the default bin for the associated item.';
                }
                field(Dedicated; Rec.Dedicated)
                {
                    ToolTip = 'Specifies if the bin is used as a dedicated bin, which means that its bin content is available only to certain resources.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
            }
        }
    }
}
