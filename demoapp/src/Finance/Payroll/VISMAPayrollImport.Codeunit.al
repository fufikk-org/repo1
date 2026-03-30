codeunit 70186 "COL VISMA Payroll Import"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Process Data Exch.", 'OnProcessColumnMappingOnBeforeRecRefInsert', '', false, false)]
    local procedure RunOnProcessColumnMappingOnBeforeRecRefInsert(RecRef: RecordRef; DataExch: Record "Data Exch."; var IsHandled: Boolean)
    var
        GenJnlLine, GenJnlLine2 : Record "Gen. Journal Line";
        DataExchMapping: Record "Data Exch. Mapping";
    begin
        DataExchMapping.SetLoadFields("Post-Mapping Codeunit");
        if DataExchMapping.Get(DataExch."Data Exch. Def Code", DataExch."Data Exch. Line Def Code", RecRef.RecordId.TableNo) then
            if DataExchMapping."Post-Mapping Codeunit" = Codeunit::"COL VISMA Payroll Import" then begin
                RecRef.SetTable(GenJnlLine);
                GenJnlLine2.SetRange("Journal Batch Name", GenJnlLine."Journal Batch Name");
                GenJnlLine2.SetRange("Journal Template Name", GenJnlLine."Journal Template Name");
                GenJnlLine2.SetRange("Account Type", GenJnlLine."Account Type");
                GenJnlLine2.SetRange("Document No.", GenJnlLine."Document No.");
                GenJnlLine2.SetRange("Account No.", GenJnlLine."Account No.");
                GenJnlLine2.SetRange(Correction, GenJnlLine.Correction);
                GenJnlLine2.SetRange("Shortcut Dimension 1 Code", GenJnlLine."Shortcut Dimension 1 Code");
                if GenJnlLine2.FindFirst() then begin
                    GenJnlLine2.Validate(Amount, GenJnlLine2.Amount + GenJnlLine.Amount);
                    GenJnlLine2.Modify(true);
                    IsHandled := true;
                end;
            end;
    end;
}