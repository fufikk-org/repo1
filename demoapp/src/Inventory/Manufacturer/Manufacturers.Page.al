namespace Weibel.Inventory.Item;

page 70214 "COL Manufacturers"
{
    PageType = List;
    Caption = 'Preferred Manufacturers';
    SourceTable = "COL Manufacturer";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(general)
            {

                field("Code"; Rec."Code")
                {
                }
                field(Name; Rec.Name)
                {
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                }
                field(Website; Rec.Website)
                {
                    ExtendedDatatype = URL;
                }
            }
        }

        area(FactBoxes)
        {
            part(ManufacturerFactbox; "COL Manufacturer Factbox")
            {
                ApplicationArea = All;
                Caption = 'Manufacturer Details';
                SubPageLink = "Code" = field(Code);
            }
            systempart(Links; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }
}