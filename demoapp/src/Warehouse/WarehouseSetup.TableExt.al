namespace Weibel.Warehouse.Setup;

using Microsoft.Warehouse.Setup;
using Microsoft.Foundation.AuditCodes;
using Microsoft.Inventory.Location;
using Microsoft.Warehouse.Structure;
using Microsoft.Inventory.Journal;

tableextension 70166 "COL Warehouse Setup" extends "Warehouse Setup"
{
    fields
    {
        field(70100; "COL ROB-EX Reason Code"; Code[20])
        {
            Caption = 'ROB-EX Reason Code';
            ToolTip = 'The reason code used for ROB-EX operations.';
            TableRelation = "Reason Code";
            DataClassification = CustomerContent;
        }
        field(70101; "COL Kardex Zone Code"; Code[10])
        {
            Caption = 'Kardex Zone Code';
            DataClassification = CustomerContent;
            TableRelation = Zone.Code where("Location Code" = field("COL Kardex Location Code"));
        }
        field(70102; "COL Kardex Bin Code"; Code[10])
        {
            Caption = 'Kardex Bin Code';
            ToolTip = 'Specifies the bin code for Kardex messages.';
            DataClassification = CustomerContent;
            TableRelation = if ("COL Kardex Zone Code" = filter('')) Bin.Code where("Location Code" = field("COL Kardex Location Code"))
            else
            if ("COL Kardex Zone Code" = filter(<> '')) Bin.Code where("Location Code" = field("COL Kardex Location Code"),
                                                                               "Zone Code" = field("COL Kardex Zone Code"));
        }
        field(70103; "COL Journal Template Name"; Code[10])
        {
            Caption = 'Kardex Journal Template Name';
            TableRelation = "Item Journal Template".Name;
            ToolTip = 'Specifies the journal template name for the item journal.';
            DataClassification = CustomerContent;
        }
        field(70104; "COL Journal Batch Name"; Code[10])
        {
            Caption = 'Kardex Journal Batch Name';
            TableRelation = "Item Journal Batch".Name where("Journal Template Name" = field("COL Journal Template Name"));
            ToolTip = 'Specifies the journal batch name for the item journal.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if ("COL Journal Template Name" <> xRec."COL Journal Template Name") then
                    "COL Journal Batch Name" := '';
            end;
        }
        field(70105; "COL Kardex Skip Request"; Boolean)
        {
            Caption = 'Skip Request in Jrn.';
            ToolTip = 'Specifies whether to skip Kardex request in the journal.';
            DataClassification = CustomerContent;
        }
        field(70106; "COL Kardex Input WS"; Text[250])
        {
            Caption = 'Kardex Input Web Service';
            ToolTip = 'Specifies the web service URL for Kardex input messages.';
            DataClassification = CustomerContent;
        }
        field(70107; "COL Kardex WS User"; Text[100])
        {
            Caption = 'Kardex Web Service User';
            ToolTip = 'Specifies the user for the Kardex web service.';
            DataClassification = CustomerContent;
        }
        field(70108; "COL Kardex WS Password"; Text[100])
        {
            Caption = 'Kardex Web Service Password';
            ToolTip = 'Specifies the password for the Kardex web service user.';
            DataClassification = CustomerContent;
        }
        field(70109; "COL Kardex Location Code"; Code[10])
        {
            Caption = 'Kardex Location Code';
            ToolTip = 'Specifies the location code for Kardex messages.';
            DataClassification = CustomerContent;
            TableRelation = "Location";
        }
        field(70110; "COL Kardex Last Log No."; Integer)
        {
            Caption = 'Kardex Last Log No.';
            ToolTip = 'Specifies the Kardex Last Log No.';
            DataClassification = CustomerContent;
        }
    }
}