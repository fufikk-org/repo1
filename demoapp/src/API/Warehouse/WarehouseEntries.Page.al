namespace Weibel.API;

using Microsoft.Warehouse.Ledger;

page 70181 "COL Warehouse Entries"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'warehouseEntry';
    EntitySetName = 'warehouseEntries';
    PageType = API;
    SourceTable = "Warehouse Entry";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(entryNo; Rec."Entry No.")
                {
                }
                field(journalBatchName; Rec."Journal Batch Name")
                {
                }
                field(lineNo; Rec."Line No.")
                {
                }
                field(registeringDate; Rec."Registering Date")
                {
                }
                field(locationCode; Rec."Location Code")
                {
                }
                field(zoneCode; Rec."Zone Code")
                {
                }
                field(binCode; Rec."Bin Code")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(itemNo; Rec."Item No.")
                {
                }
                field(quantity; Rec.Quantity)
                {
                }
                field(qtyBase; Rec."Qty. (Base)")
                {
                }
                field(warehouseRegisterNo; Rec."Warehouse Register No.")
                {
                }
                field(siftBucketNo; Rec."SIFT Bucket No.")
                {
                }
                field(sourceType; Rec."Source Type")
                {
                }
                field(sourceSubtype; Rec."Source Subtype")
                {
                }
                field(sourceNo; Rec."Source No.")
                {
                }
                field(sourceLineNo; Rec."Source Line No.")
                {
                }
                field(sourceSublineNo; Rec."Source Subline No.")
                {
                }
                field(sourceDocument; Rec."Source Document")
                {
                }
                field(sourceCode; Rec."Source Code")
                {
                }
                field(reasonCode; Rec."Reason Code")
                {
                }
                field(noSeries; Rec."No. Series")
                {
                }
                field(binTypeCode; Rec."Bin Type Code")
                {
                }
                field(cubage; Rec.Cubage)
                {
                }
                field(weight; Rec.Weight)
                {
                }
                field(journalTemplateName; Rec."Journal Template Name")
                {
                }
                field(whseDocumentNo; Rec."Whse. Document No.")
                {
                }
                field(whseDocumentType; Rec."Whse. Document Type")
                {
                }
                field(whseDocumentLineNo; Rec."Whse. Document Line No.")
                {
                }
                field(entryType; Rec."Entry Type")
                {
                }
                field(referenceDocument; Rec."Reference Document")
                {
                }
                field(referenceNo; Rec."Reference No.")
                {
                }
                field("userID"; Rec."User ID")
                {
                }
                field(variantCode; Rec."Variant Code")
                {
                }
                field(qtyPerUnitOfMeasure; Rec."Qty. per Unit of Measure")
                {
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                }
                field(serialNo; Rec."Serial No.")
                {
                }
                field(lotNo; Rec."Lot No.")
                {
                }
                field(warrantyDate; Rec."Warranty Date")
                {
                }
                field(expirationDate; Rec."Expiration Date")
                {
                }
                field(packageNo; Rec."Package No.")
                {
                }
                field(physInvtCountingPeriodCode; Rec."Phys Invt Counting Period Code")
                {
                }
                field(physInvtCountingPeriodType; Rec."Phys Invt Counting Period Type")
                {
                }
                field(dedicated; Rec.Dedicated)
                {
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                }
                field(systemId; Rec.SystemId)
                {
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                }
            }
        }
    }
}
