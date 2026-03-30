namespace Weibel.Warehouse.Request;

using Microsoft.Warehouse.Request;
using Microsoft.Manufacturing.Document;
using Microsoft.Manufacturing.WorkCenter;
using System.Text;

reportextension 70102 "COL Create Invt PutAwayPickMvm" extends "Create Invt Put-away/Pick/Mvmt"
{

    dataset
    {
        modify("Warehouse Request")
        {
            RequestFilterFields = "COL Work Center Code", "COL Routing Link Code";

            trigger OnAfterPreDataItem()
            begin
                // The method is called before the OnAfterGetRecord trigger of the Warehouse Request data item to store temporarily the Routing Link Code filter in the WarehouseActivityHeader variable.
                // If the Routing Link Code filter would not be stored in the WarehouseActivityHeader variable and reset in the Warehouse Request, the OnAfterGetRecord trigger would not be run at all.
                SetWhseActHdrRoutingLinkCode();
                SetWhseActHdrWorkCenterCode();
            end;

            trigger OnBeforeAfterGetRecord()
            begin
                // After the Warehouse Request records are found, the Routing Link Code filter is set back to the Warehouse Request as a value from the WarehouseActivityHeader variable.
                SetWhseRequestRoutingLinkCode();
                SetWhseRequestWorkCenterCode();
            end;
        }
    }

    requestpage
    {
        trigger OnOpenPage()
        begin
            MarkWorkCentersForFilter();
        end;
    }

    local procedure SetWhseActHdrRoutingLinkCode()
    var
        FilterTooLongErr: Label 'The Routing Link Code Filter is too long. The maximum length is %1.', Comment = '%1 - Max Length';
        RoutingLinkCodeFilter: Text;
    begin
        RoutingLinkCodeFilter := "Warehouse Request".GetFilter("COL Routing Link Code");
        if RoutingLinkCodeFilter = '' then
            exit;

        if StrLen(RoutingLinkCodeFilter) > MaxStrLen("Warehouse Request"."COL Routing Link Code") then //it should never happen, however the filter cannot be truncated if it exceeds the max length.
            Error(FilterTooLongErr, MaxStrLen("Warehouse Request"."COL Routing Link Code"));

        WarehouseActivityHeader."COL Routing Link Code" := CopyStr(RoutingLinkCodeFilter, 1, MaxStrLen(WarehouseActivityHeader."COL Routing Link Code"));
        "Warehouse Request".SetRange("COL Routing Link Code"); // Remove the filter from the Warehouse Request; Otherwise, it will filter out the Warehouse Request records and only production order components should be filtered.
    end;

    local procedure SetWhseRequestRoutingLinkCode()
    begin
        "Warehouse Request"."COL Routing Link Code" := WarehouseActivityHeader."COL Routing Link Code";
    end;

    local procedure SetWhseActHdrWorkCenterCode()
    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        WorkCenterCodeFilter, ProdOrderNo : Text;
        FilterTooLongErr: Label 'The Work Center Code Filter is too long. The maximum length is %1.', Comment = '%1 - Max Length';
        WorkCenterNotInRoutingErr: Label 'Work Center %1 is not used in the Production Order Routing', Comment = '%1 Work Center Code';
    begin
        WorkCenterCodeFilter := "Warehouse Request".GetFilter("COL Work Center Code");
        if WorkCenterCodeFilter = '' then
            exit;

        ProdOrderNo := CopyStr("Warehouse Request".GetFilter("Source No."), 1, MaxStrLen(ProdOrderNo));

        if StrLen(WorkCenterCodeFilter) > MaxStrLen("Warehouse Request"."COL Work Center Code") then //it should never happen, however the filter cannot be truncated if it exceeds the max length.
            Error(FilterTooLongErr, MaxStrLen("Warehouse Request"."COL Work Center Code"));

        ProdOrderRoutingLine.SetLoadFields(Type, "No.");
        ProdOrderRoutingLine.SetRange(Status, ProdOrderRoutingLine.Status::Released);
        ProdOrderRoutingLine.SetRange("Prod. Order No.", ProdOrderNo);
        ProdOrderRoutingLine.SetRange(Type, ProdOrderRoutingLine.Type::"Work Center");
        ProdOrderRoutingLine.SetFilter("No.", WorkCenterCodeFilter);
        if ProdOrderRoutingLine.IsEmpty() then
            Error(WorkCenterNotInRoutingErr, WorkCenterCodeFilter);

        WarehouseActivityHeader."COL Work Center Code" := CopyStr(WorkCenterCodeFilter, 1, MaxStrLen(WarehouseActivityHeader."COL Work Center Code"));
        "Warehouse Request".SetRange("COL Work Center Code"); // Remove the filter from the Warehouse Request; Otherwise, it will filter out the Warehouse Request records and only production order components should be filtered.
    end;

    local procedure SetWhseRequestWorkCenterCode()
    begin
        "Warehouse Request"."COL Work Center Code" := WarehouseActivityHeader."COL Work Center Code";
    end;

    local procedure MarkWorkCentersForFilter()
    var
        ProdOrderRoutingLine: Record "Prod. Order Routing Line";
        WorkCenter: Record "Work Center";
        SelectionFilterManagement: Codeunit SelectionFilterManagement;
        RecRef: RecordRef;
        ProdOrderNo: Code[20];
        WorkCenterFilter: Text;
    begin
        ProdOrderNo := CopyStr("Warehouse Request".GetFilter("Source No."), 1, MaxStrLen(ProdOrderNo));

        ProdOrderRoutingLine.SetLoadFields(Type, "No.");
        ProdOrderRoutingLine.SetRange(Status, ProdOrderRoutingLine.Status::Released);
        ProdOrderRoutingLine.SetRange("Prod. Order No.", ProdOrderNo);
        ProdOrderRoutingLine.SetRange(Type, ProdOrderRoutingLine.Type::"Work Center");
        if ProdOrderRoutingLine.FindSet() then
            repeat
                if WorkCenter.Get(ProdOrderRoutingLine."No.") then
                    if not WorkCenter.Mark() then
                        WorkCenter.Mark(true);
            until ProdOrderRoutingLine.Next() = 0;

        WorkCenter.MarkedOnly(true);
        RecRef.GetTable(WorkCenter);
        WorkCenterFilter := SelectionFilterManagement.GetSelectionFilter(RecRef, WorkCenter.FieldNo("No."));
        "Warehouse Request".SetFilter("COL Work Center Code", WorkCenterFilter);
    end;
}