namespace Weibel.UpgradeScript;

codeunit 70175 "COL Rename Data Process"
{
    trigger OnRun()
    begin
        ProcessAll();
    end;

    local procedure ProcessAll()
    var
        RenameData: Record "COL Rename Data";
        RenameData2: Record "COL Rename Data";
        RenameDataLine: Codeunit "COL Rename Data Line";
    begin
        RenameData.SetRange(Selected, true);
        if RenameData.FindSet() then
            repeat
                Clear(RenameDataLine);
                RenameDataLine.SetEntryNo(RenameData."Entry No.");
                if RenameDataLine.Run() then begin
                    RenameData2.Get(RenameData."Entry No.");
                    RenameData2.Processed := true;
                    RenameData2.Error := false;
                    RenameData2."Error Description" := '';
                    RenameData2.Selected := false;
                    RenameData2.Modify(false);
                end
                else begin
                    RenameData2.Get(RenameData."Entry No.");
                    RenameData2.Processed := false;
                    RenameData2.Error := true;
                    RenameData2."Error Description" := CopyStr(GetLastErrorText(), 1, MaxStrLen(RenameData2."Error Description"));
                    RenameData2.Selected := false;
                    RenameData2.Modify(false);
                end;
                Commit();

            until RenameData.Next() = 0;
    end;
}
