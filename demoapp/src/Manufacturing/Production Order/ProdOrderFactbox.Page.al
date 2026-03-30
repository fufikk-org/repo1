namespace Weibel.Manufacturing.Document;

using Microsoft.Manufacturing.Document;
using Weibel.Manufacturing.BlockProduction;


page 70118 "COL Prod. Order Factbox"
{
    ApplicationArea = All;
    Caption = 'Production Blocked Details';
    PageType = CardPart;
    SourceTable = "Production Order";

    layout
    {
        area(Content)
        {
            group(General)
            {
                ShowCaption = false;
                field(OrderNo; Rec."No.")
                {
                    ApplicationArea = All;
                    Caption = 'No.';
                    ToolTip = 'Specifies production order no.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    ToolTip = 'Specifies the status of the production order.';
                }
                field(BlockedOutput; ProdOrderBlockCalc.CalcNoOfBlockedOutput(Rec))
                {
                    ApplicationArea = All;
                    Caption = 'Blocked Output';
                    ToolTip = 'Specifies the number of blocked production lines.';
                    Editable = false;
                    BlankZero = true;

                    trigger OnDrillDown()
                    begin
                        ProdOrderBlockCalc.ShowBlockedOutput(Rec);
                    end;
                }
                field(BlockedComponents; ProdOrderBlockCalc.CalcNoOfBlockedComponents(Rec))
                {
                    ApplicationArea = All;
                    Caption = 'Blocked Components';
                    ToolTip = 'Specifies the number of blocked component lines.';
                    Editable = false;
                    BlankZero = true;

                    trigger OnDrillDown()
                    begin
                        ProdOrderBlockCalc.ShowBlockedComponents(Rec);
                    end;
                }
            }
        }
    }

    var
        ProdOrderBlockCalc: Codeunit "COL Prod. Order Block Calc.";
}
