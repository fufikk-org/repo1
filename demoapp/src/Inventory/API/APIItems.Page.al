namespace Weibel.Integration.BI.Item;

using Microsoft.Foundation.UOM;
using System.Reflection;
using Microsoft.Inventory.Item;
using Microsoft.Integration.Graph;
using Microsoft.Inventory.Journal;
using Microsoft.Inventory.Posting;
using Microsoft.API.V2;
using System.Environment.Configuration;
using Microsoft.Utilities;
using System.Utilities;

page 70100 "COL API - Items"
{
    APIVersion = 'v2.0';
    APIGroup = 'inventory';
    APIPublisher = 'weibel';
    EntityCaption = 'Item';
    EntitySetCaption = 'Items';
    ChangeTrackingAllowed = true;
    DelayedInsert = true;
    EntityName = 'item';
    EntitySetName = 'items';
    ODataKeyFields = SystemId;
    PageType = API;
    SourceTable = Item;
    Extensible = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(id; Rec.SystemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                field(number; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(displayName; Rec.Description)
                {
                    Caption = 'Display Name';

                    trigger OnValidate()
                    begin
                        this.RegisterFieldSet(Rec.FieldNo(Description));
                    end;
                }
                field(displayName2; Rec."Description 2")
                {
                    Caption = 'Display Name 2';

                    trigger OnValidate()
                    begin
                        this.RegisterFieldSet(Rec.FieldNo("Description 2"));
                    end;
                }
                field(type; Rec.Type)
                {
                    Caption = 'Type';

                    trigger OnValidate()
                    begin
                        this.RegisterFieldSet(Rec.FieldNo(Type));
                    end;
                }
                field(itemCategoryCode; Rec."Item Category Code")
                {
                    Caption = 'Item Category Code';

                    trigger OnValidate()
                    begin
                        if this.ItemCategory.Code <> '' then begin
                            if this.ItemCategory.Code <> Rec."Item Category Code" then
                                Error(this.ItemCategoriesValuesDontMatchErr);
                            exit;
                        end;

                        if Rec."Item Category Code" = '' then
                            Rec."Item Category Id" := this.BlankGUID
                        else begin
                            if not this.ItemCategory.Get(Rec."Item Category Code") then
                                Error(this.ItemCategoryCodeDoesNotMatchATaxGroupErr);

                            Rec."Item Category Id" := this.ItemCategory.SystemId;
                        end;
                    end;
                }
                field(manufacturerItemNo; Rec."COL Manufacturer Item No.")
                {
                    Caption = 'Manufacturer Item No.';
                    trigger OnValidate()
                    begin
                        this.RegisterFieldSet(Rec.FieldNo("COL Manufacturer Item No."));
                    end;
                }
                field(blocked; Rec.Blocked)
                {
                    Caption = 'Blocked';

                    trigger OnValidate()
                    begin
                        this.RegisterFieldSet(Rec.FieldNo(Blocked));
                    end;
                }
                field(gtin; Rec.GTIN)
                {
                    Caption = 'GTIN';

                    trigger OnValidate()
                    begin
                        this.RegisterFieldSet(Rec.FieldNo(GTIN));
                    end;
                }
                field(inventory; this.InventoryValue)
                {
                    Caption = 'Inventory';

                    trigger OnValidate()
                    begin
                        this.RegisterFieldSet(Rec.FieldNo(Inventory));
                    end;
                }
                field(unitPrice; Rec."Unit Price")
                {
                    Caption = 'Unit Price';

                    trigger OnValidate()
                    begin
                        this.RegisterFieldSet(Rec.FieldNo("Unit Price"));
                    end;
                }
                field(priceIncludesTax; Rec."Price Includes VAT")
                {
                    Caption = 'Price Includes Tax';

                    trigger OnValidate()
                    begin
                        this.RegisterFieldSet(Rec.FieldNo("Price Includes VAT"));
                    end;
                }
                field(unitCost; Rec."Unit Cost")
                {
                    Caption = 'Unit Cost';

                    trigger OnValidate()
                    begin
                        this.RegisterFieldSet(Rec.FieldNo("Unit Cost"));
                    end;
                }
                field(baseUnitOfMeasureCode; Rec."Base Unit of Measure")
                {
                    Caption = 'Base Unit Of Measure Code';

                    trigger OnValidate()
                    begin
                        if (Rec."Base Unit of Measure" <> '') and (this.ValidateUnitOfMeasure.Code <> '') then
                            if this.ValidateUnitOfMeasure.Code <> Rec."Base Unit of Measure" then
                                Error(this.UnitOfMeasureValuesDontMatchErr);

                        this.BaseUnitOfMeasureCodeValidated := true;

                        this.RegisterFieldSet(Rec.FieldNo("Unit of Measure Id"));
                        this.RegisterFieldSet(Rec.FieldNo("Base Unit of Measure"));
                    end;
                }
                field(generalProductPostingGroupCode; Rec."Gen. Prod. Posting Group")
                {
                    Caption = 'General Product Posting Group Code';

                    trigger OnValidate()
                    begin
                        this.RegisterFieldSet(Rec.FieldNo("Gen. Prod. Posting Group"));
                    end;
                }
                field(inventoryPostingGroupCode; Rec."Inventory Posting Group")
                {
                    Caption = 'Inventory Posting Group Code';

                    trigger OnValidate()
                    begin
                        this.RegisterFieldSet(Rec.FieldNo("Inventory Posting Group"));
                    end;
                }
                field(manufacturer; Rec."Manufacturer Code")
                {
                    Caption = 'Manufacturer Code';

                    trigger OnValidate()
                    begin
                        this.RegisterFieldSet(Rec.FieldNo("Manufacturer Code"));
                    end;
                }
                field(usClassificationNo; Rec."COL US Classification No.")
                {
                    Caption = 'US Classification No.';

                    trigger OnValidate()
                    begin
                        this.RegisterFieldSet(Rec.FieldNo("COL US Classification No."));
                    end;
                }
                field(moistureSensitivityLevel; Rec."COL Moisture Sensitivity Level")
                {
                    Caption = 'MSL Moisture Sensitivity Level';
                    trigger OnValidate()
                    begin
                        this.RegisterFieldSet(Rec.FieldNo("COL Moisture Sensitivity Level"));
                    end;
                }
                field(euRoHSStatus; Rec."COL EU RoHS Status")
                {
                    Caption = 'EU RoHS Status';
                    trigger OnValidate()
                    begin
                        this.RegisterFieldSet(Rec.FieldNo("COL EU RoHS Status"));
                    end;
                }
                field(processesMontageForRoutings; Rec."COL Proces.(Mont.For Routings)")
                {
                    Caption = 'Processes Montage For Routings';
                    trigger OnValidate()
                    begin
                        this.RegisterFieldSet(Rec.FieldNo("COL Proces.(Mont.For Routings)"));
                    end;
                }
                field(notes; this.Notes)
                {
                    Caption = 'Notes';
                }
                field(lastModifiedDateTime; Rec.SystemModifiedAt)
                {
                    Caption = 'Last Modified Date';
                    Editable = false;
                }
                field(bcUrl; GetUrl(ClientType::Web, CompanyName(), ObjectType::Page, Page::"Item Card", Rec, false))
                {
                    Editable = false;
                }

                part(inventoryPostingGroup; "APIV2 - Inventory Post. Group")
                {
                    Caption = 'Inventory Posting Group';
                    Multiplicity = ZeroOrOne;
                    EntityName = 'inventoryPostingGroup';
                    EntitySetName = 'inventoryPostingGroups';
                    SubPageLink = SystemId = field("Inventory Posting Group Id");
                }
                part(generalProductPostingGroup; "APIV2 - Gen. Prod. Post. Group")
                {
                    Caption = 'General Product Posting Group';
                    Multiplicity = ZeroOrOne;
                    EntityName = 'generalProductPostingGroup';
                    EntitySetName = 'generalProductPostingGroups';
                    SubPageLink = SystemId = field("Gen. Prod. Posting Group Id");
                }
                part(baseUnitOfMeasure; "APIV2 - Units of Measure")
                {
                    Caption = 'Unit Of Measure';
                    Multiplicity = ZeroOrOne;
                    EntityName = 'unitOfMeasure';
                    EntitySetName = 'unitsOfMeasure';
                    SubPageLink = SystemId = field("Unit of Measure Id");
                }
                part(picture; "APIV2 - Pictures")
                {
                    Caption = 'Picture';
                    Multiplicity = ZeroOrOne;
                    EntityName = 'picture';
                    EntitySetName = 'pictures';
                    SubPageLink = Id = field(SystemId), "Parent Type" = const(Item);
                }
                part(defaultDimensions; "APIV2 - Default Dimensions")
                {
                    Caption = 'Default Dimensions';
                    EntityName = 'defaultDimension';
                    EntitySetName = 'defaultDimensions';
                    SubPageLink = ParentId = field(SystemId), "Parent Type" = const(Item);
                }
                part(itemVariants; "APIV2 - Item Variants")
                {
                    Caption = 'Variants';
                    EntityName = 'itemVariant';
                    EntitySetName = 'itemVariants';
                    SubPageLink = "Item Id" = field(SystemId);
                }
                part(documentAttachments; "APIV2 - Document Attachments")
                {
                    Caption = 'Document Attachments';
                    EntityName = 'documentAttachment';
                    EntitySetName = 'documentAttachments';
                    SubPageLink = "Document Id" = field(SystemId), "Document Type" = const(Item);
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        this.SetCalculatedFields();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        exit(this.InsertItem());
    end;

    trigger OnModifyRecord(): Boolean
    var
        Item: Record Item;
    begin
        if this.IsInsert then
            exit(this.InsertItem());

        if this.TempFieldSet.Get(Database::Item, Rec.FieldNo(Inventory)) then
            this.UpdateInventory();

        Item.GetBySystemId(Rec.SystemId);

        if Rec."No." = Item."No." then
            Rec.Modify(true)
        else begin
            Item.TransferFields(Rec, false);
            Item.Rename(Rec."No.");
            Rec.TransferFields(Item, true);
        end;

        if this.Notes <> '' then
            this.ModifyNote(Rec.RecordId, this.Notes);

        this.SetCalculatedFields();

        exit(false);
    end;

    trigger OnOpenPage()
    begin
        Rec.SetAutoCalcFields(Inventory);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        this.IsInsert := true;
        this.ClearCalculatedFields();
    end;

    var
        TempFieldSet: Record Field temporary;
        ItemCategory: Record "Item Category";
        ValidateUnitOfMeasure: Record "Unit of Measure";
        GraphCollectionMgtItem: Codeunit "Graph Collection Mgt - Item";
        InventoryValue: Decimal;
        BlankGUID: Guid;
        BaseUnitOfMeasureIdValidated: Boolean;
        BaseUnitOfMeasureCodeValidated: Boolean;
        IsInsert: Boolean;
        Notes: Text;
        ItemCategoriesValuesDontMatchErr: Label 'The item categories values do not match to a specific item category.';
        ItemCategoryCodeDoesNotMatchATaxGroupErr: Label 'The "itemCategoryCode" does not match to a Item Category.', Comment = 'itemCategoryCode is a field name and should not be translated.';
        InventoryCannotBeChangedInAPostRequestErr: Label 'Inventory cannot be changed during on insert.';
        UnitOfMeasureValuesDontMatchErr: Label 'The unit of measure values do not match to a specific Unit of Measure.';

    local procedure InsertItem(): Boolean
    begin
        if this.TempFieldSet.Get(Database::Item, Rec.FieldNo(Inventory)) then
            Error(this.InventoryCannotBeChangedInAPostRequestErr);

        if not this.BaseUnitOfMeasureCodeValidated then
            if this.BaseUnitOfMeasureIdValidated then begin
                Rec.Validate("Base Unit of Measure", Rec."Base Unit of Measure");
                this.GraphCollectionMgtItem.ModifyItem(Rec, this.TempFieldSet);
            end else
                this.GraphCollectionMgtItem.InsertItem(Rec, this.TempFieldSet)
        else
            this.GraphCollectionMgtItem.ModifyItem(Rec, this.TempFieldSet);

        if this.Notes <> '' then
            this.WriteNote(Rec.RecordId, this.Notes);

        this.SetCalculatedFields();
        Clear(this.IsInsert);
        exit(false);
    end;

    local procedure SetCalculatedFields()
    begin
        // Inventory
        this.InventoryValue := Rec.Inventory;
        this.Notes := this.GetRelatedNotes();
    end;


    local procedure ClearCalculatedFields()
    begin
        Clear(Rec.SystemId);
        Clear(this.InventoryValue);
        Clear(this.BaseUnitOfMeasureCodeValidated);
        Clear(this.BaseUnitOfMeasureIdValidated);
        this.TempFieldSet.DeleteAll();
    end;

    local procedure UpdateInventory()
    var
        ItemJournalLine: Record "Item Journal Line";
        ItemJnlPostLine: Codeunit "Item Jnl.-Post Line";
    begin
        Rec.CalcFields(Inventory);
        if Rec.Inventory = this.InventoryValue then
            exit;
        ItemJournalLine.Init();
        ItemJournalLine.Validate("Posting Date", Today());
        ItemJournalLine."Document No." := Rec."No.";

        if Rec.Inventory < this.InventoryValue then
            ItemJournalLine.Validate("Entry Type", ItemJournalLine."Entry Type"::"Positive Adjmt.")
        else
            ItemJournalLine.Validate("Entry Type", ItemJournalLine."Entry Type"::"Negative Adjmt.");

        ItemJournalLine.Validate("Item No.", Rec."No.");
        ItemJournalLine.Validate(Description, Rec.Description);
        ItemJournalLine.Validate(Quantity, Abs(this.InventoryValue - Rec.Inventory));

        ItemJnlPostLine.RunWithCheck(ItemJournalLine);
        Rec.Get(Rec."No.");
    end;

    local procedure RegisterFieldSet(FieldNo: Integer)
    begin
        if this.TempFieldSet.Get(Database::Item, FieldNo) then
            exit;

        this.TempFieldSet.Init();
        this.TempFieldSet.TableNo := Database::Item;
        this.TempFieldSet.Validate("No.", FieldNo);
        this.TempFieldSet.Insert(true);
    end;

    local procedure GetRelatedNotes(): Text
    var
        RecordLink: Record "Record Link";
        RecordLinkManagement: Codeunit "Record Link Management";
        NoteWriter: TextBuilder;
    begin
        RecordLink.SetAutoCalcFields(Note);
        RecordLink.SetRange("Record ID", Rec.RecordId);
        RecordLink.SetRange(Type, RecordLink.Type::Note);
        if RecordLink.FindSet() then begin
            repeat
                NoteWriter.AppendLine(RecordLinkManagement.ReadNote(RecordLink));
            until RecordLink.Next() = 0;
            exit(NoteWriter.ToText());
        end;

        exit('');
    end;

    local procedure WriteNote(RecId: RecordId; NoteText: Text)
    var
        RecordLink: Record "Record Link";
        RecordLinkManagement: Codeunit "Record Link Management";
        RecRef: RecordRef;
    begin
        RecRef := RecId.GetRecord();

        // Initialize the Record Link
        RecordLink.Init();
        RecordLink."Record ID" := RecId;
        RecordLink.Type := RecordLink.Type::Note;
        RecordLink.Description := CopyStr(RecRef.Caption, 1, MaxStrLen(RecordLink.Description));
        RecordLink.Created := CurrentDateTime;
        RecordLink."User ID" := CopyStr(UserId(), 1, MaxStrLen(RecordLink."User ID"));
        RecordLink.Company := CopyStr(CompanyName, 1, MaxStrLen(RecordLink.Company));

        // Write the note using Record Link Management
        RecordLinkManagement.WriteNote(RecordLink, NoteText);

        // Insert the Record Link
        RecordLink.Insert();
    end;

    local procedure ModifyNote(RecordId: RecordId; NewNotes: Text)
    var
        RecordLink: Record "Record Link";
    begin
        RecordLink.ReadIsolation := IsolationLevel::ReadUncommitted;
        RecordLink.SetRange("Record ID", RecordId);
        RecordLink.SetRange(Type, RecordLink.Type::Note);
        if RecordLink.IsEmpty() then
            exit;

        RecordLink.DeleteAll();

        WriteNote(RecordId, NewNotes);
    end;
}