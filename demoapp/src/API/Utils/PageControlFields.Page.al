namespace Weibel.Utilities;

using System.Reflection;

page 70196 "COL Page Control Fields"
{
    PageType = List;
    Caption = 'Page Controls';
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "COL Page Control Buffer";
    SourceTableView = sorting("Field Id");

    layout
    {
        area(content)
        {
            group(Options)
            {
                field(PageId; SelectedPageId)
                {
                    BlankZero = true;
                    Caption = 'Page Id';
                    ToolTip = 'Select page to see the control details.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        AllObjWithCaption: Record AllObjWithCaption;
                    begin
                        AllObjWithCaption.SetRange("Object Type", AllObjWithCaption."Object Type"::Page);
                        if Page.RunModal(Page::"COL List of Pages", AllObjWithCaption) = Action::LookupOK then begin
                            SelectedPageId := AllObjWithCaption."Object ID";
                            LoadPageFields(SelectedPageId);
                        end;
                    end;

                    trigger OnValidate()
                    var
                        AllObject: Record AllObj;
                    begin
                        if SelectedPageId <> 0 then begin
                            AllObject.Get(AllObject."Object Type"::Page, SelectedPageId);
                            LoadPageFields(SelectedPageId);
                        end;
                    end;
                }
            }
            repeater(General)
            {
                Caption = 'General';
                field("Page Id"; Rec."Page Id")
                {
                    ToolTip = 'Specifies the value of the Page Id field.';
                }
                field("Control Id"; Rec."Control Id")
                {
                    ToolTip = 'Specifies the value of the Control Id field.';
                }
                field("Table Id"; Rec."Table Id")
                {
                    ToolTip = 'Specifies the value of the Table Id field.';
                }
                field("Field Id"; Rec."Field Id")
                {
                    ToolTip = 'Specifies the value of the Field Id field.';
                }
                field("Control Name"; Rec."Control Name")
                {
                    ToolTip = 'Specifies the value of the Control Name field.';
                }
                field("Field Name"; Rec."Field Name")
                {
                    ToolTip = 'Specifies the value of the Field Name field.';
                }
                field("Source Expression"; Rec."Source Expression")
                {
                    ToolTip = 'Specifies the value of the Source Expression field.';
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Type Name"; Rec."Type Name")
                {
                    ToolTip = 'Specifies the value of the Type Name field.';
                }
                field("Field Class"; Rec."Field Class")
                {
                    ToolTip = 'Specifies the value of the Field Class field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(GetFieldListForApi)
            {
                Caption = 'Get Fields';
                ToolTip = 'Get fields for api page.';
                Image = Web;

                trigger OnAction()
                var
                    TempPageControlBuffer: Record "COL Page Control Buffer" temporary;
                    FieldTemplate1Lbl: Label 'field(%1; ', Locked = true;
                    FieldTemplate2Lbl: Label 'Rec."%1") {}', Locked = true;
                    TBuilder: TextBuilder;
                begin
                    TempPageControlBuffer.Copy(Rec, true);
                    CurrPage.SetSelectionFilter(TempPageControlBuffer);
                    if TempPageControlBuffer.FindSet() then
                        repeat
                            TBuilder.AppendLine(StrSubstNo(FieldTemplate1Lbl, TempPageControlBuffer."Control Name") + StrSubstNo(FieldTemplate2Lbl, TempPageControlBuffer."Field Name"));
                        until TempPageControlBuffer.Next() = 0;
                    Message(TBuilder.ToText());
                end;
            }
        }
    }

    var
        SelectedPageId: Integer;

    local procedure LoadPageFields(SelectedPageNo: Integer)
    var
        PageControlField: Record "Page Control Field";
        FieldRec: Record Field;
    begin
        Rec.Reset();
        Rec.DeleteAll();
        PageControlField.SetRange(PageNo, SelectedPageNo);
        if PageControlField.FindSet() then
            repeat
                Rec.Init();
                Rec."Page Id" := SelectedPageNo;
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
        Rec.SetCurrentKey("Control Id");
        if Rec.FindFirst() then;
    end;
}