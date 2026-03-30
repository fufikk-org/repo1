namespace Weibel.API;

using Microsoft.Inventory.Item.Catalog;

page 70212 "COL Item References API"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'itemReference';
    EntitySetName = 'itemReferences';
    PageType = API;
    SourceTable = "Item Reference";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(itemNo; Rec."Item No.")
                {
                }
                field(variantCode; Rec."Variant Code")
                {
                }
                field(unitOfMeasure; Rec."Unit of Measure")
                {
                }
                field(referenceType; Rec."Reference Type")
                {
                }
                field(referenceTypeNo; Rec."Reference Type No.")
                {
                }
                field(referenceNo; Rec."Reference No.")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(description2; Rec."Description 2")
                {
                }
                field(startingDate; Rec."Starting Date")
                {
                }
                field(endingDate; Rec."Ending Date")
                {
                }
                field(colPrimaryItemReference; Rec."COL Primary Item Reference")
                {
                }
                field(colMSLMoistureSensLevel; Rec."COL MSL Moisture Sens. Level")
                {
                }
                field(colECCN; Rec."COL ECCN")
                {
                }
                field(colItemCategoryCode; Rec."COL Item Category Code")
                {
                }
                field(colManufacturer; Rec."COL Manufacturer")
                {
                }
                field(colMPNNo; Rec."COL MPN No.")
                {
                }
                field(colReachCashedSource; Rec."COL Reach Cashed Source")
                {
                }
                field(colContainsSVHC; Rec."COL Contains SVHC")
                {
                }
                field(colSVHCExceedThrLimit; Rec."COL SVHC Exceed Thr. Limit")
                {
                }
                field(colSubstanceIdentification; Rec."COL Substance Identification")
                {
                }
                field(colSubstanceLocation; Rec."COL Substance Location")
                {
                }
                field(colSubstanceConcentration; Rec."COL Substance Concentration")
                {
                }
                field(colCountriesOfOrigin; Rec."COL Countries Of Origin")
                {
                }
                field(colPartStatus; Rec."COL Part Status")
                {
                }
                field(colLTBDate; Rec."COL LTB Date")
                {
                }
                field(colRoHSStatus; Rec."COL RoHS Status")
                {
                }
                field(colRoHSVersion; Rec."COL RoHS Version")
                {
                }
                field(colExemption; Rec."COL Exemption")
                {
                }
                field(colExemptionType; Rec."COL Exemption Type")
                {
                }
                field(colEstimatedEOLDate; Rec."COL Estimated EOL Date")
                {
                }
                field(colPeakPackBodyTemp; Rec."COL Peak Pack. Body Temp.")
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
