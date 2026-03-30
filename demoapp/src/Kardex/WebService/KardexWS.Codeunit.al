namespace Weibel.Kardex.Ws;

using Weibel.Kardex;
codeunit 70202 "COL Kardex WS"
{
    procedure SendXmlResponse(xmlAsText: Text): Boolean
    var
        KardexResponse: Codeunit "COL Kardex Response";
    begin
        KardexResponse.HandleKardexResponse(xmlAsText);
        exit(true);
    end;
}
