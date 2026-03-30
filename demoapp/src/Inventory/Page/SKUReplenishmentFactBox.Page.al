page 70237 "COL SKU Replenishment FactBox"
{
    Caption = 'SKU Details - Replenishment';
    PageType = CardPart;
    SourceTable = "Stockkeeping Unit";
    layout
    {
        area(content)
        {
            field("SKU No."; Rec."Item No." + (Rec."Variant Code" <> '' ? Format('-') : '') + Rec."Variant Code" + (Rec."Location Code" <> '' ? Format('-') : '') + Rec."Location Code")
            {
                ApplicationArea = Planning;
                Caption = 'SKU No.';
                ToolTip = 'Specifies the number of the item.';
                trigger OnDrillDown()
                begin
                    ShowDetails();
                end;
            }
            field("Replenishment System"; Rec."Replenishment System")
            {
                ApplicationArea = Planning;
                ToolTip = 'Specifies the type of supply order that is created by the planning system when the item needs to be replenished.';
            }
            group(Purchase)
            {
                Caption = 'Purchase';
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = Planning;
                    Lookup = false;
                    ToolTip = 'Specifies the code of the vendor from whom this item is supplied by default.';
                    trigger OnDrillDown()
                    var
                        Vendor: Record Vendor;
                    begin
                        if Rec."Vendor No." <> '' then begin
                            Vendor.SetRange("No.", Rec."Vendor No.");
                            Page.Run(Page::"Vendor Card", Vendor);
                        end;
                    end;
                }
                field("Vendor Item No."; Rec."Vendor Item No.")
                {
                    ApplicationArea = Planning;
                    Lookup = false;
                    ToolTip = 'Specifies the number that the vendor uses for this item.';
                }
            }
        }
    }
    local procedure ShowDetails()
    begin
        Page.Run(Page::"Stockkeeping Unit Card", Rec);
    end;
}

