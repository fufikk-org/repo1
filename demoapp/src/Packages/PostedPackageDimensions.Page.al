namespace Weibel.Packaging;

page 70117 "COL Posted Package Dimensions"
{
    ApplicationArea = All;
    Caption = 'Posted Package Dimensions';
    PageType = List;
    SourceTable = "COL Posted Package Dimension";
    UsageCategory = None;
    Editable = false;
    DataCaptionFields = "Document No.";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                FreezeColumn = "Package Type Code";

                field("Table Id"; Rec."Table Id")
                {
                    Visible = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    Visible = false;
                }
                field("Package No."; Rec."Package No.")
                {
                }
                field("Package Type Code"; Rec."Package Type Code")
                {
                }
                field(Description; Rec.Description)
                {
                }
                field(Length; Rec.Length)
                {
                }
                field(Width; Rec.Width)
                {
                }
                field(Height; Rec.Height)
                {
                }
                field("Gross Shipment Weight"; Rec."Gross Shipment Weight")
                {
                }
                field("COL Warehouse Shipment No."; Rec."COL Warehouse Shipment No.")
                {
                }
                field("COL Source Line"; Rec."COL Source Line")
                {
                }
            }
        }
    }
}
