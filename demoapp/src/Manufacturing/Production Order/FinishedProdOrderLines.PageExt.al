namespace Weibel.Manufacturing.Document;

using Microsoft.Manufacturing.Document;
using Weibel.Inventory.Item;

pageextension 70210 "COL Finished Prod. Order Lines" extends "Finished Prod. Order Lines"
{
    layout
    {
        addafter("Variant Code")
        {
            field("COL Product Life Cycle"; Rec."COL Product Life Cycle")
            {
                ApplicationArea = Suite;
                Importance = Additional;
            }
        }
    }

    actions
    {
        addafter("Item &Tracking Lines")
        {
            action("COL Print Label")
            {
                ApplicationArea = All;
                Caption = 'Print Label';
                Image = Print;
                ToolTip = 'Print Label for selected line.';

                trigger OnAction()
                var
                    WeibelItemODCLabel: Report "COL Weibel Item ODC Label";
                begin
                    WeibelItemODCLabel.InitFrom(Rec);
                    WeibelItemODCLabel.RunModal();
                end;
            }
        }
    }
}
