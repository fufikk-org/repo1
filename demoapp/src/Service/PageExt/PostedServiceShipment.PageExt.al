namespace Weibel.Service.History;

using Microsoft.Service.History;
using Weibel.Packaging;

pageextension 70129 "COL Posted Service Shipment" extends "Posted Service Shipment"
{
    layout
    {
        addlast(General)
        {
            field("COL Shipping Status"; Rec."COL Shipping Status")
            {
                ApplicationArea = All;
                Editable = false;
            }
            group("COL PackagingInformation")
            {
                Caption = 'Packaging Information';

                grid("COL Packaging Grid")
                {
                    group("COL No. of Packages Group")
                    {
                        Caption = 'No. of Packages';

                        field("COL No. of Packages"; Rec."COL No. of Packages")
                        {
                            ApplicationArea = All;
                            Caption = 'Calculated';
                        }
                        field("COL No. of Packages Manual"; Rec."COL No. of Packages Manual")
                        {
                            ApplicationArea = All;
                            Caption = 'User Defined';
                            Editable = false;
                        }
                    }
                    group("COL Total Weight Group")
                    {
                        Caption = 'Total Gross Weight';
                        field("COL Total Gross Weight"; Rec."COL Total Gross Weight")
                        {
                            ApplicationArea = All;
                            Caption = 'Calculated';
                        }
                        field("COL Total Gross Weight Manual"; Rec."COL Total Gross Weight Manual")
                        {
                            ApplicationArea = All;
                            Caption = 'User Defined';
                            Editable = false;
                        }
                    }
                }
            }
            group("COL Classification")
            {
                Caption = 'Classification';
                field("COL License Required"; LicenseRequired)
                {
                    ApplicationArea = All;
                    Caption = 'License Required';
                    ToolTip = 'Specifies if a License is Required.';
                    Editable = false;
                }
                field("COL Export Classification Code"; Rec."COL Export Classification Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("COL Export Permit No."; Rec."COL Export Permit No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
            }
        }
        addafter("Shipping")
        {
            group("COL End User Details")
            {
                Caption = 'End User Details';
                group("COL Details")
                {
                    ShowCaption = false;
                    group("COL User Type")
                    {
                        ShowCaption = false;
                        field("COL EndUserOptions"; Rec."COL End User Type")
                        {
                            ApplicationArea = Basic, Suite;
                        }
                        group("COL CustomerEndUser")
                        {
                            ShowCaption = false;
                            Visible = Rec."COL End User Type" = Rec."COL End User Type"::"Existing End User";

                            field("COL Existing End User No."; Rec."COL Existing End User No.")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                            field("COL CF_1"; Rec."COL End User Name")
                            {
                                ApplicationArea = Basic, Suite;
                                Editable = false;
                                Caption = 'Customer End User Name';
                            }
                            field("COL CF_2"; Rec."COL End User Address")
                            {
                                ApplicationArea = Basic, Suite;
                                Editable = false;
                                Caption = 'Customer End User Address';
                            }
                            field("COL CF_3"; Rec."COL End User Address 2")
                            {
                                ApplicationArea = Basic, Suite;
                                Editable = false;
                                Caption = 'Customer End User Address 2';
                            }
                            field("COL CF_4"; Rec."COL End User City")
                            {
                                ApplicationArea = Basic, Suite;
                                Editable = false;
                                Caption = 'Customer End User City';
                            }
                            field("COL CF_5"; Rec."COL End User County")
                            {
                                ApplicationArea = Basic, Suite;
                                Editable = false;
                                Caption = 'Customer End User County';
                            }
                            field("COL CF_6"; Rec."COL End User Post Code")
                            {
                                ApplicationArea = Basic, Suite;
                                Editable = false;
                                Caption = 'Customer End User Post Code';
                            }
                            field("COL CF_7"; Rec."COL End User Country/Region")
                            {
                                ApplicationArea = Basic, Suite;
                                Editable = false;
                                Caption = 'Customer End User Country';
                            }
                            field("COL CF_8"; Rec."COL End User E-Mail")
                            {
                                ApplicationArea = Basic, Suite;
                                Editable = false;
                                Caption = 'Customer End User Email';
                            }
                        }
                        group("COL NewEndUser")
                        {
                            ShowCaption = false;
                            Visible = Rec."COL End User Type" = Rec."COL End User Type"::"New End User";

                            field("COL NCF_1"; Rec."COL End User Name")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                            field("COL NCF_2"; Rec."COL End User Address")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                            field("COL NCF_3"; Rec."COL End User Address 2")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                            field("COL NCF_4"; Rec."COL End User City")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                            field("COL NCF_5"; Rec."COL End User County")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                            field("COL NCF_6"; Rec."COL End User Post Code")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                            field("COL NCF_7"; Rec."COL End User Country/Region")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                            field("COL NCF_8"; Rec."COL End User E-Mail")
                            {
                                ApplicationArea = Basic, Suite;
                            }
                        }
                    }
                }

            }

            group("COL Group Client")
            {
                Caption = 'Weibel Group Sales';

                field("COL GS. Company"; Rec."COL GS. Company")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("COL GS. Customer No."; Rec."COL GS. Customer No.")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("COL GS. Salesperson Code"; Rec."COL GS. Salesperson Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("COL GS_0"; Rec."COL GS. Name")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("COL GS_1"; Rec."COL GS. Name 2")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("COL GS_2"; Rec."COL GS. Address")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("COL GS_3"; Rec."COL GS. Address 2")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("COL GS_4"; Rec."COL GS. City")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("COL GS_5"; Rec."COL GS. County")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("COL GS_6"; Rec."COL GS. Post Code")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("COL GS_7"; Rec."COL GS. Country/Region")
                {
                    ApplicationArea = Basic, Suite;
                }
            }

        }
    }

    actions
    {
        addlast("&Shipment")
        {
            action("COL Packages")
            {
                Caption = 'Package Dimensions';
                ToolTip = 'Open list of packages related to current document.';
                Image = CalculateShipment;
                ApplicationArea = All;
                RunObject = page "COL Posted Package Dimensions";
                RunPageLink = "Table Id" = const(Database::"Service Shipment Header"), "Document No." = field("No.");
            }
        }

        addlast(Category_Shipment) // shipment
        {
            actionref("COL Packages_Promoted"; "COL Packages") { }
        }
    }

    trigger OnAfterGetRecord()
    begin
        LicenseRequired := Rec.COLGetHighestPriority();
    end;

    var
        LicenseRequired: Text;
}