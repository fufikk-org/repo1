namespace Weibel.Integration.PLM;

using Microsoft.Inventory.Item;
using Microsoft.Foundation.UOM;
using Microsoft.Integration.Graph;
using System.Reflection;

page 70103 "COL PLM Items"
{
    APIGroup = 'plm';
    APIPublisher = 'weibel';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    DelayedInsert = true;
    EntityName = 'plmItem';
    EntitySetName = 'plmItems';
    PageType = API;
    SourceTable = Item;
    ODataKeyFields = SystemId;
    ChangeTrackingAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'id', Locked = true;
                    Editable = false;
                }
                field(number; Rec."No.")
                {
                    Caption = 'Number', Locked = true;
                }
                field(displayName; Rec.Description)
                {
                    Caption = 'Display Name', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo(Description));
                    end;
                }
                field(baseUnitOfMeasureCode; Rec."Base Unit of Measure")
                {
                    Caption = 'Base Unit Of Measure Code', Locked = true;

                    trigger OnValidate()
                    begin
                        if (Rec."Base Unit of Measure" <> '') and (ValidateUnitOfMeasure.Code <> '') then
                            if ValidateUnitOfMeasure.Code <> Rec."Base Unit of Measure" then
                                Error(UnitOfMeasureValuesDontMatchErr);

                        BaseUnitOfMeasureCodeValidated := true;

                        RegisterFieldSet(Rec.FieldNo("Unit of Measure Id"));
                        RegisterFieldSet(Rec.FieldNo("Base Unit of Measure"));
                    end;
                }
                field(salesUnitOfMeasureCode; Rec."Sales Unit of Measure")
                {
                    Caption = 'Sales Unit of Measure', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Sales Unit of Measure"));
                    end;
                }
                field(replenishmentSystem; Rec."Replenishment System")
                {
                    Caption = 'Replenishment System', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Replenishment System"));
                    end;
                }
                field(routingNo; Rec."Routing No.")
                {
                    Caption = 'Routing No.', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Routing No."));
                    end;
                }
                field(productionBOMNo; Rec."Production BOM No.")
                {
                    Caption = 'Production BOM No.', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("Production BOM No."));
                    end;
                }
                field(exportClassificationCode; Rec."COL Export Classification Code")
                {
                    Caption = 'Export Classification Code', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("COL Export Classification Code"));
                    end;
                }
                field(euClassificationNo; Rec."COL EU Classification No.")
                {
                    Caption = 'EU Classification No.', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("COL EU Classification No."));
                    end;
                }
                field(usClassificationNo; Rec."COL US Classification No.")
                {
                    Caption = 'US Classification No.', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("COL US Classification No."));
                    end;
                }
                field(manufacturerItemNo; Rec."COL Manufacturer Item No.")
                {
                    Caption = 'Manufacturer Item No.', Locked = true;

                    trigger OnValidate()
                    begin
                        RegisterFieldSet(Rec.FieldNo("COL Manufacturer Item No."));
                    end;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        exit(InsertItem());
    end;

    trigger OnModifyRecord(): Boolean
    var
        Item: Record Item;
    begin
        if IsInsert then
            exit(InsertItem());

        Item.GetBySystemId(Rec.SystemId);

        if Rec."No." = Item."No." then
            Rec.Modify(true)
        else begin
            Item.TransferFields(Rec, false);
            Item.Rename(Rec."No.");
            Rec.TransferFields(Item, true);
        end;

        exit(false);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IsInsert := true;
        ClearCalculatedFields();
    end;

    var
        TempFieldSet: Record Field temporary;
        ValidateUnitOfMeasure: Record "Unit of Measure";
        GraphCollectionMgtItem: Codeunit "Graph Collection Mgt - Item";
        InventoryValue: Decimal;
        BaseUnitOfMeasureIdValidated: Boolean;
        BaseUnitOfMeasureCodeValidated: Boolean;
        IsInsert: Boolean;
        UnitOfMeasureValuesDontMatchErr: Label 'The unit of measure values do not match to a specific Unit of Measure.';

    local procedure InsertItem(): Boolean
    var
        PLMIntegrationSetup: Record "COL PLM Integration Setup";
        ItemTempl: Record "Item Templ.";
        ItemTemplMgt: Codeunit "Item Templ. Mgt.";
        PLMItemTemplSubs: Codeunit "COL PLM Item Templ. Subs";
    begin
        if not BaseUnitOfMeasureCodeValidated then
            if BaseUnitOfMeasureIdValidated then begin
                Rec.Validate("Base Unit of Measure", Rec."Base Unit of Measure");
                GraphCollectionMgtItem.ModifyItem(Rec, TempFieldSet);
            end else
                GraphCollectionMgtItem.InsertItem(Rec, TempFieldSet)
        else
            GraphCollectionMgtItem.ModifyItem(Rec, TempFieldSet);

        if PLMIntegrationSetup.Get() then
            if PLMIntegrationSetup."PLM Item Template Code" <> '' then
                if ItemTempl.Get(PLMIntegrationSetup."PLM Item Template Code") then begin
                    BindSubscription(PLMItemTemplSubs);
                    ItemTemplMgt.ApplyItemTemplate(Rec, ItemTempl, false);
                    UnbindSubscription(PLMItemTemplSubs);
                end;
        Clear(IsInsert);
        exit(false);
    end;

    local procedure ClearCalculatedFields()
    begin
        Clear(Rec.SystemId);
        Clear(InventoryValue);
        Clear(BaseUnitOfMeasureCodeValidated);
        Clear(BaseUnitOfMeasureIdValidated);
        TempFieldSet.DeleteAll();
    end;

    local procedure RegisterFieldSet(FieldNo: Integer)
    begin
        if TempFieldSet.Get(Database::Item, FieldNo) then
            exit;

        TempFieldSet.Init();
        TempFieldSet.TableNo := Database::Item;
        TempFieldSet.Validate("No.", FieldNo);
        TempFieldSet.Insert(true);
    end;
}
