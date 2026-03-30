namespace Weibel.Inventory.Item;

page 70216 "COL Manufacturer Factbox"
{
    ApplicationArea = All;
    Caption = 'Manufacturer Factbox';
    PageType = CardPart;
    SourceTable = "COL Manufacturer";

    layout
    {
        area(Content)
        {
            group(General)
            {
                ShowCaption = false;

                field("No. of Items"; Rec."No. of Items")
                {
                }
            }
        }
    }
}
