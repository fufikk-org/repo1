codeunit 70220 "COL AcuBizMgt"
{
    internal procedure ShowAcubizDoc(DocId: Text[50])
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        if DocId.Trim() = '' then
            exit;
        GeneralLedgerSetup.Get();
        GeneralLedgerSetup.TestField("COL Acubiz Expense URL");
        Hyperlink(StrSubstNo(GeneralLedgerSetup."COL Acubiz Expense URL", DocId.Trim()));
    end;
}