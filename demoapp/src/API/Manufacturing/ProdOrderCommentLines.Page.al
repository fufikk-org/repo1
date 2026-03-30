namespace Weibel.API;

using Microsoft.Manufacturing.Document;

page 70210 "COL Prod. Order Comment Lines"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'prodOrderCommentLine';
    EntitySetName = 'prodOrderCommentLines';
    PageType = API;
    SourceTable = "Prod. Order Comment Line";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("code"; Rec."Code")
                {
                }
                field(comment; Rec.Comment)
                {
                }
                field("date"; Rec."Date")
                {
                }
                field(lineNo; Rec."Line No.")
                {
                }
                field(prodOrderNo; Rec."Prod. Order No.")
                {
                }
                field(status; Rec.Status)
                {
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                }
                field(systemId; Rec.SystemId)
                {
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                }
            }
        }
    }
}
