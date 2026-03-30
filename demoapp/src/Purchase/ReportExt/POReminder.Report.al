report 70113 "COL PO Reminder"
{
    UsageCategory = Documents;
    ApplicationArea = All;
    Caption = 'PO Reminder';
    DefaultRenderingLayout = COLReportLayout;
    EnableHyperlinks = true;
    PreviewMode = PrintLayout;
    WordMergeDataItem = "Purchase Header";

    dataset
    {
        dataitem("Purchase Header"; "Purchase Header")
        {
            RequestFilterFields = "No.", "Buy-from Vendor No.";
            RequestFilterHeading = 'PO Reminder';

            column(GreetingText; GreetingLbl)
            {
            }
            column(VendorName; VendorName)
            {
            }
            column(ClosingText; ClosingLbl)
            {
            }
            column(COLNewBodyTextLbl; NewBodyText)
            { }

            dataitem("Purchase Line"; "Purchase Line")
            {
                DataItemTableView = sorting("Document Type", "Buy-from Vendor No.", "Document No.", "Line No.") where("Document Type" = const(Order));

                column(LineNo_PurchLine; "Line No.")
                { }

                column(Type_PurchLine; Format(Type, 0, 2))
                { }
                column(No_PurchLine; ItemNo)
                { }
                column(ItemNo_PurchLine; "No.")
                { }
                column(VendorItemNo_PurchLine; "Vendor Item No.")
                { }
                column(ItemReferenceNo_PurchLine; "Item Reference No.")
                { }
                column(Desc_PurchLine; Description)
                { }
                column(Qty_PurchLine; FormattedQuantity)
                { }
                column(UOM_PurchLine; "Unit of Measure")
                { }
                column(No_PurchLine_Lbl; FieldCaption("No."))
                { }
                column(Desc_PurchLine_Lbl; FieldCaption(Description))
                { }
                column(Qty_PurchLine_Lbl; FieldCaption(Quantity))
                { }
                column(UOM_PurchLine_Lbl; ItemUnitOfMeasureCaptionLbl)
                { }
                column(VATIdentifier_PurchLine_Lbl; FieldCaption("VAT Identifier"))
                { }
                column(AmountIncludingVAT; "Amount Including VAT")
                { }
                column(PlannedReceiptDateLbl; PlannedReceiptDateLbl)
                { }
                column(PlannedReceiptDate; Format("Planned Receipt Date", 0, 4))
                { }
                column(ExpectedReceiptDateLbl; ExpectedReceiptDateLbl)
                { }
                column(ExpectedReceiptDate; Format("Expected Receipt Date", 0, 4))
                { }
                column(PromisedReceiptDateLbl; PromisedReceiptDateLbl)
                { }
                column(PromisedReceiptDate; Format("Promised Receipt Date", 0, 4))
                { }
                column(RequestedReceiptDateLbl; RequestedReceiptDateLbl)
                { }
                column(RequestedReceiptDate; "Requested Receipt Date")
                { }
                column(COLlineOrderLbl; OrderLbl)
                { }
                column(COLlineOrder; "Purchase Line"."Document No.")
                { }
                column(COLlineOutQtyLbl; "Purchase Line".FieldCaption("Outstanding Quantity"))
                { }
                column(COLlineOutQty; "Purchase Line"."Outstanding Quantity")
                { }
                column(COLlinePromRecDateLbl; ConfDateLbl)
                { }
                column(COLlinePromRecDate; "Purchase Line"."Promised Receipt Date")
                { }
                column(COLlineCommentLbl; CommentLbl)
                { }
                column(COLlineComment; StaggerLines.Contains("Purchase Line".SystemId) ? CommentTxt + format(CrLf1) + format(CrLf2) + format(CrLf1) + format(CrLf2) : CommentTxt)
                { }

                trigger OnPreDataItem()
                begin
                    SetPOLineFilters("Purchase Line", "Purchase Header");
                end;

                trigger OnAfterGetRecord()
                var
                    Vendor: Record Vendor;
                    ConnectorSetup: Record "FPL Connector Setup";
                    LanguageMgt: Codeunit Language;
                    LangCode: Code[10];
                begin
                    CommentTxt := "Purchase Line"."COL Reminder Comment";
                    ItemNo := "No.";

                    if "Vendor Item No." <> '' then
                        ItemNo := "Vendor Item No.";

                    if "Item Reference No." <> '' then
                        ItemNo := "Item Reference No.";

                    FormatDocument.SetPurchaseLine("Purchase Line", FormattedQuantity, FormattedDirectUnitCost, FormattedVATPct, FormattedLineAmount);
                    FormattedQuantity := Format("Purchase Line"."Outstanding Quantity");

                    Vendor.Get("Purchase Line"."Buy-from Vendor No.");
                    VendorName := Vendor.Name;
                    LangCode := Vendor."Language Code";

                    if LangCode = '' then begin
                        ConnectorSetup.Get();
                        LangCode := ConnectorSetup."Local Language for Documents";
                    end;

                    if CurrReport.Language <> LanguageMgt.GetLanguageIdOrDefault(LangCode) then
                        CurrReport.Language := LanguageMgt.GetLanguageIdOrDefault(LangCode);
                end;


            }

            trigger OnPreDataItem()
            var
                MissingDate, LateDelivery : Boolean;
            begin
                PrepData(MissingDate, LateDelivery);
            end;

        }

    }

    rendering
    {
        layout(COLReportLayout)
        {
            Caption = 'Order Reminder Email';
            Type = Word;
            LayoutFile = './src/Purchase/ReportLayout/PurchaseOrderReminderEmail2.docx';
        }
    }

    trigger OnPreReport()
    begin
        CrLf1 := 13;
        CrLf2 := 10;
    end;


    var
        FormatDocument: Codeunit "Format Document";
        StaggerLines: List of [Guid];
        CrLf1: Char;
        CrLf2: Char;
        ItemNo: Text;
        ItemUnitOfMeasureCaptionLbl: Label 'Unit';
        PromisedReceiptDateLbl: Label 'Promised Receipt Date';
        RequestedReceiptDateLbl: Label 'Requested Receipt Date';
        ExpectedReceiptDateLbl: Label 'Expected Receipt Date';
        PlannedReceiptDateLbl: Label 'Planned Receipt Date';
        LegalOfficeTxt, LegalOfficeLbl, CustomGiroTxt, CustomGiroLbl : Text;
        FormattedQuantity: Text;
        FormattedDirectUnitCost: Text;
        FormattedVATPct: Text;
        FormattedLineAmount: Text;
        CommentTxt: Text;
        OrderLbl: Label 'Order No.';
        ConfDateLbl: Label 'Confirmed Receipt Date';
        CommentLbl: Label 'Comment';
        NewBodyTextLbl: Label 'We have not registered receipt of Order Confirmation or deliveries are late, please send updated order confirmation.';
        NewBodyText2Lbl: Label 'We have not registered receipt of Order Confirmation, please send updated order confirmation.';
        NewBodyText3Lbl: Label 'Delivery of below goods are late, Please confirm new delivery.';
        NewBodyText: Text;
        GreetingLbl: Label 'Hello';
        ClosingLbl: Label 'Sincerely';
        VendorName: Text[100];

    protected procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview() or MailManagement.IsHandlingGetEmailBody());
    end;

    [InternalEvent(false, false)]
    local procedure OnSetPoFilter(var ToPoFilter: Text)
    begin
    end;

    internal procedure SetPOLineFilters(var PurchLine: Record "Purchase Line"; var PurchHeader: Record "Purchase Header")
    var
        POFilter: Text;
    begin
        PurchLine.SetRange("Document Type", "Purchase Line"."Document Type"::Order);
        PurchLine.SetRange("COL Reminder Problem Exist", true);
        if PurchHeader.GetFilter("No.") <> '' then
            PurchLine.SetFilter("Document No.", PurchHeader.GetFilter("No."));
        if PurchHeader.GetFilter("Location Filter") <> '' then
            PurchLine.SetFilter("Document No.", PurchHeader.GetFilter("Location Filter"));

        this.OnSetPoFilter(POFilter);
        if PoFilter <> '' then
            PurchLine.SetFilter("Document No.", PoFilter);

        if PurchHeader.GetFilter("Buy-from Vendor No.") <> '' then
            PurchLine.SetFilter("Buy-from Vendor No.", PurchHeader.GetFilter("Buy-from Vendor No."));
    end;

    procedure PrepData(var MissingDate: Boolean; var LateDelivery: Boolean)
    var
        PurchLine: Record "Purchase Line";
        LastPoNo: Code[20];
        LastSysId: Guid;
    begin
        SetPOLineFilters(PurchLine, "Purchase Header");
        Clear(LastPoNo);
        if PurchLine.FindSet() then
            repeat
                MissingDate := MissingDate or (PurchLine."Promised Receipt Date" = 0D);
                LateDelivery := LateDelivery or (PurchLine."COL Reminder Problem Exist" and (PurchLine."Promised Receipt Date" <> 0D));
                if (LastPoNo <> PurchLine."Document No.") and (LastPoNo <> '') then
                    StaggerLines.Add(LastSysId);

                LastPoNo := PurchLine."Document No.";
                LastSysId := PurchLine.SystemId;
            until PurchLine.Next() = 0;

        if MissingDate and LateDelivery then
            NewBodyText := NewBodyTextLbl
        else begin
            if MissingDate then
                NewBodyText := NewBodyText2Lbl;
            if LateDelivery then
                NewBodyText := NewBodyText3Lbl;
        end;
    end;

}