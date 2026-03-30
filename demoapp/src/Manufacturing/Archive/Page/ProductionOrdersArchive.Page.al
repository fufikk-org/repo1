namespace Weibel.Manufacturing.Archive;

using Microsoft.Finance.Dimension;
using Microsoft.Inventory.Ledger;
using Microsoft.Manufacturing.Capacity;
using Microsoft.Manufacturing.Reports;
using Microsoft.Warehouse.Ledger;
using Microsoft.Warehouse.Structure;

page 70129 "COL Production Orders Archive"
{
    ApplicationArea = Manufacturing;
    Caption = 'Production Orders Archive';
    CardPageID = "COL Production Order Archive";
    Editable = false;
    PageType = List;
    SourceTable = "COL Production Order Archive";
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("No."; Rec."No.")
                {
                    ApplicationArea = Manufacturing;
                    Lookup = false;
                }
                field("COL Org. Status"; Rec."Original Status")
                {
                    ApplicationArea = Suite;
                    Lookup = false;
                }
                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = Manufacturing;
                    Lookup = false;
                }
                field("Archived By"; Rec."Archived By")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Date Archived"; Rec."Date Archived")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Time Archived"; Rec."Time Archived")
                {
                    ApplicationArea = Manufacturing;
                }
                field("COL Internal Status"; Rec."COL Internal Status")
                {
                    ApplicationArea = Suite;
                }
                field("COL Reason Code"; Rec."COL Reason Code")
                {
                    ApplicationArea = Suite;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Manufacturing;
                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ApplicationArea = Manufacturing;
                }
                field(Quantity; Rec.Quantity)
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
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Location;
                    Visible = false;
                }
                field("Starting Date-Time"; Rec."Starting Date-Time")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Ending Date-Time"; Rec."Ending Date-Time")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Finished Date"; Rec."Finished Date")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = Warehouse;
                    Visible = false;
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
                Visible = true;
            }
        }
    }
}

