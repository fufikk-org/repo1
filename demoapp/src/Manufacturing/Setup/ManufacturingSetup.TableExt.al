namespace Weibel.Manufacturing.Setup;

using Microsoft.Manufacturing.Setup;
using Microsoft.Inventory.Requisition;
using Microsoft.Manufacturing.Forecast;

tableextension 70106 "COL Manufacturing Setup" extends "Manufacturing Setup"
{
    fields
    {
        field(70100; "COL NoFinishRemainQty"; Boolean)
        {
            Caption = 'Block Status Finish';
            DataClassification = CustomerContent;
            ToolTip = 'If remaining components > 0';
        }
        field(70101; "COL Requisition Template Name"; Code[10])
        {
            Caption = 'Requisition Template Name';
            TableRelation = "Req. Wksh. Template".Name;
            ToolTip = 'Specifies the template to be used for creating requisitions';
            DataClassification = CustomerContent;
        }
        field(70102; "COL Requisition Batch Name"; Code[10])
        {
            Caption = 'Requisition Batch Name';
            TableRelation = "Requisition Wksh. Name".Name where("Worksheet Template Name" = field("COL Requisition Template Name"));
            ToolTip = 'Specifies the batch to be used for creating requisitions';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if ("COL Requisition Template Name" <> xRec."COL Requisition Template Name") then
                    "COL Requisition Batch Name" := '';
            end;
        }
        field(70103; "COL Plan. Worksheet Temp. Name"; Code[10])
        {
            Caption = 'Planning Worksheet Temp. Name';
            ToolTip = 'Specifies the name of the planning worksheet template.';
            TableRelation = "Req. Wksh. Template".Name;
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if ("COL Plan. Worksheet Temp. Name" <> xRec."COL Plan. Worksheet Temp. Name") then
                    "COL Std. Plan Jnl. Batch Name" := '';
            end;
        }
        field(70104; "COL Std. Plan Jnl. Batch Name"; Code[10])
        {
            Caption = 'Std. Plan Journal Batch Name';
            ToolTip = 'Specifies the name of the standard plan journal batch.';
            TableRelation = "Requisition Wksh. Name".Name where("Worksheet Template Name" = field("COL Plan. Worksheet Temp. Name"));
            DataClassification = CustomerContent;
        }
        // field(70105; "COL Net. Plan Jnl. Batch Name"; Code[10])
        // {
        //     Caption = 'Net. Plan Journal Batch Name';
        //     ToolTip = 'Specifies the name of the net plan journal batch.';
        //     TableRelation = "Requisition Wksh. Name".Name where("Worksheet Template Name" = field("COL Plan. Worksheet Temp. Name"));
        //     DataClassification = CustomerContent;
        // }
        // field(70106; "COL Batch Plan On"; Enum "COL Batch Plan On")
        // {
        //     Caption = 'Batch Plan On';
        //     ToolTip = 'Specifies the batch planning method which determines the planning journal batch to be used.';
        //     DataClassification = CustomerContent;
        // }

        field(70107; "COL Calculate MPS"; Boolean)
        {
            Caption = 'Calculate MPS';
            ToolTip = 'Specifies if the MPS should be calculated.';
            DataClassification = CustomerContent;
        }
        field(70108; "COL Calculate MRP"; Boolean)
        {
            Caption = 'Calculate MRP';
            ToolTip = 'Specifies if the MRP should be calculated.';
            DataClassification = CustomerContent;
        }
        field(70109; "COL Order Date DF"; DateFormula)
        {
            Caption = 'Order Date (DF)';
            ToolTip = 'Specifies the date formula for order date used for the calculation.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Rec.Validate("COL Plan Horizontal");
                COLCalculateExcludeForecastBefore();
            end;
        }
        field(70110; "COL End Date"; Date)
        {
            Caption = 'End Date';
            ToolTip = 'Specifies the end date used for the calculation.';
            DataClassification = CustomerContent;
        }
        field(70111; "COL Stop and Show First Error"; Boolean)
        {
            Caption = 'Stop and Show First Error';
            ToolTip = 'Specifies if the calculation should stop and show the first error.';
            DataClassification = CustomerContent;
        }
        field(70112; "COL Use Forecast"; Code[10])
        {
            Caption = 'Use Forecast';
            ToolTip = 'Specifies if the forecast should be used for the calculation.';
            TableRelation = "Production Forecast Name";
            DataClassification = CustomerContent;
        }
        field(70113; "COL Exclude Forecast Before"; Date)
        {
            Caption = 'Exclude Forecast Before';
            ToolTip = 'Specifies the date before which the forecast should be excluded.';
            DataClassification = CustomerContent;
        }
        field(70114; "COL Plan Horizontal"; DateFormula)
        {
            Caption = 'Plan Horizontal (DF)';
            ToolTip = 'Specifies the date formula for the horizontal planning.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                Rec."COL End Date" := CalcDate("COL Plan Horizontal", Today());
            end;
        }
        field(70115; "COL Exclude Forecast Before DF"; DateFormula)
        {
            Caption = 'Exclude Forecast Before (DF))';
            ToolTip = 'Specifies the date formula for the date before which the forecast should be excluded.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                this.COLCalculateExcludeForecastBefore();
            end;
        }
        field(70116; "COL SMD Batch Code"; Code[20])
        {
            Caption = 'Last SMD Batch Code';
            ToolTip = 'Specifies last batch value for SMD report.';
            DataClassification = CustomerContent;
            ObsoleteState = Removed;
            ObsoleteReason = 'move to table COL Manufacturing Tech Setup.';
        }
        field(70117; "COL Def.Loc. for BOM Structure"; Code[10])
        {
            Caption = 'Default Location for BOM Structure';
            ToolTip = 'Specifies the default location for the BOM structure tree viewed from SKU. It is also used by API calls that request SKU BOM Structure when location code is not specified.';
            TableRelation = Microsoft.Inventory.Location.Location;
            DataClassification = CustomerContent;
        }
        field(70118; "COL Debug No. Filter"; Text[250])
        {
            Caption = 'Debug No. Filter';
            ToolTip = 'Specifies Debug No. Filter';
            DataClassification = CustomerContent;
        }
        field(70119; "COL Log Prod. Tracking"; Boolean)
        {
            Caption = 'Log Prod. Tracking';
            ToolTip = 'Specifies whether production tracking changes are logged.';
            DataClassification = CustomerContent;
        }
    }

    procedure COLCalculateExcludeForecastBefore()
    begin
        if Format("COL Exclude Forecast Before DF") <> '' then
            "COL Exclude Forecast Before" := CalcDate("COL Exclude Forecast Before DF", WorkDate());
    end;
}
