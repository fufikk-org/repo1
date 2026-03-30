namespace Weibel.Sales.Document;

using Microsoft.Sales.Document;
using Weibel.Foundation.Reporting;
using Weibel.Intercompany;
using Weibel.Packaging;
using Weibel.Common;

pageextension 70124 "COL Sales Order" extends "Sales Order"
{
    layout
    {
        addlast(General)
        {
            field("COL Shipping Status"; Rec."COL Shipping Status")
            {
                ApplicationArea = All;
            }
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
                        }
                    }
                }
                group("COL Weibel")
                {
                    Caption = 'Weibel';
                    field("COL Description"; Rec."COL Description")
                    {
                        ApplicationArea = All;
                    }
                    field("COL Order Information"; Rec."COL Order Information")
                    {
                        ApplicationArea = All;
                    }
                    field("COL Order Category (Old)"; Rec."COL Order Category (Old)")
                    {
                        ApplicationArea = All;
                    }
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

        }

        addafter("External Document No.")
        {
            field("COL Original Promised Date"; Rec."COL Original Promised Date")
            {
                ApplicationArea = All;
                Editable = OriginalPromisedDateEditable;

                trigger OnValidate()
                var
                begin
                    UpdateEditable();
                end;
            }
        }

        addafter("Responsibility Center")
        {
            field("COL Original Contractual Date"; Rec."COL Original Contractual Date")
            {
                ApplicationArea = All;
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
        addafter(Control1900201301) // prepayments
        {

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
        addlast("&Print")
        {
            action("COL Print Shipment Label")
            {
                ApplicationArea = All;
                Caption = 'Print Shipment Label';
                Ellipsis = true;
                Image = Print;
                ToolTip = 'Print Shipment Label.';

                trigger OnAction()
                var
                    DocumentPrint: Codeunit "COL Document-Print";
                begin
                    DocumentPrint.PrintSalesHeaderShipmentLabel(Rec);
                end;
            }
        }
        addlast("O&rder")
        {
            action("COL Packages")
            {
                Caption = 'Package Dimensions';
                ToolTip = 'Open and edit list of packages related to current document.';
                Image = CalculateShipment;
                ApplicationArea = All;
                RunObject = page "COL Package Dimension List";
                RunPageLink = "Document Type" = const("Sales Order"), "Document No." = field("No.");
            }
            action("COL Change Org. Prom. Date")
            {
                ApplicationArea = All;
                Caption = 'Update Original Promised Date';
                Ellipsis = true;
                Image = ChangeDate;
                ToolTip = 'Update Original Promised Date.';

                trigger OnAction()
                begin
                    Rec.COLChangeOriginalPromDate();
                    UpdateEditable();
                end;
            }
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

        addlast(Category_Process)
        {
            actionref("COL Print Shipment Label_Promoted_Home"; "COL Print Shipment Label") { }
            actionref("COL CreateEndUser_promoted"; "COL CreateEndUser") { }
        }
        addlast(Category_Category11)
        {
            actionref("COL Print Shipment Label_Promoted_PrintSend"; "COL Print Shipment Label") { }
        }
        addlast(Category_Category8) // Order
        {
            actionref("COL Packages_Promoted"; "COL Packages") { }
            actionref("COL Change Org. Prom. Date_Promoted"; "COL Change Org. Prom. Date") { }
        }

        addlast(Category_Category7) // Prepare
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
        IsChangeCustomerEnabled := RecreateSalesLinesSub.IsValidDocumentType(Enum::"Sales Document Type"::Order);
    end;

    trigger OnAfterGetRecord()
    begin
        LicenseRequired := Rec.COLGetHighestPriority();
        UpdateEditable();
    end;

    var
        LicenseRequired: Text;
        OriginalPromisedDateEditable: Boolean;
        IsChangeCustomerEnabled: Boolean;

    local procedure UpdateEditable()
    begin
        OriginalPromisedDateEditable := Rec."COL Original Promised Date" = 0D;
    end;
}
