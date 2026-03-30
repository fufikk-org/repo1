namespace Weibel.Inventory.LegacyItems;

xmlport 70100 "COL Import Legacy Items"
{
    Caption = 'Import Legacy Items';
    Encoding = UTF8;
    Direction = Import;
    DefaultFieldsValidation = false;
    Format = Xml;
    FormatEvaluate = Xml;


    schema
    {
        textelement(root)
        {
            XmlName = 'itemswap';

            tableelement(COLLegacyItem; "COL Legacy Item")
            {
                XmlName = 'item';
                AutoReplace = true;
                AutoSave = true;
                AutoUpdate = true;
                fieldattribute(NAVItemNo; COLLegacyItem."NAV Item No.")
                {
                    XmlName = 'navitemno';
                }
                fieldattribute(NAVItemDescription; COLLegacyItem."NAV Item Description")
                {
                    XmlName = 'navitemdesc';
                }
                fieldattribute(NAVItemDescription2; COLLegacyItem."NAV Item Description 2")
                {
                    XmlName = 'navitemdesc2';
                }
                fieldattribute(ItemNo; COLLegacyItem."Item No.")
                {
                    XmlName = 'bcitemno';
                }
                fieldattribute(VariantCode; COLLegacyItem."Variant Code")
                {
                    XmlName = 'bcvariantcode';
                }
            }
        }
    }
}
