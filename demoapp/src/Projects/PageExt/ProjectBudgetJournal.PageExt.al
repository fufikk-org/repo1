namespace Weibel.Projects.Project;

using Microsoft.Inventory.Item;
using Microsoft.Projects.Resources.Resource;
using Microsoft.Finance.GeneralLedger.Account;
using Microsoft.Utilities;

pageextension 70193 "COL Project Budget Journal" extends "Project Budget Journal (PGS)"
{
    layout
    {
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                Item: Record "Item";
                ProjectBlockedErr: Label 'You cannot select Item %1 because the Project Blocked check box is selected on the Item Card', Comment = '%1 - item';
            begin
                if Rec.Type <> Rec.Type::Item then
                    exit;

                if Rec."No." = '' then
                    exit;

                if not Item.Get(Rec."No.") then
                    exit;

                if Item."COL Project Blocked" then
                    Error(ProjectBlockedErr, Rec."No.");
            end;

            trigger OnLookup(var Text: Text): Boolean
            var
                Item: Record Item;
                Resource: Record Resource;
                ResGroup: Record "Resource Group";
                Expenses: Record "Expenses (PGS)";
                ResSubGroup: Record "Resource Sub. Group (PGS)";
                ItemList: Page "Item List";
            begin
                Permissions(4);
                case Rec.Type of
                    Rec.Type::Resource:
                        begin
                            Resource.SetRange(Blocked, false);
                            Resource.SetRange("Date Filter", Rec.Date);

                            if Page.RunModal(14046085, Resource) = Action::LookupOK then
                                Rec.Validate("No.", Resource."No.");
                        end;
                    Rec.Type::"Res.Group":

                        if Page.RunModal(0, ResGroup) = Action::LookupOK then
                            Rec.Validate("No.", ResGroup."No.");

                    Rec.Type::Expense:
                        if Page.RunModal(0, Expenses) = Action::LookupOK then
                            Rec.Validate("No.", Expenses.Code);
                    Rec.Type::Item:
                        begin
                            Item.SetRange("COL Project Blocked", false);
                            ItemList.SetTableView(Item);
                            ItemList.LookupMode(true);
                            if ItemList.RunModal() = Action::LookupOK then begin
                                ItemList.GetRecord(Item);
                                Rec.Validate("No.", Item."No.");
                                if Rec.Quantity <> 0 then
                                    Rec.validate(Quantity);
                            end;
                        end;
                    Rec.Type::"Res.Sub Group":

                        if Page.RunModal(0, ResSubGroup) = Action::LookupOK then begin
                            Rec."No." := ResSubGroup."No.";
                            Rec."Resource Group No." := ResSubGroup."Resource Group No.";
                            Rec.Validate("No.", ResSubGroup."No.");
                        end;
                end;
            end;
        }
    }

    local procedure Permissions(Type1: Option "Tasklist and Budget ",Tasklist,"Time Sheet",Approval,Budget) // copy from Page local function
    var
        ProjectRights: Record "Permissions PM (PGS)";
        Text: Text[250];
    begin
        Text := '';
        if Type1 = 0 then begin
            Text := ProjectRights.IsPermissionAllowed(ProjectRights.GetResourceNo(), Rec."Project No.", Rec."Task Code", 1);
            if Text <> 'OK' then Text := ProjectRights.IsPermissionAllowednotaskcheck(ProjectRights.GetResourceNo(), Rec."Project No.", Rec."Task Code", 4);
        end else
            Text := ProjectRights.IsPermissionAllowed(ProjectRights.GetResourceNo(), Rec."Project No.", Rec."Task Code", Type1);
        if (Text <> '') and (Text <> 'OK') then
            Error(Text);
    end;
}
