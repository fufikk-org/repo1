namespace Weibel.Intercompany;

codeunit 70143 "COL Intercompany Posting Job"
{
    trigger OnRun()
    var
        IntercompanyTransactions: Record "COL Intercompany Transactions";
        IntercompanyTransactions2: Record "COL Intercompany Transactions";
        IntercompanyPost: Codeunit "COL Intercompany Post";
    begin

        IntercompanyTransactions.SetRange(Processed, false);
        IntercompanyTransactions.SetRange("Destination Company", CompanyName());
        if IntercompanyTransactions.FindSet() then
            repeat
                IntercompanyPost.SetPostEntryNo(IntercompanyTransactions."Entry No.");
                if not IntercompanyPost.Run() then begin
                    IntercompanyTransactions2.Get(IntercompanyTransactions."Entry No.");
                    IntercompanyTransactions2."Last Error" := CopyStr(GetLastErrorText(), 1, MaxStrLen(IntercompanyTransactions."Last Error"));
                    IntercompanyTransactions2.Modify(true);
                    Commit();
                    Error(IntercompanyTransactions2."Last Error"); // This is a workaround to stop the job when an error occurs so user sees the error
                end
                else begin
                    IntercompanyTransactions2.Get(IntercompanyTransactions."Entry No.");
                    IntercompanyTransactions2."Last Error" := '';
                    IntercompanyTransactions2.Processed := true;
                    IntercompanyTransactions2."Processed Date/Time" := CurrentDateTime;
                    IntercompanyTransactions2.Modify(true);
                end;
                Commit();
            until IntercompanyTransactions.Next() = 0;
    end;
}
