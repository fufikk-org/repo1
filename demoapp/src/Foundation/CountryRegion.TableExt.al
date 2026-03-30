namespace Weibel.Foundation.Address;

using Microsoft.Foundation.Address;

tableextension 70152 "COL Country/Region" extends "Country/Region"
{

    fields
    {
        field(70100; "COL EU Country"; Boolean)
        {
            Caption = 'EU Country';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies if this is a EU country.';
            Description = 'This field is part of Group 1.';

            trigger OnValidate()
            begin
                SetGroup1Fields(Rec."COL EU Country", false, false);
            end;
        }
        field(70101; "COL Safa Country"; Boolean)
        {
            Caption = 'Safa Country';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies if this is a Safa country.';
            Description = 'This field is part of Group 1.';

            trigger OnValidate()
            begin
                SetGroup1Fields(false, Rec."COL Safa Country", false);
            end;
        }
        field(70102; "COL Other Country"; Boolean)
        {
            Caption = 'Other Country';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies if this is an other country.';
            Description = 'This field is part of Group 1.';

            trigger OnValidate()
            begin
                SetGroup1Fields(false, false, Rec."COL Other Country");
            end;
        }
        field(70110; "COL Special Text 1"; Boolean)
        {
            Caption = 'Special Text 1';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies if for this country, Special Text 1 should be printed.';
            Description = 'This field is part of Group 2.';

            trigger OnValidate()
            begin
                SetGroup2Fields(Rec."COL Special Text 1", false, false, false);
            end;
        }
        field(70111; "COL Special Text 2"; Boolean)
        {
            Caption = 'Special Text 2';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies if for this country, Special Text 2 should be printed.';
            Description = 'This field is part of Group 2.';

            trigger OnValidate()
            begin
                SetGroup2Fields(false, Rec."COL Special Text 2", false, false);
            end;
        }
        field(70112; "COL Special Text 3"; Boolean)
        {
            Caption = 'Special Text 3';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies if for this country, Special Text 3 should be printed.';
            Description = 'This field is part of Group 2.';

            trigger OnValidate()
            begin
                SetGroup2Fields(false, false, Rec."COL Special Text 3", false);
            end;
        }
        field(70113; "COL No Special Text"; Boolean)
        {
            Caption = 'No Special Text';
            DataClassification = CustomerContent;
            ToolTip = 'Specifies if for this country, no special text should be printed.';
            Description = 'This field is part of Group 2.';

            trigger OnValidate()
            begin
                SetGroup2Fields(false, false, false, Rec."COL No Special Text");
            end;
        }
    }

    local procedure SetGroup1Fields(EUCountry: Boolean; SafaCountry: Boolean; OtherCountry: Boolean)
    begin
        RecallFieldGroupNotification(GetFieldGroup1NotificationId());
        Rec."COL EU Country" := EUCountry;
        Rec."COL Safa Country" := SafaCountry;
        Rec."COL Other Country" := OtherCountry;
    end;

    local procedure SetGroup2Fields(SpecText1: Boolean; SpecText2: Boolean; SpecText3: Boolean; NoSpecText: Boolean)
    begin
        RecallFieldGroupNotification(GetFieldGroup2NotificationId());
        Rec."COL Special Text 1" := SpecText1;
        Rec."COL Special Text 2" := SpecText2;
        Rec."COL Special Text 3" := SpecText3;
        Rec."COL No Special Text" := NoSpecText;
    end;

    procedure COLCheckGroupFieldsBeforeSaving()
    begin
        CheckGroup1FieldsBeforeSaving();
        CheckGroup2FieldsBeforeSaving();
    end;

    local procedure CheckGroup1FieldsBeforeSaving()
    var
        NotificationGroup1: Notification;
        Group1MustBeOneTxt: Label 'For country code %1, one of the following fields must be selected: %2, %3, %4.', Comment = '%1 = country code; %2 = field caption; %3 = field caption; %4 = field caption';
    begin
        RecallFieldGroupNotification(GetFieldGroup1NotificationId());
        if not ("COL EU Country" or "COL Safa Country" or "COL Other Country") then begin
            NotificationGroup1.Id := GetFieldGroup1NotificationId();
            NotificationGroup1.Message := StrSubstNo(Group1MustBeOneTxt, Rec.Code, Rec.FieldCaption("COL EU Country"), Rec.FieldCaption("COL Safa Country"),
                Rec.FieldCaption("COL Other Country"));
            NotificationGroup1.Scope := NotificationScope::LocalScope;
            NotificationGroup1.Send();
        end;
    end;

    local procedure CheckGroup2FieldsBeforeSaving()
    var
        NotificationGroup2: Notification;
        Group2MustBeOneTxt: Label 'For country code %1, one of the following fields must be selected: %2, %3, %4. If none of these apply, select %5.', Comment = '%1 = country code; %2 = field caption; %3 = field caption; %4 = field caption; %5 = field caption';
    begin
        RecallFieldGroupNotification(GetFieldGroup2NotificationId());
        if not Rec."COL No Special Text" then
            if not (Rec."COL Special Text 1" or Rec."COL Special Text 2" or Rec."COL Special Text 3") then begin
                NotificationGroup2.Id := GetFieldGroup2NotificationId();
                NotificationGroup2.Message := StrSubstNo(Group2MustBeOneTxt, Rec.Code, Rec.FieldCaption("COL Special Text 1"), Rec.FieldCaption("COL Special Text 2"),
                    Rec.FieldCaption("COL Special Text 3"), Rec.FieldCaption("COL No Special Text"));
                NotificationGroup2.Scope := NotificationScope::LocalScope;
                NotificationGroup2.Send();
            end;
    end;

    local procedure RecallFieldGroupNotification(GroupNotificationId: Guid)
    var
        NotificationGroup: Notification;
    begin
        NotificationGroup.Id := GroupNotificationId;
        NotificationGroup.Recall();
    end;

    local procedure GetFieldGroup1NotificationId(): Guid
    var
        Group1NotificationIdLbl: Label '51407a5c-944b-4b27-a4d2-204f21363cb2', Locked = true;
    begin
        exit(Group1NotificationIdLbl);
    end;

    local procedure GetFieldGroup2NotificationId(): Guid
    var
        Group2NotificationIdLbl: Label '563b2c8a-1750-44cb-82c2-bf0e2a748aff', Locked = true;
    begin
        exit(Group2NotificationIdLbl);
    end;
}