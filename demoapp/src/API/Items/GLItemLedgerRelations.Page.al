namespace Weibel.API;

using Microsoft.Inventory.Ledger;

page 70291 "COL G/L Item Ledger Relations"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'glItemLedgerRelation';
    EntitySetName = 'glItemLedgerRelations';
    PageType = API;
    SourceTable = "G/L - Item Ledger Relation";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(glEntryNo; Rec."G/L Entry No.")
                {
                }
                field(valueEntryNo; Rec."Value Entry No.")
                {
                }
                field(glRegisterNo; Rec."G/L Register No.")
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
