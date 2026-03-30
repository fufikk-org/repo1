namespace Weibel.Utilities;

using System.Reflection;

page 70197 "COL BCdata Api Overview"
{
    PageType = List;
    Caption = 'BCdata Api Overview';
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "COL Page Control Buffer";
    SourceTableView = sorting("Page Id", "Control Name");

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                ShowAsTree = true;
                IndentationControls = "Page Info";
                IndentationColumn = Indent;
                TreeInitialState = CollapseAll;

                field("Page Info"; Rec."Page Info")
                {
                    ToolTip = 'Specifies the value of the Page Info field.';
                    HideValue = Rec.Indentation > 0;
                }
                field("Page Id"; Rec."Page Id")
                {
                    ToolTip = 'Specifies the value of the Page Id field.';
                }
                field("Api Publisher"; Rec."Api Publisher")
                {
                    ToolTip = 'Specifies the value of the Api Publisher field.';
                    HideValue = Rec.Indentation > 0;
                }
                field("Api Group"; Rec."Api Group")
                {
                    ToolTip = 'Specifies the value of the Api Group field.';
                    HideValue = Rec.Indentation > 0;
                }
                field("Api Version"; Rec."Api Version")
                {
                    ToolTip = 'Specifies the value of the Api Version field.';
                    HideValue = Rec.Indentation > 0;
                }
                field("Entity Set Name"; Rec."Entity Set Name")
                {
                    ToolTip = 'Specifies the value of the Entity Set Name field.';
                    HideValue = Rec.Indentation > 0;
                }
                field("Source Table"; Rec."Source Table")
                {
                    ToolTip = 'Specifies the value of the Source Table field.';
                    HideValue = Rec.Indentation > 0;
                }
                field("Source Table View"; Rec."Source Table View")
                {
                    ToolTip = 'Specifies the value of the Source Table View field.';
                    HideValue = Rec.Indentation > 0;
                }
                field(Url; Rec.Url)
                {
                    ToolTip = 'Specifies the value of the Url field.';
                    HideValue = Rec.Indentation > 0;
                }
                field("Control Id"; Rec."Control Id")
                {
                    ToolTip = 'Specifies the value of the Control Id field.';
                    HideValue = Rec.Indentation = 0;
                }
                field("Table Id"; Rec."Table Id")
                {
                    ToolTip = 'Specifies the value of the Table Id field.';
                    HideValue = Rec.Indentation = 0;
                }
                field("Field Id"; Rec."Field Id")
                {
                    ToolTip = 'Specifies the value of the Field Id field.';
                    HideValue = Rec.Indentation = 0;
                }
                field("Control Name"; Rec."Control Name")
                {
                    ToolTip = 'Specifies the value of the Control Name field.';
                    HideValue = Rec.Indentation = 0;
                }
                field("Field Name"; Rec."Field Name")
                {
                    ToolTip = 'Specifies the value of the Field Name field.';
                    HideValue = Rec.Indentation = 0;
                }
                field("Source Expression"; Rec."Source Expression")
                {
                    ToolTip = 'Specifies the value of the Source Expression field.';
                    HideValue = Rec.Indentation = 0;
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                    HideValue = Rec.Indentation = 0;
                }
                field("Type Name"; Rec."Type Name")
                {
                    ToolTip = 'Specifies the value of the Type Name field.';
                    HideValue = Rec.Indentation = 0;
                }
                field("Field Class"; Rec."Field Class")
                {
                    ToolTip = 'Specifies the value of the Field Class field.';
                    HideValue = Rec.Indentation = 0;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        PageMetadata: Record "Page Metadata";
        PageControlField: Record "Page Control Field";
        AllObj: Record AllObj;
        FieldRec: Record Field;
        Window: Dialog;
        ProgressLbl: Label 'Loading Page Data: #1#', Locked = true;
        PageInfoLbl: Label '%1/%2/%3/%4', Locked = true;
    begin
        Window.Open(ProgressLbl);
        PageMetadata.SetRange(PageType, PageMetadata.PageType::API);
        PageMetadata.SetRange(APIPublisher, 'weibel');
        if PageMetadata.FindSet() then
            repeat
                Window.Update(1, PageMetadata.Name);
                Rec.Init();
                Rec."Page Id" := PageMetadata.ID;
                Rec."Api Group" := PageMetadata.APIGroup;
                Rec."Api Publisher" := PageMetadata.APIPublisher;
                Rec."Api Version" := PageMetadata.APIVersion;
                Rec."Entity Set Name" := PageMetadata.EntitySetName;
                if PageMetadata.SourceTable > 0 then
                    if AllObj.Get(AllObj."Object Type"::Table, PageMetadata.SourceTable) then
                        Rec."Source Table" := AllObj."Object Name";
                Rec."Source Table View" := PageMetadata.SourceTableView;
                Rec.Indentation := 0;
                Rec.Url := CopyStr(GetUrl(ClientType::Api, CompanyName(), ObjectType::Page, PageMetadata.ID), 1, MaxStrLen(Rec.Url));
                Rec."Page Info" := StrSubstNo(PageInfoLbl, Rec."Api Publisher", Rec."Api Group", Rec."Api Version", Rec."Entity Set Name");
                Rec.Insert();
                PageControlField.SetRange(PageNo, PageMetadata.ID);
                if PageControlField.FindSet() then
                    repeat
                        Rec.Indentation := 1;
                        Rec."Control Id" := PageControlField.ControlId;
                        Rec."Table Id" := PageControlField.TableNo;
                        Rec."Field Id" := PageControlField.FieldNo;
                        Rec."Control Name" := PageControlField.ControlName;
                        Rec."Source Expression" := PageControlField.SourceExpression;
                        if (Rec."Table Id" <> 0) and (Rec."Field Id" <> 0) then
                            if FieldRec.Get(Rec."Table Id", Rec."Field Id") then begin
                                Rec."Field Name" := FieldRec.FieldName;
                                Rec.Type := Format(FieldRec.Type);
                                Rec."Type Name" := FieldRec."Type Name";
                                Rec."Field Class" := FieldRec.Class;
                            end;
                        Rec.Insert();
                    until PageControlField.Next() = 0;
            until PageMetadata.Next() = 0;

        if Rec.FindFirst() then;
        Window.Close();
    end;

    trigger OnAfterGetRecord()
    begin
        Indent := Rec.Indentation;
    end;

    var
        Indent: Integer;
}