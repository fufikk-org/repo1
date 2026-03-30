namespace Weibel.Manufacturing.Archive;

using Microsoft.Manufacturing.Document;
using Microsoft.Manufacturing.Capacity;
using System.Security.AccessControl;
using Weibel.Common;
using Microsoft.Foundation.AuditCodes;

table 70105 "COL Production Order Archive"
{
    Caption = 'Production Order Archive';
    DataCaptionFields = "No.", Description;
    DrillDownPageID = "COL Production Orders Archive";
    LookupPageID = "COL Production Orders Archive";
    DataClassification = CustomerContent;

    fields
    {
        field(1; Status; Enum "Production Order Status")
        {
            Caption = 'Status';
            ToolTip = 'Specifies the Status';
        }
        field(2; "No."; Code[20])
        {
            Caption = 'No.';
            ToolTip = 'Specifies the No.';
        }
        field(3; Description; Text[100])
        {
            Caption = 'Description';
            ToolTip = 'Specifies the Description';
        }
        field(4; "Search Description"; Code[100])
        {
            Caption = 'Search Description';
            ToolTip = 'Specifies the Search Description';
        }
        field(5; "Description 2"; Text[50])
        {
            Caption = 'Description 2';
            ToolTip = 'Specifies the Description 2';
        }
        field(6; "Creation Date"; Date)
        {
            Caption = 'Creation Date';
            ToolTip = 'Specifies the Creation Date';
            Editable = false;
        }
        field(7; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            ToolTip = 'Specifies the Last Date Modified';
            Editable = false;
        }
        field(9; "Source Type"; Enum "Prod. Order Source Type")
        {
            Caption = 'Source Type';
            ToolTip = 'Specifies the Source Type';
        }
        field(10; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            ToolTip = 'Specifies the Source No.';
        }
        field(11; "Routing No."; Code[20])
        {
            Caption = 'Routing No.';
            ToolTip = 'Specifies the Routing No.';
        }
        field(12; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            ToolTip = 'Specifies the Variant Code';
        }
        field(15; "Inventory Posting Group"; Code[20])
        {
            Caption = 'Inventory Posting Group';
            ToolTip = 'Specifies the Inventory Posting Group';
        }
        field(16; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group';
            ToolTip = 'Specifies the Gen. Prod. Posting Group';
        }
        field(17; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group';
            ToolTip = 'Specifies the Gen. Bus. Posting Group';
        }
        field(19; Comment; Boolean)
        {
            CalcFormula = exist("COL Prod. Order Comment Arch" where(Status = field(Status),
                                                                  "Prod. Order No." = field("No."),
                                                                  "Doc. No. Occurrence" = field("Doc. No. Occurrence"),
                                                                  "Version No." = field("Version No.")));
            Caption = 'Comment';
            ToolTip = 'Specifies the Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(20; "Starting Time"; Time)
        {
            Caption = 'Starting Time';
            ToolTip = 'Specifies the Starting Time';

        }
        field(21; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            ToolTip = 'Specifies the Starting Date';

        }
        field(22; "Ending Time"; Time)
        {
            Caption = 'Ending Time';
            ToolTip = 'Specifies the Ending Time';

        }
        field(23; "Ending Date"; Date)
        {
            Caption = 'Ending Date';
            ToolTip = 'Specifies the Ending Date';

        }
        field(24; "Due Date"; Date)
        {
            Caption = 'Due Date';
            ToolTip = 'Specifies the Due Date';

        }
        field(25; "Finished Date"; Date)
        {
            Caption = 'Finished Date';
            ToolTip = 'Specifies the Finished Date';
            Editable = false;
        }
        field(28; Blocked; Boolean)
        {
            Caption = 'Blocked';
            ToolTip = 'Specifies the Blocked';
        }
        field(30; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            ToolTip = 'Specifies the Shortcut Dimension 1 Code';
        }
        field(31; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            ToolTip = 'Specifies the Shortcut Dimension 2 Code';
        }
        field(32; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            ToolTip = 'Specifies the Location Code';
        }
        field(33; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code';
            ToolTip = 'Specifies the Bin Code';
        }
        field(34; "Replan Ref. No."; Code[20])
        {
            Caption = 'Replan Ref. No.';
            ToolTip = 'Specifies the Replan Ref. No.';
            Editable = false;
        }
        field(35; "Replan Ref. Status"; Enum "Production Order Status")
        {
            Caption = 'Replan Ref. Status';
            ToolTip = 'Specifies the Replan Ref. Status';
            Editable = false;
        }
        field(38; "Low-Level Code"; Integer)
        {
            Caption = 'Low-Level Code';
            ToolTip = 'Specifies the Low-Level Code';
            Editable = false;
        }
        field(40; Quantity; Decimal)
        {
            Caption = 'Quantity';
            ToolTip = 'Specifies the Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;

        }
        field(41; "Unit Cost"; Decimal)
        {
            Caption = 'Unit Cost';
            ToolTip = 'Specifies the Unit Cost';
            DecimalPlaces = 2 : 5;
        }
        field(42; "Cost Amount"; Decimal)
        {
            Caption = 'Cost Amount';
            ToolTip = 'Specifies the Cost Amount';
            DecimalPlaces = 2 : 2;
        }
        field(47; "Work Center Filter"; Code[20])
        {
            Caption = 'Work Center Filter';
            ToolTip = 'Specifies the Work Center Filter';
            FieldClass = FlowFilter;
        }
        field(48; "Capacity Type Filter"; Enum "Capacity Type")
        {
            Caption = 'Capacity Type Filter';
            ToolTip = 'Specifies the Capacity Type Filter';
            FieldClass = FlowFilter;
        }
        field(49; "Capacity No. Filter"; Code[20])
        {
            Caption = 'Capacity No. Filter';
            ToolTip = 'Specifies the Capacity No. Filter';
            FieldClass = FlowFilter;
        }
        field(50; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            ToolTip = 'Specifies the Date Filter';
            FieldClass = FlowFilter;
        }
#pragma warning disable AA0232
        field(51; "Expected Operation Cost Amt."; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("COL Prod.Or. Routing Line Arch"."Expected Operation Cost Amt." where(Status = field(Status),
                                                                                               "Prod. Order No." = field("No."),
                                                                                               "Doc. No. Occurrence" = field("Doc. No. Occurrence"),
                                                                                               "Version No." = field("Version No.")));
            Caption = 'Expected Operation Cost Amt.';
            ToolTip = 'Specifies the Expected Operation Cost Amt.';
            Editable = false;
            FieldClass = FlowField;
        }
#pragma warning restore AA0232
        field(52; "Expected Component Cost Amt."; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("COL Prod. Order Component Arch"."Cost Amount" where(Status = field(Status),
                                                                           "Prod. Order No." = field("No."),
                                                                           "Due Date" = field("Date Filter"),
                                                                           "Doc. No. Occurrence" = field("Doc. No. Occurrence"),
                                                                           "Version No." = field("Version No.")));
            Caption = 'Expected Component Cost Amt.';
            ToolTip = 'Specifies the Expected Component Cost Amt.';
            Editable = false;
            FieldClass = FlowField;
        }
        field(55; "Actual Time Used"; Decimal)
        {
            Caption = 'Actual Time Used';
            ToolTip = 'Specifies the Actual Time Used';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(56; "Allocated Capacity Need"; Decimal)
        {
            Caption = 'Allocated Capacity Need';
            ToolTip = 'Specifies the Allocated Capacity Need';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(57; "Expected Capacity Need"; Decimal)
        {
            Caption = 'Expected Capacity Need';
            ToolTip = 'Specifies the Expected Capacity Need';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(80; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            ToolTip = 'Specifies the No. Series';
            Editable = false;
        }
        field(82; "Planned Order No."; Code[20])
        {
            Caption = 'Planned Order No.';
            ToolTip = 'Specifies the Planned Order No.';
        }
        field(83; "Firm Planned Order No."; Code[20])
        {
            Caption = 'Firm Planned Order No.';
            ToolTip = 'Specifies the Firm Planned Order No.';
        }
        field(85; "Simulated Order No."; Code[20])
        {
            Caption = 'Simulated Order No.';
            ToolTip = 'Specifies the Simulated Order No.';
        }
        field(92; "Expected Material Ovhd. Cost"; Decimal)
        {
            CalcFormula = sum("COL Prod. Order Component Arch"."Overhead Amount" where(Status = field(Status),
                                                                               "Prod. Order No." = field("No."),
                                                                               "Doc. No. Occurrence" = field("Doc. No. Occurrence"),
                                                                               "Version No." = field("Version No.")));
            Caption = 'Expected Material Ovhd. Cost';
            ToolTip = 'Specifies the Expected Material Ovhd. Cost';
            DecimalPlaces = 2 : 2;
            Editable = false;
            FieldClass = FlowField;
        }
        field(94; "Expected Capacity Ovhd. Cost"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("COL Prod.Or. Routing Line Arch"."Expected Capacity Ovhd. Cost" where(Status = field(Status),
                                                                                               "Prod. Order No." = field("No."),
                                                                                               "Doc. No. Occurrence" = field("Doc. No. Occurrence"),
                                                                                               "Version No." = field("Version No.")));
            Caption = 'Expected Capacity Ovhd. Cost';
            ToolTip = 'Specifies the Expected Capacity Ovhd. Cost';
            Editable = false;
            FieldClass = FlowField;
        }
        field(98; "Starting Date-Time"; DateTime)
        {
            Caption = 'Starting Date-Time';
            ToolTip = 'Specifies the Starting Date-Time';

        }
        field(99; "Ending Date-Time"; DateTime)
        {
            Caption = 'Ending Date-Time';
            ToolTip = 'Specifies the Ending Date-Time';

        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            ToolTip = 'Specifies the Dimension Set ID';
            Editable = false;
        }

        //Archive fields
        field(5000; "Source Doc. Exists"; Boolean)
        {
            FieldClass = Flowfield;
            CalcFormula = exist("Production Order" where("No." = field("No.")));
            Caption = 'Source Doc. Exists';
            ToolTip = 'Specifies the Source Doc. Exists';
            Editable = false;
        }
        field(5001; "Last Archived Date"; DateTime)
        {
            Caption = 'Last Archived Date';
            ToolTip = 'Specifies the Last Archived Date';
            FieldClass = FlowField;
            CalcFormula = max("COL Production Order Archive".SystemCreatedAt where(
                                                            "No." = field("No."),
                                                            "Doc. No. Occurrence" = field("Doc. No. Occurrence")));
            Editable = false;
        }
        field(5002; "Interaction Exist"; Boolean)
        {
            Caption = 'Interaction Exist';
            ToolTip = 'Specifies the Interaction Exist';
        }
        field(5003; "Time Archived"; Time)
        {
            Caption = 'Time Archived';
            ToolTip = 'Specifies the Time Archived';
        }
        field(5004; "Date Archived"; Date)
        {
            Caption = 'Date Archived';
            ToolTip = 'Specifies the Date Archived';
        }
        field(5005; "Archived By"; Code[50])
        {
            Caption = 'Archived By';
            ToolTip = 'Specifies the Archived By';
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
            TableRelation = User."User Name";
        }
        field(5006; "Version No."; Integer)
        {
            Caption = 'Version No.';
            ToolTip = 'Specifies the Version No.';
        }
        field(70999; "Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
            ToolTip = 'Specifies the Doc. No. Occurrence';
        }

        field(7300; "Completely Picked"; Boolean)
        {
            CalcFormula = min("COL Prod. Order Component Arch"."Completely Picked" where(Status = field(Status),
                                                                                 "Prod. Order No." = field("No."),
                                                                                 "Supplied-by Line No." = filter(0),
                                                                                 "Doc. No. Occurrence" = field("Doc. No. Occurrence"),
                                                                                 "Version No." = field("Version No.")));
            Caption = 'Completely Picked';
            ToolTip = 'Specifies the Completely Picked';
            FieldClass = FlowField;
        }
        field(9000; "Assigned User ID"; Code[50])
        {
            Caption = 'Assigned User ID';
            ToolTip = 'Specifies the Assigned User ID';
            DataClassification = EndUserIdentifiableInformation;
        }
        field(70100; "COL Remaining Quantity"; Boolean)
        {
            Caption = 'Remaining Quantity';
            ToolTip = 'Specifies if the production order has remaining quantity and is not flushed backward.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("COL Prod. Order Component Arch" where(Status = field(Status), "Prod. Order No." = field("No."),
                                                                       "Flushing Method" = filter(<> Backward),
                                                                       "Remaining Qty. (Base)" = filter(> 0),
                                                                       "Doc. No. Occurrence" = field("Doc. No. Occurrence"),
                                                                       "Version No." = field("Version No.")));
        }
        field(70101; "COL Capacity Ledger Entries"; Boolean)
        {
            Caption = 'Capacity Ledger Entries';
            ToolTip = 'Specifies if the production order has capacity ledger entries.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Capacity Ledger Entry" where("Order Type" = filter(Production), "Order No." = field("No.")));
        }
        field(70102; "COL No. of Archived Versions"; Integer)
        {
            CalcFormula = max("COL Production Order Archive"."Version No." where("Status" = field("Status"),
                                                                             "No." = field("No."),
                                                                             "Doc. No. Occurrence" = field("Doc. No. Occurrence")));
            Caption = 'No. of Archived Versions';
            ToolTip = 'Specifies the No. of Archived Versions';
            Editable = false;
            FieldClass = FlowField;
        }
        field(70103; "COL Internal Status"; enum "COL Internal Status")
        {
            Caption = 'Internal Status';
            ToolTip = 'Specifies the Internal Status';
            DataClassification = CustomerContent;
        }
        field(70104; "COL Reason Code"; Code[20])
        {
            Caption = 'Reason Code';
            ToolTip = 'Specifies the Reason Code';
            DataClassification = CustomerContent;
            TableRelation = "Reason Code"."Code";
        }
        field(70105; "Original Status"; Enum "Production Order Status")
        {
            Caption = 'Original Status';
            ToolTip = 'Specifies the Original Status when archived was done';
        }
    }

    keys
    {
        key(Key1; Status, "No.", "Doc. No. Occurrence", "Version No.")
        {
            Clustered = true;
        }
        key(Key3; "Search Description")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", Description, "Source No.", "Source Type")
        {
        }
        fieldgroup(Brick; "No.", Description, "Source No.", Status, "Due Date")
        { }
    }

    trigger OnInsert()
    var
        ProdArchiveManagement: Codeunit "COL Prod. Archive Management";
    begin
        "Doc. No. Occurrence" := ProdArchiveManagement.GetNextOccurrenceNo(Rec.Status, Rec."No.");
    end;

    trigger OnDelete()
    var
        RefreshRecord: Boolean;
    begin
        // if Status = Status::Finished then
        //     DeleteFinishedProdOrderRelations()
        // else
        //     DeleteProdOrderRelations();

        RefreshRecord := false;
        if RefreshRecord then
            Get(Status, "No.");
    end;
}

