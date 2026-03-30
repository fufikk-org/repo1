namespace Weibel.Manufacturing.Document;

using Microsoft.Manufacturing.Document;
using Microsoft.Manufacturing.Routing;
using Microsoft.Purchases.Document;
using Microsoft.Purchases.History;
using Microsoft.Inventory.Item;
using Weibel.Inventory.Item;

tableextension 70101 "COL Prod. Order Routing Line" extends "Prod. Order Routing Line"
{
    fields
    {
        field(70100; "COL Lock"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Lock';
            ToolTip = 'Specifies if the routing line is locked.';
        }
        field(70101; "COL In Progress Set By User"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'In Progress Set By User';
            ToolTip = 'Specifies the user who set the routing line in progress.';
        }
        field(70102; "COL In Progress Date-Time"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'In Progress Date-Time';
            ToolTip = 'Specifies the date and time when the routing line was set to in-progress.';
        }
        field(70103; "COL Finished By User"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Finished By User';
            ToolTip = 'Specifies the user who finished the routing line.';
        }
        field(70104; "COL Finished Date-Time"; DateTime)
        {
            DataClassification = CustomerContent;
            Caption = 'Finished Date-Time';
            ToolTip = 'Specifies the date and time when the routing line was finished.';
        }
        field(70105; "COL Prod. Order Quantity"; Decimal)
        {
            Caption = 'Prod. Order Quantity';
            ToolTip = 'Specifies the production order quantity.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Prod. Order Line".Quantity where(Status = field(Status), "Prod. Order No." = field("Prod. Order No."), "Routing No." = field("Routing No."), "Routing Reference No." = field("Routing Reference No.")));
        }
        field(70106; "COL Prod. Order Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Item;
            Caption = 'Prod. Order Item No.';
            ToolTip = 'Specifies the item number of the production order.';
        }
        field(70107; "COL Prod. Order Variant Code"; Code[10])
        {
            Caption = 'Prod. Order Variant Code';
            ToolTip = 'Specifies the variant code of the production order.';
            DataClassification = CustomerContent;
            TableRelation = "Item Variant"."Code" where("Item No." = field("COL Prod. Order Item No."));
        }
        field(70108; "COL Purchase Invoice No."; Code[20])
        {
            Caption = 'Posted Purch. Invoice No.';
            ToolTip = 'Specifies the purchase invoice number.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Inv. Line"."Document No." where("Prod. Order No." = field("Prod. Order No."), "Routing Reference No." = field("Routing Reference No."), "Operation No." = field("Operation No."), "Routing No." = field("Routing No.")));
        }
        field(70109; "COL Purchase Order No."; Code[20])
        {
            Caption = 'Purchase Order No.';
            ToolTip = 'Specifies the purchase order number.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Purchase Line"."Document No." where("Prod. Order No." = field("Prod. Order No."), "Routing Reference No." = field("Routing Reference No."), "Operation No." = field("Operation No."), "Routing No." = field("Routing No.")));
        }
        field(70110; "COL Prod. Order Rem. Quantity"; Decimal)
        {
            Caption = 'Prod. Order Remaining Quantity';
            ToolTip = 'Specifies the remaining production order quantity.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Prod. Order Line"."Remaining Quantity" where(Status = field(Status), "Prod. Order No." = field("Prod. Order No."), "Routing No." = field("Routing No."), "Routing Reference No." = field("Routing Reference No.")));
        }
        field(70111; "COL Prod. Order Fin. Quantity"; Decimal)
        {
            Caption = 'Prod. Order Finished Quantity';
            ToolTip = 'Specifies the finished production order quantity.';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Sum("Prod. Order Line"."Finished Quantity" where(Status = field(Status), "Prod. Order No." = field("Prod. Order No."), "Routing No." = field("Routing No."), "Routing Reference No." = field("Routing Reference No.")));
        }
        field(70112; "COL Product Life Cycle"; enum "COL Product Life Cycle")
        {
            Caption = 'Source Product Life Cycle';
            ToolTip = 'Specifies the Product Life Cycle of the source item variant.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Item Variant"."COL Product Life Cycle" where("Item No." = field("COL Prod. Order Item No."), "Code" = field("COL Prod. Order Variant Code")));
        }
        // Requirement 244
        // technical field to skip the routing line when calculating subcontracts, because of a bug with report extension (CurrReport.Skip() is not working as expected)
        // https://github.com/microsoft/AL/issues/7039
        // Update 2026-01-05: bug has been closed, "by design". Technical field is needed. Obsolete state removed.
        field(70990; "COL Skip Routing Line"; Boolean)
        {
            Caption = 'Skip Routing Line';
            Editable = false;
            DataClassification = CustomerContent;
            ObsoleteState = No;
            // ObsoleteReason = 'This field is used to skip the routing line when calculating subcontracts, because of a bug with report extension (CurrReport.Skip() is not working as expected).';
        }
        modify("Routing Status")
        {
            trigger OnAfterValidate()
            begin
                COLUpdateRoutingStatusLogFields();
            end;
        }
    }

    var
        LineLockedErr: Label 'Routing Line (Operation: %1) is Locked.', Comment = '%1 routing line.';

    trigger OnInsert()
    begin
        UpdateProdItemData();
    end;

    trigger OnModify()
    begin
        UpdateProdItemData();
    end;

    trigger OnAfterModify()
    begin
        if not GuiAllowed() then
            exit;

        if (Rec."Routing Status" <> xRec."Routing Status") then
            exit;

        if (Rec."COL Lock" = xRec."COL Lock") and (Rec."COL Lock") then
            if Rec.Status in [Rec.Status::Released, Rec.Status::"Firm Planned"] then
                Error(LineLockedErr, Rec."Operation No.");
    end;

    trigger OnBeforeDelete()
    begin
        if not GuiAllowed() then
            exit;

        if (Rec."COL Lock") then
            Error(LineLockedErr, Rec."Operation No.");
    end;

    procedure COLUpdateRoutingStatusLogFields()
    begin
        case Rec."Routing Status" of
            Enum::"Prod. Order Routing Status"::"In Progress":
                if Rec."COL In Progress Set By User" = '' then begin
                    Rec."COL In Progress Date-Time" := CurrentDateTime();
                    Rec."COL In Progress Set By User" := CopyStr(UserId(), 1, MaxStrLen(Rec."COL In Progress Set By User"));
                end;
            Enum::"Prod. Order Routing Status"::"Finished":
                if Rec."COL Finished By User" = '' then begin
                    Rec."COL Finished Date-Time" := CurrentDateTime();
                    Rec."COL Finished By User" := CopyStr(UserId(), 1, MaxStrLen(Rec."COL Finished By User"));
                end;
        end;
    end;

    local procedure UpdateProdItemData()
    var
        ProdOrderLine: Record "Prod. Order Line";
    begin
        if Rec."COL Prod. Order Item No." <> '' then
            exit;

        ProdOrderLine.SetRange(Status, Status);
        ProdOrderLine.SetRange("Prod. Order No.", "Prod. Order No.");
        ProdOrderLine.SetRange("Routing No.", "Routing No.");
        ProdOrderLine.SetRange("Routing Reference No.", "Routing Reference No.");
        ProdOrderLine.SetLoadFields("Item No.", "Variant Code");
        if ProdOrderLine.FindFirst() then begin
            Rec."COL Prod. Order Item No." := ProdOrderLine."Item No.";
            Rec."COL Prod. Order Variant Code" := ProdOrderLine."Variant Code";
        end;
    end;
}