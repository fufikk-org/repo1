namespace Weibel.Kardex.Ws;

using Weibel.Kardex;

page 70234 "COL Kardex API"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    Caption = 'colKardexAPI';
    DelayedInsert = true;
    EntityName = 'kardexResponse';
    EntitySetName = 'kardexResponses';
    PageType = API;
    SourceTable = "COL Kardex Msg. Header";
    SourceTableTemporary = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(sendXmlResponse; sendXmlResponseTxt)
                {
                    Caption = 'sendXMLResponse';

                    trigger OnValidate()
                    begin
                        ProcessData(sendXmlResponseTxt);
                    end;
                }
            }
        }
    }

    var
        sendXmlResponseTxt: Text;

    local procedure ProcessData(xml: Text)
    var
        KardexResponse: Codeunit "COL Kardex Response";
    begin
        KardexResponse.HandleKardexResponse(xml);
    end;
}
