namespace Weibel.Inventory.Item;

using Microsoft.Inventory.Item;
using Microsoft.Purchases.Document;
using Microsoft.Inventory.Location;
using Microsoft.Inventory.Requisition;
using Weibel.Inventory.LegacyItems;
using Weibel.Inventory.Planning;
using Microsoft.Purchases.Setup;
using Microsoft.Inventory.Availability;

tableextension 70102 "COL Item" extends Item
{
    fields
    {
        modify("Vendor No.")
        {
            trigger OnBeforeValidate()
            begin
                LastLeadTimeCalculation := Rec."Lead Time Calculation";
            end;

            trigger OnAfterValidate()
            var
                PurchSetup: Record "Purchases & Payables Setup";
            begin
                PurchSetup.SetLoadFields("COL Keep Vendor Lead Time I/S");
                PurchSetup.Get();
                if not PurchSetup."COL Keep Vendor Lead Time I/S" then
                    exit;
                Rec."Lead Time Calculation" := LastLeadTimeCalculation;
                Clear(LastLeadTimeCalculation);
            end;
        }
        field(70100; "COL Manufacturer Item No."; Text[100])
        {
            Caption = 'Manufacturer Item No.';
            DataClassification = CustomerContent;
        }
        field(70101; "COL Out.Qty.Blank.Purch.Order"; Decimal)
        {
            Caption = 'Qty. on Blanket Purch. Order';
            Editable = false;
            FieldClass = FlowField;
            DecimalPlaces = 0 : 5;
            CalcFormula = sum("Purchase Line"."Quantity (Base)" where("Document Type" = const("Blanket Order"),
                                                                               Type = const(Item),
                                                                               "No." = field("No."),
                                                                               "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                               "Location Code" = field("Location Filter"),
                                                                               "Drop Shipment" = field("Drop Shipment Filter"),
                                                                               "Variant Code" = field("Variant Filter"),
                                                                               "Expected Receipt Date" = field("Date Filter"),
                                                                               "Unit of Measure Code" = field("Unit of Measure Filter")));
        }
        field(70102; "COL Qty. Purch.Order"; Decimal)
        {
            Caption = 'Qty. on Purch. Order';
            Editable = false;
            FieldClass = FlowField;
            DecimalPlaces = 0 : 5;
            CalcFormula = sum("Purchase Line"."Quantity (Base)" where("Document Type" = const("Order"),
                                                                               Type = const(Item),
                                                                               "No." = field("No."),
                                                                               "Blanket Order Line No." = filter('>0'),
                                                                               "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                               "Location Code" = field("Location Filter"),
                                                                               "Drop Shipment" = field("Drop Shipment Filter"),
                                                                               "Variant Code" = field("Variant Filter"),
                                                                               "Expected Receipt Date" = field("Date Filter"),
                                                                               "Unit of Measure Code" = field("Unit of Measure Filter")));
        }
        field(70103; "COL Export Classification Code"; Enum "COL Item Export Classification")
        {
            Caption = 'Export Classification Code';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies item''s export classification.';
        }
        field(70104; "COL EU Classification No."; Text[30])
        {
            Caption = 'EU Classification No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies item''s EU Classification No. When value is present, US Classification No. cannot be specified.';

            trigger OnValidate()
            begin
                if Rec."COL US Classification No." <> '' then
                    Rec.FieldError("COL EU Classification No.", StrSubstNo(ClassificationFieldErr, Rec.FieldCaption("COL US Classification No.")));
            end;
        }
        field(70105; "COL US Classification No."; Text[30])
        {
            Caption = 'US Classification No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies item''s US Classification No. When value is present, EU Classification No. cannot be specified.';

            trigger OnValidate()
            begin
                if Rec."COL EU Classification No." <> '' then
                    Rec.FieldError("COL US Classification No.", StrSubstNo(ClassificationFieldErr, Rec.FieldCaption("COL EU Classification No.")));
            end;
        }
        field(70106; "COL EU RoHS Dir. Compliant"; Enum "COL EU RoHS Dir. Compliant")
        {
            Caption = 'EU RoHS Directive Compliant';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the value of the EU RoHS Directive Compliant field.';
        }
        field(70107; "COL EU REACH Reg. Compliant"; Enum "COL EU REACH Reg. Compliant")
        {
            Caption = 'EU REACH Regulation Compliant';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the value of the EU REACH Regulation Compliant field.';
        }
        field(70108; "COL Moisture Sensitivity Level"; Enum "COL Moisture Sensitivity Level")
        {
            Caption = 'Moisture Sensitivity Level';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the value of the Moisture Sensitivity Level field.';
        }
        field(70109; "COL NATO Stock No."; Text[50])
        {
            Caption = 'NATO Stock No.';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the value of the NATO Stock No. field.';
        }
        field(70110; "COL Created By User"; Text[100])
        {
            Caption = 'Created By User';
            ToolTip = 'Specifies the user who created the item.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70111; "COL Creation Date"; Date)
        {
            Caption = 'Creation Date';
            ToolTip = 'Specifies the date when the item was created.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(70112; "COL Item Configuration Type"; Enum "COL Item Configuration Type")
        {
            Caption = 'Item Configuration Type';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the item configuration type.';
        }
        field(70113; "COL Production Blocked"; Boolean)
        {
            Caption = 'Production Blocked';
            ToolTip = 'Specifies whether the item is blocked for production.';
            DataClassification = CustomerContent;
        }
        field(70114; "COL Project Blocked"; Boolean)
        {
            Caption = 'Project Blocked';
            ToolTip = 'Specifies whether the item is blocked for project.';
            DataClassification = CustomerContent;
        }
        field(70115; "COL EU RoHS Status"; Text[20])
        {
            Caption = 'EU RoHS Status';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the value of the EU RoHS Status field.';
        }
        field(70116; "COL Standard Placing Code"; Code[10])
        {
            Caption = 'Standard Placing Code';
            DataClassification = CustomerContent;
            TableRelation = Location;
            ToolTip = 'Specifies the value of the Standard Placing Code field.';
        }
        field(70117; "COL Planning Blocked"; Boolean)
        {
            Caption = 'Planning Blocked';
            ToolTip = 'Specifies whether the item is blocked for planning.';
            DataClassification = CustomerContent;
        }
        field(70118; "COL MTBF No."; BigInteger)
        {
            MinValue = 0;
            BlankZero = true;
            Caption = 'MTBF 1', Locked = true;
            ToolTip = 'Specifies the value of the MTBF No. field.';
            DataClassification = CustomerContent;
        }
        field(70119; "COL MTBF Comment"; Text[150])
        {
            Caption = 'Comment';
            ToolTip = 'Specifies the value of the MTBF Comment field.';
            DataClassification = CustomerContent;
        }
        field(70120; "COL MTBF No. 2"; BigInteger)
        {
            MinValue = 0;
            BlankZero = true;
            Caption = 'MTBF 2', Locked = true;
            ToolTip = 'Specifies the value of the MTBF No. 2 field.';
            DataClassification = CustomerContent;
        }
        field(70121; "COL MTBF Comment 2"; Text[150])
        {
            Caption = 'Comment 2';
            ToolTip = 'Specifies the value of the MTBF Comment 2 field.';
            DataClassification = CustomerContent;
        }
        field(70122; "COL Proces.(Mont.For Routings)"; Text[100])
        {
            Caption = 'Processes (Montage for Routings)';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies the value of the Processes (Montage for Routings) field.';
        }
        field(70123; "COL Legacy Items Nos."; Integer)
        {
            Caption = 'Legacy Items Nos.';
            ToolTip = 'Specifies number of legacy items related to this item.';
            FieldClass = FlowField;
            Editable = false;
            BlankZero = true;
            CalcFormula = count("COL Legacy Item" where("Item No." = field("No.")));
        }
        field(70124; "COL Manufacturer"; Code[30])
        {
            Caption = 'Preferred Manufacturer';
            DataClassification = CustomerContent;
            TableRelation = "COL Manufacturer";
            ToolTip = 'Specifies the manufacturer of the item.';
        }
        field(70125; "COL Stockkeeping Units"; Integer)
        {
            CalcFormula = count("Stockkeeping Unit" where("Item No." = field("No.")));
            Caption = 'Stockkeeping Units';
            ToolTip = 'Specifies number of stockkeeping units related to this item.';
            Editable = false;
            FieldClass = FlowField;
        }
        // Technical field
        field(70500; "COL Availability Type Check"; Enum "Item Availability Type")
        {
            Caption = 'Availability Type Check';
            Editable = false;
            ToolTip = 'Specifies whether to exclude open orders from the Item Availability by Event.';
            InitValue = "COL Empty";
            AllowInCustomizations = Never;
            DataClassification = CustomerContent;
        }

        field(70501; "COL Filter Criteria ID"; Guid)
        {
            FieldClass = FlowFilter;
            Caption = 'Filter Criteria ID';
            ToolTip = 'Specifies the filter criteria identifier used for matching attribute filters.';
            AllowInCustomizations = Never;
        }

        field(70502; "COL Matches Criteria"; Boolean)
        {
            Caption = 'Matches Criteria';
            ToolTip = 'Indicates whether the item matches the selected filter criteria.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("COL Item Attr. Filter Criteria" where("Table ID" = const(Database::Item), "Filter ID" = field("COL Filter Criteria ID"), "Item No." = field("No.")));
            AllowInCustomizations = Never;
        }
    }

    keys
    {
        key(COL1; "COL Export Classification Code", "COL EU Classification No.", "COL US Classification No.") { }
        key(COL2; "COL NATO Stock No.", "COL EU RoHS Dir. Compliant", "COL EU REACH Reg. Compliant", "COL Moisture Sensitivity Level", "COL EU RoHS Status") { }
        key(COL3; "COL Item Configuration Type") { }
        key(COL4; "COL Manufacturer") { }
    }

    trigger OnAfterInsert()
    begin
        if "COL Created By User" = '' then begin
            "COL Created By User" := CopyStr(UserId, 1, MaxStrLen("COL Created By User"));
            "COL Creation Date" := Today;
        end;
    end;

    var
        LastLeadTimeCalculation: DateFormula;
        ClassificationFieldErr: Label 'cannot be specified if %1 has a value', Comment = '%1 = field caption';

    procedure COLGetQtyInPlanningWorksheet(): Decimal
    var
        ItemInPlanning: Query "COL Item In Planning";
        TotalQty: Decimal;
    begin
        ItemInPlanning.SetRange(ItemNo, Rec."No.");
        ItemInPlanning.Open();
        while ItemInPlanning.Read() do
            TotalQty += ItemInPlanning.Quantity;

        ItemInPlanning.Close();
        exit(TotalQty);
    end;

    procedure COLDrillDownQtyInPlanningWorksheet()
    var
        ItemVariant: Record "Item Variant";
        TempRequisitionLine: Record "Requisition Line" temporary;
        LineNo: Integer;
    begin

        COLCalcVariant(Rec."No.", '', TempRequisitionLine, LineNo);
        ItemVariant.SetRange("Item No.", Rec."No.");
        if ItemVariant.FindSet() then
            repeat
                COLCalcVariant(Rec."No.", ItemVariant."Code", TempRequisitionLine, LineNo);
            until ItemVariant.Next() = 0;

        Page.Run(Page::"Requisition Lines", TempRequisitionLine);
    end;

    local procedure COLCalcVariant(pItemNo: Code[20]; pVariantCode: Code[10]; var TempRequisitionLine: Record "Requisition Line"; var LineNo: Integer)
    var
        ItemInPlanning: Query "COL Item In Planning";
    begin
        ItemInPlanning.SetRange(ItemNo, pItemNo);
        if pVariantCode <> '' then
            ItemInPlanning.SetRange(Variant_Code, pVariantCode)
        else
            ItemInPlanning.SetFIlter(Variant_Code, '=%1', ''); // empty variant code

        ItemInPlanning.Open();
        while ItemInPlanning.Read() do begin
            LineNo += 10000;
            TempRequisitionLine.Init();
            TempRequisitionLine."Worksheet Template Name" := ItemInPlanning.Worksheet_Template_Name;
            TempRequisitionLine."Journal Batch Name" := ItemInPlanning.Journal_Batch_Name;
            TempRequisitionLine."Line No." := LineNo;
            TempRequisitionLine.Type := ItemInPlanning.Type;
            TempRequisitionLine."No." := ItemInPlanning.ItemNo;
            TempRequisitionLine.Description := ItemInPlanning.Description;
            TempRequisitionLine.Quantity := ItemInPlanning.Quantity;
            TempRequisitionLine."Location Code" := ItemInPlanning.Location_Code;
            TempRequisitionLine."Unit of Measure Code" := ItemInPlanning.Unit_of_Measure_Code;
            TempRequisitionLine."Variant Code" := ItemInPlanning.Variant_Code;
            TempRequisitionLine.Insert(false);
        end;
        ItemInPlanning.Close();
    end;
}