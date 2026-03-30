// namespace Weibel.Manufacturing.Planning.Batch;

// using Microsoft.Inventory.Item;
// using Weibel.Common.Setup;
// using Microsoft.Manufacturing.Setup;
// using Microsoft.Inventory.Planning;
// using Microsoft.Manufacturing.Planning;

// report 70101 "COL Batch Planning"
// {
//     Caption = 'Batch Planning';
//     ApplicationArea = All;
//     ProcessingOnly = true;
//     UsageCategory = None;

//     dataset
//     {
//         dataitem(Item; Item)
//         {
//             DataItemTableView = sorting("Low-Level Code") where(Type = const(Inventory), "Replenishment System" = const("Purchase"));
//             RequestFilterFields = "No.", "Search Description", "Location Filter";

//             trigger OnPreDataItem()
//             begin
//                 if GuiAllowed() then
//                     OpenWindow();

//                 WeibelSetup.Get();
//                 if (WeibelSetup."Kardex Location Code" <> '') then
//                     Item.SetFilter("Location Filter", WeibelSetup."Kardex Location Code");

//                 CalcItemPlanPlanWksh.SetTemplAndWorksheet(TemplateName, WorksheetName, NetChange);
//                 CalcItemPlanPlanWksh.SetParm(UseForecast, ExcludeForecastBefore, Item);
//                 CalcItemPlanPlanWksh.Initialize(FromDate, ToDate, MPS, MRP, RespectPlanningParm);

//                 PlanningErrorLog.ReadIsolation := IsolationLevel::ReadUncommitted;
//                 PlanningErrorLog.SetRange("Worksheet Template Name", TemplateName);
//                 PlanningErrorLog.SetRange("Journal Batch Name", WorksheetName);
//                 if not PlanningErrorLog.IsEmpty() then
//                     PlanningErrorLog.DeleteAll(true);

//                 ClearLastError();
//                 Commit();
//             end;

//             trigger OnAfterGetRecord()
//             begin
//                 if GuiAllowed() then
//                     UpdateWindow();

//                 if not NoPlanningResiliency then
//                     CalcItemPlanPlanWksh.SetResiliencyOn();

//                 if not CalcItemPlanPlanWksh.Run(Item) then
//                     InsertLogError();

//                 Commit();
//             end;

//             trigger OnPostDataItem()
//             begin
//                 CalcItemPlanPlanWksh.Finalize();
//                 if GuiAllowed() then
//                     Window.Close();
//             end;
//         }
//     }

//     var
//         WeibelSetup: Record "COL Weibel Setup";
//         PlanningErrorLog: Record "Planning Error Log";
//         CalcItemPlanPlanWksh: Codeunit "Calc. Item Plan - Plan Wksh.";
//         Counter, CounterOK, NoOfRecords : Integer;
//         Window: Dialog;

//     protected var
//         TemplateName, WorksheetName, UseForecast : Code[10];
//         NoPlanningResiliency, MPS, MRP, RespectPlanningParm, NetChange : Boolean;
//         ExcludeForecastBefore, FromDate, ToDate : Date;

//     procedure SetTemplate(pTemplateName: Code[10]; pWorksheetName: Code[10]; pRegenerative: Boolean)
//     begin
//         TemplateName := pTemplateName;
//         WorksheetName := pWorksheetName;
//         NetChange := not pRegenerative;
//     end;

//     procedure SetResiliency(pResiliency: Boolean)
//     begin
//         NoPlanningResiliency := pResiliency;
//     end;

//     procedure SetMPS(pMPS: Boolean)
//     begin
//         MPS := pMPS;
//     end;

//     procedure SetMRP(pMRP: Boolean)
//     begin
//         MRP := pMRP;
//     end;

//     procedure SetUseForecast(pUseForecast: Code[10])
//     begin
//         UseForecast := pUseForecast;
//     end;

//     procedure SetPreventForecastBefore(pPreventForecastBefore: Date)
//     begin
//         ExcludeForecastBefore := pPreventForecastBefore;
//     end;

//     procedure SetOrderDate(pOrderDate: Date)
//     begin
//         FromDate := pOrderDate;
//     end;

//     procedure SetToDate(pToDate: Date)
//     begin
//         ToDate := pToDate;
//     end;

//     procedure SetRespectPlanningParm(pRespectPlanningParm: Boolean)
//     begin
//         RespectPlanningParm := pRespectPlanningParm;
//     end;

//     local procedure InsertLogError()
//     var
//         ManufacturingSetup: Record "Manufacturing Setup";
//         ErrorText: Text[250];
//         PlanningErr: Label 'An unidentified error occurred while planning. Recalculate the plan with the option %1.', Comment = '%1 - Stop and Show First Error caption';
//     begin
//         if not CalcItemPlanPlanWksh.GetResiliencyError(PlanningErrorLog) then begin
//             ErrorText := CopyStr(GetLastErrorText(), 1, MaxStrLen(ErrorText));

//             if ErrorText = '' then
//                 ErrorText := StrSubstNo(PlanningErr, ManufacturingSetup.FieldCaption("COL Stop and Show First Error"))
//             else
//                 ClearLastError();

//             PlanningErrorLog.SetJnlBatch(TemplateName, WorksheetName, Item."No.");
//             PlanningErrorLog.SetError(ErrorText, 0, CopyStr(Item.GetPosition(), 1, 250));
//         end;
//     end;

//     local procedure OpenWindow()
//     var
//         Indentation: Integer;
//         ProgressLbl: Label 'Progress';
//         CalcPlanLbl: Label 'Calculating the plan...\\';
//     begin
//         Counter := 0;
//         CounterOK := 0;
//         NoOfRecords := Item.Count();
//         Indentation := StrLen(ProgressLbl);
//         if StrLen(Item.FieldCaption("Low-Level Code")) > Indentation then
//             Indentation := StrLen(Item.FieldCaption("Low-Level Code"));
//         if StrLen(Item.FieldCaption("No.")) > Indentation then
//             Indentation := StrLen(Item.FieldCaption("No."));

//         Window.Open(
//           CalcPlanLbl +
//           PadStr(ProgressLbl, Indentation) + ' @1@@@@@@@@@@@@@\' +
//           PadStr(Item.FieldCaption("Low-Level Code"), Indentation) + ' #2######\' +
//           PadStr(Item.FieldCaption("No."), Indentation) + ' #3##########');
//     end;

//     local procedure UpdateWindow()
//     begin
//         Counter := Counter + 1;
//         Window.Update(1, Round(Counter / NoOfRecords * 10000, 1));
//         Window.Update(2, Item."Low-Level Code");
//         Window.Update(3, Item."No.");
//     end;
// }