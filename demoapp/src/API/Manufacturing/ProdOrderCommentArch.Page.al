namespace Weibel.API;

using Weibel.Manufacturing.Archive;

page 70166 "COL Prod. Order Comment Arch"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'prodOrderCommentLineArchive';
    EntitySetName = 'prodOrderCommentLineArchives';
    PageType = API;
    SourceTable = "COL Prod. Order Comment Arch";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(status; Rec.Status)
                {
                }
                field(prodOrderNo; Rec."Prod. Order No.")
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
                field(versionNo; Rec."Version No.")
                {
                }
                field(docNoOccurrence; Rec."Doc. No. Occurrence")
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
