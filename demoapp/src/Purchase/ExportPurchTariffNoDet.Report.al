report 70114 "COL ExportPurch.TariffNo.Det."
{
    Caption = 'Export Purchase Per Tariff No. Detail';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(TariffNumber; "Tariff Number")
        {
            RequestFilterFields = "No.";

            trigger OnPreDataItem()
            begin
                CurrReport.Skip();
            end;
        }

    }

    requestpage
    {

        layout
        {
            area(Content)
            {
                group(Dates)
                {
                    Caption = 'Dates';
                    field(FieldStartingDate; StartingDate)
                    {
                        Caption = 'Starting Date';
                        ToolTip = 'Specifies the starting date for filtering the report.';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            if StartingDate > EndingDate then
                                EndingDate := 0D;
                        end;
                    }
                    field(FieldEndingDate; EndingDate)
                    {
                        Caption = 'Starting Date';
                        ToolTip = 'Specifies the ending date for filtering the report.';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            if StartingDate > EndingDate then
                                StartingDate := 0D;
                        end;
                    }
                }

                group(Details)
                {
                    Caption = 'Details';
                    field(FieldShowBlankTariffDetail; ShowBlankTariffDetail)
                    {
                        Caption = 'Show Blank Tariff Detail';
                        ToolTip = 'Specifies whether to include details for items with no tariff number.';
                        ApplicationArea = All;
                    }
                    field(FieldShowSmallItemDetail; ShowSmallItemDetail)
                    {
                        Caption = 'Show Small Item Detail';
                        ToolTip = 'Specifies whether to include details for items with small quantities.';
                        ApplicationArea = All;
                    }
                }
            }
        }


    }

    trigger OnPostReport()
    begin
        TempExcelBuffer.DeleteAll();

        SetupReportMetaData('');

        BasicReportHeaders();
        BasicReport();

        TempExcelBuffer.CreateNewBook(WorkBookNameLbl);
        TempExcelBuffer.WriteSheet(WorkBookNameLbl, CompanyName, UserId);

        TempExcelBuffer.SetColumnWidth('A', 20);
        TempExcelBuffer.SetColumnWidth('B', 30);
        TempExcelBuffer.SetColumnWidth('C', 20);

        if ShowBlankTariffDetail then
            CreateDetailedBook(BlankTariffDetailLbl, '''''', '=''''');

        if ShowSmallItemDetail then
            CreateDetailedBook(SmallItemTariffDetailLbl, '99500000', '=99500000');


        TempExcelBuffer.CloseBook();
        TempExcelBuffer.SetFriendlyFilename(ExcelFileNameLbl);
        TempExcelBuffer.OpenExcel();

    end;

    var
        TempExcelBuffer: Record "Excel Buffer" temporary;
        StartingDate, EndingDate : Date;
        ShowBlankTariffDetail, ShowSmallItemDetail : Boolean;
        CurrRowNo: Integer;
        UserIdLbl: Label 'User ID:';
        DateRunLbl: Label 'Date/Time Run:';
        FiltersLbl: Label 'Filters:';
        DateRangeLbl: Label 'Date Range:';
        PurchaseAmountLbl: Label 'Purchase Amount';
        ExcelFileNameLbl: Label 'TariffReport.xlsx';
        WorkBookNameLbl: Label 'Tariff Data';
        TotalLbl: Label 'Total:';
        BlankTariffNoLbl: Label 'Blank Tariff No.';
        BlankTariffDetailLbl: Label 'Blank Tariff Detail';
        SmallItemTariffDetailLbl: Label 'Small Item Tariff Detail';
        BaseCellType: Option Number,Text,Date,Time;

    internal procedure SetDates(FromDate: Date; ToDate: Date)
    begin
        StartingDate := FromDate;
        EndingDate := ToDate;
    end;


    local procedure CreateDetailedBook(BookName: Text; FilterText: Text; Filter: Text)
    begin
        TempExcelBuffer.DeleteAll();
        TempExcelBuffer.SetCurrent(0, 0);
        TempExcelBuffer.SelectOrAddSheet(BookName);
        CurrRowNo := 1;
        SetupReportMetaData(FilterText);
        DetailedReportHeaders();
        DetailedReport(Filter);

        TempExcelBuffer.WriteSheet(BookName, CompanyName, UserId);

        TempExcelBuffer.SetColumnWidth('A', 20);
        TempExcelBuffer.SetColumnWidth('B', 20);
        TempExcelBuffer.SetColumnWidth('C', 15);
        TempExcelBuffer.SetColumnWidth('E', 20);
        TempExcelBuffer.SetColumnWidth('F', 15);
        TempExcelBuffer.SetColumnWidth('G', 15);
        TempExcelBuffer.SetColumnWidth('H', 30);
        TempExcelBuffer.SetColumnWidth('I', 20);
        TempExcelBuffer.SetColumnWidth('J', 20);
        TempExcelBuffer.SetColumnWidth('K', 20);
        TempExcelBuffer.SetColumnWidth('L', 20);
        TempExcelBuffer.SetColumnWidth('M', 20);
        TempExcelBuffer.SetColumnWidth('N', 20);
        TempExcelBuffer.SetColumnWidth('O', 20);
        TempExcelBuffer.SetColumnWidth('P', 20);
        TempExcelBuffer.SetColumnWidth('R', 20);
        TempExcelBuffer.SetColumnWidth('S', 20);
        TempExcelBuffer.SetColumnWidth('T', 20);
    end;

    local procedure SetupReportMetaData(ForcedFilter: Text)
    var
        TariffNumber2: Record "Tariff Number";
    begin
        if ForcedFilter <> '' then
            TariffNumber2.SetFilter("No.", ForcedFilter);
        InsertCell(true, 1, UserIdLbl, true, false, false, '', BaseCellType::Text);
        InsertCell(false, 2, CopyStr(UserId, 1, 250), false, false, false, '', BaseCellType::Text);
        InsertCell(true, 1, DateRunLbl, true, false, false, '', BaseCellType::Text);
        InsertCell(false, 2, Format(CurrentDateTime()), false, false, false, '', BaseCellType::Text);
        InsertCell(true, 1, DateRangeLbl, true, false, false, '', BaseCellType::Text);
        InsertCell(false, 2, CopyStr(StrSubstNo('%1..%2', StartingDate, EndingDate), 1, 250), false, false, false, '', BaseCellType::Text);
        InsertCell(true, 1, FiltersLbl, true, false, false, '', BaseCellType::Text);
        if ForcedFilter <> '' then
            InsertCell(false, 2, CopyStr(TariffNumber2.GetFilters(), 1, 250), false, false, false, '', BaseCellType::Text)
        else
            InsertCell(false, 2, CopyStr(TariffNumber.GetFilters(), 1, 250), false, false, false, '', BaseCellType::Text);

        CurrRowNo += 1;
    end;

    local procedure BasicReportHeaders()
    var
        Item: Record Item;
    begin
        InsertCell(true, 1, CopyStr(Item.FieldCaption("Tariff No."), 1, 250), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        InsertCell(false, 2, CopyStr(Item.FieldCaption(Description), 1, 250), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        InsertCell(false, 3, PurchaseAmountLbl, true, false, false, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure DetailedReportHeaders()
    var
        ValueEntry: Record "Value Entry";
    begin
        InsertCell(true, 1, CopyStr(ValueEntry.FieldCaption("Posting Date"), 1, 250), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        InsertCell(false, 2, CopyStr(ValueEntry.FieldCaption("Item No."), 1, 250), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        InsertCell(false, 3, CopyStr(ValueEntry.FieldCaption("Entry Type"), 1, 250), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        InsertCell(false, 4, CopyStr(ValueEntry.FieldCaption(Adjustment), 1, 250), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        InsertCell(false, 5, CopyStr(ValueEntry.FieldCaption("Document Type"), 1, 250), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        InsertCell(false, 6, CopyStr(ValueEntry.FieldCaption("Document No."), 1, 250), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        InsertCell(false, 7, CopyStr(ValueEntry.FieldCaption("Item Charge No."), 1, 250), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        InsertCell(false, 8, CopyStr(ValueEntry.FieldCaption(Description), 1, 250), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        InsertCell(false, 9, CopyStr(ValueEntry.FieldCaption("Cost Amount (Actual)"), 1, 250), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        InsertCell(false, 10, CopyStr(ValueEntry.FieldCaption("Cost Posted to G/L"), 1, 250), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        InsertCell(false, 11, CopyStr(ValueEntry.FieldCaption("Item Ledger Entry Quantity"), 1, 250), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        InsertCell(false, 12, CopyStr(ValueEntry.FieldCaption("Valued Quantity"), 1, 250), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        InsertCell(false, 13, CopyStr(ValueEntry.FieldCaption("Invoiced Quantity"), 1, 250), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        InsertCell(false, 14, CopyStr(ValueEntry.FieldCaption("Cost per Unit"), 1, 250), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        InsertCell(false, 15, CopyStr(ValueEntry.FieldCaption("Source Type"), 1, 250), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        InsertCell(false, 16, CopyStr(ValueEntry.FieldCaption("Source No."), 1, 250), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        InsertCell(false, 17, CopyStr(ValueEntry.FieldCaption("External Document No."), 1, 250), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        InsertCell(false, 18, CopyStr(ValueEntry.FieldCaption("Order Type"), 1, 250), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        InsertCell(false, 19, CopyStr(ValueEntry.FieldCaption("Item Ledger Entry No."), 1, 250), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        InsertCell(false, 20, CopyStr(ValueEntry.FieldCaption("Entry No."), 1, 250), true, false, false, '', TempExcelBuffer."Cell Type"::Text);
    end;

    local procedure DetailedReport(TariffNoFilter: Text)
    var
        ExportPurchTariffNoDet: Query "COL ExportPurchTariffNoDet";
        Total: array[2] of Decimal;
    begin
        ExportPurchTariffNoDet.SetFilter(Tariff_No_, TariffNoFilter);
        ExportPurchTariffNoDet.SetRange(Posting_Date, StartingDate, EndingDate);
        ExportPurchTariffNoDet.Open();

        while ExportPurchTariffNoDet.Read() do begin

            InsertCell(true, 1, Format(ExportPurchTariffNoDet.Posting_Date), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            InsertCell(false, 2, ExportPurchTariffNoDet.Item_No_, false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            InsertCell(false, 3, Format(ExportPurchTariffNoDet.Entry_Type), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            InsertCell(false, 4, Format(ExportPurchTariffNoDet.Adjustment), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            InsertCell(false, 5, Format(ExportPurchTariffNoDet.Document_Type), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            InsertCell(false, 6, ExportPurchTariffNoDet.Document_No_, false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            InsertCell(false, 7, ExportPurchTariffNoDet.Item_Charge_No_, false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            InsertCell(false, 8, ExportPurchTariffNoDet.VEDescription, false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            InsertCell(false, 9, Format(ExportPurchTariffNoDet.Cost_Amount__Actual_), false, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
            InsertCell(false, 10, Format(ExportPurchTariffNoDet.Cost_Posted_to_G_L), false, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);

            InsertCell(false, 11, Format(ExportPurchTariffNoDet.Item_Ledger_Entry_Quantity), false, false, false, '', TempExcelBuffer."Cell Type"::Number);
            InsertCell(false, 12, Format(ExportPurchTariffNoDet.Valued_Quantity), false, false, false, '', TempExcelBuffer."Cell Type"::Number);
            InsertCell(false, 13, Format(ExportPurchTariffNoDet.Invoiced_Quantity), false, false, false, '', TempExcelBuffer."Cell Type"::Number);
            InsertCell(false, 14, Format(ExportPurchTariffNoDet.Cost_per_Unit), false, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
            InsertCell(false, 15, Format(ExportPurchTariffNoDet.Source_Type), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            InsertCell(false, 16, ExportPurchTariffNoDet.Source_No_, false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            InsertCell(false, 17, ExportPurchTariffNoDet.External_Document_No_, false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            InsertCell(false, 18, Format(ExportPurchTariffNoDet.Order_Type), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            InsertCell(false, 19, Format(ExportPurchTariffNoDet.Item_Ledger_Entry_No_), false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            InsertCell(false, 20, Format(ExportPurchTariffNoDet.Entry_No_), false, false, false, '', TempExcelBuffer."Cell Type"::Text);


            Total[1] += ExportPurchTariffNoDet.Cost_Amount__Actual_;
            Total[2] += ExportPurchTariffNoDet.Cost_Posted_to_G_L;
        end;

        CurrRowNo += 1;

        InsertCell(true, 8, TotalLbl, true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        InsertCell(false, 9, Format(Total[1]), false, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
        InsertCell(false, 10, Format(Total[2]), false, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);

    end;

    local procedure BasicReport()
    var
        ExportPurchTariffNo: Query "COL ExportPurchTariffNo";
        Total: Decimal;
    begin
        if TariffNumber.GetFilter("No.") <> '' then
            ExportPurchTariffNo.SetFilter(Tariff_No_, TariffNumber.GetFilter("No."));
        ExportPurchTariffNo.SetRange(Posting_Date, StartingDate, EndingDate);
        ExportPurchTariffNo.Open();

        while ExportPurchTariffNo.Read() do begin
            InsertCell(true, 1, ExportPurchTariffNo.Tariff_No_, false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            InsertCell(false, 2, ExportPurchTariffNo.Tariff_No_ <> '' ? ExportPurchTariffNo.Description : BlankTariffNoLbl, false, false, false, '', TempExcelBuffer."Cell Type"::Text);
            InsertCell(false, 3, Format(ExportPurchTariffNo.Cost_Amount__Actual_), false, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);
            Total += ExportPurchTariffNo.Cost_Amount__Actual_;
        end;

        CurrRowNo += 1;

        InsertCell(true, 2, TotalLbl, true, false, false, '', TempExcelBuffer."Cell Type"::Text);
        InsertCell(false, 3, Format(Total), false, false, false, '#,##0.00', TempExcelBuffer."Cell Type"::Number);

    end;

    local procedure InsertCell(NewRow: Boolean; ColumnNo: Integer; CellValue: Text[250]; Bold: Boolean; Italic: Boolean; UnderLine: Boolean; NumberFormat: Text[30]; CellType: Option)
    begin
        if NewRow then
            CurrRowNo += 1;

        TempExcelBuffer.Init();
        TempExcelBuffer.Validate("Row No.", CurrRowNo);
        TempExcelBuffer.Validate("Column No.", ColumnNo);
        TempExcelBuffer."Cell Value as Text" := CellValue;
        TempExcelBuffer.Formula := '';
        TempExcelBuffer.Bold := Bold;
        TempExcelBuffer.Italic := Italic;
        TempExcelBuffer.Underline := UnderLine;
        TempExcelBuffer.NumberFormat := NumberFormat;
        TempExcelBuffer."Cell Type" := CellType;
        TempExcelBuffer.Insert();
    end;
}