namespace Weibel.API;

using Microsoft.Inventory.Item.Attribute;
using Microsoft.Inventory.Item;

query 70106 "COL Item to Attribute API"
{
    APIGroup = 'bcdata';
    APIPublisher = 'weibel';
    APIVersion = 'v1.0';
    EntityName = 'itemToAttributeMatch';
    EntitySetName = 'itemToAttributeMatches';
    QueryType = API;
    DataAccessIntent = ReadOnly;

    elements
    {
        dataitem(itemAttributeValueMapping; "Item Attribute Value Mapping")
        {
            DataItemTableFilter = "Table ID" = filter(Database::Item);

            column(itemNo; "No.")
            {
            }
            column(itemAttributeID; "Item Attribute ID")
            {
            }
            column(itemAttributeValueID; "Item Attribute Value ID")
            {
            }

            dataitem(itemAttribute; "Item Attribute")
            {
                DataItemLink = ID = itemAttributeValueMapping."Item Attribute ID";

                column(itemAttributeName; Name)
                {
                }
                column(itemAttributeType; "Type")
                {
                }
                column(itemAttributeUnitOfMeasure; "Unit of Measure")
                {
                }

                dataitem(itemAttributeValueDataSet; "Item Attribute Value")
                {
                    DataItemLink = "Attribute ID" = itemAttributeValueMapping."Item Attribute ID", ID = itemAttributeValueMapping."Item Attribute Value ID";

                    column(itemAttributeValue; "Value")
                    {
                    }
                }
            }
        }
    }
}
