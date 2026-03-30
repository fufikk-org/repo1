namespace Weibel.Common;

using Microsoft.Manufacturing.Document;
using System.Reflection;
codeunit 70145 "COL Field Select Mgt"
{

    procedure CheckIfModifyAllowed(var Rec: Record "Production Order"; var xRec: Record "Production Order")
    var
        TableRecRef: RecordRef;
        xTableRecRef: RecordRef;
    begin
        TableRecRef.GetTable(Rec);
        xTableRecRef.GetTable(xRec);
        CheckIfModifyAllowed(TableRecRef, xTableRecRef, Database::"Production Order");
    end;

    procedure CheckIfModifyAllowed(var Rec: Record "Prod. Order Line"; var xRec: Record "Prod. Order Line")
    var
        TableRecRef: RecordRef;
        xTableRecRef: RecordRef;
    begin
        TableRecRef.GetTable(Rec);
        xTableRecRef.GetTable(xRec);
        CheckIfModifyAllowed(TableRecRef, xTableRecRef, Database::"Prod. Order Line");
    end;

    procedure CheckIfModifyAllowed(var Rec: Record "Prod. Order Component"; var xRec: Record "Prod. Order Component")
    var
        TableRecRef: RecordRef;
        xTableRecRef: RecordRef;
    begin
        TableRecRef.GetTable(Rec);
        xTableRecRef.GetTable(xRec);
        CheckIfModifyAllowed(TableRecRef, xTableRecRef, Database::"Prod. Order Component");
    end;

    procedure CheckIfModifyAllowed(var Rec: Record "Prod. Order Routing Line"; var xRec: Record "Prod. Order Routing Line")
    var
        TableRecRef: RecordRef;
        xTableRecRef: RecordRef;
    begin
        TableRecRef.GetTable(Rec);
        xTableRecRef.GetTable(xRec);
        CheckIfModifyAllowed(TableRecRef, xTableRecRef, Database::"Prod. Order Routing Line");
    end;

    procedure CheckIfModifyAllowed(var TableRecRef: RecordRef; var xTableRecRef: RecordRef; TableNo: Integer)
    var
        FieldSelect: Record "COL Field Selected";
        TableFldRef: FieldRef;
        xTableFldRef: FieldRef;
        FieldExclusionList: List of [Integer];
        I: Integer;
        FieldEditableNotErr: Label 'Field %1 is not allowed to modify when Production Order internal status is released!', Comment = '%1 - field name';
    begin
        if not GuiAllowed() then
            exit;

        FillSalesHeaderFieldExclusionList(FieldExclusionList, TableNo);

        for i := 1 to TableRecRef.FieldCount do begin
            TableFldRef := TableRecRef.FieldIndex(i);
            xTableFldRef := xTableRecRef.FieldIndex(i);
            if TemplateFieldCanBeProcessed(TableFldRef.Number, FieldExclusionList) then
                if TableFldRef.Value <> xTableFldRef.Value then begin

                    FieldSelect.SetRange("Code", '');
                    FieldSelect.SetRange("Table No.", TableNo);
                    FieldSelect.SetRange("Field No.", TableFldRef.Number);
                    if FieldSelect.FindLast() and (not FieldSelect.Selected) then
                        Error(FieldEditableNotErr, TableFldRef.Name);
                end;
        end;
    end;

    /// <summary>
    /// OpenFieldSelectSalesHeader.
    /// </summary>
    procedure OpenFieldSelectProductionOrder()
    var
        ProdHeader: Record "Production Order";
    begin
        FillTemplateFieldFromTable(ProdHeader);

        Commit();
        OpenEditPage(Database::"Production Order", PageCapLbl);
    end;

    procedure OpenFieldSelectProductionOrderLines()
    var
        ProdLine: Record "Prod. Order Line";
    begin
        FillTemplateFieldFromTable(ProdLine);

        Commit();
        OpenEditPage(Database::"Prod. Order Line", PageLinesCapLbl);
    end;

    procedure OpenFieldSelectProductionOrderComponents()
    var
        ProdComp: Record "Prod. Order Component";
    begin
        FillTemplateFieldFromTable(ProdComp);

        Commit();
        OpenEditPage(Database::"Prod. Order Component", PageCompCapLbl);
    end;

    procedure OpenFieldSelectProductionOrderRoutes()
    var
        ProdRoute: Record "Prod. Order Routing Line";
    begin
        FillTemplateFieldFromTable(ProdRoute);

        Commit();
        OpenEditPage(Database::"Prod. Order Routing Line", PageRouteCapLbl);
    end;

    local procedure OpenEditPage(TableNo: Integer; Title: Text)
    var
        FieldSelected: Record "COL Field Selected";
        FieldSelectedPage: Page "COL Fields Selected";
    begin
        FieldSelected.SetRange("Table No.", TableNo);
        FieldSelected.SetRange("Code", '');
        FieldSelectedPage.SetTableView(FieldSelected);
        FieldSelectedPage.Caption(Title);
        FieldSelectedPage.RunModal();
    end;

    internal procedure FillTemplateFieldFromTable(var ProdHeader: Record "Production Order")
    var
        TableRecRef: RecordRef;
    begin
        TableRecRef.GetTable(ProdHeader);
        FillTemplateFieldFromTable(TableRecRef, Database::"Production Order");
    end;

    internal procedure FillTemplateFieldFromTable(var ProdLine: Record "Prod. Order Line")
    var
        TableRecRef: RecordRef;
    begin
        TableRecRef.GetTable(ProdLine);
        FillTemplateFieldFromTable(TableRecRef, Database::"Prod. Order Line");
    end;

    internal procedure FillTemplateFieldFromTable(var ProdComp: Record "Prod. Order Component")
    var
        TableRecRef: RecordRef;
    begin
        TableRecRef.GetTable(ProdComp);
        FillTemplateFieldFromTable(TableRecRef, Database::"Prod. Order Component");
    end;

    internal procedure FillTemplateFieldFromTable(var ProdRoute: Record "Prod. Order Routing Line")
    var
        TableRecRef: RecordRef;
    begin
        TableRecRef.GetTable(ProdRoute);
        FillTemplateFieldFromTable(TableRecRef, Database::"Prod. Order Routing Line");
    end;

    local procedure FillTemplateFieldFromTable(var TableRecRef: RecordRef; TableNo: Integer)
    var
        FieldSelect: Record "COL Field Selected";
        TableFldRef: FieldRef;
        EmptyTableRecRef: RecordRef;
        EmptyTableFldRef: FieldRef;
        FieldExclusionList: List of [Integer];
        i: Integer;
    begin
        EmptyTableRecRef.Open(TableNo);
        EmptyTableRecRef.Init();

        FillSalesHeaderFieldExclusionList(FieldExclusionList, TableNo);

        for i := 2 to TableRecRef.FieldCount do begin
            TableFldRef := TableRecRef.FieldIndex(i);
            if TemplateFieldCanBeProcessed(TableFldRef.Number, FieldExclusionList) then begin
                EmptyTableFldRef := EmptyTableRecRef.Field(TableFldRef.Number);

                FieldSelect.SetRange("Code", '');
                FieldSelect.SetRange("Table No.", TableNo);
                FieldSelect.SetRange("Field No.", TableFldRef.Number);
                if not FieldSelect.FindFirst() then begin
                    FieldSelect.Reset();
                    FieldSelect.Init();
                    FieldSelect.Validate("Code", '');
                    FieldSelect.Validate("Table No.", TableNo);
                    FieldSelect.Validate("Field No.", TableFldRef.Number);
                    FieldSelect.Insert();
                end;

                FieldSelect."Field Name" := CopyStr(TableFldRef.Name, 1, MaxStrLen(FieldSelect."Field Name"));
                FieldSelect."Field Caption" := CopyStr(TableFldRef.Caption(), 1, MaxStrLen(FieldSelect."Field Caption"));
                if TableFldRef.Type = TableFldRef.Type::Text then
                    FieldSelect."Field Value" := CopyStr(TableFldRef.Value, 1, MaxStrLen(FieldSelect."Field Value"))
                else
                    FieldSelect."Field Value" := CopyStr(Format(TableFldRef.Value), 1, MaxStrLen(FieldSelect."Field Value"));
                FieldSelect.Modify();
            end;
        end;
    end;

    local procedure TemplateFieldCanBeProcessed(FieldNumber: Integer; FieldExclusionList: List of [Integer]): Boolean
    var
        TableField: Record Field;
        ClearTableField: Record Field;
    begin
        if FieldExclusionList.Contains(FieldNumber) or (FieldNumber > 2000000000) then
            exit(false);

        if (TableField.Class <> TableField.Class::Normal) or (ClearTableField.Class <> ClearTableField.Class::Normal) or
            (TableField.Type <> ClearTableField.Type) or (TableField.FieldName <> ClearTableField.FieldName) or
            (TableField.Len <> ClearTableField.Len) or
            (TableField.ObsoleteState = TableField.ObsoleteState::Removed) or
            (ClearTableField.ObsoleteState = ClearTableField.ObsoleteState::Removed)
        then
            exit(false);

        exit(true);
    end;

    local procedure FillSalesHeaderFieldExclusionList(var FieldExclusionList: List of [Integer]; TableNo: Integer)
    var
        ProdHeader: Record "Production Order";
        ProdLine: Record "Prod. Order Line";
        ProdComp: Record "Prod. Order Component";
        ProdRoute: Record "Prod. Order Routing Line";
    begin
        case TableNo of
            Database::"Production Order":
                begin
                    FieldExclusionList.Add(ProdHeader.FieldNo("No."));
                    FieldExclusionList.Add(ProdHeader.FieldNo("COL No. of Archived Versions"));
                    FieldExclusionList.Add(ProdHeader.FieldNo("COL Reason Code"));
                    FieldExclusionList.Add(ProdHeader.FieldNo("COL Internal Status"));
                end;
            Database::"Prod. Order Line":
                begin
                    FieldExclusionList.Add(ProdLine.FieldNo("Prod. Order No."));
                    FieldExclusionList.Add(ProdLine.FieldNo("Line No."));
                end;
            Database::"Prod. Order Component":
                begin
                    FieldExclusionList.Add(ProdComp.FieldNo("Prod. Order No."));
                    FieldExclusionList.Add(ProdComp.FieldNo("Prod. Order Line No."));
                    FieldExclusionList.Add(ProdComp.FieldNo("Line No."));
                end;
            Database::"Prod. Order Routing Line":
                begin
                    FieldExclusionList.Add(ProdRoute.FieldNo("Prod. Order No."));
                    FieldExclusionList.Add(ProdRoute.FieldNo("Routing Reference No."));
                end;
        end;
    end;

    var
        PageCapLbl: Label 'Field allow to edit - Production Order Header';
        PageLinesCapLbl: Label 'Field allow to edit - Production Order Lines';
        PageCompCapLbl: Label 'Field allow to edit - Production Order Components';
        PageRouteCapLbl: Label 'Field allow to edit - Production Order Routes';

}