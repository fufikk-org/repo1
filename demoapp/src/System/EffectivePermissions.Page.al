page 70223 "COL Effective Permissions"
{
    ApplicationArea = All;
    Caption = 'Object Effective Permissions';
    DeleteAllowed = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = Worksheet;
    SourceTable = "COL User Expanded Permission";
    SourceTableTemporary = true;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(ChooseCompany; CurrentCompanyName)
                {
                    ApplicationArea = All;
                    Caption = 'Company';
                    ToolTip = 'Specifies the company for which effective permissions for the chosen user will be shown.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        Company: Record Company;
                        Companies: Page Companies;
                    begin
                        if Company.Get(CurrentCompanyName) then
                            Companies.SetRecord(Company);
                        Companies.LookupMode(true);
                        if Companies.RunModal() = ACTION::LookupOK then begin
                            Companies.GetRecord(Company);

                            if Text <> Company.Name then begin
                                Text := Company.Name;
                                CurrentCompanyName := CopyStr(Text, 1, MaxStrLen(CurrentCompanyName));
                            end;
                        end;
                    end;

                    trigger OnValidate()
                    var
                        Company: Record Company;
                    begin
                        Company.Get(CurrentCompanyName);
                    end;
                }

                field(ChooseObjectType; CurrentObjectType)
                {
                    ApplicationArea = All;
                    Caption = 'Object Type';
                    OptionCaption = 'TableData,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,FieldNumber,,,PageExtension,TableExtension,Enum,EnumExtension,Profile,ProfileExtension,PermissionSet,PermissionSetExtension,ReportExtension';
                    ToolTip = 'Specifies the type of object for which effective permissions will be shown.';

                    trigger OnValidate()
                    begin
                        CurrentObjectId := 0;
                    end;
                }

                field(ChooseObjectId; CurrentObjectId)
                {
                    ApplicationArea = All;
                    Caption = 'Object ID';
                    ToolTip = 'Specifies the ID of the object for which effective permissions will be shown. If no ID is specified, effective permissions for all objects of the chosen type will be shown.';
                    BlankZero = true;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        AllObjWithCaption: Record AllObjWithCaption;
                        Objects: Page Objects;
                    begin
                        AllObjWithCaption.SetRange("Object Type", CurrentObjectType);
                        if AllObjWithCaption.FindFirst() then
                            Objects.SetRecord(AllObjWithCaption);
                        Objects.LookupMode(true);
                        if Objects.RunModal() = ACTION::LookupOK then begin
                            Objects.GetRecord(AllObjWithCaption);
                            CurrentObjectId := AllObjWithCaption."Object ID";
                            Text := Format(CurrentObjectId);
                            exit(true);
                        end;
                    end;
                }

            }
            group(Permissions)
            {
                Caption = 'Permissions';
                repeater(EffectivePermissions)
                {
                    field("User Name"; Rec."User Name")
                    {
                        ApplicationArea = All;
                    }
                    field("Object Type"; Rec."Object Type")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the type of object that the permissions apply to in the current database.';
                    }
                    field("Object ID"; Rec."Object ID")
                    {
                        ApplicationArea = All;
                        Editable = false;
                        ToolTip = 'Specifies the ID of the object to which the permissions apply.';
                        Visible = false;
                    }
                    field("Object Name"; Rec."AL Object Name")
                    {
                        ApplicationArea = All;
                        Caption = 'Object Name';
                        Editable = false;
                        ToolTip = 'Specifies the name of the object.';
                    }
                    field("Read Permission"; Rec."Read Permission")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies information about whether the permission set has read permission to this object. The values for the field are blank, Yes, and Indirect. Indirect means permission only through another object. If the field is empty, the permission set does not have read permission.';
                    }
                    field("Insert Permission"; Rec."Insert Permission")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies information about whether the permission set has insert permission to this object. The values for the field are blank, Yes, and Indirect. Indirect means permission only through another object. If the field is empty, the permission set does not have insert permission.';
                    }
                    field("Modify Permission"; Rec."Modify Permission")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies information about whether the permission set has modify permission to this object. The values for the field are blank, Yes, and Indirect. Indirect means permission only through another object. If the field is empty, the permission set does not have modify permission.';
                    }
                    field("Delete Permission"; Rec."Delete Permission")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies information about whether the permission set has delete permission to this object. The values for the field are blank, Yes, and Indirect. Indirect means permission only through another object. If the field is empty, the permission set does not have delete permission.';
                    }
                    field("Execute Permission"; Rec."Execute Permission")
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies information about whether the permission set has execute permission to this object. The values for the field are blank, Yes, and Indirect. Indirect means permission only through another object. If the field is empty, the permission set does not have execute permission.';
                    }
                    field(ContainedInCustomPermissionSet; ContainedInCustomPermissionSet)
                    {
                        ApplicationArea = All;
                        Caption = 'In User-Defined Permission Set';
                        Editable = false;
                        ToolTip = 'Specifies if the object is included in a User-Defined permission set.';
                    }
                }
            }
            part(ByPermissionSet; "Effective Permissions By Set")
            {
                ApplicationArea = All;
                UpdatePropagation = Both;
            }
        }
    }

    actions
    {
        area(processing)
        {

            action("Get Permissions")
            {
                ApplicationArea = All;
                Caption = 'Get Permissions';
                Image = Permission;
                ToolTip = 'Get and display the effective permissions.';

                trigger OnAction()
                begin
                    FillByObject();
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';


                actionref("Get Permissions_Promoted"; "Get Permissions")
                {
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        if Rec."Object ID" <> 0 then
            CurrPage.ByPermissionSet.PAGE.SetRecordAndRefresh(Rec."User Security Id", CurrentCompanyName, Rec."Object Type", Rec."Object ID");
    end;

    trigger OnAfterGetRecord()
    var
        TenantPermission: Record "Tenant Permission";
        ZeroGuid: Guid;
    begin
        if Rec."Object ID" = 0 then
            exit;
        TenantPermission.SetRange("App ID", ZeroGuid); // does not come from an extension
        TenantPermission.SetRange("Object Type", Rec."Object Type");
        TenantPermission.SetRange("Object ID", Rec."Object ID");
        ContainedInCustomPermissionSet := not TenantPermission.IsEmpty();
    end;

    trigger OnInit()
    begin
        CurrentCompanyName := CopyStr(CompanyName(), 1, MaxStrLen(CurrentCompanyName));
    end;

    trigger OnOpenPage()
    var
        EffectivePermissionsMgt: Codeunit "Effective Permissions Mgt.";
    begin
        EffectivePermissionsMgt.DisallowViewingEffectivePermissionsForNonAdminUsers(UserSecurityId());

    end;

    var
        CurrentObjectType: Option "TableData","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System","FieldNumber",,,"PageExtension","TableExtension","Enum","EnumExtension","Profile","ProfileExtension","PermissionSet","PermissionSetExtension","ReportExtension";
        CurrentObjectId: Integer;
        CurrentCompanyName: Text[30];
        LastUsedCompanyName: Text[30];
        LastUsedObjectType: Option;
        LastUsedObjectId: Integer;
        LastUsedShowAllObjects: Boolean;
        ShowAllObjects: Boolean;
        ContainedInCustomPermissionSet: Boolean;
        DialogFormatMsg: Label 'Reading users...@1@@@@@@@@@@@@@@@@@@';

    local procedure FillByObject()
    var
        User: Record User;
        Window: Dialog;
        TotalCount: Integer;
        NumUsersProcessed: Integer;
        TimesToUpdate: Integer;
    begin
        Rec.Reset();
        Rec.DeleteAll();
        Window.Open(DialogFormatMsg);

        if (LastUsedCompanyName = CurrentCompanyName) and
           (LastUsedObjectType = CurrentObjectType) and
           (LastUsedObjectId = CurrentObjectId) and
           (LastUsedShowAllObjects = ShowAllObjects)
        then
            exit;

        if User.FindSet() then begin
            TotalCount := User.Count();
            // Only update every 5 %
            TimesToUpdate := TotalCount div 5;
            if TimesToUpdate = 0 then
                TimesToUpdate := 1;

            repeat

                PopulateEffectivePermissionsBuffer(Rec, User."User Name",
                  User."User Security ID", CurrentCompanyName, CurrentObjectType, CurrentObjectId, ShowAllObjects);
                NumUsersProcessed += 1;
                if (NumUsersProcessed mod TimesToUpdate) = 0 then
                    Window.Update(1, Round(NumUsersProcessed * 10000 / TotalCount, 1));
            until User.Next() = 0;
            Window.Close();
        end;
        CurrPage.Update(false);

        LastUsedCompanyName := CurrentCompanyName;
        LastUsedObjectType := CurrentObjectType;
        LastUsedObjectId := CurrentObjectId;
        LastUsedShowAllObjects := ShowAllObjects;
    end;


    procedure PopulateEffectivePermissionsBuffer(var Permission: Record "COL User Expanded Permission"; PassedUserName: Code[50]; PassedUserID: Guid; PassedCompanyName: Text[50]; PassedObjectType: Integer; PassedObjectId: Integer; PassedShowAllObjects: Boolean)
    var
        AllObj: Record AllObj;
    begin
        //Permission.Reset();
        //Permission.DeleteAll();

        if PassedObjectId = 0 then begin

            AllObj.SetFilter("Object Type", '%1|%2|%3|%4|%5|%6|%7|%8|%9',
              Permission."Object Type"::"Table Data",
              Permission."Object Type"::Table,
              Permission."Object Type"::Report,
              Permission."Object Type"::Codeunit,
              Permission."Object Type"::XMLport,
              Permission."Object Type"::MenuSuite,
              Permission."Object Type"::Page,
              Permission."Object Type"::Query,
              Permission."Object Type"::System);

            if AllObj.FindSet() then begin
                repeat
                    InsertEffectivePermissionForObject(Permission, PassedUserName, PassedUserID, PassedCompanyName,
                      AllObj."Object Type", AllObj."Object ID");

                until AllObj.Next() = 0;
                Permission.FindFirst();
            end;

        end else
            InsertEffectivePermissionForObject(Permission, PassedUserName, PassedUserID, PassedCompanyName, PassedObjectType, PassedObjectId);
    end;

    // TODO BC28: Update to use 'Expanded Permission' table when Permission table is moved to OnPrem scope
    // 2026-01-05: The PopulatePermissionRecordWithEffectivePermissionsForObject procedure only accepts Record Permission,
    // not Expanded Permission. Microsoft needs to update their codeunit first.
    local procedure InsertEffectivePermissionForObject(var Permission: Record "COL User Expanded Permission"; PassedUserName: Code[50]; PassedUserID: Guid; PassedCompanyName: Text[50]; PassedObjectType: Integer; PassedObjectId: Integer)
    var
        TempPermission: Record Permission temporary;
        EffectivePermissionsMgt: Codeunit "Effective Permissions Mgt.";
    begin
        Permission.Init();
        Permission."Object Type" := PassedObjectType;
        Permission."Object ID" := PassedObjectId;
        Permission."User Name" := PassedUserName;
        Permission."User Security Id" := PassedUserID;
        EffectivePermissionsMgt.PopulatePermissionRecordWithEffectivePermissionsForObject(TempPermission, PassedUserID, PassedCompanyName,
          PassedObjectType, PassedObjectId);
        Permission.TransferFields(TempPermission);
        Permission.Insert();
    end;


}

