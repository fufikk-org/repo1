namespace Weibel.Inventory.Requisition;

using Microsoft.Inventory.Requisition;
using Microsoft.Inventory.Tracking;
using Microsoft.Inventory.Item;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Purchases.Vendor;
using Microsoft.Purchases.Document;
using Weibel.Inventory.Item;
using Microsoft.Manufacturing.Routing;

tableextension 70100 "COL Requisition Line" extends "Requisition Line"
{

    fields
    {
        field(70100; "COL No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.';
            ToolTip = 'Specifies the number of the requisition line.';
            TableRelation = if (Type = const("G/L Account")) "G/L Account"
            else
            if (Type = const(Item)) Item where("COL Planning Blocked" = const(false));

            ObsoleteState = Removed;
            ObsoleteReason = 'Field cosign conflicts and was removed';
        }
        field(70101; "COL Purchaser Code"; Code[20])
        {
            Caption = 'Purchaser Code';
            ToolTip = 'Specifies the code of the purchaser responsible for the requisition line.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup(Vendor."Purchaser Code" where("No." = field("Vendor No.")));
        }
        field(70102; "COL Qty. On Purch. Order"; Decimal)
        {
            Caption = 'Qty. On Purch. Order';
            ToolTip = 'Specifies the quantity on purchase order.';
            Editable = false;
            DecimalPlaces = 0 : 5;
            FieldClass = FlowField;
            CalcFormula = Sum("Purchase Line"."Outstanding Qty. (Base)" where("Document Type" = const(Order), Type = const(Item), "No." = field("No."), "Variant Code" = field("Variant Code"), "Location Code" = field("Location Code")));
        }
        field(70103; "COL Product Life Cycle"; Enum "COL Product Life Cycle")
        {
            Caption = 'Product Life Cycle';
            ToolTip = 'Specifies product life cycle.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = Lookup("Item Variant"."COL Product Life Cycle" where("Item No." = field("No."), "Code" = field("Variant Code")));
        }
        field(70104; "COL Warning"; Enum "COL Requisition Warning type")
        {
            DataClassification = CustomerContent;
            Caption = 'Warning';
            ToolTip = 'Displays potential warning for the line';
            Editable = false;
        }
        field(70105; "COL First Opr. Work Center"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'First Operation Work Center No.';
            ToolTip = 'Specifies the work center number of the first operation in the routing line.';
        }
        field(70106; "COL First Opr. Wrk Center Grp"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'First Operation Work Center Group Code';
            ToolTip = 'Specifies the work center group code of the first operation in the routing line.';
        }

        field(70107; "COL Filter Criteria ID"; Guid)
        {
            FieldClass = FlowFilter;
            Caption = 'Filter Criteria ID';
            ToolTip = 'Specifies the filter criteria identifier used for matching attribute filters on this line.';
            AllowInCustomizations = Never;
        }

        field(70108; "COL Matches Criteria"; Boolean)
        {
            Caption = 'Matches Criteria';
            ToolTip = 'Indicates whether the item on this line matches the selected filter criteria.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("COL Item Attr. Filter Criteria" where("Table ID" = const(Database::"Requisition Line"), "Filter ID" = field("COL Filter Criteria ID"), "Item No." = field("No.")));
            AllowInCustomizations = Never;
        }

        modify("Routing No.")
        {
            trigger OnAfterValidate()
            begin
                Rec.COL_FillFromRouting();
            end;
        }

        modify("Routing Version Code")
        {
            trigger OnAfterValidate()
            begin
                Rec.COL_FillFromRouting();
            end;
        }

        modify("No.")
        {
            trigger OnAfterValidate()
            var
                Item: Record "Item";
                ProjectBlockedErr: Label 'You cannot select Item %1 because the Planning Blocked check box is selected on the Item Card', Comment = '%1 - item';
            begin

                if Rec."No." = '' then
                    exit;

                if not Item.Get(Rec."No.") then
                    exit;

                if Item."COL Planning Blocked" then
                    Error(ProjectBlockedErr, Rec."No.");
            end;
        }

        modify("Accept Action Message")
        {
            trigger OnAfterValidate()
            begin
                CheckActionMessage();
            end;
        }
    }

    procedure COL_FillFromRouting()
    var
        RoutingLine: Record "Routing Line";
    begin
        RoutingLine.SetRange("Routing No.", Rec."Routing No.");
        RoutingLine.SetRange("Version Code", Rec."Routing Version Code");
        RoutingLine.SetRange("COL First Operation", true);
        if RoutingLine.FindFirst() then begin
            Rec."COL First Opr. Work Center" := RoutingLine."Work Center No.";
            Rec."COL First Opr. Wrk Center Grp" := RoutingLine."Work Center Group Code";
        end
        else begin
            Rec."COL First Opr. Work Center" := '';
            Rec."COL First Opr. Wrk Center Grp" := '';
        end;
    end;

    local procedure CheckActionMessage()
    var
        AcceptActionMsgLbl: Label '%1 can be set only if %2 is not empty or New.', Comment = '%1 is the caption of the field "Accept Action Message", %2 is the caption of the field "Action Message"';
    begin
        //TODO Wait for consultant
        exit; //It is temporary disable on behalf of Mikael Klaus Aaberg (to be removed/enable in future)

#pragma warning disable AA0136
        if not Rec."Accept Action Message" then
            exit;

        if not (Rec."Action Message" in [Rec."Action Message"::" ", Rec."Action Message"::New]) then
            Error(ErrorInfo.Create(StrSubstNo(AcceptActionMsgLbl, Rec.FieldCaption("Accept Action Message"), Rec.FieldCaption("Action Message")), true));
#pragma warning restore AA0136
    end;
}