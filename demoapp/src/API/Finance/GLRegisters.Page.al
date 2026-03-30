namespace Weibel.API;

using Microsoft.Finance.GeneralLedger.Ledger;

page 70294 "COL G/L Registers"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'glRegister';
    EntitySetName = 'glRegisters';
    PageType = API;
    SourceTable = "G/L Register";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(no; Rec."No.")
                {
                }
                field(fromEntryNo; Rec."From Entry No.")
                {
                }
                field(toEntryNo; Rec."To Entry No.")
                {
                }
                field(creationDate; Rec."Creation Date")
                {
                }
                field(sourceCode; Rec."Source Code")
                {
                }
                field(userId; Rec."User ID")
                {
                }
                field(journalBatchName; Rec."Journal Batch Name")
                {
                }
                field(fromVATEntryNo; Rec."From VAT Entry No.")
                {
                }
                field(toVATEntryNo; Rec."To VAT Entry No.")
                {
                }
                field(reversed; Rec.Reversed)
                {
                }
                field(creationTime; Rec."Creation Time")
                {
                }
                field(journalTemplName; Rec."Journal Templ. Name")
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
