// namespace Weibel.Common.Setup;

// using Microsoft.Inventory.Location;
// using Microsoft.Inventory.Item;
// using System.IO;

// table 70106 "COL Weibel Setup"
// {
//     Caption = 'Weibel Setup';
//     DataClassification = CustomerContent;

//     fields
//     {
//         field(1; "Primary Key"; Code[10])
//         {
//             Caption = 'Primary Key';
//             Editable = false;
//             ToolTip = 'Specifies the primary key of the record.';
//             DataClassification = CustomerContent;
//         }
//         field(2; "Kardex Location Code"; Code[10])
//         {
//             Caption = 'Kardex Location Code';
//             ToolTip = 'Specifies the kardex location code.';
//             TableRelation = Location;
//             DataClassification = CustomerContent;
//         }
//         field(3; "COL Copy Item Template Code"; Code[10])
//         {
//             Caption = 'Copy Item Template Code';
//             ToolTip = 'Specifies if the item is a template.';
//             DataClassification = CustomerContent;
//             TableRelation = "Config. Template Header" where("Table ID" = filter(Database::Item));
//         }
//     }

//     keys
//     {
//         key(PK; "Primary Key")
//         {
//             Clustered = true;
//         }
//     }
// }