page 70260 "COL Cable Label Templates"
{
    ApplicationArea = All;
    Caption = 'Cable Label Templates';
    PageType = List;
    SourceTable = "COL Cable Label Template";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Cable Size"; Rec."Cable Size")
                {
                }
                field("Line No."; Rec."Line No.")
                {
                }
                field(Instruction; Rec.Instruction)
                {
                }
                field(Condition; Rec.Condition)
                {
                }
                field("Left Offset"; Rec.LeftOffset)
                {
                }
                field("Right Offset"; Rec.RightOffset)
                {
                }
                field("Space Size"; Rec."Space Size")
                {
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Create17mmTemplate)
            {
                ApplicationArea = All;
                Caption = 'Create 17mm Template';
                Image = CreateForm;
                ToolTip = 'Create default template for 17mm cable labels.';

                trigger OnAction()
                var
                    CableLabelTemplate: Record "COL Cable Label Template";
                    LineNo: Integer;
                begin
                    CableLabelTemplate.SetRange("Cable Size", CableLabelTemplate."Cable Size"::"17");
                    if not CableLabelTemplate.IsEmpty() then
                        if not Confirm(Overwrite17mmTemplateQst) then
                            exit;

                    CableLabelTemplate.DeleteAll();

                    LineNo := 10000;

                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"17", LineNo, 'mm', CableLabelTemplate.Condition::Always, 20, 10, 2.09);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"17", LineNo, 'zO', CableLabelTemplate.Condition::Always, 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"17", LineNo, 'J', CableLabelTemplate.Condition::Always, 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"17", LineNo, 'H50,10,T', CableLabelTemplate.Condition::Always, 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"17", LineNo, 'O P', CableLabelTemplate.Condition::Always, 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"17", LineNo, 'Se;0.00,0.00,{FULLLENGTH},{FULLLENGTH},17.00;WMS 19,1 (EX30)R', CableLabelTemplate.Condition::Always, 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"17", LineNo, 'Cs,0.00', CableLabelTemplate.Condition::Always, 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"17", LineNo, 'C1,0.00,0.00', CableLabelTemplate.Condition::Always, 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"17", LineNo, 'T 5,{TEXTLENGTH},90,3,pt12; P/N: {ITEMNO} / REV: {VARIANT}', CableLabelTemplate.Condition::"If Variant", 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"17", LineNo, 'T 5,{TEXTLENGTH},90,3,pt12; P/N: {ITEMNO}', CableLabelTemplate.Condition::"If Not Variant", 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"17", LineNo, 'T 10,{TEXTLENGTH},90,3,pt12; S/N: {SERIALNO} / ODA:', CableLabelTemplate.Condition::"If Serial No", 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"17", LineNo, 'A1', CableLabelTemplate.Condition::Always, 0, 0, 0);
                    Message(Template17mmCreatedMsg);
                    CurrPage.Update(false);
                end;
            }

            action(Create31mmTemplate)
            {
                ApplicationArea = All;
                Caption = 'Create 31mm Template';
                Image = CreateForm;
                ToolTip = 'Create default template for 31mm cable labels.';

                trigger OnAction()
                var
                    CableLabelTemplate: Record "COL Cable Label Template";
                    LineNo: Integer;
                begin
                    CableLabelTemplate.SetRange("Cable Size", CableLabelTemplate."Cable Size"::"31");
                    if not CableLabelTemplate.IsEmpty() then
                        if not Confirm(OverwriteTemplateQst) then
                            exit;

                    CableLabelTemplate.DeleteAll();

                    LineNo := 10000;

                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"31", LineNo, 'mm', CableLabelTemplate.Condition::Always, 20, 10, 4.77);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"31", LineNo, 'zO', CableLabelTemplate.Condition::Always, 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"31", LineNo, 'J', CableLabelTemplate.Condition::Always, 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"31", LineNo, 'H50,10,T', CableLabelTemplate.Condition::Always, 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"31", LineNo, 'O P', CableLabelTemplate.Condition::Always, 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"31", LineNo, 'Se;0.00,0.00,{FULLLENGTH},{FULLLENGTH},31.20;WMS 19,1 (EX30)R', CableLabelTemplate.Condition::Always, 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"31", LineNo, 'Cs,0.00', CableLabelTemplate.Condition::Always, 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"31", LineNo, 'C1,0.00,0.00', CableLabelTemplate.Condition::Always, 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"31", LineNo, 'T 10,{TEXTLENGTH},90,3,pt25; P/N: {ITEMNO} / REV: {VARIANT}', CableLabelTemplate.Condition::"If Variant", 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"31", LineNo, 'T 10,{TEXTLENGTH},90,3,pt25; P/N: {ITEMNO}', CableLabelTemplate.Condition::"If Not Variant", 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"31", LineNo, 'T 20,{TEXTLENGTH},90,3,pt25; S/N: {SERIALNO} / ODA:', CableLabelTemplate.Condition::"If Serial No", 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"31", LineNo, 'A1', CableLabelTemplate.Condition::Always, 0, 0, 0);
                    Message(TemplateCreatedMsg);
                    CurrPage.Update(false);
                end;
            }

            action(Create81mmTemplate)
            {
                ApplicationArea = All;
                Caption = 'Create 81mm Template';
                Image = CreateForm;
                ToolTip = 'Create default template for 81mm cable labels.';

                trigger OnAction()
                var
                    CableLabelTemplate: Record "COL Cable Label Template";
                    LineNo: Integer;
                begin
                    CableLabelTemplate.SetRange("Cable Size", CableLabelTemplate."Cable Size"::"81");
                    if not CableLabelTemplate.IsEmpty() then
                        if not Confirm(Overwrite81mmTemplateQst) then
                            exit;

                    CableLabelTemplate.DeleteAll();

                    LineNo := 10000;

                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"81", LineNo, 'mm', CableLabelTemplate.Condition::Always, 20, 10, 6);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"81", LineNo, 'zO', CableLabelTemplate.Condition::Always, 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"81", LineNo, 'J', CableLabelTemplate.Condition::Always, 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"81", LineNo, 'H50,10,T', CableLabelTemplate.Condition::Always, 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"81", LineNo, 'O P', CableLabelTemplate.Condition::Always, 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"81", LineNo, 'Se;0.00,0.00,480.00,480.00,81.00;WMS 19,1 (EX30)R', CableLabelTemplate.Condition::Always, 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"81", LineNo, 'Cs,0.00', CableLabelTemplate.Condition::Always, 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"81", LineNo, 'C1,0.00,0.00', CableLabelTemplate.Condition::Always, 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"81", LineNo, 'T 20,460,90,3,pt62; P/N: {ITEMNO} / REV: {VARIANT}', CableLabelTemplate.Condition::"If Variant", 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"81", LineNo, 'T 20,460,90,3,pt62; P/N: {ITEMNO}', CableLabelTemplate.Condition::"If Not Variant", 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"81", LineNo, 'T 50,460,90,3,pt62; S/N: {SERIALNO} / ODA:', CableLabelTemplate.Condition::"If Serial No", 0, 0, 0);
                    LineNo += 10000;
                    InsertTemplateLine(CableLabelTemplate."Cable Size"::"81", LineNo, 'A1', CableLabelTemplate.Condition::Always, 0, 0, 0);
                    Message(Template81mmCreatedMsg);
                    CurrPage.Update(false);
                end;
            }
        }
    }

    local procedure InsertTemplateLine(CableSize: Enum "COL Cable Size"; LineNo: Integer; InstructionText: Text[100]; ConditionValue: Enum "COL Cable Label Condition"; LeftOffsetValue: Integer; RightOffsetValue: Integer; SpaceSizeValue: Decimal)
    var
        CableLabelTemplate: Record "COL Cable Label Template";
    begin
        CableLabelTemplate.Init();
        CableLabelTemplate."Cable Size" := CableSize;
        CableLabelTemplate."Line No." := LineNo;
        CableLabelTemplate.Instruction := InstructionText;
        CableLabelTemplate.Condition := ConditionValue;
        CableLabelTemplate.LeftOffset := LeftOffsetValue;
        CableLabelTemplate.RightOffset := RightOffsetValue;
        CableLabelTemplate."Space Size" := SpaceSizeValue;
        CableLabelTemplate.Insert();
    end;

    var
        OverwriteTemplateQst: Label 'Template for 31mm cable size already exists. Do you want to overwrite it?';
        TemplateCreatedMsg: Label '31mm template created successfully.';
        Overwrite17mmTemplateQst: Label 'Template for 17mm cable size already exists. Do you want to overwrite it?';
        Template17mmCreatedMsg: Label '17mm template created successfully.';
        Overwrite81mmTemplateQst: Label 'Template for 81mm cable size already exists. Do you want to overwrite it?';
        Template81mmCreatedMsg: Label '81mm template created successfully.';
}
