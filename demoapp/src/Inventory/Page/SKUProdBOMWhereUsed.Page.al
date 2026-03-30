namespace Weibel.Manufacturing.ProductionBOM;

using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Location;

page 70221 "COL SKU Prod. BOM Where-Used"
{
    Caption = 'SKU Prod. BOM Where-Used';
    DataCaptionExpression = SetCaption();
    PageType = Worksheet;
    SourceTable = "Where-Used Line";
    SourceTableTemporary = true;
    ApplicationArea = All;
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(Options)
            {
                Caption = 'Options';
                field(CalculateDate; CalculateDate)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Calculation Date';
                    ToolTip = 'Specifies the date for which you want to show the where-used lines.';

                    trigger OnValidate()
                    begin
                        CalculateDateOnAfterValidate();
                    end;
                }
                field(ShowLevel; ShowLevel)
                {
                    ApplicationArea = Manufacturing;
                    Caption = 'Levels';
                    OptionCaption = 'Single,Multi';
                    ToolTip = 'Specifies the level of detail for the where-used lines.';

                    trigger OnValidate()
                    begin
                        ShowLevelOnAfterValidate();
                    end;
                }
            }
            repeater(Control1)
            {
                Editable = false;
                IndentationColumn = DescriptionIndent;
                IndentationControls = Description;
                ShowCaption = false;
                field(Type; Rec."COL Type")
                {
                    ApplicationArea = Manufacturing;
                }
                field("No."; Rec."COL No.")
                {
                    ToolTip = 'Opens related SKU Card';
                    ApplicationArea = Manufacturing;
                    trigger OnDrillDown()
                    begin
                        this.DrillDownCardPage();
                    end;
                }
                field("Item No."; Rec."Item No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the item number of the item or production BOM component that is assigned to the item.';
                    ApplicationArea = Manufacturing;

                }
                field("Version Code"; Rec."Version Code")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the version code of the production BOM that the item or production BOM component is assigned to.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the description of the item to which the item or production BOM component is assigned.';
                }
                field("Quantity Needed"; Rec."Quantity Needed")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the quantity of the item or the production BOM component that is needed for the assigned item.';
                }
                field("COL Product Life Cycle"; Rec."COL Product Life Cycle")
                {
                    ApplicationArea = Manufacturing;
                    ToolTip = 'Specifies the product life cycle from the item variant.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        DescriptionIndent := 0;
        DescriptionOnFormat();
    end;

    trigger OnFindRecord(Which: Text): Boolean
    begin
        exit(WhereUsedMgt.FindRecord(Which, Rec));
    end;

    trigger OnNextRecord(Steps: Integer): Integer
    begin
        exit(WhereUsedMgt.NextRecord(Steps, Rec));
    end;

    trigger OnOpenPage()
    begin
        BuildForm();
    end;

    var
        ProdBOMHeader: Record "Production BOM Header";
        WhereUsedMgt: Codeunit "COL SKU Where-Used Management";
        CalculateDate: Date;
        DescriptionIndent: Integer;

    protected var
        Sku: Record "Stockkeeping Unit";
        ShowLevel: Option Single,Multi;


    procedure SetSKU(pSku: Record "Stockkeeping Unit"; NewCalcDate: Date)
    begin
        Sku := pSku;
        CalculateDate := NewCalcDate;
    end;

    procedure BuildForm()
    begin
        WhereUsedMgt.WhereUsedFromSku(Sku, CalculateDate, ShowLevel = ShowLevel::Multi);
    end;

    procedure SetCaption(): Text
    var
        IsHandled: Boolean;
        Result: Text;
    begin
        IsHandled := false;
        if IsHandled then
            exit(Result);

        if ProdBOMHeader."No." <> '' then
            exit(ProdBOMHeader."No." + ' ' + ProdBOMHeader.Description);

        exit(Sku."Item No." + ' ' + Sku."Variant Code");
    end;

    local procedure CalculateDateOnAfterValidate()
    begin
        BuildForm();
        CurrPage.Update(false);
    end;

    local procedure ShowLevelOnAfterValidate()
    begin
        BuildForm();
        CurrPage.Update(false);
    end;

    local procedure DescriptionOnFormat()
    begin
        DescriptionIndent := Rec."Level Code" - 1;
        if DescriptionIndent <= 0 then
            DescriptionIndent := 1;
    end;

    local procedure DrillDownCardPage()
    var
        ProductionBOMHeader: Record "Production BOM Header";
        StockKeepingUnit: Record "Stockkeeping Unit";
        SKUCard: Page "Stockkeeping Unit Card";
        ProductionBOM: Page "Production BOM";
    begin
        case Rec."COL Type" of
            Rec."COL Type"::Item:
                begin
                    StockKeepingUnit.Get(Rec."COL Related SKU Location Code", Rec."COL Related SKU Item No.", Rec."COL Related SKU Variant Code");
                    StockKeepingUnit.SetRecFilter();
                    SkuCard.SetTableView(StockKeepingUnit);
                    SKUCard.LookupMode(true);
                    SKUCard.RunModal();
                end;
            Rec."COL Type"::"Production BOM":
                begin
                    ProductionBOMHeader.Get(Rec."COL No.");
                    ProductionBOMHeader.SetRecFilter();
                    ProductionBOM.SetTableView(ProductionBOMHeader);
                    ProductionBOM.LookupMode(true);
                    ProductionBOM.RunModal();
                end;
        end;
    end;
}

