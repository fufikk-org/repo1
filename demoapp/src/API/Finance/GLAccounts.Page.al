namespace Weibel.API;

using Microsoft.Finance.GeneralLedger.Account;

page 70292 "COL G/L Accounts"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'glAccount';
    EntitySetName = 'glAccounts';
    PageType = API;
    SourceTable = "G/L Account";
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
                field(name; Rec.Name)
                {
                }
                field(searchName; Rec."Search Name")
                {
                }
                field(accountType; Rec."Account Type")
                {
                }
                field(globalDimension1Code; Rec."Global Dimension 1 Code")
                {
                }
                field(globalDimension2Code; Rec."Global Dimension 2 Code")
                {
                }
                field(accountCategory; Rec."Account Category")
                {
                }
                field(incomeBalance; Rec."Income/Balance")
                {
                }
                field(debitCredit; Rec."Debit/Credit")
                {
                }
                field(no2; Rec."No. 2")
                {
                }
                // field(comment; Rec.Comment)
                // {
                // }
                field(blocked; Rec.Blocked)
                {
                }
                field(directPosting; Rec."Direct Posting")
                {
                }
                field(reconciliationAccount; Rec."Reconciliation Account")
                {
                }
                field(newPage; Rec."New Page")
                {
                }
                field(noOfBlankLines; Rec."No. of Blank Lines")
                {
                }
                field(indentation; Rec.Indentation)
                {
                }
                field(sourceCurrencyCode; Rec."Source Currency Code")
                {
                }
                field(sourceCurrencyPosting; Rec."Source Currency Posting")
                {
                }
                field(sourceCurrencyRevaluation; Rec."Source Currency Revaluation")
                {
                }
                field(unrealizedRevaluation; Rec."Unrealized Revaluation")
                {
                }
                field(lastModifiedDateTime; Rec."Last Modified Date Time")
                {
                }
                field(lastDateModified; Rec."Last Date Modified")
                {
                }
                // field(dateFilter; Rec."Date Filter")
                // {
                // }
                // field(globalDimension1Filter; Rec."Global Dimension 1 Filter")
                // {
                // }
                // field(globalDimension2Filter; Rec."Global Dimension 2 Filter")
                // {
                // }
                // field(balanceAtDate; Rec."Balance at Date")
                // {
                // }
                // field(netChange; Rec."Net Change")
                // {
                // }
                // field(budgetedAmount; Rec."Budgeted Amount")
                // {
                // }
                field(totaling; Rec.Totaling)
                {
                }
                // field(budgetFilter; Rec."Budget Filter")
                // {
                // }
                // field(balance; Rec.Balance)
                // {
                // }
                // field(budgetAtDate; Rec."Budget at Date")
                // {
                // }
                field(consolTranslationMethod; Rec."Consol. Translation Method")
                {
                }
                field(consolDebitAcc; Rec."Consol. Debit Acc.")
                {
                }
                field(consolCreditAcc; Rec."Consol. Credit Acc.")
                {
                }
                // field(businessUnitFilter; Rec."Business Unit Filter")
                // {
                // }
                field(genPostingType; Rec."Gen. Posting Type")
                {
                }
                field(genBusPostingGroup; Rec."Gen. Bus. Posting Group")
                {
                }
                field(genProdPostingGroup; Rec."Gen. Prod. Posting Group")
                {
                }
                // field(picture; Rec.Picture) -- Blob field, cannot be exposed via API
                // {
                // }
                // field(debitAmount; Rec."Debit Amount")
                // {
                // }
                // field(creditAmount; Rec."Credit Amount")
                // {
                // }
                field(automaticExtTexts; Rec."Automatic Ext. Texts")
                {
                }
                // field(budgetedDebitAmount; Rec."Budgeted Debit Amount")
                // {
                // }
                // field(budgetedCreditAmount; Rec."Budgeted Credit Amount")
                // {
                // }
                field(taxAreaCode; Rec."Tax Area Code")
                {
                }
                field(taxLiable; Rec."Tax Liable")
                {
                }
                field(taxGroupCode; Rec."Tax Group Code")
                {
                }
                field(vatBusPostingGroup; Rec."VAT Bus. Posting Group")
                {
                }
                field(vatProdPostingGroup; Rec."VAT Prod. Posting Group")
                {
                }
                // field(vatAmt; Rec."VAT Amt.")
                // {
                // }
                // field(additionalCurrencyNetChange; Rec."Additional-Currency Net Change")
                // {
                // }
                // field(addCurrencyBalanceAtDate; Rec."Add.-Currency Balance at Date")
                // {
                // }
                // field(additionalCurrencyBalance; Rec."Additional-Currency Balance")
                // {
                // }
                field(exchangeRateAdjustment; Rec."Exchange Rate Adjustment")
                {
                }
                // field(addCurrencyDebitAmount; Rec."Add.-Currency Debit Amount")
                // {
                // }
                // field(addCurrencyCreditAmount; Rec."Add.-Currency Credit Amount")
                // {
                // }
                field(defaultICPartnerGLAccNo; Rec."Default IC Partner G/L Acc. No")
                {
                }
                field(omitDefaultDescrInJnl; Rec."Omit Default Descr. in Jnl.")
                {
                }
                // field(sourceCurrencyNetChange; Rec."Source Currency Net Change")
                // {
                // }
                // field(sourceCurrBalanceAtDate; Rec."Source Curr. Balance at Date")
                // {
                // }
                // field(sourceCurrencyBalance; Rec."Source Currency Balance")
                // {
                // }
                field(accountSubcategoryEntryNo; Rec."Account Subcategory Entry No.")
                {
                }
                // field(accountSubcategoryDescript; Rec."Account Subcategory Descript.")
                // {
                // }
                // field(vatReportingDateFilter; Rec."VAT Reporting Date Filter")
                // {
                // }
                field(excludeFromConsolidation; Rec."Exclude From Consolidation")
                {
                }
                // field(dimensionSetIDFilter; Rec."Dimension Set ID Filter")
                // {
                // }
                field(costTypeNo; Rec."Cost Type No.")
                {
                }
                field(defaultDeferralTemplateCode; Rec."Default Deferral Template Code")
                {
                }
                field(apiAccountType; Rec."API Account Type")
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
