namespace Weibel.Service.Setup;

using Microsoft.Service.Setup;

pageextension 70111 "COL Service Mgt. Setup" extends "Service Mgt. Setup"
{
    layout
    {
        addafter("Skip Manual Reservation")
        {
            field("COL Quote Validity Calculation"; Rec."COL Quote Validity Calculation")
            {
                ApplicationArea = Service;
                Importance = Additional;
            }
        }
        addlast(content)
        {
            group("COL Intercompany")
            {
                Caption = 'Weibel';

                field("COL Default Service GL Account"; Rec."COL Default Service GL Account")
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
            }
        }
    }
}
