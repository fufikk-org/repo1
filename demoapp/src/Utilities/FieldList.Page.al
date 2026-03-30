namespace Weibel.Utilities;

using System.Reflection;

page 70101 "COL Field List"
{
    ApplicationArea = All;
    Caption = 'Field List';
    PageType = List;
    SourceTable = "Field";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(TableNo; Rec.TableNo)
                {
                    ToolTip = 'Specifies the table number.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the ID number of the field in the table.';
                }
                field(TableName; Rec.TableName)
                {
                    ToolTip = 'Specifies the name of the table.';
                }
                field(FieldName; Rec.FieldName)
                {
                    ToolTip = 'Specifies the name of the field in the table.';
                }
                field(Type; Rec."Type")
                {
                    ToolTip = 'Specifies the type of the field in the table, which indicates the type of data it contains.';
                }
                field(Len; Rec.Len)
                {
                    ToolTip = 'Specifies the value of the Len field.';
                }
                field(Class; Rec.Class)
                {
                    ToolTip = 'Specifies the type of class. Normal is data entry, FlowFields calculate and display results immediately, and FlowFilters display results based on user-defined filter values that affect the calculation of a FlowField.';
                }
                field(Enabled; Rec.Enabled)
                {
                    ToolTip = 'Specifies the value of the Enabled field.';
                }
                field("Type Name"; Rec."Type Name")
                {
                    ToolTip = 'Specifies the type of data.';
                }
                field(ExternalName; Rec.ExternalName)
                {
                    ToolTip = 'Specifies the value of the External Name field.';
                }
                field("Field Caption"; Rec."Field Caption")
                {
                    ToolTip = 'Specifies the caption of the field, that is, the name that will be shown in the user interface.';
                }
                field(RelationTableNo; Rec.RelationTableNo)
                {
                    ToolTip = 'Specifies the ID number of a table from which the field on the current table gets data. For example, the field can provide a lookup into another table.';
                }
                field(RelationFieldNo; Rec.RelationFieldNo)
                {
                    ToolTip = 'Specifies the value of the Relation Field No field.';
                }
                field(SQLDataType; Rec.SQLDataType)
                {
                    ToolTip = 'Specifies the value of the SQL Data Type field.';
                }
                field(OptionString; Rec.OptionString)
                {
                    ToolTip = 'Specifies the option string.';
                }
                field(ObsoleteState; Rec.ObsoleteState)
                {
                    ToolTip = 'Specifies the value of the Obsolete State field.';
                }
                field(ObsoleteReason; Rec.ObsoleteReason)
                {
                    ToolTip = 'Specifies the value of the Obsolete Reason field.';
                }
                field(DataClassification; Rec."DataClassification")
                {
                    ToolTip = 'Specifies the Data Classification.';
                }
                field(IsPartOfPrimaryKey; Rec.IsPartOfPrimaryKey)
                {
                    ToolTip = 'Specifies if it''s a part of the primary key.';
                }
                field("App Package ID"; Rec."App Package ID")
                {
                    ToolTip = 'Specifies the value of the App Package ID field.';
                }
                field("App Runtime Package ID"; Rec."App Runtime Package ID")
                {
                    ToolTip = 'Specifies the value of the App Runtime Package ID field.';
                }
            }
        }
    }
}
