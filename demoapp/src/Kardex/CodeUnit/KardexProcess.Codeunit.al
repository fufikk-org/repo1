namespace Weibel.Kardex;

codeunit 70223 "COL Kardex Process"
{
    trigger OnRun()
    var
        KardexMsgHeader: Record "COL Kardex Msg. Header";
        KardexMsgHeader2: Record "COL Kardex Msg. Header";
        KardexResponse: Codeunit "COL Kardex Response";
    begin
        KardexMsgHeader.SetRange(Processed, false);
        KardexMsgHeader.SetRange(Response, true);

        if KardexMsgHeader.FindSet() then
            repeat
                Clear(KardexMsgHeader2);
                Commit();
                KardexResponse.SetCurrHeader(KardexMsgHeader."Entry No.", KardexMsgHeader."Related Log Line");
                if KardexResponse.Run() then begin
                    KardexMsgHeader2.Get(KardexMsgHeader."Entry No.", KardexMsgHeader."Related Log Line");
                    KardexMsgHeader2."Has Error" := false;
                    KardexMsgHeader2."Error Description" := '';
                    KardexMsgHeader2.Modify(false);
                end
                else begin
                    KardexMsgHeader2.Get(KardexMsgHeader."Entry No.", KardexMsgHeader."Related Log Line");
                    KardexMsgHeader2.Processed := false;
                    KardexMsgHeader2."Has Error" := true;
                    KardexMsgHeader2."Error Description" := CopyStr(GetLastErrorText(), 1, MaxStrLen(KardexMsgHeader2."Error Description"));
                    KardexMsgHeader2.Modify(false);
                end;
                Commit();
            until KardexMsgHeader.Next() = 0;
    end;
}
