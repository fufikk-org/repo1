namespace Weibel.API;

using Microsoft.Foundation.Comment;

page 70148 "COL Comment Lines"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'commentLine';
    EntitySetName = 'commentLines';
    PageType = API;
    SourceTable = "Comment Line";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(tableName; Rec."Table Name")
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
                field(colBudgetChange; Rec."COL Budget Change")
                {
                }
                field(colBudgetChangeBy; Rec."COL Budget Change By")
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
