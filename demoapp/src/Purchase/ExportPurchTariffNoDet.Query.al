query 70105 "COL ExportPurchTariffNoDet"
{
    QueryType = Normal;

    elements
    {
        dataitem(Item; Item)
        {

            column(Tariff_No_; "Tariff No.") { }
            dataitem(Value_Entry; "Value Entry")
            {
                DataItemLink = "Item No." = Item."No.";
                DataItemTableFilter = "Item Ledger Entry Type" = const(Purchase);

                column(Posting_Date; "Posting Date") { }
                column(Item_No_; "Item No.") { }
                column(VEDescription; Description) { }
                column(Entry_Type; "Entry Type") { }
                column(Cost_Amount__Actual_; "Cost Amount (Actual)") { }
                column(Cost_Posted_to_G_L; "Cost Posted to G/L") { }
                column(Document_Type; "Document Type") { }
                column(Document_No_; "Document No.") { }
                column(Adjustment; Adjustment) { }
                column(Item_Charge_No_; "Item Charge No.") { }
                column(Item_Ledger_Entry_Quantity; "Item Ledger Entry Quantity") { }
                column(Valued_Quantity; "Valued Quantity") { }
                column(Invoiced_Quantity; "Invoiced Quantity") { }
                column(Cost_per_Unit; "Cost per Unit") { }
                column(Source_Type; "Source Type") { }
                column(Source_No_; "Source No.") { }
                column(External_Document_No_; "External Document No.") { }
                column(Order_Type; "Order Type") { }
                column(Item_Ledger_Entry_No_; "Item Ledger Entry No.") { }
                column(Entry_No_; "Entry No.") { }

                dataitem(Tariff_Number; "Tariff Number")
                {
                    DataItemLink = "No." = Item."Tariff No.";
                    SqlJoinType = LeftOuterJoin;

                    column(Description; Description)
                    {

                    }
                }
            }

        }
    }

}