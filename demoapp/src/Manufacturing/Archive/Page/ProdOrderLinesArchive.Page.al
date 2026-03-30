namespace Weibel.Manufacturing.Archive;

using Microsoft.Finance.Dimension;
using Microsoft.Inventory.Item;

page 70120 "COL Prod. Order Lines Archive"
{
    Caption = 'Lines';
    PageType = ListPart;
    SourceTable = "COL Prod. Order Line Archive";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                IndentationColumn = DescriptionIndent;
                IndentationControls = Description;
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
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Planning Flexibility"; Rec."Planning Flexibility")
                {
                    ApplicationArea = Planning;
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Manufacturing;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Production BOM No."; Rec."Production BOM No.")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Routing Version Code"; Rec."Routing Version Code")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Production BOM Version Code"; Rec."Production BOM Version Code")
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
                    Visible = false;
                }
                field("Starting Date-Time"; Rec."Starting Date-Time")
                {
                    ApplicationArea = Manufacturing;

                }
                field("Starting Time"; StartingTime)
                {
                    Caption = 'Starting Time';
                    ApplicationArea = Manufacturing;
                    Visible = DateAndTimeFieldVisible;
                    ToolTip = 'Specifies the value of the StartingTime field.';

                }
                field("Starting Date"; StartingDate)
                {
                    Caption = 'Starting Date';
                    ApplicationArea = Manufacturing;
                    Visible = DateAndTimeFieldVisible;
                    ToolTip = 'Specifies the value of the StartingDate field.';

                }
                field("Ending Date-Time"; Rec."Ending Date-Time")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Ending Time"; EndingTime)
                {
                    Caption = 'Ending Time';
                    ApplicationArea = Manufacturing;
                    Visible = DateAndTimeFieldVisible;
                    ToolTip = 'Specifies the value of the EndingTime field.';

                }
                field("Ending Date"; EndingDate)
                {
                    Caption = 'Ending Date';
                    ApplicationArea = Manufacturing;
                    Visible = DateAndTimeFieldVisible;
                    ToolTip = 'Specifies the value of the EndingDate field.';

                }
                field("Scrap %"; Rec."Scrap %")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field(Quantity; Rec.Quantity)
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
                field("Finished Quantity"; Rec."Finished Quantity")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Cost Amount"; Rec."Cost Amount")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Dimension field.';
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Dimension field.';
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
            }
        }
    }

    actions
    {
        area(processing)
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
                    Image = Dimensions;
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'Executes the Dimensions action.';

                    trigger OnAction()
                    begin
                        Rec.ShowDimensions();
                    end;
                }
                action(Routing)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Ro&uting';
                    Image = Route;
                    ShortCutKey = 'Ctrl+Alt+R';
                    ToolTip = 'Executes the Ro&uting action.';

                    trigger OnAction()
                    begin
                        Rec.ShowRouting();
                    end;
                }
                action(Components)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Components';
                    Image = Components;
                    ShortCutKey = 'Ctrl+Alt+C';
                    ToolTip = 'Executes the Components action.';

                    trigger OnAction()
                    begin
                        ShowComponents();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        Item: Record Item;
    begin
        DescriptionIndent := 0;
        Rec.ShowShortcutDimCode(ShortcutDimCode);
        Rec.GetStartingEndingDateAndTime(StartingTime, StartingDate, EndingTime, EndingDate);
        DescriptionOnFormat();
        if Rec."Variant Code" = '' then
            VariantCodeMandatory := Item.IsVariantMandatory(true, Rec."Item No.");
    end;

    var
        ShortcutDimCode: array[8] of Code[20];
        DescriptionIndent: Integer;
        DateAndTimeFieldVisible: Boolean;
        StartingTime: Time;
        EndingTime: Time;
        StartingDate: Date;
        EndingDate: Date;
        VariantCodeMandatory: Boolean;

    local procedure ShowComponents()
    var
        ProdOrderComp: Record "COL Prod. Order Component Arch";
    begin
        ProdOrderComp.SetRange(Status, Rec.Status);
        ProdOrderComp.SetRange("Prod. Order No.", Rec."Prod. Order No.");
        ProdOrderComp.SetRange("Prod. Order Line No.", Rec."Line No.");
        ProdOrderComp.SetRange("Doc. No. Occurrence", Rec."Doc. No. Occurrence");
        ProdOrderComp.SetRange("Version No.", Rec."Version No.");

        Page.Run(Page::"COL Prod. Order Com. Archive", ProdOrderComp);
    end;

    local procedure DescriptionOnFormat()
    begin
        DescriptionIndent := Rec."Planning Level Code";
    end;
}

