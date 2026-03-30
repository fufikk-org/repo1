namespace Weibel.Sales.Document;

using Microsoft.Sales.Document;
using Weibel.Common;
using Weibel.Intercompany;

pageextension 70138 "COL Sales Quote" extends "Sales Quote"
{
    layout
    {
        addlast(General)
        {
            field("COL Warranty Code"; Rec."COL Warranty Code")
            {
                ApplicationArea = All;
            }
            field("COL Warranty Description"; Rec."COL Warranty Description")
            {
                ApplicationArea = All;
            }
            field("COL Terms and Cond. Code"; Rec."COL Terms and Cond. Code")
            {
                ApplicationArea = All;
            }
            group("COL Quote Delivery")
            {
                Caption = 'Quote Delivery';
                field("COL Quote Delivery Code"; Rec."COL Quote Delivery Code")
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                }
                field("COL Quote Delivery Description"; Rec."COL Quote Delivery Description")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Description';
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
                }
                field("COL Export Permit No."; Rec."COL Export Permit No.")
                {
                    ApplicationArea = All;
                }
            }
            group("COL Weibel")
            {
                Caption = 'Weibel';
                field("COL Sales Order Category"; Rec."COL Sales Order Category")
                {
                    ApplicationArea = All;
                }
                field("COL Sales Finance Category"; Rec."COL Sales Finance Category")
                {
                    ApplicationArea = All;
                }
                field("COL Project Name"; Rec."COL Project Name")
                {
                    ApplicationArea = All;
                }

                field("COL Sales Resp. Group"; Rec."COL Sales Resp. Group")
                {
                    ApplicationArea = All;
                }
            }
        }

        addafter("Shipping and Billing")
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
                                Caption = 'Customer End User County';
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
                    LookupPageId = "COL Intercompany Companies";
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
        addafter(Customer)
        {
            action("COL CreateEndUser")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Create End User Customer';
                Image = NewCustomer;
                Enabled = Rec."COL End User Type" = Rec."COL End User Type"::"New End User";
                ToolTip = 'Create new end user from page details';

                trigger OnAction()
                var
                    CommonCustMgt: Codeunit "COL Common Cust. Mgt";
                begin
                    CommonCustMgt.CreateEndUserCust(Rec);
                end;
            }
        }
        addlast(Category_Category4)
        {
            actionref("COL CreateEndUser_Promoted"; "COL CreateEndUser") { }
        }

        addlast(processing)
        {
            group("COL Change Customer")
            {
                Caption = 'Change Customer';
                Image = ChangeCustomer;

                action("COL Change Sell-to Customer")
                {
                    Caption = 'Change Sell-to Customer';
                    Image = ChangeCustomer;
                    ToolTip = 'Change sell-to customer and preserve line information.';
                    ApplicationArea = All;
                    Enabled = IsChangeCustomerEnabled;

                    trigger OnAction()
                    var
                        ChangeCustomerMgt: Codeunit "COL Sales Change Customer Mgt.";
                    begin
                        ChangeCustomerMgt.ChangeSellToCustomer(Rec);
                    end;
                }
                action("COL Change Bill-to Customer")
                {
                    Caption = 'Change Bill-to Customer';
                    Image = ChangeCustomer;
                    ToolTip = 'Change bill-to customer and preserve line information.';
                    ApplicationArea = All;
                    Enabled = IsChangeCustomerEnabled;

                    trigger OnAction()
                    var
                        ChangeCustomerMgt: Codeunit "COL Sales Change Customer Mgt.";
                    begin
                        ChangeCustomerMgt.ChangeBillToCustomer(Rec);
                    end;
                }
            }
        }

        addlast(Category_Prepare)
        {
            group("COL Change Customer_Promoted")
            {
                Caption = 'Change Customer';
                Image = ChangeCustomer;

                actionref("COL Change Sell-to Customer_Promoted"; "COL Change Sell-to Customer") { }
                actionref("COL Change Bill-to Customer_Promoted"; "COL Change Bill-to Customer") { }
            }
        }
    }

    trigger OnOpenPage()
    var
        RecreateSalesLinesSub: Codeunit "COL Recreate Sales Lines Sub";
    begin
        IsChangeCustomerEnabled := RecreateSalesLinesSub.IsValidDocumentType(Enum::"Sales Document Type"::Quote);
    end;

    trigger OnAfterGetRecord()
    begin
        LicenseRequired := Rec.COLGetHighestPriority();
    end;

    var
        LicenseRequired: Text;
        IsChangeCustomerEnabled: Boolean;
}
