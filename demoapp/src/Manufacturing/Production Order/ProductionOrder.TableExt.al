namespace Weibel.Manufacturing.Order;

using Microsoft.Manufacturing.Document;
using Weibel.Manufacturing.Archive;
using Weibel.Common;
using Microsoft.Manufacturing.Capacity;
using Microsoft.Foundation.AuditCodes;
using Weibel.Manufacturing.BlockProduction;
using Microsoft.Inventory.Item;
using Weibel.Inventory.Item;

tableextension 70112 "COL Production Order" extends "Production Order"
{
    fields
    {
        field(70100; "COL Remaining Quantity"; Boolean)
        {
            Caption = 'Remaining Quantity';
            ToolTip = 'Specifies if the production order has remaining quantity and is not flushed backward.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Prod. Order Component" where(Status = field(Status), "Prod. Order No." = field("No."), "Flushing Method" = filter(<> Backward), "Remaining Qty. (Base)" = filter(> 0)));
        }
        field(70101; "COL Capacity Ledger Entries"; Boolean)
        {
            Caption = 'Capacity Ledger Entries';
            ToolTip = 'Specifies if the production order has capacity ledger entries.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Capacity Ledger Entry" where("Order Type" = filter(Production), "Order No." = field("No.")));
        }
#pragma warning disable AA0232
        field(70102; "COL No. of Archived Versions"; Integer)
        {
            CalcFormula = max("COL Production Order Archive"."Version No." where("Status" = field("Status"),
                                                                             "No." = field("No."),
                                                                             "Doc. No. Occurrence" = field("COL Doc. No. Occurrence")));
            Caption = 'No. of Archived Versions';
            ToolTip = 'Specifies the No. of Archived Versions';
            Editable = false;
            FieldClass = FlowField;
        }
#pragma warning restore AA0232
        field(70103; "COL Internal Status"; Enum "COL Internal Status")
        {
            Caption = 'Internal Status';
            ToolTip = 'Specifies the Internal Status';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                ProdArchiveManagement: Codeunit "COL Prod. Archive Management";
            begin
                ProdArchiveManagement.ChangeInternalStatus(Rec, xRec);
                if Rec."COL Internal Status" = Rec."COL Internal Status"::Released then
                    Rec."COL Reason Code" := '';
            end;
        }
        field(70104; "COL Reason Code"; Code[20])
        {
            Caption = 'Reason Code';
            ToolTip = 'Specifies the Reason Code';
            DataClassification = CustomerContent;
            TableRelation = "Reason Code"."Code";
        }
        field(70105; "COL Remaining Output"; Boolean)
        {
            Caption = 'Remaining Output';
            ToolTip = 'Specifies if the production order has remaining output.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("Prod. Order Line" where("Prod. Order No." = field("No."), Status = field(Status), "Remaining Qty. (Base)" = filter(> 0)));
        }
        field(70106; "COL Work Center 1. Op."; Code[20])
        {
            Caption = 'Work Center (1. Op.)';
            ToolTip = 'Specifies the work center for the first operation.';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Lookup("Prod. Order Routing Line"."No." where("Prod. Order No." = field("No."), Status = field(Status), "Operation No." = filter(<> ''), "Previous Operation No." = filter('')));
        }
        field(70107; "COL Item Tracked"; Boolean)
        {
            Caption = 'Item Tracked';
            ToolTip = 'Specifies if the item is lot or serial tracked.';
            DataClassification = CustomerContent;
        }
        field(70108; "COL EU RoHS Dir. Compliant"; Enum "COL EU RoHS Dir. Compliant")
        {
            Caption = 'EU RoHS Directive Compliant';
            ToolTip = 'Specifies the value of the EU RoHS Directive Compliant field.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Item"."COL EU RoHS Dir. Compliant" where("No." = field("Source No.")));
        }
        field(70109; "COL EU REACH Reg. Compliant"; Enum "COL EU REACH Reg. Compliant")
        {
            Caption = 'EU REACH Regulation Compliant';
            ToolTip = 'Specifies the value of the EU REACH Regulation Compliant field.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Item"."COL EU REACH Reg. Compliant" where("No." = field("Source No.")));
        }
        field(70110; "COL EU RoHS Status"; Text[20])
        {
            Caption = 'EU RoHS Status';
            ToolTip = 'Specifies the value of the EU RoHS Status field.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Item"."COL EU RoHS Status" where("No." = field("Source No.")));
        }
        field(70111; "COL Product Life Cycle"; enum "COL Product Life Cycle")
        {
            Caption = 'Source Product Life Cycle';
            ToolTip = 'Specifies the Product Life Cycle of the source item variant.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Item Variant"."COL Product Life Cycle" where("Item No." = field("Source No."), "Code" = field("Variant Code")));
        }
        field(70999; "COL Doc. No. Occurrence"; Integer)
        {
            Caption = 'Doc. No. Occurrence';
            ToolTip = 'Specifies the Doc. No. Occurrence';
            DataClassification = CustomerContent;
        }


        modify("Source No.")
        {
            trigger OnAfterValidate()
            begin
                BlockProductionMgt.VerifyProductionOrder(Rec);
            end;
        }
        modify("Variant Code")
        {
            trigger OnAfterValidate()
            begin
                BlockProductionMgt.VerifyProductionOrder(Rec);
            end;
        }

    }

    var
        BlockProductionMgt: Codeunit "COL Block Production Mgt.";
        VariantCodeChange: Boolean;

    procedure COLSetVariantCodeChanging(pVariantCodeChange: Boolean)
    begin
        VariantCodeChange := pVariantCodeChange;
    end;

    procedure COLGetVariantCodeChanging(): Boolean
    begin
        exit(VariantCodeChange);
    end;
}