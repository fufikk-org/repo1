namespace Weibel.API;

using Microsoft.Purchases.Comment;

page 70172 "COL Purch. Comment Lines"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'purchCommentLine';
    EntitySetName = 'purchCommentLines';
    PageType = API;
    SourceTable = "Purch. Comment Line";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(documentType; Rec."Document Type")
                {
                }
                field(no; Rec."No.")
                {
                }
                field(lineNo; Rec."Line No.")
                {
                }
                field("date"; Rec."Date")
                {
                }
                field("code"; Rec."Code")
                {
                }
                field(comment; Rec.Comment)
                {
                }
                field(documentLineNo; Rec."Document Line No.")
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
