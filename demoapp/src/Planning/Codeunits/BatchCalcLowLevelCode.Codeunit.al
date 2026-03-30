namespace Weibel.Manufacturing.Planning.Batch;

using Microsoft.Inventory.Item;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Inventory.BOM;

codeunit 70139 "COL Batch Calc. Low-Level Code"
{
    trigger OnRun()
    begin
        Initialize();
        FindTopLevel();

        // WeibelSetup.GET;
        // IF WeibelSetup."Auto Calc. Item Min Values" THEN
        //CalculateAllBOMMinValues();
    end;

    var
        WindowUpdateDateTime: DateTime;
        Window: Dialog;
        NoofItems: Integer;
        CountOfRecords: Integer;
        HasProductionBOM: Boolean;
        BarWInLbl: Label '#1################## \\', Comment = '#1 - Window title';
        BarTextLbl: Label 'No. #2################## @3@@@@@@@@@@@@@', Comment = '#2 - Text for the progress bar';
        TopLvlLbl: Label 'Top-Level Items';
        BomsLbl: Label 'BOMs';

    local procedure Initialize()
    begin
        Clear(WindowUpdateDateTime);
        Clear(NoofItems);
        Clear(CountOfRecords);
        Clear(HasProductionBOM);

        NoofItems := 0;
        if GuiAllowed() then
            Window.OPEN(BarWInLbl + BarTextLbl);
        WindowUpdateDateTime := CurrentDateTime();

        if GuiAllowed() then
            Window.Update(1, TopLvlLbl);
    end;

    local procedure FindTopLevel()
    var
        ProdBOMHeader: Record "Production BOM Header";
        ProdBOMLine: Record "Production BOM Line";
        BOMComp: Record "BOM Component";
        Item: Record Item;
        CalculateLowLevelCode: Codeunit "Calculate Low-Level Code";
    begin
        Item.LockTable();
        Item.ModifyAll("Low-Level Code", 0);
        ProdBOMHeader.LockTable();
        ProdBOMHeader.ModifyAll("Low-Level Code", 0);

        ProdBOMLine.SetCurrentKey(Type, "No.");
        CountOfRecords := Item.Count();
        if Item.FindSet() then
            repeat
                UpdateBar(Item."No.");

                HasProductionBOM := ProdBOMHeader.Get(Item."Production BOM No.");
                if (ProdBOMHeader."Low-Level Code" = 0) or not HasProductionBOM then begin
                    ProdBOMLine.SetRange("No.", Item."No.");
                    ProdBOMLine.SetRange(Type, ProdBOMLine.Type::Item);

                    BOMComp.SetRange(Type, BOMComp.Type::Item);
                    BOMComp.SetRange("No.", Item."No.");

                    if ProdBOMLine.IsEmpty() and BOMComp.IsEmpty() then begin
                        // handle items which are not part of any BOMs
                        Item.CalcFields("Assembly BOM");
                        if Item."Assembly BOM" then
                            CalculateLowLevelCode.RecalcAsmLowerLevels(Item."No.", CalculateLowLevelCode.CalcLevels(3, Item."No.", 0, 0), true);
                        if HasProductionBOM then
                            CalcLevelsForBOM(ProdBOMHeader);
                    end else
                        if HasProductionBOM then
                            CalcLines(ProdBOMLine, ProdBOMHeader);
                end;

                NoofItems := NoofItems + 1;
            until Item.Next() = 0;

        CalcBOM(ProdBOMHeader);
    end;

    local procedure UpdateBar(CodeOnLabel: Text)
    begin
        if GuiAllowed() then
            if CurrentDateTime() - WindowUpdateDateTime > 2000 then begin
                Window.Update(2, CodeOnLabel);
                Window.Update(3, Round(NoofItems / CountOfRecords * 10000, 1));
                WindowUpdateDateTime := CurrentDateTime();
            end;
    end;

    local procedure CalcBOM(var ProdBOMHeader: Record "Production BOM Header")
    var
        ProdBOMHeader2: Record "Production BOM Header";
    begin
        NoofItems := 0;
        if GuiAllowed() then
            Window.Update(1, BomsLbl);

        ProdBOMHeader.Reset();
        ProdBOMHeader.SetCurrentKey(Status);
        ProdBOMHeader.SetRange(Status, ProdBOMHeader.Status::Certified);
        ProdBOMHeader.SetRange("Low-Level Code", 0);
        CountOfRecords := ProdBOMHeader.Count();
        if ProdBOMHeader.FindSet() then
            repeat
                UpdateBar(ProdBOMHeader."No.");

                ProdBOMHeader2 := ProdBOMHeader;
                CalcLevelsForBOM(ProdBOMHeader2);
                NoofItems := NoofItems + 1;
            until ProdBOMHeader.Next() = 0;
    end;

    local procedure CalcLines(var ProdBOMLine: Record "Production BOM Line"; var ProdBOMHeader: Record "Production BOM Header")
    var
        ProdBOMHeader2: Record "Production BOM Header";
    begin
        if ProdBOMLine.FindSet() then
            repeat
                // handle items which are part of un-certified, active BOMs
                if ProdBOMHeader2.Get(ProdBOMLine."Production BOM No.") then
                    if ProdBOMHeader2.Status in [ProdBOMHeader2.Status::New, ProdBOMHeader2.Status::"Under Development"] then
                        CalcLevelsForBOM(ProdBOMHeader);
            until ProdBOMLine.Next() = 0;
    end;

    local procedure CalcLevelsForBOM(var ProdBOM: Record "Production BOM Header")
    var
        ProductionBOMLine: Record "Production BOM Line";
        CalculateLowLevelCode: Codeunit "Calculate Low-Level Code";
    begin
        if ProdBOM.Status = ProdBOM.Status::Certified then begin
            ProdBOM."Low-Level Code" := CalculateLowLevelCode.CalcLevels(ProductionBOMLine.Type::"Production BOM".AsInteger(), ProdBOM."No.", 0, 0);
            CalculateLowLevelCode.RecalcLowerLevels(ProdBOM."No.", ProdBOM."Low-Level Code", true);
            ProdBOM.Modify();
        end;
    end;

    // local procedure CalculateAllBOMMinValues()
    // var
    //     Item: Record Item;
    //     BOMHeader: Record "Production BOM Header";
    //     UpdateThis: Boolean;
    // begin
    //     //PF1.04 150610 PMO New procedure
    //     WITH BOMHeader DO BEGIN
    //         BOMHeader.SETCURRENTKEY("Low-Level Code");
    //         Item.SETCURRENTKEY("Production BOM No.");
    //         Item.SETRANGE("Replenishment System", Item."Replenishment System"::"Prod. Order");

    //         BOMHeader.FINDLAST;
    //         REPEAT
    //             IF CalculateBOMMinValues(BOMHeader, Item) THEN
    //                 BOMHeader.MODIFY;
    //             Item.SETRANGE("Production BOM No.", BOMHeader."No.");
    //             IF Item.FINDSET THEN
    //                 REPEAT
    //                     UpdateThis := (Item."RoHS compatible" <> "RoHS compatible") OR
    //                       (Item."Peak Package Body Temp." <> "Peak Package Body Temp.");
    //                     IF UpdateThis THEN BEGIN
    //                         Item."RoHS compatible" := "RoHS compatible";
    //                         Item."Peak Package Body Temp." := "Peak Package Body Temp.";
    //                         Item.MODIFY;
    //                     END;
    //                 UNTIL Item.NEXT = 0;
    //             Item.SETRANGE("Production BOM No.");
    //         UNTIL BOMHeader.NEXT(-1) = 0;
    //     END;

    // end;

    // local procedure CalculateBOMMinValues(var BOMHeader: Record "Production BOM Header"; var Item: Record Item) HasChanged: Boolean
    // var
    //     BOMHeader2: Record "Production BOM Header";
    //     ProdBOMLine: Record "Production BOM Line";
    //     MinRoHSValueFound: Integer;
    //     MinPPBTValueFound: Integer;
    //     UpdateThis: Boolean;
    // begin
    //     ProdBOMLine.SETRANGE("Production BOM No.", BOMHeader."No.");
    //     ProdBOMLine.SETFILTER(Type, '<>%1', ProdBOMLine.Type::" ");
    //     BOMHeader2 := BOMHeader;
    //     IF NOT ProdBOMLine.FINDSET() THEN
    //         EXIT;

    //     MinRoHSValueFound := 99999;
    //     MinPPBTValueFound := 99999;

    //     REPEAT
    //         CASE ProdBOMLine.Type OF
    //             ProdBOMLine.Type::Item:
    //                 IF Item.GET(ProdBOMLine."No.") THEN BEGIN
    //                     UpdateThis := (Item."RoHS compatible" <> ProdBOMLine."RoHS compatible") OR
    //                       (Item."Peak Package Body Temp." <> ProdBOMLine."Peak Package Body Temp.");
    //                     IF UpdateThis THEN BEGIN
    //                         ProdBOMLine."RoHS compatible" := Item."RoHS compatible";
    //                         ProdBOMLine."Peak Package Body Temp." := Item."Peak Package Body Temp.";
    //                         ProdBOMLine.MODIFY;
    //                     END;
    //                 END;

    //             ProdBOMLine.Type::"Production BOM":
    //                 IF BOMHeader.GET(ProdBOMLine."No.") THEN BEGIN
    //                     UpdateThis := (BOMHeader."RoHS compatible" <> ProdBOMLine."RoHS compatible") OR
    //                       (BOMHeader."Peak Package Body Temp." <> ProdBOMLine."Peak Package Body Temp.");
    //                     IF UpdateThis THEN BEGIN
    //                         ProdBOMLine."RoHS compatible" := BOMHeader."RoHS compatible";
    //                         ProdBOMLine."Peak Package Body Temp." := BOMHeader."Peak Package Body Temp.";
    //                         ProdBOMLine.MODIFY();
    //                     END;
    //                 END; //***
    //         END;

    //         IF "RoHS compatible" < MinRoHSValueFound THEN
    //             MinRoHSValueFound := ProdBOMLine."RoHS compatible";
    //         IF "Peak Package Body Temp." < MinPPBTValueFound THEN
    //             MinPPBTValueFound := ProdBOMLine."Peak Package Body Temp.";

    //     UNTIL ProdBOMLine.NEXT() = 0;

    //     BOMHeader := BOMHeader2;
    //     BOMHeader."RoHS compatible" := MinRoHSValueFound;
    //     BOMHeader."Peak Package Body Temp." := MinPPBTValueFound;
    //     HasChanged := (BOMHeader."RoHS compatible" <> BOMHeader2."RoHS compatible") OR
    //       (BOMHeader."Peak Package Body Temp." <> BOMHeader2."Peak Package Body Temp.");
    // end;

}
