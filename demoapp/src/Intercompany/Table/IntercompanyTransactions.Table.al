namespace Weibel.Intercompany;

using Weibel.Common;
using Microsoft.Sales.History;
using Microsoft.Finance.Currency;

table 70114 "COL Intercompany Transactions"
{
    Caption = 'Weibel Intercompany Transactions';
    DataClassification = CustomerContent;
    DataPerCompany = false;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            ToolTip = 'Specifies the Entry No.';
        }
        field(2; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            ToolTip = 'Specifies the Posting Date';
        }
        field(3; "Destination Company"; Text[30])
        {
            Caption = 'Destination Company';
            ToolTip = 'Specifies the Destination Company';
        }
        field(4; "Destination Customer No."; Code[20])
        {
            Caption = 'Destination Customer No.';
            ToolTip = 'Specifies the Destination Customer No.';
        }
        field(5; "Destination Customer Name"; Text[100])
        {
            Caption = 'Destination Customer Name';
            ToolTip = 'Specifies the Destination Customer Name';
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            ToolTip = 'Specifies the Document No.';
        }
        field(7; "Posting Description"; Text[100])
        {
            Caption = 'Posting Description';
            ToolTip = 'Specifies the Posting Description';
        }
        field(8; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code';
            ToolTip = 'Specifies the Currency Code';
        }
        field(9; Amount; Decimal)
        {
            Caption = 'Amount';
            ToolTip = 'Specifies the Amount';
        }
        field(10; "Amount (LCY)"; Decimal)
        {
            Caption = 'Amount (LCY)';
            ToolTip = 'Specifies the Amount (LCY)';
        }
        field(11; "Sales GL Account No."; Code[20])
        {
            Caption = 'Sales GL Account No.';
            ToolTip = 'Specifies the Sales GL Account No.';
        }
        field(12; Processed; Boolean)
        {
            Caption = 'Processed';
            ToolTip = 'Specifies the Processed';
        }
        field(13; "Processed Date/Time"; DateTime)
        {
            Caption = 'Processed Date/Time';
            ToolTip = 'Specifies the Processed Date/Time';
        }
        field(14; "Source Company"; Text[30])
        {
            Caption = 'Source Company';
            ToolTip = 'Specifies the Source Company';
        }
        field(15; "Transaction Document Type"; enum "COL Transaction Document Type")
        {
            Caption = 'Transaction Document Type';
            ToolTip = 'Specifies the Transaction Document Type';
        }
        field(16; "Last Error"; Text[200])
        {
            Caption = 'Last Error';
            ToolTip = 'Specifies the Last Error during posting';
        }
        field(17; "Purchase GL Account No."; Code[20])
        {
            Caption = 'Purchase GL Account No.';
            ToolTip = 'Specifies the Purchase GL Account No.';
        }
        field(18; "IC GL Account No."; Code[20])
        {
            Caption = 'IC GL Account No.';
            ToolTip = 'Specifies the IC GL Account No.';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(SortKey; "Processed", "Destination Company")
        {
        }
        key(DocNoKey; "Document No.", "Destination Company", "Transaction Document Type", Processed)
        {
        }
    }

    internal procedure CopyFromSalesCrMemoHeader(var SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        CurrExchRate: Record "Currency Exchange Rate";
        DocumentAmount, DocumentAmountLCY : Decimal;
    begin
        Rec."Posting Date" := SalesCrMemoHeader."Posting Date";
        Rec."Document No." := SalesCrMemoHeader."No.";
        Rec."Posting Description" := SalesCrMemoHeader."Posting Description";
        Rec."Currency Code" := SalesCrMemoHeader."Currency Code";
        Rec."Destination Company" := SalesCrMemoHeader."COL GS. Company";
        Rec."Destination Customer No." := SalesCrMemoHeader."COL GS. Customer No.";
        Rec."Destination Customer Name" := SalesCrMemoHeader."COL GS. Name";

        SalesCrMemoHeader.CalcFields(Amount);
        DocumentAmount := SalesCrMemoHeader.Amount;

        if SalesCrMemoHeader."Currency Factor" <> 0 then
            DocumentAmountLCY := CurrExchRate.ExchangeAmtFCYToLCY(SalesCrMemoHeader."Posting Date", SalesCrMemoHeader."Currency Code", DocumentAmount, SalesCrMemoHeader."Currency Factor")
        else
            DocumentAmountLCY := DocumentAmount;

        Rec.Amount := -DocumentAmount;
        Rec."Amount (LCY)" := -DocumentAmountLCY;
    end;
}
