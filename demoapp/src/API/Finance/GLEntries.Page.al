namespace Weibel.API;

using Microsoft.Finance.GeneralLedger.Ledger;

page 70293 "COL G/L Entries"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'glEntry';
    EntitySetName = 'glEntries';
    PageType = API;
    SourceTable = "G/L Entry";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(entryNo; Rec."Entry No.")
                {
                }
                field(glAccountNo; Rec."G/L Account No.")
                {
                }
                field(postingDate; Rec."Posting Date")
                {
                }
                field(documentType; Rec."Document Type")
                {
                }
                field(documentNo; Rec."Document No.")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(balAccountNo; Rec."Bal. Account No.")
                {
                }
                field(amount; Rec.Amount)
                {
                }
                field(sourceCurrencyAmount; Rec."Source Currency Amount")
                {
                }
                field(sourceCurrencyVATAmount; Rec."Source Currency VAT Amount")
                {
                }
                field(sourceCurrencyCode; Rec."Source Currency Code")
                {
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                }
                field(userId; Rec."User ID")
                {
                }
                field(sourceCode; Rec."Source Code")
                {
                }
                field(systemCreatedEntry; Rec."System-Created Entry")
                {
                }
                field(priorYearEntry; Rec."Prior-Year Entry")
                {
                }
                field(jobNo; Rec."Job No.")
                {
                }
                field(quantity; Rec.Quantity)
                {
                }
                field(vatAmount; Rec."VAT Amount")
                {
                }
                field(businessUnitCode; Rec."Business Unit Code")
                {
                }
                field(journalBatchName; Rec."Journal Batch Name")
                {
                }
                field(reasonCode; Rec."Reason Code")
                {
                }
                field(genPostingType; Rec."Gen. Posting Type")
                {
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                }
                field(balAccountType; Rec."Bal. Account Type")
                {
                }
                field(transactionNo; Rec."Transaction No.")
                {
                }
                field(debitAmount; Rec."Debit Amount")
                {
                }
                field(creditAmount; Rec."Credit Amount")
                {
                }
                field(documentDate; Rec."Document Date")
                {
                }
                field(externalDocumentNo; Rec."External Document No.")
                {
                }
                field(sourceType; Rec."Source Type")
                {
                }
                field(sourceNo; Rec."Source No.")
                {
                }
                field(noSeries; Rec."No. Series")
                {
                }
                field(taxAreaCode; Rec."Tax Area Code")
                {
                }
                field(taxLiable; Rec."Tax Liable")
                {
                }
                field(taxGroupCode; Rec."Tax Group Code")
                {
                }
                field(useTax; Rec."Use Tax")
                {
                }
                field(vatBusPostingGroup; Rec."VAT Bus. Posting Group")
                {
                }
                field(vatProdPostingGroup; Rec."VAT Prod. Posting Group")
                {
                }
                field(additionalCurrencyAmount; Rec."Additional-Currency Amount")
                {
                }
                field(addCurrencyDebitAmount; Rec."Add.-Currency Debit Amount")
                {
                }
                field(addCurrencyCreditAmount; Rec."Add.-Currency Credit Amount")
                {
                }
                field(closeIncomeStatementDimID; Rec."Close Income Statement Dim. ID")
                {
                }
                field(icPartnerCode; Rec."IC Partner Code")
                {
                }
                field(reversed; Rec.Reversed)
                {
                }
                field(reversedByEntryNo; Rec."Reversed by Entry No.")
                {
                }
                field(reversedEntryNo; Rec."Reversed Entry No.")
                {
                }
                // field(glAccountName; Rec."G/L Account Name")
                // {
                // }
                field(journalTemplName; Rec."Journal Templ. Name")
                {
                }
                field(vatReportingDate; Rec."VAT Reporting Date")
                {
                }
                field(dimensionSetID; Rec."Dimension Set ID")
                {
                }
                // field(shortcutDimension3Code; Rec."Shortcut Dimension 3 Code")
                // {
                // }
                // field(shortcutDimension4Code; Rec."Shortcut Dimension 4 Code")
                // {
                // }
                // field(shortcutDimension5Code; Rec."Shortcut Dimension 5 Code")
                // {
                // }
                // field(shortcutDimension6Code; Rec."Shortcut Dimension 6 Code")
                // {
                // }
                // field(shortcutDimension7Code; Rec."Shortcut Dimension 7 Code")
                // {
                // }
                // field(shortcutDimension8Code; Rec."Shortcut Dimension 8 Code")
                // {
                // }
                field(lastDimCorrectionEntryNo; Rec."Last Dim. Correction Entry No.")
                {
                }
                field(lastDimCorrectionNode; Rec."Last Dim. Correction Node")
                {
                }
                field(dimensionChangesCount; Rec."Dimension Changes Count")
                {
                }
                field(allocationAccountNo; Rec."Allocation Account No.")
                {
                }
                field(allocJournalLineSystemId; Rec."Alloc. Journal Line SystemId")
                {
                }
                field(prodOrderNo; Rec."Prod. Order No.")
                {
                }
                field(faEntryType; Rec."FA Entry Type")
                {
                }
                field(faEntryNo; Rec."FA Entry No.")
                {
                }
                field(comment; Rec.Comment)
                {
                }
                field(nonDeductibleVATAmount; Rec."Non-Deductible VAT Amount")
                {
                }
                field(nonDeductibleVATAmountACY; Rec."Non-Deductible VAT Amount ACY")
                {
                }
                field(srcCurrNonDedVATAmount; Rec."Src. Curr. Non-Ded. VAT Amount")
                {
                }
                // field(accountId; Rec."Account Id")
                // {
                // }
                field(lastModifiedDateTime; Rec."Last Modified DateTime")
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
