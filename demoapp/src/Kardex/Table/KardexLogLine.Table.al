namespace Weibel.Kardex;
using Microsoft.Inventory.Journal;
using Microsoft.Warehouse.Setup;
using Microsoft.Warehouse.Activity;
using System.Security.User;

table 70134 "COL Kardex Log Line"
{
    Caption = 'Kardex FIle Log';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            ToolTip = 'Specifies the value of the Entry No. field.';
        }
        field(2; "Last Modified Date"; DateTime)
        {
            Caption = 'Last Modified Date';
            ToolTip = 'Specifies the date and time when the record was last modified.';
        }
        field(3; "Last Modified User"; Code[50])
        {
            Caption = 'Last Modified User';
            ToolTip = 'Specifies the user who last modified the record.';
        }
        field(4; "Send Date And Time"; DateTime)
        {
            Caption = 'Send Date And Time';
            ToolTip = 'Specifies the date and time when the record was sent.';
        }
        field(5; "Received Date And Time"; DateTime)
        {
            Caption = 'Received Date And Time';
            ToolTip = 'Specifies the date and time when the record was received.';
        }
        field(6; Type; Enum "COL Kardex Type")
        {
            Caption = 'Type';
            ToolTip = 'Specifies the type of Kardex log line.';
        }
        field(7; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name';
            TableRelation = "Item Journal Template".Name;
            ToolTip = 'Specifies the journal template name for the item journal.';
            DataClassification = CustomerContent;
        }
        field(8; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name';
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
            ToolTip = 'Specifies the journal batch name for the item journal.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if ("Journal Template Name" <> xRec."Journal Template Name") then
                    "Journal Batch Name" := '';
            end;
        }
        field(9; "Ad Hoc No."; Code[20])
        {
            Caption = 'Ad Hoc No.';
            ToolTip = 'Specifies the ad hoc number for the Kardex log line.';
            DataClassification = CustomerContent;
        }
        field(10; "Ad Hoc"; Boolean)
        {
            Caption = 'Ad Hoc';
            ToolTip = 'Specifies whether the Kardex log line is ad hoc.';
            DataClassification = CustomerContent;
        }
        field(11; "Send Messages"; Integer)
        {
            Caption = 'Send Messages';
            ToolTip = 'Specifies the send Kardex message associated with the log line.';
            FieldClass = FlowField;
            CalcFormula = count("COL Kardex Msg. Header" where("Related Log Line" = field("Entry No."), Response = const(false)));
        }
        field(12; "Response Messages"; Integer)
        {
            Caption = 'Response Messages';
            ToolTip = 'Specifies the response Kardex message associated with the log line.';
            FieldClass = FlowField;
            CalcFormula = count("COL Kardex Msg. Header" where("Related Log Line" = field("Entry No."), Response = const(true)));
        }
        field(13; "Skip Update From File"; Boolean)
        {
            Caption = 'Skip Update From File';
            ToolTip = 'Specifies the user ID that should skip the update from file.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
            begin
                UserSetup.Get(UserId());
                UserSetup.TestField("COL Allow Skip Kardex File", true);
            end;
        }
        field(14; "Inventory Document Updated"; Boolean)
        {
            Caption = 'Inventory Document Updated';
            ToolTip = 'Specifies whether the inventory document has been updated.';
            DataClassification = CustomerContent;
        }
        field(15; "No."; Code[20])
        {
            Caption = 'No.';
            ToolTip = 'Specifies the number of the Kardex log line.';
            DataClassification = CustomerContent;
        }
        field(16; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            ToolTip = 'Specifies the source number for the Kardex log line.';
            DataClassification = CustomerContent;
        }
        field(17; "Whs. Type"; enum "Warehouse Action Type")
        {
            Caption = 'Whs. Type';
            ToolTip = 'Specifies the warehouse action type for the Kardex log line.';
            DataClassification = CustomerContent;
        }
        field(18; "Source Document"; enum "Warehouse Activity Source Document")
        {
            Caption = 'Source Document';
            ToolTip = 'Specifies the source document for the Kardex log line.';
            DataClassification = CustomerContent;
        }
        field(19; "Source Type"; Integer)
        {
            Caption = 'Source Type';
            ToolTip = 'Specifies the source type for the Kardex log line.';
            DataClassification = CustomerContent;
        }
        field(20; "Source Subtype"; Integer)
        {
            Caption = 'Source Subtype';
            ToolTip = 'Specifies the source subtype for the Kardex log line.';
            DataClassification = CustomerContent;
        }
        field(21; "Error Response Messages"; Integer)
        {
            Caption = 'Error Response Messages';
            ToolTip = 'Specifies the error response Kardex message associated with the log line.';
            FieldClass = FlowField;
            CalcFormula = count("COL Kardex Msg. Header" where("Related Log Line" = field("Entry No."), Response = const(true), "Has Error" = const(true)));
        }
        field(22; "Delete Confirmed"; Boolean)
        {
            Caption = 'Delete Confirmed';
            ToolTip = 'Specifies whether the deletion of the Kardex log line has been confirmed by kardex.';
            DataClassification = CustomerContent;
        }

    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnDelete()
    var
        KardexMsgHeader: Record "COL Kardex Msg. Header";
    begin
        if not Rec."Inventory Document Updated" then begin
            Rec.TestField("Skip Update From File", true);
            Rec.TestField("Delete Confirmed", true);
        end;

        KardexMsgHeader.SetRange("Related Log Line", Rec."Entry No.");
        KardexMsgHeader.DeleteAll(true);
    end;
}
