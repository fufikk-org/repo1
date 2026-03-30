// namespace Weibel.Common.Setup;

// using Weibel.Common.Setup;

// page 70119 "COL Weibel Setup"
// {
//     ApplicationArea = All;
//     Caption = 'Weibel Setup';
//     PageType = Card;
//     SourceTable = "COL Weibel Setup";
//     UsageCategory = Administration;
//     InsertAllowed = false;
//     DeleteAllowed = false;

//     layout
//     {
//         area(Content)
//         {
//             group(General)
//             {
//                 Caption = 'General';

//                 field("Kardex Location Code"; Rec."Kardex Location Code")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("COL Item Template Code"; Rec."COL Copy Item Template Code")
//                 {
//                     ApplicationArea = All;
//                 }
//             }
//         }
//     }

//     trigger OnOpenPage()
//     begin
//         InitSetup();
//     end;

//     local procedure InitSetup()
//     begin
//         Rec.Reset();
//         if not Rec.Get() then begin
//             Rec.Init();
//             Rec.Insert();
//         end
//     end;
// }
