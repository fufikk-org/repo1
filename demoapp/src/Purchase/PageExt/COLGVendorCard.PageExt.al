pageextension 70249 "COL COLG Vendor Card" extends "Vendor Card"
{
    layout
    {
        addlast(General)
        {
            field("COL Statistics Group"; Rec."Statistics Group")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the statistics group for the vendor.';
            }
        }
    }


}