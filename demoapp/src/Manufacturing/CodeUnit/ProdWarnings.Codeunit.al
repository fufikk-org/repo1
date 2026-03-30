namespace Weibel.Manufacturing.Order;

using Microsoft.Manufacturing.Document;
using Microsoft.Inventory.Requisition;
using Microsoft.Inventory.Tracking;

codeunit 70232 "COL Prod. Warnings"
{
    procedure WarningCheck(var Rec: Record "Production Order")
    var
        Selection: Integer;
        STMsg: Text;
        RatioOptionsLbl: Label 'Cancel,Delete Related Planning Lines and PO';
        CancelDeleteLbl: Label 'You Cannot delete %1 Production Order %2 because there is at least one Planning Line associated with it.', Comment = 'You Cannot delete %1, %2 because there is at least one Planning Line associated with it.';
    begin
        if not FindRelatedLines(Rec) then
            exit;

        STMsg := StrSubstNo(CancelDeleteLbl, Rec.Status, Rec."No.");
        Selection := StrMenu(RatioOptionsLbl, 1, STMsg);
        if Selection in [0, 1] then
            Error('');

        if Selection = 2 then
            DeleteRelatedLines(Rec);

    end;

    local procedure FindRelatedLines(var Rec: Record "Production Order"): Boolean
    var
        RequisitionLine: Record "Requisition Line";
    begin
        RequisitionLine.SetRange("Ref. Order Type", RequisitionLine."Ref. Order Type"::"Prod. Order");
        RequisitionLine.SetRange("Ref. Order No.", Rec."No.");
        RequisitionLine.SetRange("Ref. Order Status", Rec.Status);
        if not RequisitionLine.IsEmpty() then
            exit(true);

        exit(false);
    end;

    local procedure DeleteRelatedLines(var Rec: Record "Production Order")
    var
        RequisitionLine: Record "Requisition Line";
        ReservationEntry: Record "Reservation Entry";
        ReserveReqLine: Codeunit "Req. Line-Reserve";
    begin
        RequisitionLine.SetRange("Ref. Order Type", RequisitionLine."Ref. Order Type"::"Prod. Order");
        RequisitionLine.SetRange("Ref. Order No.", Rec."No.");
        RequisitionLine.SetRange("Ref. Order Status", Rec.Status);

        if RequisitionLine.FindSet() then
            repeat
                if ReserveReqLine.FindReservEntry(RequisitionLine, ReservationEntry) then begin
                    ReserveReqLine.DeleteLine(RequisitionLine);
                    RequisitionLine.TestField("Reserved Qty. (Base)", 0);
                end;
            until RequisitionLine.Next() = 0;

        RequisitionLine.DeleteAll(true);
    end;

    // local procedure ReactivateProdOrderCapacityNeed(RequisitionLine: Record "Requisition Line")
    // var
    //     ProdOrderCapNeed: Record "Prod. Order Capacity Need";
    // begin
    //     ProdOrderCapNeed.SetCurrentKey(Status, "Prod. Order No.", Active);
    //     ProdOrderCapNeed.SetRange(Status, RequisitionLine."Ref. Order Status");
    //     ProdOrderCapNeed.SetRange("Prod. Order No.", RequisitionLine."Ref. Order No.");
    //     ProdOrderCapNeed.SetRange(Active, false);
    //     if not ProdOrderCapNeed.IsEmpty() then
    //         ProdOrderCapNeed.ModifyAll(Active, true);
    // end;
}
