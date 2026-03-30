namespace Weibel.Inventory.Planning;

using Microsoft.Inventory.Requisition;

query 70100 "COL Item In Planning"
{
    Caption = 'Item in Planning';
    QueryType = Normal;
    DataAccessIntent = ReadOnly;

    elements
    {
        dataitem(ReqWkshTemplate; "Req. Wksh. Template")
        {
            DataItemTableFilter = Type = filter(Planning);
            dataitem(RequisitionWkshName; "Requisition Wksh. Name")
            {
                DataItemLink = "Worksheet Template Name" = ReqWkshTemplate.Name;
                dataitem(Requisition_Line; "Requisition Line")
                {
                    DataItemLink = "Worksheet Template Name" = RequisitionWkshName."Worksheet Template Name", "Journal Batch Name" = RequisitionWkshName.Name;
                    DataItemTableFilter = Type = filter(Item);
                    column(Worksheet_Template_Name; "Worksheet Template Name") { }
                    column(Journal_Batch_Name; "Journal Batch Name") { }
                    column(Type; Type) { }
                    column(ItemNo; "No.") { }
                    column(Variant_Code; "Variant Code") { }
                    column(Description; Description) { }
                    column(Location_Code; "Location Code") { }
                    column(Unit_of_Measure_Code; "Unit of Measure Code") { }
                    column(Quantity; Quantity)
                    {
                        Method = Sum;
                    }
                }
            }
        }
    }
}