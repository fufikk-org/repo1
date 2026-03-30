namespace Weibel.Sales.Setup;

using Microsoft.Sales.Setup;

pageextension 70149 "COL Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    layout
    {
        addlast(General)
        {
            field("COL Internal Customer No."; Rec."COL Internal Customer No.")
            {
                ApplicationArea = All;
            }
            field("COL Assembly Explode Item No."; Rec."COL Assembly Explode Item No.")
            {
                ApplicationArea = All;
            }
            field("COL QHSE Manager for CoC Sig."; Rec."COL QHSE Manager for CoC Sig.")
            {
                ApplicationArea = All;
            }
        }

        addlast(Archiving)
        {
            field("COL Disable Release Archive"; Rec."COL Disable Release Archive")
            {
                ApplicationArea = All;
            }
        }

        addlast(content)
        {
            group("COL Weibel")
            {
                Caption = 'Weibel';

                group("COL Intercompany")
                {
                    Caption = 'Intercompany';

                    field("COL Default Sales GL Account"; Rec."COL Default Sales GL Account")
                    {
                        ApplicationArea = All;
                    }
                    field("COL Default Purch. GL Account"; Rec."COL Default Purch. GL Account")
                    {
                        ApplicationArea = All;
                    }
                    field("COL Default IC GL Account"; Rec."COL Default IC GL Account")
                    {
                        ApplicationArea = All;
                    }
                    field("COL InterCo. Journal Template"; Rec."COL InterCo. Journal Template")
                    {
                        ApplicationArea = All;
                    }
                    field("COL InterCo. Journal Batch"; Rec."COL InterCo. Journal Batch")
                    {
                        ApplicationArea = All;
                    }
                    field("COL Show IC Attachments"; Rec."COL Show IC Attachments")
                    {
                        ApplicationArea = All;
                    }
                }
                group("COL Sales Order Overview")
                {
                    Caption = 'Sales Order Overview';

                    field("COL Prep.Value G/L Acc.Filter"; Rec."COL Prep.Value G/L Acc.Filter")
                    {
                        ApplicationArea = All;
                    }
                    field("COL Order Value G/L Acc.Filter"; Rec."COL Order Value G/L Acc.Filter")
                    {
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
}