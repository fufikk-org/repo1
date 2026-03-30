namespace Weibel.Warehouse.Activity;

using Microsoft.Warehouse.Activity;
using Microsoft.Warehouse.Setup;

// CU To store state during the pick creation process 
codeunit 70225 "COL Create Pic SM"
{
    SingleInstance = true;

    var
        ErrorWasDisplayed: Boolean;
        FirstPicToPrintFilter: Dictionary of [Text, Text]; // holds first WH no of pick to print for user
        LastPickToPrintFilter: Dictionary of [Text, Text]; // holds last of pick to print for user


    procedure SetErrorDisplayed(NewErrorWasDisplayed: Boolean)
    begin
        ErrorWasDisplayed := NewErrorWasDisplayed;
    end;

    procedure IsErrorDisplayed(): Boolean
    begin
        exit(ErrorWasDisplayed);
    end;

    procedure InitCreatePick(pUserId: Text)
    begin
        if FirstPicToPrintFilter.ContainsKey(pUserId) then
            FirstPicToPrintFilter.Remove(pUserId);

        if LastPickToPrintFilter.ContainsKey(pUserId) then
            LastPickToPrintFilter.Remove(pUserId);
    end;

    procedure GetPickToPrintFilter(pUserId: Text): Text
    var
        FilterLbl: Label '%1..%2', Locked = true;
        FilterTxt: Text;
    begin
        FilterTxt := '';
        if not FirstPicToPrintFilter.ContainsKey(pUserId) then
            exit('');

        FilterTxt := FirstPicToPrintFilter.Get(pUserId);

        if LastPickToPrintFilter.ContainsKey(pUserId) then
            FilterTxt := StrSubstNo(FilterLbl, FilterTxt, LastPickToPrintFilter.Get(pUserId));

        exit(FilterTxt);
    end;

    procedure SetPickToPrintFilter(pUserId: Text; pFilter: Text)
    begin
        if not FirstPicToPrintFilter.ContainsKey(pUserId) then
            FirstPicToPrintFilter.Add(pUserId, pFilter);

        if LastPickToPrintFilter.ContainsKey(pUserId) then
            LastPickToPrintFilter.Remove(pUserId);

        LastPickToPrintFilter.Add(pUserId, pFilter);
    end;

    procedure PrintPickWarehouse(pFIlter: Text)
    var
        WarehouseActivityHeader2: Record "Warehouse Activity Header";
        ReportSelectionWarehouse: Record "Report Selection Warehouse";
    begin
        if pFIlter = '' then
            exit;
        WarehouseActivityHeader2.SetRange(Type, WarehouseActivityHeader2.Type::Pick);
        WarehouseActivityHeader2.SetFilter("No.", pFIlter);

        ReportSelectionWarehouse.SetRange(Usage, ReportSelectionWarehouse.Usage::Pick);
        if ReportSelectionWarehouse.FindFirst() then
            Report.Run(ReportSelectionWarehouse."Report ID", true, false, WarehouseActivityHeader2)
        else
            Report.Run(Report::"FPL Whse-Picking List", true, false, WarehouseActivityHeader2);
    end;
}
