namespace Weibel.Manufacturing.Archive;

using Microsoft.Finance.Dimension;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Ledger;
using Microsoft.Inventory.Requisition;
using Microsoft.Manufacturing.Capacity;
using Microsoft.Manufacturing.Reports;
using Microsoft.Warehouse.Activity;
using Microsoft.Warehouse.Activity.History;
using Microsoft.Warehouse.InventoryDocument;
using Microsoft.Warehouse.Ledger;
using Microsoft.Warehouse.Structure;

page 70131 "COL Production Order Archive"
{
    Caption = 'Production Order Archive';
    PageType = Document;
    SourceTable = "COL Production Order Archive";
    Editable = false;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = Manufacturing;
                    Importance = Promoted;
                    Lookup = false;
                }
                field("Version No."; Rec."Version No.")
                {
                    ApplicationArea = Manufacturing;
                    Lookup = false;
                }
                field("COL Org. Status"; Rec."Original Status")
                {
                    ApplicationArea = Suite;
                    Lookup = false;
                }
                field("COL Internal Status"; Rec."COL Internal Status")
                {
                    ApplicationArea = Suite;
                }
                field("COL Reason Code"; Rec."COL Reason Code")
                {
                    ApplicationArea = Suite;
                }
                field("COL No. of Archived Versions"; Rec."COL No. of Archived Versions")
                {
                    ApplicationArea = Suite;
                    Importance = Additional;
                }
                field("Doc. No. Occurrence"; Rec."Doc. No. Occurrence")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;
                }
                field("Archived By"; Rec."Archived By")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Date Archived"; Rec."Date Archived")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Last Archived Date"; Rec."Last Archived Date")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Source Doc. Exists"; Rec."Source Doc. Exists")
                {
                    ApplicationArea = Manufacturing;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Manufacturing;
                    Importance = Promoted;
                    QuickEntry = false;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = Manufacturing;
                    QuickEntry = false;
                }
                field("Source Type"; Rec."Source Type")
                {
                    ApplicationArea = Manufacturing;

                }
                field("Source No."; Rec."Source No.")
                {
                    ApplicationArea = Manufacturing;

                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = Manufacturing;
                    Visible = false;

                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = Manufacturing;
                    QuickEntry = false;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = Manufacturing;
                    Importance = Promoted;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Manufacturing;

                }
                field("Assigned User ID"; Rec."Assigned User ID")
                {
                    ApplicationArea = Manufacturing;
                    QuickEntry = false;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = Manufacturing;
                    QuickEntry = false;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = Manufacturing;
                    QuickEntry = false;
                }
            }
            part(ProdOrderLines; "COL Prod. Order Lines Archive")
            {
                ApplicationArea = Manufacturing;
                SubPageLink = "Prod. Order No." = field("No."),
                              Status = field("Status"),
                              "Doc. No. Occurrence" = field("Doc. No. Occurrence"),
                              "Version No." = field("Version No.");

                UpdatePropagation = Both;
            }
            group(Schedule)
            {
                Caption = 'Schedule';
                field("Starting Date-Time"; Rec."Starting Date-Time")
                {
                    ApplicationArea = Manufacturing;
                    Importance = Promoted;

                }
                field("Ending Date-Time"; Rec."Ending Date-Time")
                {
                    ApplicationArea = Manufacturing;
                    Importance = Promoted;

                }
            }
            group(Posting)
            {
                Caption = 'Posting';
                field("Inventory Posting Group"; Rec."Inventory Posting Group")
                {
                    ApplicationArea = Manufacturing;
                    Importance = Promoted;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = Manufacturing;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;

                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;

                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = Location;
                    Importance = Promoted;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = Warehouse;
                    Importance = Promoted;
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

    actions
    {
        area(Navigation)
        {
            action("Co&mments")
            {
                ApplicationArea = Manufacturing;
                Caption = 'Co&mments';
                Image = ViewComments;
                RunObject = Page "COL Prod.Or. Comment Archive";
                RunPageLink = "Prod. Order No." = field("No."),
                              Status = field("Status"),
                              "Doc. No. Occurrence" = field("Doc. No. Occurrence"),
                              "Version No." = field("Version No.");
                ToolTip = 'View or add comments for the record.';
            }
        }
    }

}

