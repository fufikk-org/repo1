namespace Weibel.Projects.Project.Job;

using Microsoft.Projects.Project.Job;

using Microsoft.Inventory.Item;
using Microsoft.Projects.Resources.Resource;
using Microsoft.Finance.Analysis;

pageextension 70147 "COL Budget Header Matrix (PGS)" extends "Budget Header Matrix (PGS)"
{
    layout
    {
        modify(SourceNoFilter)
        {
            trigger OnLookup(var Text: Text): Boolean
            var
                res: Boolean;
            begin
                res := COLDoOnLookup(Text);
                exit(res);
            end;

            trigger OnAfterValidate()
            var
                Item: Record "Item";
                ProjectBlockedErr: Label 'You cannot select Item %1 because the Project Blocked check box is selected on the Item card', Comment = '%1 - item';
            begin
                if SourceType <> SourceType::Item then
                    exit;

                if SourceNoFilter = '' then
                    exit;

                if not Item.Get(SourceNoFilter) then
                    exit;

                if Item."COL Project Blocked" then
                    Error(ProjectBlockedErr, Item."No.");
            end;
        }

        addafter("Basic Filters")
        {
            group("COL Change Reason Group")
            {
                Caption = 'Change Reason';
                ShowCaption = false;
                field("COL Change Reason"; ChangeReason)
                {
                    ApplicationArea = All;
                    Caption = 'Change Reason';
                    ToolTip = 'Specifies the change reason.';
                    ShowMandatory = true;

                    trigger OnValidate()
                    var
                        Job: Record "Job";
                    begin
                        if Job.Get(Rec."No.") then begin
                            Job.Validate("COL Change Reason", ChangeReason);
                            Job.Modify();
                            CurrPage.Update();
                            CurrPage.MatrixForm.Page.COLSetChangeReason(ChangeReason);
                        end;
                    end;
                }
            }
        }
    }

    var
        ChangeReason: Text[80];


    procedure COLDoOnLookup(var Text: Text): Boolean
    var
        Resource: Record Resource;
        Expenses: Record "Expenses (PGS)";
        ResGroup: Record "Resource Group";
        ResSubGroup: Record "Resource Sub. Group (PGS)";
        Item: Record Item;
    begin
        case SourceType of
            SourceType::Resource:
                begin
                    Resource.Reset();
                    Resource.SetRange(Blocked, false);
                    if Page.RunModal(14046085, Resource) = Action::LookupOK then
                        Text := Format(Resource."No.")
                    else
                        exit(false);
                end;

            SourceType::"Res.Group":
                begin
                    ResGroup.Reset();
                    if Page.RunModal(0, ResGroup) = Action::LookupOK then
                        Text := Format(ResGroup."No.")
                    else
                        exit(false);
                    ResourceGroupFilter := ResGroup."No.";
                    SetColumns(SetWantedGbl::Initial);
                    UpdateMatrixSubform();
                end;
            SourceType::"Res.Sub Group":
                begin
                    ResSubGroup.Reset();
                    if Page.RunModal(0, ResSubGroup) = Action::LookupOK then
                        Text := Format(ResSubGroup."No.")
                    else
                        exit(false);
                end;
            SourceType::"Expense (Qty.)":
                begin
                    Expenses.Reset();
                    Expenses.SetRange(Blocked, false);
                    if Page.RunModal(0, Expenses) = Action::LookupOK then
                        Text := Format(Expenses.Code)
                    else
                        exit(false);
                end;

            SourceType::"Expense (Total Cost)":
                begin
                    Expenses.Reset();
                    Expenses.SetRange(Blocked, false);
                    if Page.RunModal(0, Expenses) = Action::LookupOK then
                        Text := Format(Expenses.Code)
                    else
                        exit(false);
                end;

            SourceType::Item:
                begin
                    Item.Reset();
                    Item.SetRange(Blocked, false);
                    Item.SetRange("COL Project Blocked", false);
                    if Page.RunModal(0, Item) = Action::LookupOK then
                        Text := Format(Item."No.")
                    else
                        exit(false);
                end;
        end;

        exit(true);
    end;

    local procedure SetColumns(SetWanted: Option Initial,Previous,Same,Next,PreviousColumn,NextColumn) // it is copy of local page function 
    var
        MatrixMgt: Codeunit "Matrix Management";
        DateFilterEnd: Date;
    begin
        if StartDate = 0D then
            StartDate := WorkDate();

        DateFilter := StartDate;
        DateFilterEnd := StartDate;
        case PeriodType of
            PeriodType::Year:
                begin
                    DateFilter := CalcDate('<-CY>', StartDate);
                    DateFilterEnd := CalcDate('<+CY>', StartDate);
                end;
            PeriodType::Quarter:
                begin
                    DateFilter := CalcDate('<-CQ>', StartDate);
                    DateFilterEnd := CalcDate('<+CQ>', StartDate);
                end;
            PeriodType::Month:
                begin
                    DateFilter := CalcDate('<-CM>', StartDate);
                    DateFilterEnd := CalcDate('<+CM>', StartDate);
                end;
            PeriodType::Week:
                begin
                    DateFilter := CalcDate('<-CW>', StartDate);
                    DateFilterEnd := CalcDate('<+CW>', StartDate);
                end;
        end;
        if SetWanted = SetWanted::Initial then
            if PeriodType = PeriodType::Year then
                MatrixMgt.GeneratePeriodMatrixData(SetWanted, 31, ShowColumnName, PeriodType, Format(DateFilter) + '..' + Format(CalcDate('<CY+3Y>', DateFilterEnd)),
                PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrSetLength, MatrixRecords)
            else
                MatrixMgt.GeneratePeriodMatrixData(SetWanted, 31, ShowColumnName, PeriodType, Format(DateFilter) + '..' + Format(CalcDate('<+1Y>', DateFilterEnd)),
                PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrSetLength, MatrixRecords)
        else
            MatrixMgt.GeneratePeriodMatrixData(SetWanted, 31, ShowColumnName, PeriodType, '',
            PKFirstRecInCurrSet, MatrixColumnCaptions, ColumnSet, CurrSetLength, MatrixRecords);
    end;

    local procedure UpdateMatrixSubform() // it is copy of local page function 
    begin
        CurrPage.MatrixForm.Page.SetFilters(SourceType, SourceNoFilter, WorkTypeFilter, UnitofMeasureFilter, StartTimeFilter, CurrencyFilter,
        GlobalDim1Filter, GlobalDim2Filter, ResourceGroupFilter, ResourceSubGroupFilter, BudgetVersionFilter, IgnoreFilters);

        CurrPage.MatrixForm.Page.Load(PeriodType, QtyType, AmountType, MatrixColumnCaptions, MatrixRecords, CurrSetLength,
        CurrentProjectNo, GlobalDim1Filter, GlobalDim2Filter, ResourceGroupFilter, ResourceSubGroupFilter, CurrencyFilter,
        BudgetVersionFilter, PossiblyUnitPrice, PossiblyFactor);

        CurrPage.Update(false);
    end;
}
