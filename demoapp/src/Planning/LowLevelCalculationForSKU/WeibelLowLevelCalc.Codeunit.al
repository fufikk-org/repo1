#if not HIDE_LOWLEVEL_SKU
namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.BOM;

codeunit 70196 "COL Weibel Low Level Calc."
{
    trigger OnRun()
    begin
        CalculateLowLevel();
    end;

    var
        LowLevelCalcWarningMgt: Codeunit "COL LowLevel Calc. Warning Mgt";
        AllElements: Dictionary of [Guid, Integer];
        AllDetails: Dictionary of [Guid, List of [Text]];
        DetailsList: List of [Text];
        Window: Dialog;
        SKUDoesNotExistLbl: Label 'SKU does not exist: %1.', Comment = '%1 = SKU record information';
        BOMDoesNotExistLbl: Label 'BOM %1 does not exist (SKU: %2, %3).', Comment = '%1 = Prod. BOM No.; %2 = Item No.; %3 = Variant Code';
        ProdBOMLinesMissingLbl: Label 'No BOM Lines for BOM %1.', Comment = '%1 = production bom no.';
        AsmBOMLinesMissingLbl: Label 'No asm. BOM Lines for parent item %1.', Comment = '%1 = item no.';
        ConfirmQst: Label 'Calculate low-level code using SKUs?';
        ProgressLbl: Label 'Processing SKUs: #1#\Warnings: #2#\Storing results: #3#\Storing details: #4#\Storing warnings: #5#', Comment = '%1 = number; %2 = number; %3 = status; %4 = status; %5 = status';
        CounterLbl: Label '%1 of %2', Comment = '%1 = number; %2 = number';
        InProgressStatusLbl: Label 'In-progress...';
        DoneStatusLbl: Label 'Done.';
        CalcSummaryLbl: Label 'Calculation Summary:\Processed SKUs: %1\Calculation Time: %2\Warnings: %3', Comment = '%1 = number of sku-s; %2 = duration; %3 = warning count';


    procedure RunLowLevelCalculations()
    begin
        if Confirm(ConfirmQst, false) then
            CalculateLowLevel();
    end;

    local procedure CalculateLowLevel()
    var
        StockkeepingUnit: Record "Stockkeeping Unit";
        SKUTotal, SKUCounter : Integer;
        LastUpdate, CalcStart : DateTime;
        CalcDuration: Duration;
    begin
        if GuiAllowed() then
            Window.Open(ProgressLbl);
        LastUpdate := CurrentDateTime();
        CalcStart := CurrentDateTime();

        SKUTotal := StockkeepingUnit.CountApprox();

        if StockkeepingUnit.FindSet() then
            repeat
                ProcessSKU(StockkeepingUnit, 0);
                SKUCounter += 1;
                if GuiAllowed() then
                    if CurrentDateTime() - LastUpdate > 1000 then begin
                        Window.Update(1, StrSubstNo(CounterLbl, SKUCounter, SKUTotal));
                        Window.Update(2, LowLevelCalcWarningMgt.GetWarningCount());
                        LastUpdate := CurrentDateTime();
                    end;
            until StockkeepingUnit.Next() = 0;

        if GuiAllowed() then
            Window.Update(1, StrSubstNo(CounterLbl, SKUCounter, SKUTotal));

        StoreLowLevelResults();
        StoreLowLevelDetails();
        StoreWarnings();

        CalcDuration := CurrentDateTime() - CalcStart;
        Commit();

        if GuiAllowed() then begin
            Window.Close();
            Message(CalcSummaryLbl, SKUCounter, CalcDuration, LowLevelCalcWarningMgt.GetWarningCount());
        end;
    end;

    local procedure ProcessSKU(SKU: Record "Stockkeeping Unit"; CurrentLowLevel: Integer)
    var
        ElementLowLevel, ElementAt : Integer;
        DetailElement: Text;
        SKULbl: Label 'SKU: %1', Comment = '%1 = record info';
    begin
        // for reporting details of low level calc.
        DetailElement := GetDetailText(CurrentLowLevel, StrSubstNo(SKULbl, SKU.RecordId()));
        DetailsList.Add(Format(DetailElement));
        ElementAt := DetailsList.Count();

        if AllElements.Get(SKU.SystemId, ElementLowLevel) then begin
            if ElementLowLevel < CurrentLowLevel then begin
                AllElements.Set(SKU.SystemId, CurrentLowLevel);
                // for detail reporting:
                AllDetails.Set(SKU.SystemId, DetailsList.GetRange(1, DetailsList.Count()));
            end;
        end else begin
            AllElements.Add(SKU.SystemId, CurrentLowLevel);
            // for detail reporting:
            AllDetails.Add(SKU.SystemId, DetailsList.GetRange(1, DetailsList.Count()));
        end;

        if SKU."Production BOM No." <> '' then
            DrillDownProduction(SKU, CurrentLowLevel);

        if SKU.IsAssemblySKU() then
            DrillDownAssembly(SKU, CurrentLowLevel);

        // for detail reporting:
        DetailsList.RemoveRange(ElementAt, DetailsList.Count() - ElementAt + 1);
    end;

    local procedure DrillDownProduction(ParentSKU: Record "Stockkeeping Unit"; CurrentLowLevel: Integer)
    var
        ProductionBOMLine: Record "Production BOM Line";
        ProductionBOMHeader: Record "Production BOM Header";
        SKU: Record "Stockkeeping Unit";
        DetailElement: Text;
        DrillDownBOMLbl: Label 'Drilldown Prod. BOM: %1', Comment = '%1 = production bom.';
    begin
        // for detail reporting:
        DetailElement := GetDetailText(CurrentLowLevel, StrSubstNo(DrillDownBOMLbl, ParentSKU."Production BOM No."));
        DetailsList.Add(Format(DetailElement));

        ProductionBOMHeader.SetLoadFields(Status);
        if not ProductionBOMHeader.Get(ParentSKU."Production BOM No.") then begin
            LowLevelCalcWarningMgt.RegisterWarning('BOM', StrSubstNo(BOMDoesNotExistLbl, ParentSKU."Production BOM No.", ParentSKU."Item No.", ParentSKU."Variant Code"));
            exit;
        end;
        if ProductionBOMHeader.Status <> Enum::"BOM Status"::Certified then
            exit;

        ProductionBOMLine.SetRange("Production BOM No.", ParentSKU."Production BOM No.");
        ProductionBOMLine.SetRange("Version Code", '');
        ProductionBOMLine.SetLoadFields(Type, "No.", "Variant Code");
        ProductionBOMLine.SetFilter(Type, '%1|%2', Enum::"Production BOM Line Type"::Item, Enum::"Production BOM Line Type"::"Production BOM");
        if ProductionBOMLine.FindSet() then
            repeat
                SKU.Reset();
                case ProductionBOMLine.Type of
                    Enum::"Production BOM Line Type"::Item:
                        begin
                            SKU.SetRange("Item No.", ProductionBOMLine."No.");
                            SKU.SetRange("Variant Code", ProductionBOMLine."Variant Code");
                            if SKU.IsEmpty() then
                                LowLevelCalcWarningMgt.RegisterWarning('SKU', StrSubstNo(SKUDoesNotExistLbl, SKU.GetFilters()))
                            else
                                if SKU.FindSet() then
                                    repeat
                                        ProcessSKU(SKU, CurrentLowLevel + 1);
                                    until SKu.Next() = 0;
                        end;

                    Enum::"Production BOM Line Type"::"Production BOM":
                        begin
                            SKU.SetRange("Production BOM No.", ProductionBOMLine."No.");
                            if SKU.IsEmpty() then
                                LowLevelCalcWarningMgt.RegisterWarning('SKU', StrSubstNo(SKUDoesNotExistLbl, SKU.GetFilters()))
                            else
                                if SKU.FindSet() then
                                    repeat
                                        ProcessSKU(SKU, CurrentLowLevel); // put the components of such bom on the same level
                                    until SKu.Next() = 0;
                        end;

                end;
            until ProductionBOMLine.Next() = 0
        else
            LowLevelCalcWarningMgt.RegisterWarning('BOM LINES', StrSubstNo(ProdBOMLinesMissingLbl, ParentSKU."Production BOM No."));
    end;

    local procedure DrillDownAssembly(ParentSKU: Record "Stockkeeping Unit"; CurrentLowLevel: Integer)
    var
        BOMComponent: Record "BOM Component";
        SKU: Record "Stockkeeping Unit";
        DetailElement: Text;
        DrillDownAsmBOMLbl: Label 'Drilldown assembly for: %1', Comment = '%1 = parent item no.';
    begin
        // for detail reporting:
        DetailElement := GetDetailText(CurrentLowLevel, StrSubstNo(DrillDownAsmBOMLbl, ParentSKU."Item No."));
        DetailsList.Add(Format(DetailElement));

        BOMComponent.SetRange("Parent Item No.", ParentSKU."Item No.");
        BOMComponent.SetRange(Type, Enum::"BOM Component Type"::Item);
        BOMComponent.SetLoadFields("No.", "Variant Code");
        if BOMComponent.FindSet() then
            repeat
                SKU.SetRange("Item No.", BOMComponent."No.");
                SKU.SetRange("Variant Code", BOMComponent."Variant Code");
                if SKU.IsEmpty() then
                    LowLevelCalcWarningMgt.RegisterWarning('SKU', StrSubstNo(SKUDoesNotExistLbl, SKU.GetFilters()))
                else
                    if SKU.FindSet() then
                        repeat
                            ProcessSKU(SKU, CurrentLowLevel + 1);
                        until SKu.Next() = 0;
            until BOMComponent.Next() = 0
        else
            LowLevelCalcWarningMgt.RegisterWarning('ASM LINES', StrSubstNo(AsmBOMLinesMissingLbl, ParentSKU."Item No."));
    end;

    local procedure StoreLowLevelResults()
    var
        StockkeepingUnit: Record "Stockkeeping Unit";
        SKUId: Guid;
        LowLevelValue: Integer;
        LowLevelGuid: List of [Guid];
        ElementsByValue: Dictionary of [Integer, List of [Guid]];
    begin
        if GuiAllowed() then
            Window.Update(3, InProgressStatusLbl);

        // group SKUid-s by their low level and later update in batches
        foreach SKUId in AllElements.Keys() do begin
            LowLevelValue := AllElements.Get(SKUId);
            if not ElementsByValue.ContainsKey(LowLevelValue) then begin
                Clear(LowLevelGuid);
                LowLevelGuid.Add(SKUId);
                ElementsByValue.Add(LowLevelValue, LowLevelGuid);
            end else begin
                LowLevelGuid := ElementsByValue.Get(LowLevelValue);
                LowLevelGuid.Add(SKUId);
                ElementsByValue.Set(LowLevelValue, LowLevelGuid);
            end;
        end;

        // there's a lot of 0 level codes, faster to change all to zero first and update remaining ones
        StockkeepingUnit.ModifyAll("COL Low-Level Code", 0);

        foreach LowLevelValue in ElementsByValue.Keys() do
            if LowLevelValue > 0 then
                UpdateLowLevelCodesOnSKUs(ElementsByValue.Get(LowLevelValue), LowLevelValue);

        if GuiAllowed() then
            Window.Update(3, DoneStatusLbl);
    end;

    local procedure UpdateLowLevelCodesOnSKUs(SKUsToUpdate: List of [Guid]; NewLowLevelCode: Integer): Integer
    var
        SKU: Record "Stockkeeping Unit";
        SKUsToProcessCount, i, j, Counter : Integer;
        GuidBuilder: TextBuilder;
        SubSKUsToSet: List of [Guid];
    begin
        while SKUsToUpdate.Count() > 0 do begin

            SKUsToProcessCount := 200;
            if SKUsToProcessCount > SKUsToUpdate.Count() then
                SKUsToProcessCount := SKUsToUpdate.Count();

            Counter += SKUsToProcessCount;

            SubSKUsToSet := SKUsToUpdate.GetRange(1, SKUsToProcessCount);
            Clear(GuidBuilder);
            j := 0;
            for i := 1 to SubSKUsToSet.Count() do
                if not IsNullGuid(SubSKUsToSet.Get(i)) then begin
                    if j > 0 then
                        GuidBuilder.Append('|');
                    GuidBuilder.Append(SubSKUsToSet.Get(i));
                    j += 1;
                end;

            SKU.SetFilter(SystemId, GuidBuilder.ToText());
            SKU.ModifyAll("COL Low-Level Code", NewLowLevelCode);

            SKUsToUpdate.RemoveRange(1, SKUsToProcessCount);
        end;
        exit(Counter);
    end;

    local procedure StoreLowLevelDetails()
    var
        WeibelLowLevelSetup: Record "COL Weibel Low Level Setup";
        SKULowLevelDetail: Record "COL SKU Low Level Detail";
        SKU: Record "Stockkeeping Unit";
        PathDetail: Text;
        LineNo: Integer;
        SKUGuid: Guid;
        SKUElementPath: List of [Text];
    begin
        SKULowLevelDetail.DeleteAll();
        WeibelLowLevelSetup.GetRecordOnce();
        if not WeibelLowLevelSetup."Log Low Level Details" then begin
            if GuiAllowed() then
                Window.Update(4, DoneStatusLbl);
            exit;
        end;

        if GuiAllowed() then
            Window.Update(4, InProgressStatusLbl);

        SKU.ReadIsolation := IsolationLevel::ReadUncommitted;
        SKU.SetLoadFields("Location Code", "Item No.", "Variant Code");
        foreach SKUGuid in AllDetails.Keys() do begin
            SKUElementPath := AllDetails.Get(SKUGuid);
            LineNo := 0;
            SKU.GetBySystemId(SKUGuid);
            foreach PathDetail in SKUElementPath do begin
                SKULowLevelDetail.Init();
                SKULowLevelDetail."Location Code" := SKU."Location Code";
                SKULowLevelDetail."Item No." := SKU."Item No.";
                SKULowLevelDetail."Variant Code" := SKU."Variant Code";
                LineNo += 1;
                SKULowLevelDetail."Line No." := LineNo;
                if GetFromDetailText(PathDetail, SKULowLevelDetail."Path Information", SKULowLevelDetail."Low Level Code") then
                    SKULowLevelDetail.Insert();
            end;
        end;
        if GuiAllowed() then
            Window.Update(4, DoneStatusLbl);
    end;

    local procedure StoreWarnings()
    begin
        if GuiAllowed() then
            Window.Update(5, InProgressStatusLbl);
        LowLevelCalcWarningMgt.StoreRegisteredWarnings();
        if GuiAllowed() then
            Window.Update(5, DoneStatusLbl);
    end;

    local procedure GetDetailText(LowLevelCode: Integer; DetText: Text): Text
    var
        JsonKey: JsonObject;
    begin
        JsonKey.Add('LowLevelCode', Format(LowLevelCode));
        JsonKey.Add('InfoText', DetText);
        exit(Format(JsonKey));
    end;

    local procedure GetFromDetailText(FullInfoText: Text; var DetText: Text[100]; var LowLevelCode: Integer): Boolean
    var
        JsonKey: JsonObject;
    begin
        if JsonKey.ReadFrom(FullInfoText) then begin
            LowLevelCode := JsonKey.GetInteger('LowLevelCode');
            DetText := CopyStr(JsonKey.GetText('InfoText'), 1, MaxStrLen(DetText));
            exit(true);
        end;
    end;
}
#endif