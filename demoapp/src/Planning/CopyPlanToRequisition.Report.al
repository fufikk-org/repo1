namespace Weibel.Manufacturing.Planning.Batch;
using Microsoft.Inventory.Requisition;
using Microsoft.Sales.Document;
using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Planning;

report 70105 "COL Copy Plan. To Requisition"
{
    Caption = 'Copy Planning to Requisition';
    UsageCategory = None;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(RequisitionLine; "Requisition Line")
        {
            trigger OnPreDataItem()
            begin
                CheckCopyToWksh(ToReqWkshTemp, ToReqWkshBatch);
                CheckPreconditions();
            end;

            trigger OnAfterGetRecord()
            var
                CarryOutAction: Codeunit "Carry Out Action";
            begin
                CarryOutAction.TryCarryOutAction(Enum::"Planning Create Source Type"::Purchase, RequisitionLine, 4, ToReqWkshTemp, ToReqWkshBatch);
                Commit();
            end;
        }
    }

    trigger OnPreReport()
    var
        UniqueFilterErr: Label 'You must specify an unique %1 filter.', Comment = '%1 - unique template or batch name';
    begin
        if RequisitionLine.GetRangeMin("Worksheet Template Name") <> RequisitionLine.GetRangeMax("Worksheet Template Name") then
            Error(UniqueFilterErr, RequisitionLine.FieldCaption("Worksheet Template Name"));
        if RequisitionLine.GetRangeMin("Journal Batch Name") <> RequisitionLine.GetRangeMax("Journal Batch Name") then
            Error(UniqueFilterErr, RequisitionLine.FieldCaption("Journal Batch Name"));

        CurrReqWkshTemp := RequisitionLine.GetRangeMax("Worksheet Template Name");
        CurrReqWkshName := RequisitionLine.GetRangeMax("Journal Batch Name");
    end;

    protected var
        CurrReqWkshTemp, CurrReqWkshName, ToReqWkshTemp, ToReqWkshBatch : Code[10];

    internal procedure SetTemplateAndBatch(pRequisitionTemplateName: Code[10]; pRequisitionBatchName: Code[10])
    begin
        ToReqWkshTemp := pRequisitionTemplateName;
        ToReqWkshBatch := pRequisitionBatchName;
    end;

    local procedure CheckCopyToWksh(pToReqWkshTemp: Code[10]; pToReqWkshBatch: Code[10])
    var
        ReqLine: Record "Requisition Line";
        ActiveTemplateErr: Label 'This template and worksheet are currently active. You must select a different template name or worksheet name to copy to.';
        EmptyTemplateErr: Label 'You must select a worksheet to copy to.';
    begin
        if (pToReqWkshTemp <> '') and
           (CurrReqWkshTemp = pToReqWkshTemp) and
           (CurrReqWkshName = pToReqWkshBatch)
        then
            Error(ActiveTemplateErr);

        if (pToReqWkshTemp = '') or (pToReqWkshBatch = '') then
            Error(EmptyTemplateErr);

        ReqLine.ReadIsolation := IsolationLevel::ReadUncommitted;
        ReqLine.SetRange("Worksheet Template Name", pToReqWkshTemp);
        ReqLine.SetRange("Journal Batch Name", pToReqWkshBatch);
        if not ReqLine.IsEmpty() then
            ReqLine.DeleteAll(true);
    end;

    local procedure CheckPreconditions()
    begin
        repeat
            CheckLine();
        until RequisitionLine.Next() = 0;
    end;

    local procedure CheckLine()
    var
        SalesLine: Record "Sales Line";
        ProdOrderComp: Record "Prod. Order Component";
        ReqLine2: Record "Requisition Line";
    begin
        if RequisitionLine."Planning Line Origin" <> RequisitionLine."Planning Line Origin"::"Order Planning" then
            exit;

        CheckAssociations(RequisitionLine);

        if RequisitionLine."Planning Level" > 0 then
            exit;

        if RequisitionLine."Replenishment System" in [RequisitionLine."Replenishment System"::Purchase, RequisitionLine."Replenishment System"::Transfer] then
            RequisitionLine.TestField(RequisitionLine."Supply From");

        case RequisitionLine."Demand Type" of
            Database::"Sales Line":
                begin
                    SalesLine.Get(RequisitionLine."Demand Subtype", RequisitionLine."Demand Order No.", RequisitionLine."Demand Line No.");
                    SalesLine.TestField(Type, SalesLine.Type::Item);
                    if not ((RequisitionLine."Demand Date" = WorkDate()) and (SalesLine."Shipment Date" in [0D, WorkDate()])) then
                        RequisitionLine.TestField("Demand Date", SalesLine."Shipment Date");
                    RequisitionLine.TestField("No.", SalesLine."No.");
                    RequisitionLine.TestField("Qty. per UOM (Demand)", SalesLine."Qty. per Unit of Measure");
                    RequisitionLine.TestField("Variant Code", SalesLine."Variant Code");
                    RequisitionLine.TestField("Location Code", SalesLine."Location Code");
                    SalesLine.CalcFields("Reserved Qty. (Base)");
                    RequisitionLine.TestField(
                      RequisitionLine."Demand Quantity (Base)",
                      -SalesLine.SignedXX(SalesLine."Outstanding Qty. (Base)" - SalesLine."Reserved Qty. (Base)"))
                end;
            Database::"Prod. Order Component":
                begin
                    ProdOrderComp.Get(RequisitionLine."Demand Subtype", RequisitionLine."Demand Order No.", RequisitionLine."Demand Line No.", RequisitionLine."Demand Ref. No.");
                    RequisitionLine.TestField("No.", ProdOrderComp."Item No.");
                    if not ((RequisitionLine."Demand Date" = WorkDate()) and (ProdOrderComp."Due Date" in [0D, WorkDate()])) then
                        RequisitionLine.TestField("Demand Date", ProdOrderComp."Due Date");
                    RequisitionLine.TestField("Qty. per UOM (Demand)", ProdOrderComp."Qty. per Unit of Measure");
                    RequisitionLine.TestField("Variant Code", ProdOrderComp."Variant Code");
                    RequisitionLine.TestField("Location Code", ProdOrderComp."Location Code");
                    ProdOrderComp.CalcFields("Reserved Qty. (Base)");
                    RequisitionLine.TestField(
                      RequisitionLine."Demand Quantity (Base)",
                      ProdOrderComp."Remaining Qty. (Base)" - ProdOrderComp."Reserved Qty. (Base)");
                end;

        end;

        ReqLine2.ReadIsolation := ReqLine2.ReadIsolation::ReadUncommitted;
        ReqLine2.SetFilter("User ID", '<>%1', UserId);
        ReqLine2.SetRange("Demand Type", RequisitionLine."Demand Type");
        ReqLine2.SetRange("Demand Subtype", RequisitionLine."Demand Subtype");
        ReqLine2.SetRange("Demand Order No.", RequisitionLine."Demand Order No.");
        ReqLine2.SetRange("Demand Line No.", RequisitionLine."Demand Line No.");
        ReqLine2.SetRange("Demand Ref. No.", RequisitionLine."Demand Ref. No.");
        if not ReqLine2.IsEmpty then
            ReqLine2.DeleteAll(true);
    end;

    local procedure CheckAssociations(var ReqLine: Record "Requisition Line")
    var
        ReqLine2: Record "Requisition Line";
        ReqLine3: Record "Requisition Line";
        AssociationErr: Label 'You must make order for both line %1 and %2 because they are associated.', Comment = '%1 - first line no., %2 - second line no.';
    begin
#pragma warning disable AA0181
        ReqLine3.Copy(ReqLine);
        ReqLine2 := ReqLine;

        if ReqLine2."Planning Level" > 0 then
            while (ReqLine2.Next(-1) <> 0) and (ReqLine2."Planning Level" > 0) do;

        repeat
            ReqLine3 := ReqLine2;
            if not ReqLine3.Find() then // Copy of the standard code from report 99001020 "Carry Out Action Msg. - Plan."
                Error(AssociationErr, ReqLine."Line No.", ReqLine2."Line No.");
        until (ReqLine2.Next() = 0) or (ReqLine2."Planning Level" = 0); // Copy of the standard code from report 99001020 "Carry Out Action Msg. - Plan."
#pragma warning restore AA0181 
    end;
}