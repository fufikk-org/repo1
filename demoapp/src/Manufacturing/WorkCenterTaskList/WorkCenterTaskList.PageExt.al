namespace Weibel.Manufacturing.WorkCenter;

using Microsoft.Manufacturing.WorkCenter;
using Microsoft.Manufacturing.Document;

pageextension 70222 "COL Work Center Task List" extends "Work Center Task List"
{
    layout
    {
        addafter(Description)
        {
            field("COL Description 2"; GetDescription2FromProdOrder(Rec.Status, Rec."Prod. Order No."))
            {
                ApplicationArea = All;
                Caption = 'Description 2';
                ToolTip = 'Specifies the value of the Description 2 field from related production order.';
                Editable = false;
            }
            field("COL Routing No."; Rec."Routing No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Routing No. field.';
                Editable = false;
            }
            field("COL Work Center No."; Rec."Work Center No.")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Work Center No. field.';
                Editable = false;
            }
            field("COL Work Center Group Code"; Rec."Work Center Group Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Work Center Group Code field.';
                Editable = false;
            }
        }
        addlast(Control1)
        {
#if not BLOCK_DYNAMIC_PRODITEMNO
            field("COL prodOrderItemNo"; GetProdOrderItemNo())
            {
                Caption = 'Prod. Order Item No.';
                Editable = false;
                Visible = false;
                ToolTip = 'Specifies the number of the item that is to be produced.';
                ApplicationArea = Manufacturing;

            }
            field("COL prodOrderItemVariantCode"; GetProdOrderItemVariantNo())
            {
                Caption = 'Prod. Order Item Variant Code';
                Editable = false;
                Visible = false;
                ToolTip = 'Specifies the variant of the item on the line.';
                ApplicationArea = Manufacturing;
            }
#else
            field("COL Prod. Order Item No."; Rec."COL Prod. Order Item No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL Prod. Order Variant Code"; Rec."COL Prod. Order Variant Code")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL Product Life Cycle"; Rec."COL Product Life Cycle")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL Prod. Order Quantity"; Rec."COL Prod. Order Quantity")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL Prod. Order Rem. Quantity"; Rec."COL Prod. Order Rem. Quantity")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL Prod. Order Fin. Quantity"; Rec."COL Prod. Order Fin. Quantity")
            {
                ApplicationArea = All;
                Editable = false;
            }
#endif
            field("COL In Progress Date-Time"; Rec."COL In Progress Date-Time")
            {
                ApplicationArea = All;
                Editable = not Rec."COL Lock";
            }
            field("COL In Progress Set By User"; Rec."COL In Progress Set By User")
            {
                ApplicationArea = All;
                Editable = not Rec."COL Lock";
            }
            field("COL Finished Date-Time"; Rec."COL Finished Date-Time")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("COL Finished By User"; Rec."COL Finished By User")
            {
                ApplicationArea = All;
                Editable = false;
            }
#pragma warning disable AA0218
            field("COL Routing Status"; Rec."Routing Status")
            {
                ApplicationArea = All;
                Editable = false;
            }
#pragma warning restore AA0218
        }
    }

#if not BLOCK_DYNAMIC_PRODITEMNO
    var
        ProdOrderLine: Record "Prod. Order Line";
        ItemNoDictionary: Dictionary of [Guid, Code[20]];
        VariantCodeDictionary: Dictionary of [Guid, Code[10]];

    local procedure GetProdOrderItemNo(): Code[20]
    var
        ProdOrderItemNo: Code[20];
        ProdOrderItemVariantNo: Code[10];
    begin
        GetAdditionalLineData(ProdOrderItemNo, ProdOrderItemVariantNo);
        exit(ProdOrderItemNo);
    end;

    local procedure GetProdOrderItemVariantNo(): Code[10]
    var
        ProdOrderItemNo: Code[20];
        ProdOrderItemVariantNo: Code[10];
    begin
        GetAdditionalLineData(ProdOrderItemNo, ProdOrderItemVariantNo);
        exit(ProdOrderItemVariantNo);
    end;

    local procedure GetAdditionalLineData(var ProdOrderItemNo: Code[20]; var ProdOrderItemVariantNo: Code[10])
    var
        MissingData: Boolean;
    begin
        MissingData := (not ItemNoDictionary.Get(Rec.SystemId, ProdOrderItemNo)) or (not VariantCodeDictionary.Get(Rec.SystemId, ProdOrderItemVariantNo));
        if not MissingData then
            exit;

        Clear(ProdOrderItemNo);
        Clear(ProdOrderItemVariantNo);

        ProdOrderLine.ReadIsolation := IsolationLevel::ReadCommitted;
        ProdOrderLine.SetLoadFields("Item No.", "Variant Code");

        ProdOrderLine.SetCurrentKey(Status, "Prod. Order No.", "Routing No.", "Routing Reference No.");
        ProdOrderLine.SetRange(Status, Rec.Status);
        ProdOrderLine.SetRange("Prod. Order No.", Rec."Prod. Order No.");
        ProdOrderLine.SetRange("Routing No.", Rec."Routing No.");
        ProdOrderLine.SetRange("Routing Reference No.", Rec."Routing Reference No.");
        if ProdOrderLine.FindFirst() then begin
            ProdOrderItemNo := ProdOrderLine."Item No.";
            ProdOrderItemVariantNo := ProdOrderLine."Variant Code";
        end;
        ItemNoDictionary.Set(Rec.SystemId, ProdOrderItemNo);
        VariantCodeDictionary.Set(Rec.SystemId, ProdOrderItemVariantNo);
    end;
#endif

    local procedure GetDescription2FromProdOrder(Status: Enum Microsoft.Manufacturing.Document."Production Order Status"; ProdOrderNo: Code[20]): Text
    var
        ProductionOrder: Record "Production Order";
    begin
        ProductionOrder.ReadIsolation := IsolationLevel::ReadUncommitted;
        ProductionOrder.SetLoadFields("Description 2");
        if ProductionOrder.Get(Status, ProdOrderNo) then
            exit(ProductionOrder."Description 2");
    end;
}