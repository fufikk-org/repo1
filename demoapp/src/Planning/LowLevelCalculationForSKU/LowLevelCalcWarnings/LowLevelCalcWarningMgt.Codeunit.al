#if not HIDE_LOWLEVEL_SKU
namespace Weibel.Manufacturing.ProductionBOM;

codeunit 70195 "COL LowLevel Calc. Warning Mgt"
{
    var
        WeibelLowLevelSetup: Record "COL Weibel Low Level Setup";
        TempWarning: Record "COL Low Level Warning" temporary;
        EntryNo, RegisteredWarnings : Integer;

    procedure RegisterWarning(WarningCode: Code[20]; WarningText: Text)
    begin
        RegisteredWarnings += 1;
        WeibelLowLevelSetup.GetRecordOnce();
        if not WeibelLowLevelSetup."Log Warnings" then
            exit;

        AddNewEntry(WarningCode, WarningText)
    end;

    procedure GetWarningCount(): Integer
    begin
        exit(RegisteredWarnings);
    end;

    procedure StoreRegisteredWarnings()
    var
        LowLevelWarning: Record "COL Low Level Warning";
    begin
        if not LowLevelWarning.IsEmpty() then
            LowLevelWarning.DeleteAll();

        WeibelLowLevelSetup.GetRecordOnce();
        if not WeibelLowLevelSetup."Log Warnings" then
            exit;

        if TempWarning.FindSet() then
            repeat
                LowLevelWarning := TempWarning;
                LowLevelWarning.Insert();
            until TempWarning.Next() = 0;
    end;

    local procedure AddNewEntry(WarningCode: Code[20]; WarningText: Text)
    begin
        EntryNo += 1;

        Clear(TempWarning);
        TempWarning.Init();
        TempWarning."Entry No." := EntryNo;
        TempWarning."Warning Code" := WarningCode;
        TempWarning."Warning Information" := CopyStr(WarningText, 1, MaxStrLen(TempWarning."Warning Information"));
        TempWarning.Insert();
    end;

    procedure ShowWarnings()
    var
        LowLevelWarning: Record "COL Low Level Warning";
        WeibelLowLevelSetupPage: Page "COL Weibel Low Level Setup";
        LogNotEnabledLbl: Label 'Logging of warnings is not enabled. Open %1 page and enable %2 before running next low level calculation.', Comment = '%1 = page caption; %2 = field caption';
    begin
        if LowLevelWarning.IsEmpty() then begin
            WeibelLowLevelSetup.GetRecordOnce();
            if not WeibelLowLevelSetup."Log Warnings" then begin
                Message(LogNotEnabledLbl, WeibelLowLevelSetupPage.Caption(), WeibelLowLevelSetup.FieldCaption("Log Warnings"));
                exit;
            end;
        end;
        Page.Run(Page::"COL Low Level Warnings");
    end;
}
#endif