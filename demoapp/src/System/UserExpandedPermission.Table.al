
table 70120 "COL User Expanded Permission"
{
    Caption = 'User Expanded Permission';
    DataPerCompany = false;
    DataClassification = CustomerContent;

    fields
    {
        /// <summary>
        /// The application ID that defines this permission.
        /// </summary>
        field(1; "App ID"; Guid)
        {
        }
        /// <summary>
        /// The role ID of the permission set that contains this permission.
        /// </summary>
        field(2; "Role ID"; Code[30])
        {
            Caption = 'Role ID';
            TableRelation = "Aggregate Permission Set"."Role ID" WHERE("App ID" = FIELD("App ID"), Scope = FIELD(Scope));
        }
        /// <summary>
        /// The display name of the permission set that contains this permission.
        /// </summary>
        field(3; "Role Name"; Text[30])
        {
            CalcFormula = Lookup("Aggregate Permission Set".Name WHERE("Role ID" = FIELD("Role ID"), "App ID" = FIELD("App ID"), Scope = FIELD(Scope)));
            Caption = 'Role Name';
            FieldClass = FlowField;
        }
        /// <summary>
        /// The type of AL object that this permission applies to.
        /// </summary>
        field(4; "Object Type"; Option)
        {
            Caption = 'Object Type';
            OptionMembers = "Table Data","Table",,"Report",,"Codeunit","XMLport","MenuSuite","Page","Query","System",,,,,,,,,;
            OptionCaption = 'Table Data,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System,,,,,,,,,';
        }
        /// <summary>
        /// The ID of the specific object that this permission applies to.
        /// </summary>
        field(5; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            TableRelation = IF ("Object Type" = CONST("Table Data")) AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Table))
            ELSE
            IF ("Object Type" = CONST(Table)) AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Table))
            ELSE
            IF ("Object Type" = CONST(Report)) AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Report))
            ELSE
            IF ("Object Type" = CONST(Codeunit)) AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Codeunit))
            ELSE
            IF ("Object Type" = CONST(XMLport)) AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(XMLport))
            ELSE
            IF ("Object Type" = CONST(MenuSuite)) AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(MenuSuite))
            ELSE
            IF ("Object Type" = CONST(Page)) AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Page))
            ELSE
            IF ("Object Type" = CONST(Query)) AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(Query))
            ELSE
            IF ("Object Type" = CONST(System)) AllObjWithCaption."Object ID" WHERE("Object Type" = CONST(System));
        }
        /// <summary>
        /// The display name or caption of the object that this permission applies to.
        /// </summary>
        field(6; "Object Name"; Text[249])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Caption" WHERE("Object Type" = FIELD("Object Type"),
                                                                           "Object ID" = FIELD("Object ID")));
            Caption = 'Object Name';
            FieldClass = FlowField;
        }
        /// <summary>
        /// The effective read permission level for this object (blank, Yes, or Indirect).
        /// </summary>
        field(7; "Read Permission"; Option)
        {
            Caption = 'Read Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// The effective insert permission level for this object (blank, Yes, or Indirect).
        /// </summary>
        field(8; "Insert Permission"; Option)
        {
            Caption = 'Insert Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// The effective modify permission level for this object (blank, Yes, or Indirect).
        /// </summary>
        field(9; "Modify Permission"; Option)
        {
            Caption = 'Modify Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// The effective delete permission level for this object (blank, Yes, or Indirect).
        /// </summary>
        field(10; "Delete Permission"; Option)
        {
            Caption = 'Delete Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// The effective execute permission level for this object (blank, Yes, or Indirect).
        /// </summary>
        field(11; "Execute Permission"; Option)
        {
            Caption = 'Execute Permission';
            InitValue = Yes;
            OptionCaption = ' ,Yes,Indirect';
            OptionMembers = " ",Yes,Indirect;
        }
        /// <summary>
        /// The security filter that restricts access to specific records within the object.
        /// </summary>
        field(12; "Security Filter"; TableFilter)
        {
            Caption = 'Security Filter';
        }
        /// <summary>
        /// The AL object name as defined in the source code.
        /// </summary>
        field(13; "AL Object Name"; Text[30])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Name" WHERE("Object Type" = FIELD("Object Type"),
                                                                           "Object ID" = FIELD("Object ID")));
            Caption = 'AL Object Name';
            FieldClass = FlowField;
        }
        /// <summary>
        /// The scope level where this permission is defined (System or Tenant).
        /// </summary>
        field(14; Scope; Option)
        {
            OptionMembers = System,Tenant;
        }
        field(15; "User Name"; Code[100])
        {
            Caption = 'User Name';
            ToolTip = 'Specifies the user to whom this expanded permission applies.';
        }
        field(16; "User Security Id"; Guid)
        {
            Caption = 'User Security Id';
            ToolTip = 'Specifies the security identifier of the user to whom this expanded permission applies.';
        }
    }

    keys
    {
        key(Key1; "App ID", "Role ID", "Object Type", "Object ID", "User Name")
        {
        }
    }
}

