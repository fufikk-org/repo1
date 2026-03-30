namespace Weibel.API;

using Microsoft.Manufacturing.ProductionBOM;

page 70141 "COL Production BOM Lines"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    ApplicationArea = All;
    EntityName = 'productionBomLine';
    EntitySetName = 'productionBomLines';
    PageType = API;
    SourceTable = "Production BOM Line";
    DataAccessIntent = ReadOnly;
    Editable = false;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(productionBOMNo; Rec."Production BOM No.")
                {
                }
                field(lineNo; Rec."Line No.")
                {
                }
                field(versionCode; Rec."Version Code")
                {
                }
                field(type; Rec."Type")
                {
                }
                field(no; Rec."No.")
                {
                }
                field(description; Rec.Description)
                {
                }
                field(unitOfMeasureCode; Rec."Unit of Measure Code")
                {
                }
                field(quantity; Rec.Quantity)
                {
                }
                field(position; Rec.Position)
                {
                }
                field(position2; Rec."Position 2")
                {
                }
                field(position3; Rec."Position 3")
                {
                }
                field(leadTimeOffset; Rec."Lead-Time Offset")
                {
                }
                field(routingLinkCode; Rec."Routing Link Code")
                {
                }
                field(scrap; Rec."Scrap %")
                {
                }
                field(variantCode; Rec."Variant Code")
                {
                }
                field(comment; Rec.Comment)
                {
                }
                field(startingDate; Rec."Starting Date")
                {
                }
                field(endingDate; Rec."Ending Date")
                {
                }
                field(length; Rec.Length)
                {
                }
                field(width; Rec.Width)
                {
                }
                field(weight; Rec.Weight)
                {
                }
                field(depth; Rec.Depth)
                {
                }
                field(calculationFormula; Rec."Calculation Formula")
                {
                }
                field(quantityPer; Rec."Quantity per")
                {
                }
                field(colProductLifeCycle; Rec."COL Product Life Cycle")
                {
                }
                field(colEURoHSDirCompliant; (Rec."Variant Code" = '') ? Rec."COL EU RoHS Dir. Compliant" : Rec."COL V.EU RoHS Dir. Compliant")
                {
                }
                field(colEURoHSStatus; (Rec."Variant Code" = '') ? Rec."COL EU RoHS Status" : Rec."COL V.EU RoHS Status")
                {
                }
                field(colPosition; Rec."COL Position")
                {
                }
                field(colPosition3; Rec."COL Position 3")
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

    trigger OnOpenPage()
    begin
        Rec.SetAutoCalcFields("COL EU RoHS Status", "COL V.EU RoHS Status", "COL EU RoHS Dir. Compliant", "COL V.EU RoHS Dir. Compliant");
    end;
}
