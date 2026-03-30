namespace Weibel.Manufacturing.Archive;

using Microsoft.Finance.Dimension;
using Microsoft.Inventory.Item;

page 70121 "COL Prod. Order Com. Archive"
{
    Caption = 'Prod. Order Components Archive';
    Editable = false;
    PageType = List;
    SourceTable = "COL Prod. Order Component Arch";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = Planning;
                    Visible = false;
                    ShowMandatory = VariantCodeMandatory;
                }
                field("Due Date-Time"; Rec."Due Date-Time")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Manufacturing;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Manufacturing;
                }
                field("Scrap %"; Rec."Scrap %")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Calculation Formula"; Rec."Calculation Formula")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field(Length; Rec.Length)
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field(Width; Rec.Width)
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field(Weight; Rec.Weight)
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field(Depth; Rec.Depth)
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Quantity per"; Rec."Quantity per")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    ApplicationArea = Reservation;
                    Visible = false;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Flushing Method"; Rec."Flushing Method")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Expected Quantity"; Rec."Expected Quantity")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    Visible = false;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    Visible = false;
                }
                field("ShortcutDimCode[3]"; ShortcutDimCode[3])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,3';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Dimension field.';

                }
                field("ShortcutDimCode[4]"; ShortcutDimCode[4])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,4';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Dimension field.';

                }
                field("ShortcutDimCode[5]"; ShortcutDimCode[5])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,5';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Dimension field.';

                }
                field("ShortcutDimCode[6]"; ShortcutDimCode[6])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,6';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Dimension field.';

                }
                field("ShortcutDimCode[7]"; ShortcutDimCode[7])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,7';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Dimension field.';

                }
                field("ShortcutDimCode[8]"; ShortcutDimCode[8])
                {
                    ApplicationArea = Dimensions;
                    CaptionClass = '1,2,8';
                    Visible = false;
                    ToolTip = 'Specifies the value of the Dimension field.';
                }
                field("Routing Link Code"; Rec."Routing Link Code")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Location;
                    Visible = false;

                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = Warehouse;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Cost Amount"; Rec."Cost Amount")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("COL Position"; Rec."COL Position")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Position 2"; Rec."Position 2")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Position 3"; Rec."Position 3")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("COL Position 3"; Rec."COL Position 3")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Lead-Time Offset"; Rec."Lead-Time Offset")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Qty. Picked"; Rec."Qty. Picked")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Qty. Picked (Base)"; Rec."Qty. Picked (Base)")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Substitution Available"; Rec."Substitution Available")
                {
                    ApplicationArea = Manufacturing;
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
                action(Dimensions)
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    ToolTip = 'Specifies the list of the Dimensions.';
                    Image = Dimensions;
                    ShortCutKey = 'Alt+D';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions();
                        CurrPage.SaveRecord();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        Item: Record Item;
    begin
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        if Rec."Variant Code" = '' then
            VariantCodeMandatory := Item.IsVariantMandatory(true, Rec."Item No.");
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Clear(ShortcutDimCode);
    end;

    var
        VariantCodeMandatory: Boolean;

    protected var
        ShortcutDimCode: array[8] of Code[20];
}

