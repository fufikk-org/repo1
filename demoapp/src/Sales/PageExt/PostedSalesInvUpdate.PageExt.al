// Possible to unlock it during user testing

// namespace Weibel.Sales.History;

// using Microsoft.Sales.History;

// pageextension 70120 "COL Posted Sales Inv. - Update" extends "Posted Sales Inv. - Update"
// {
//     layout
//     {
//         addafter(Payment)
//         {
//             group("COL End User Details")
//             {
//                 Caption = 'End User Details';
//                 group("COL Details")
//                 {
//                     ShowCaption = false;
//                     group("COL User Type")
//                     {
//                         ShowCaption = false;
//                         field("COL EndUserOptions"; Rec."COL End User Type")
//                         {
//                             ApplicationArea = Basic, Suite;
//                         }
//                         group("COL CustomerEndUser")
//                         {
//                             ShowCaption = false;
//                             Visible = Rec."COL End User Type" = Rec."COL End User Type"::"Existing End User";

//                             field("COL Existing End User No."; Rec."COL Existing End User No.")
//                             {
//                                 ApplicationArea = Basic, Suite;
//                             }
//                             field("COL CF_1"; Rec."COL End User Name")
//                             {
//                                 ApplicationArea = Basic, Suite;
//                                 Editable = false;
//                                 Caption = 'Customer End User Name';
//                             }
//                             field("COL CF_2"; Rec."COL End User Address")
//                             {
//                                 ApplicationArea = Basic, Suite;
//                                 Editable = false;
//                                 Caption = 'Customer End User Address';
//                             }
//                             field("COL CF_3"; Rec."COL End User Address 2")
//                             {
//                                 ApplicationArea = Basic, Suite;
//                                 Editable = false;
//                                 Caption = 'Customer End User Address 2';
//                             }
//                             field("COL CF_4"; Rec."COL End User City")
//                             {
//                                 ApplicationArea = Basic, Suite;
//                                 Editable = false;
//                                 Caption = 'Customer End User City';
//                             }
//                             field("COL CF_5"; Rec."COL End User County")
//                             {
//                                 ApplicationArea = Basic, Suite;
//                                 Editable = false;
//                                 Caption = 'Customer End User County';
//                             }
//                             field("COL CF_6"; Rec."COL End User Post Code")
//                             {
//                                 ApplicationArea = Basic, Suite;
//                                 Editable = false;
//                                 Caption = 'Customer End User Post Code';
//                             }
//                             field("COL CF_7"; Rec."COL End User Country/Region")
//                             {
//                                 ApplicationArea = Basic, Suite;
//                                 Editable = false;
//                                 Caption = 'Customer End User Country';
//                             }
//                             field("COL CF_8"; Rec."COL End User E-Mail")
//                             {
//                                 ApplicationArea = Basic, Suite;
//                                 Editable = false;
//                                 Caption = 'Customer End User County';
//                             }
//                         }
//                         group("COL NewEndUser")
//                         {
//                             ShowCaption = false;
//                             Visible = Rec."COL End User Type" = Rec."COL End User Type"::"New End User";

//                             field("COL NCF_1"; Rec."COL End User Name")
//                             {
//                                 Editable = true;
//                                 ApplicationArea = Basic, Suite;
//                             }
//                             field("COL NCF_2"; Rec."COL End User Address")
//                             {
//                                 ApplicationArea = Basic, Suite;
//                             }
//                             field("COL NCF_3"; Rec."COL End User Address 2")
//                             {
//                                 ApplicationArea = Basic, Suite;
//                             }
//                             field("COL NCF_4"; Rec."COL End User City")
//                             {
//                                 ApplicationArea = Basic, Suite;
//                             }
//                             field("COL NCF_5"; Rec."COL End User County")
//                             {
//                                 ApplicationArea = Basic, Suite;
//                             }
//                             field("COL NCF_6"; Rec."COL End User Post Code")
//                             {
//                                 ApplicationArea = Basic, Suite;
//                             }
//                             field("COL NCF_7"; Rec."COL End User Country/Region")
//                             {
//                                 ApplicationArea = Basic, Suite;
//                             }
//                             field("COL NCF_8"; Rec."COL End User E-Mail")
//                             {
//                                 ApplicationArea = Basic, Suite;
//                             }
//                         }
//                     }
//                 }

//             }
//         }
//     }
// }
