query 70104 "COL ExportPurchTariffNo"
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

                filter(Posting_Date; "Posting Date")
                {

                }

                column(Cost_Amount__Actual_; "Cost Amount (Actual)")
                {
                    Method = Sum;
                }
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