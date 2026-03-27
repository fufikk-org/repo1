# AL Development Guidelines

Comprehensive guidelines for Business Central AL development covering code style, naming conventions, error handling, and upgrade best practices.

---

## Table of Contents

1. [Naming Conventions and Numbering](#1-naming-conventions-and-numbering)
2. [Code Organization](#2-code-organization)
3. [Standard AL Modules](#3-standard-al-modules)
4. [Table Development](#4-table-development)
5. [Page Development](#5-page-development)
6. [API Development](#6-api-development)
7. [Code Style and Formatting](#7-code-style-and-formatting)
8. [Error Handling](#8-error-handling)
9. [Data Upgrade Rules](#9-data-upgrade-rules)

---

## 1. Naming Conventions and Numbering

### Object and Field Numbering

- **Do not use namespaces** in the project
- Each field added to `pageextension` or `tableextension` must have a **unique number** starting from the number defined in `app.json`
- Each field added to `pageextension` or `tableextension` must have a **unique name** starting with a prefix
- Each object must have a **unique number** starting from the number defined in `app.json`
- Unique numbers should be unique for the **same object type** (e.g., if you have table 70000, you can create page 70000 if it doesn't exist)
- Each object must have a **unique name** starting with a prefix

### Prefix Conventions

Use **`COL`** prefix for:
- New fields in page, enum, report, and table extensions
- New actions in extensions
- Global procedures in extensions
- New objects in the project

**Example:**
```al
// Table Extension
field(70000; "COL Custom Field"; Text[50])
{
    DataClassification = CustomerContent;
    Caption = 'Custom Field';
}

// Page Extension
field("COL Custom Field"; Rec."COL Custom Field")
{
    ApplicationArea = All;
}
```

### Field Naming Rules

All field names must follow Business Central naming standards:

- **PascalCase** - Each word in the field name must start with a capital letter
- **Maximum Length** - Field name cannot exceed **25 characters** (including prefix)
- **Clear and Descriptive** - Field names should be clear and follow Business Central conventions

**✅ GOOD Examples:**
- `Customer No.` (standard field)
- `COL Custom Field` (extension field with prefix)
- `Posting Date`
- `Amount Including VAT`

**❌ BAD Examples:**
- `customerNo` (not PascalCase)
- `Customer_Number` (uses underscores)
- `CUSTOMERNO` (all uppercase)
- `COL Very Long Field Name That Exceeds The Character Limit` (exceeds 25 characters)

---

### Interface and Implementation Naming
 
**Interfaces:**
- Prefix with standard prefix and with "I" (e.g., `COL ICustomerService`)
- File: `ICustomerService.Interface.al`
 
**Implementations:**
- Suffix with "Impl" (e.g., `Customer Service Impl`)
- File: `CustomerServiceImpl.Codeunit.al`
```al
// Interface
interface "COL ICustomerService"
{
    procedure GetCustomerBalance(CustomerNo: Code[20]): Decimal;
}
 
// Implementation
codeunit 50100 "COL Customer Service Impl" implements ICustomerService
{
    procedure GetCustomerBalance(CustomerNo: Code[20]): Decimal
    begin
        // Implementation
    end;
}
```

## 2. Code Organization

### Feature-Based Folder Structure

Organize code by **business features** rather than object types to improve maintainability and logical grouping.

**✅ GOOD - Feature-based organization:**
```
src/
├── NoSeries/
│   ├── NoSeries.Table.al
│   ├── NoSeries.Page.al
│   └── NoSeriesSetup.Codeunit.al
├── Sales/
│   ├── Invoice/
│   │   ├── SalesInvoice.Page.al
│   │   └── SalesInvoicePosting.Codeunit.al
│   └── Order/
│       └── SalesOrder.Page.al
└── Common/
    ├── Helpers/
    │   └── DateHelper.Codeunit.al
    └── Interfaces/
        └── IPostable.Interface.al
```

**❌ BAD - Object-type segregation:**
```
src/
├── Tables/
│   ├── NoSeries.Table.al
│   └── SalesHeader.Table.al
├── Pages/
│   ├── NoSeries.Page.al
│   └── SalesInvoice.Page.al
└── Codeunits/
    ├── NoSeriesSetup.Codeunit.al
    └── SalesInvoicePosting.Codeunit.al
```

### Folder Guidelines

- Use `src/feature/subfeature/` structure
- Place shared components in `Common` or `Shared` folders
- Maintain consistent indentation (2 spaces preferred)

---

## 3. Standard AL Modules

### Reuse Standard Modules

- **Avoid creating new codeunits or functions** if functionality already exists in standard AL modules
- Try to use examples and patterns from **Microsoft Learn for AL Language**
- Use standard AL modules from:
  - [System Application](https://github.com/microsoft/BCApps/tree/main/src/System%20Application/App)
  - [Business Foundation](https://github.com/microsoft/BCApps/tree/main/src/Business%20Foundation/App)

This helps keep the codebase clean, maintainable, and optimized for performance.

---

## 4. Table Development

### Table Creation Rules

#### Required Elements

1. **Caption** - Must not contain object prefix
2. **DataClassification** - Add `CustomerContent` at table level
3. **Field Captions** - Always add captions to fields
4. **Field Tooltips** - Always add tooltips to fields

#### Field Naming Conventions

- **PascalCase** - Each word in the field name must start with a capital letter
- **Maximum Length** - Field name cannot be longer than **25 characters**
- **Descriptive Names** - Use clear, descriptive names following Business Central standards

**✅ GOOD Examples:**
- `Customer No.` (13 characters)
- `Posting Date` (12 characters)
- `Amount Including VAT` (20 characters)
- `Unit Price` (10 characters)
- `Description` (11 characters)

**❌ BAD Examples:**
- `customerNo` (Wrong: not PascalCase)
- `customer_no` (Wrong: not PascalCase, uses underscore)
- `CUSTOMER NO` (Wrong: all uppercase)
- `This Is A Very Long Field Name That Exceeds Limit` (Wrong: 48 characters, exceeds 25)
- `VeryLongCustomerNumberField` (Wrong: 28 characters, exceeds 25)

#### Field-Level Rules

- **Do NOT add** `DataClassification` at field level (use table-level)
- **Do NOT add** `DataClassification` if field type is `FlowField` or `FlowFilter`
- **Do NOT add** prefix to fields in tables created in the same repository
- **Do NOT add** Created Date, Created By, Modified Date, Modified By fields
- **Do NOT add** validation code for `TableRelation` fields (system handles automatically)
- **Do NOT add** errors in `OnInsert` trigger

#### Triggers

- **OnDelete Trigger**: Add related table deletions (e.g., delete `Sales Line` records when deleting `Sales Header`)
- **OnInsert Trigger**: Do not add error handling

**✅ GOOD Example:**
```al
table 70000 "Sales Document"
{
    Caption = 'Sales Document';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            ToolTip = 'Specifies the number of the sales document.';
        }
        
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            ToolTip = 'Specifies the customer number.';
            TableRelation = Customer;
        }
        
        field(10; "Amount"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line".Amount where("Document No." = field("No.")));
            Caption = 'Amount';
            ToolTip = 'Specifies the total amount of the sales document.';
            Editable = false;
            // Note: No DataClassification for FlowField
        }
        
        field(11; "Amount Filter"; Decimal)
        {
            FieldClass = FlowFilter;
            Caption = 'Amount Filter';
            ToolTip = 'Specifies a filter for the amount.';
            // Note: No DataClassification for FlowFilter
        }
    }
    
    trigger OnDelete()
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document No.", "No.");
        SalesLine.DeleteAll(true);
    end;
}
```

### Table Extension Rules

#### Required Elements

1. **DataClassification** - Add `CustomerContent` at field level (except for FlowField/FlowFilter)
2. **Caption** - Must not contain object prefix
3. **Tooltip** - Always add tooltip
4. **Prefix** - Always add prefix to field name

#### Field Naming Conventions

- **PascalCase** - Each word in the field name must start with a capital letter (after prefix)
- **Maximum Length** - Field name (including prefix) cannot be longer than **25 characters**
- **Descriptive Names** - Use clear, descriptive names following Business Central standards

**✅ GOOD Examples:**
- `COL Custom Field` (16 characters)
- `COL Posting Date` (16 characters)
- `COL Unit Price` (14 characters)
- `COL Total Quantity` (18 characters)

**❌ BAD Examples:**
- `COL customField` (Wrong: not PascalCase after prefix)
- `COL_custom_field` (Wrong: uses underscores)
- `COL CUSTOM FIELD` (Wrong: all uppercase after prefix)
- `COL Very Long Field Name Text` (Wrong: 30 characters, exceeds 25)

#### Field-Level Rules

- **Do NOT add** `DataClassification` if field type is `FlowField` or `FlowFilter`

**✅ GOOD Example:**
```al
tableextension 70000 "COL Sales Header Ext" extends "Sales Header"
{
    fields
    {
        field(70000; "COL Custom Field"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Custom Field';
            ToolTip = 'Specifies a custom field for additional information.';
        }
        
        field(70001; "COL Total Quantity"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Sales Line".Quantity where("Document No." = field("No.")));
            Caption = 'Total Quantity';
            ToolTip = 'Specifies the total quantity of all lines.';
            Editable = false;
            // Note: No DataClassification for FlowField
        }
    }
}
```

---

## 5. Page Development

### Page Creation Rules

#### Page-Level Settings

- **ApplicationArea** - Always add `All` at page level
- **Do NOT add** `ApplicationArea` at field level
- **Do NOT add** Caption at field level
- **Do NOT add** Tooltip at field level
- **Do NOT add** New, Delete, or Edit actions

#### Field Naming

- **For pages in this repository**: Do NOT add prefix to fields
- **For page extensions**: Always add prefix to fields

**✅ GOOD Example:**
```al
page 70000 "COL Sales Documents"
{
    Caption = 'Sales Documents';
    PageType = List;
    SourceTable = "Sales Document";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                }
                
                field("Customer No."; Rec."Customer No.")
                {
                }
            }
        }
    }
}
```

### Page Extension Rules

#### Field and Action Placement

- **Prefix** - Always add prefix to field names
- **ApplicationArea** - Add `All` at field level
- **Use `addlast`** - When adding fields or actions, prefer `addlast` in section instead of `addafter` specific field
  - This makes extensions more resilient to changes in base objects
  - Reduces conflicts with other extensions

**✅ GOOD Example - Using addlast:**
```al
pageextension 70000 "COL Sales Order Ext" extends "Sales Order"
{
    layout
    {
        addlast(content)
        {
            group("COL Additional Info")
            {
                Caption = 'Additional Information';
                
                field("COL Custom Field"; Rec."COL Custom Field")
                {
                    ApplicationArea = All;
                }
                
                field("COL Reference No."; Rec."COL Reference No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
```

**❌ BAD Example - Using addafter:**
```al
pageextension 70000 "COL Sales Order Ext" extends "Sales Order"
{
    layout
    {
        // AVOID: Using addafter makes extension fragile to base changes
        addafter("No.")
        {
            field("COL Custom Field"; Rec."COL Custom Field")
            {
                ApplicationArea = All;
            }
        }
    }
}
```

### Action Development Rules

When adding actions to pages, **always include**:

1. **Caption** - User-visible action name
2. **ToolTip** - Description of what the action does
3. **Image** - Icon for the action
4. **Do NOT use** `Promoted` properties (PromotedCategory, PromotedOnly, etc.)
5. **Use ActionRef** - For promoted actions, use `actionref` in promoted section

**✅ GOOD Example:**
```al
pageextension 70000 "COL Sales Order Ext" extends "Sales Order"
{
    actions
    {
        addlast(processing)
        {
            action("COL Custom Process")
            {
                Caption = 'Custom Process';
                ToolTip = 'Executes the custom processing logic for this document.';
                Image = Process;
                ApplicationArea = All;
                
                trigger OnAction()
                begin
                    // Action implementation
                end;
            }
            
            action("COL Export Data")
            {
                Caption = 'Export Data';
                ToolTip = 'Exports the document data to external format.';
                Image = Export;
                ApplicationArea = All;
                
                trigger OnAction()
                begin
                    // Export implementation
                end;
            }
        }
        
        // Promote actions using actionref
        addfirst(Promoted)
        {
            actionref("COL Custom Process_Promoted"; "COL Custom Process")
            {
            }
            actionref("COL Export Data_Promoted"; "COL Export Data")
            {
            }
        }
    }
}
```

**❌ BAD Example:**
```al
pageextension 70000 "COL Sales Order Ext" extends "Sales Order"
{
    actions
    {
        addlast(processing)
        {
            action("COL Custom Process")
            {
                // WRONG: Missing Caption, ToolTip, Image
                // WRONG: Using old Promoted properties
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                
                trigger OnAction()
                begin
                    // Action implementation
                end;
            }
        }
    }
}
```

---

## 6. API Development

### API Page Requirements

When creating API pages, always include:

1. **EntityName** and **EntitySetName**
2. **ODataKeyFields** - Use `systemId`
3. **systemId field** - Add as `id`
4. **APIPublisher** - Use `columbus` as the default value
5. **Do NOT add** Caption or Tooltip (except for systemId field)

**✅ GOOD Example:**
```al
page 70000 "Sales Documents API"
{
    PageType = API;
    APIPublisher = 'columbus';
    APIGroup = 'sales';
    APIVersion = 'v1.0';
    EntityName = 'salesDocument';
    EntitySetName = 'salesDocuments';
    SourceTable = "Sales Document";
    ODataKeyFields = systemId;
    Extensible = false;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(id; Rec.systemId)
                {
                    Caption = 'Id';
                    Editable = false;
                }
                
                field(number; Rec."No.")
                {
                }
                
                field(customerNumber; Rec."Customer No.")
                {
                }
            }
        }
    }
}
```

---

## 7. Code Style and Formatting

### Consistent Indentation

Maintain consistent code formatting with **2 spaces** indentation throughout your project.

**✅ GOOD Example:**
```al
procedure CalculateDiscount(Amount: Decimal; DiscountPct: Decimal): Decimal
begin
  if DiscountPct > 0 then
    exit(Amount * DiscountPct / 100);
    
  exit(0);
end;
```

### Code Documentation

Provide clear documentation for **global functions** using XML documentation comments.

**✅ GOOD Example:**
```al
codeunit 50100 "Base64 Convert"
{
    /// <summary>
    /// Converts the value of the input string to its equivalent string representation that is encoded with base-64 digits.
    /// </summary>
    /// <param name="String">The string to convert.</param>
    /// <returns>The string representation, in base-64, of the input string.</returns>
    procedure ToBase64(String: Text): Text
    begin
        exit(Base64ConvertImpl.ToBase64(String));
    end;

    /// <summary>
    /// Validates discount percentage against business rules.
    /// </summary>
    /// <param name="DiscountPct">The discount percentage to validate.</param>
    procedure ValidateDiscountPercentage(DiscountPct: Decimal)
    var
        DiscountExceedsLimitErr: Label 'Discount cannot exceed 50%% due to company policy.';
        NegativeDiscountErr: Label 'Discount percentage cannot be negative.';
    begin
        if DiscountPct > 50 then
            Error(DiscountExceedsLimitErr);
            
        if DiscountPct < 0 then
            Error(NegativeDiscountErr);
    end;
}
```

**❌ BAD Example - Avoid inline comments for obvious operations and hardcoded messages:**
```al
procedure ValidateDiscountPercentage(DiscountPct: Decimal)
begin
  // Check if discount is greater than 50
  if DiscountPct > 50 then
    Error('Discount cannot exceed 50%');  // WRONG: Hardcoded message
    
  // Check if discount is less than 0
  if DiscountPct < 0 then
    Error('Discount percentage cannot be negative');  // WRONG: Hardcoded message
end;
```

### Modular Code Structure

Write small, focused procedures that do one thing well. Use interfaces and patterns where appropriate.

**✅ GOOD Example:**
```al
procedure PostDocument(var DocumentHeader: Record "Sales Header")
begin
  ValidateDocument(DocumentHeader);
  CalculateTotals(DocumentHeader);
  CreateLedgerEntries(DocumentHeader);
  UpdateStatus(DocumentHeader);
end;

local procedure ValidateDocument(var DocumentHeader: Record "Sales Header")
var
    DocumentNumberEmptyErr: Label 'Document number cannot be empty.';
begin
  if DocumentHeader."No." = '' then
    Error(DocumentNumberEmptyErr);
end;

local procedure CalculateTotals(var DocumentHeader: Record "Sales Header")
begin
  DocumentHeader.CalcFields(Amount);
end;
```

**❌ BAD Example:**
```al
procedure PostDocument(var DocumentHeader: Record "Sales Header")
begin
  // All validation, calculation, and posting logic in one procedure
  // ... 200+ lines of mixed concerns
end;
```

### Naming Conventions

- Use **PascalCase** for variable and function names
- Use **PascalCase** for object names (tables, pages, reports)
- Code should be self-documenting through clear naming

### Object References

**Always use object names instead of object numbers** in references.

#### Rule: Avoid Using Object Numbers

When referencing objects (tables, pages, codeunits, etc.), always use the object name rather than the object number. This makes code more readable and maintainable.

**✅ GOOD Examples:**
```al
// Table references
var
    Customer: Record Customer;
    SalesHeader: Record "Sales Header";
    
// Page references
Page.Run(Page::"Customer Card", Customer);
Page.RunModal(Page::"Sales Order", SalesHeader);

// Codeunit references
Codeunit.Run(Codeunit::"Sales-Post");
SalesPost: Codeunit "Sales-Post";

// Database references
DataTransfer.SetTables(Database::Customer, Database::"Sales Header");
```

**❌ BAD Examples:**
```al
// WRONG: Using object numbers instead of names
var
    Customer: Record 18;  // WRONG: Use Record Customer
    SalesHeader: Record 36;  // WRONG: Use Record "Sales Header"
    
// WRONG: Page and Codeunit references with numbers
Page.Run(21, Customer);  // WRONG: Use Page::"Customer Card"
Codeunit.Run(80);  // WRONG: Use Codeunit::"Sales-Post"

// WRONG: Database references with numbers
DataTransfer.SetTables(18, 36);  // WRONG: Use Database::Customer, Database::"Sales Header"
```

### Event Subscribers

When developing Event Subscribers, follow these patterns for better code organization and maintainability.

#### Rule: Wrap Event Subscriber Code in Procedures

Event subscriber code should be wrapped in separate procedures when possible. This improves:
- **Testability** - Procedures can be unit tested
- **Reusability** - Logic can be called from multiple places
- **Readability** - Cleaner event subscriber methods

#### Rule: Event Subscriber Method Naming

The **event subscriber method** (with `[EventSubscriber]` attribute) should be named starting with **"Run"** followed by the **Event Publisher name**.

**Format:** `Run<EventPublisherName>`

The event subscriber then calls a descriptive local procedure that contains the actual business logic.

**✅ GOOD Example:**
```al
codeunit 70000 "COL Sales Event Subscribers"
{
    // Event subscriber method - MUST start with "Run" + event name
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure RunOnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean)
    begin
        // Just call the local procedure with descriptive name
        ValidateCustomFieldsBeforePosting(SalesHeader, PreviewMode, IsHandled);
    end;

    // Local procedure - descriptive name, contains actual logic
    local procedure ValidateCustomFieldsBeforePosting(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean)
    var
        CustomValidationLbl: Label 'Custom validation started', Locked = true;
    begin
        Session.LogMessage('0001', CustomValidationLbl, Verbosity::Normal, DataClassification::SystemMetadata);
        
        // Validation logic here
        ValidateCustomFields(SalesHeader);
        
        if SalesHeader."COL Custom Field" = '' then
            IsHandled := true;
    end;
    
    local procedure ValidateCustomFields(var SalesHeader: Record "Sales Header")
    var
        CustomFieldEmptyErr: Label 'Custom field cannot be empty.';
    begin
        if SalesHeader."COL Custom Field" = '' then
            Error(CustomFieldEmptyErr);
    end;
}
```

**Another Example:**
```al
codeunit 70001 "COL Item Event Subscribers"
{
    // Event subscriber method - starts with "Run"
    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'Unit Price', false, false)]
    local procedure RunOnAfterValidateUnitPrice(var Rec: Record Item)
    begin
        // Call descriptive local procedure
        UpdateRelatedPricesAfterValidation(Rec);
    end;

    // Local procedure - descriptive name for what it does
    local procedure UpdateRelatedPricesAfterValidation(var Item: Record Item)
    var
        PriceChangedTxt: Label 'Item unit price changed', Locked = true;
        CustomDimensions: Dictionary of [Text, Text];
    begin
        CustomDimensions.Add('ItemNo', Item."No.");
        CustomDimensions.Add('NewPrice', Format(Item."Unit Price"));
        Session.LogMessage('0002', PriceChangedTxt, Verbosity::Normal, DataClassification::SystemMetadata, TelemetryScope::All, CustomDimensions);
        
        // Additional logic
        UpdateRelatedPrices(Item);
    end;
    
    local procedure UpdateRelatedPrices(var Item: Record Item)
    begin
        // Update logic
    end;
}
```

**❌ BAD Example:**
```al
codeunit 70000 "COL Sales Event Subscribers"
{
    // WRONG: Event subscriber method doesn't start with "Run"
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; var IsHandled: Boolean)
    begin
        // WRONG: All logic directly in event subscriber
        // WRONG: Not wrapped in a separate procedure
        // WRONG: Hard to test, hard to reuse
        if SalesHeader."COL Custom Field" = '' then begin
            Message('Custom field cannot be empty.');
            IsHandled := true;
        end;
        
        // ... more logic here (hundreds of lines)
    end;
}
```

**Summary:**
- ✅ Event subscriber method: **MUST start with "Run"** (e.g., `RunOnBeforePostSalesDoc`)
- ✅ Local procedure: **Descriptive name** for what it does (e.g., `ValidateCustomFieldsBeforePosting`)
- ✅ Keep event subscriber method minimal - just call the local procedure
- ✅ Put all business logic in the local procedure for testability and reusability

### Telemetry

Add custom telemetry for critical operations to enable monitoring and troubleshooting.

### DRY Principle (Don't Repeat Yourself)
 
Every piece of knowledge or logic should have a single, unambiguous representation.
 
**Apply DRY when you find:**
- Same calculations/validations in multiple places
- Repeated data transformations
- Magic numbers scattered throughout code
- Similar code structures that could be generalized
 
✅ GOOD - Centralized discount calculation:
```al
codeunit 84050 "Discount Manager"
{
    procedure CalculateDiscount(Amount: Decimal; DiscountPct: Decimal): Decimal
    begin
        if DiscountPct > 0 then
            exit(Amount * DiscountPct / 100);
        exit(0);
    end;
}
```
 
❌ BAD - Duplicated calculation:
```al
// In Sales...
if Customer."Discount %" > 0 then
    SalesLine."Line Discount Amount" := SalesLine.Amount * Customer."Discount %" / 100;
 
// In Purchase... (same logic duplicated)
if Vendor."Discount %" > 0 then
    PurchaseLine."Line Discount Amount" := PurchaseLine.Amount * Vendor."Discount %" / 100;
```
 
**When NOT to force DRY:**
- Coincidental similarity (different business concepts)
- Only 2 uses (over-abstraction can be worse)
- Code that changes for different business reasons

#### Rule: Add Telemetry for Critical Operations

Use the System Application telemetry module for logging important events and operations:

- **Critical business operations** (posting, data synchronization, external integrations)
- **Error conditions** and exceptions
- **Performance-sensitive operations**
- **User actions** that affect system state

#### Implementation Guidelines

1. **Use System Telemetry Module** - `Session.LogMessage()`
2. **Add Telemetry Logger Codeunit** - For complex telemetry needs, create a dedicated logger codeunit
3. **Use Locked Labels** - All telemetry messages must use `Locked = true`
4. **Include Context** - Add relevant context using custom dimensions

**✅ GOOD Example with System Module:**
```al
procedure ProcessCriticalOperation(var SalesHeader: Record "Sales Header")
var
    OperationStartedTxt: Label 'Critical operation started', Locked = true;
    OperationCompletedTxt: Label 'Critical operation completed successfully', Locked = true;
    OperationFailedTxt: Label 'Critical operation failed', Locked = true;
    CustomDimensions: Dictionary of [Text, Text];
begin
    // Log operation start
    CustomDimensions.Add('DocumentNo', SalesHeader."No.");
    CustomDimensions.Add('DocumentType', Format(SalesHeader."Document Type"));
    Session.LogMessage('0001', OperationStartedTxt, Verbosity::Normal, DataClassification::SystemMetadata, TelemetryScope::All, CustomDimensions);
    
    if TryProcessOperation(SalesHeader) then begin
        Session.LogMessage('0002', OperationCompletedTxt, Verbosity::Normal, DataClassification::SystemMetadata, TelemetryScope::All, CustomDimensions);
    end else begin
        CustomDimensions.Add('ErrorText', GetLastErrorText());
        Session.LogMessage('0003', OperationFailedTxt, Verbosity::Error, DataClassification::SystemMetadata, TelemetryScope::All, CustomDimensions);
    end;
end;

[TryFunction]
local procedure TryProcessOperation(var SalesHeader: Record "Sales Header")
begin
    // Critical operation logic
end;
```

**✅ GOOD Example with Telemetry Logger Codeunit:**
```al
codeunit 70001 "COL Telemetry Logger"
{
    procedure LogSalesDocumentPosting(DocumentNo: Code[20]; DocumentType: Enum "Sales Document Type"; Success: Boolean; ErrorText: Text)
    var
        PostingStartedTxt: Label 'Sales document posting started', Locked = true;
        PostingCompletedTxt: Label 'Sales document posting completed', Locked = true;
        PostingFailedTxt: Label 'Sales document posting failed', Locked = true;
        CustomDimensions: Dictionary of [Text, Text];
    begin
        CustomDimensions.Add('DocumentNo', DocumentNo);
        CustomDimensions.Add('DocumentType', Format(DocumentType));
        
        if Success then
            Session.LogMessage('0010', PostingCompletedTxt, Verbosity::Normal, DataClassification::SystemMetadata, TelemetryScope::All, CustomDimensions)
        else begin
            CustomDimensions.Add('ErrorText', ErrorText);
            Session.LogMessage('0011', PostingFailedTxt, Verbosity::Error, DataClassification::SystemMetadata, TelemetryScope::All, CustomDimensions);
        end;
    end;
    
    procedure LogAPICall(Endpoint: Text; Success: Boolean; ResponseTime: Duration)
    var
        APICallTxt: Label 'External API call executed', Locked = true;
        CustomDimensions: Dictionary of [Text, Text];
    begin
        CustomDimensions.Add('Endpoint', Endpoint);
        CustomDimensions.Add('Success', Format(Success));
        CustomDimensions.Add('ResponseTimeMs', Format(ResponseTime));
        
        Session.LogMessage('0020', APICallTxt, Verbosity::Normal, DataClassification::SystemMetadata, TelemetryScope::All, CustomDimensions);
    end;
}
```

**❌ BAD Example:**
```al
procedure ProcessCriticalOperation(var SalesHeader: Record "Sales Header")
begin
    // WRONG: No telemetry for critical operation
    // WRONG: No logging of errors or success
    ProcessOperation(SalesHeader);
end;

procedure ProcessWithBadTelemetry(var SalesHeader: Record "Sales Header")
begin
    // WRONG: Using unlocked label
    Session.LogMessage('0001', 'Operation started', Verbosity::Normal, DataClassification::SystemMetadata);
    
    // WRONG: Not using try function, no error logging
    ProcessOperation(SalesHeader);
end;
```

---

## 8. Error Handling

### TryFunctions for Error Handling

Implement proper error handling using **TryFunctions** to manage exceptions gracefully.

#### When to Use TryFunctions

- External service calls
- Data operations that might fail
- Provide meaningful error messages to users
- Log errors appropriately for debugging

#### Implementation Rules

- Use TryFunction for error handling
- Implement proper exception handling
- Provide meaningful error messages
- Before using try function, analyze the code to check if it doesn't write to database
- **NEVER use hardcoded strings** - Always use labels for all messages and errors
- Add `Comment` attribute to labels with placeholders explaining each placeholder
- Add `Locked = true` to labels that should not be translated (telemetry, technical messages)
- Log errors with telemetry using locked labels

**✅ GOOD Example:**
```al
procedure ProcessPayment(Amount: Decimal): Boolean
var
  PaymentService: Codeunit "Payment Service";
  ErrorText: Text;
  PaymentProcessingFailedLbl: Label 'Payment processing failed: %1', Comment = '%1 = Error message';
  PaymentProcessingFailedTelemetryLbl: Label 'Payment processing failed', Locked = true;
begin
  if not TryProcessPaymentInternal(Amount) then begin
    ErrorText := GetLastErrorText();
    LogError(PaymentProcessingFailedTelemetryLbl, ErrorText);
    Message(PaymentProcessingFailedLbl, ErrorText);
    exit(false);
  end;
  
  exit(true);
end;

[TryFunction]
local procedure TryProcessPaymentInternal(Amount: Decimal)
var
  PaymentService: Codeunit "Payment Service";
begin
  PaymentService.ProcessPayment(Amount);
end;
```

**❌ BAD Example:**
```al
procedure ProcessPayment(Amount: Decimal)
var
  PaymentService: Codeunit "Payment Service";
begin
  // No error handling - will cause unhandled exceptions
  // Also avoid hardcoded messages
  PaymentService.ProcessPayment(Amount);
end;
```

### Labels for Messages and Errors

#### Rule: Never Use Hardcoded Messages

**All errors and messages MUST use labels** - never hardcode text strings directly in Error(), Message(), or StrSubstNo() calls.

#### Label Requirements

1. **Use Labels for all user-facing text**
   - Error messages
   - Information messages
   - Confirmation dialogs
   - Any text displayed to users

2. **Placeholders require Comments**
   - If label contains placeholders (%1, %2, etc.), add `Comment` attribute
   - Comment must explain what each placeholder represents
   - Format: `Comment = '%1 = description, %2 = description'`

3. **Non-translatable text requires Locked**
   - Use `Locked = true` for text that should NOT be translated
   - Typical cases: Telemetry labels, technical identifiers, API keys
   - System/technical messages that must remain in English

**✅ GOOD Examples:**

```al
procedure ValidateAmount(Amount: Decimal; MaxAmount: Decimal)
var
    AmountExceedsMaxLbl: Label 'Amount %1 exceeds maximum allowed %2.', Comment = '%1 = Current Amount, %2 = Maximum Amount';
    InvalidAmountLbl: Label 'Amount cannot be negative.';
    AmountValidationFailedTxt: Label 'Amount validation failed', Locked = true;
begin
    if Amount < 0 then
        Error(InvalidAmountLbl);
        
    if Amount > MaxAmount then begin
        Session.LogMessage('0001', AmountValidationFailedTxt, Verbosity::Warning, DataClassification::SystemMetadata);
        Error(AmountExceedsMaxLbl, Amount, MaxAmount);
    end;
end;

procedure ConfirmDeletion(RecordName: Text): Boolean
var
    ConfirmDeleteQst: Label 'Are you sure you want to delete %1?', Comment = '%1 = Record Name';
begin
    exit(Confirm(ConfirmDeleteQst, false, RecordName));
end;

procedure LogTelemetry(EventName: Text)
var
    TelemetryEventTxt: Label 'Custom Event Triggered', Locked = true;
begin
    Session.LogMessage('0002', TelemetryEventTxt, Verbosity::Normal, DataClassification::SystemMetadata);
end;
```

**❌ BAD Examples:**

```al
procedure ValidateAmount(Amount: Decimal; MaxAmount: Decimal)
begin
    // WRONG: Hardcoded error message
    if Amount < 0 then
        Error('Amount cannot be negative.');
        
    // WRONG: No comment explaining placeholders
    if Amount > MaxAmount then
        Error('Amount %1 exceeds maximum allowed %2.', Amount, MaxAmount);
end;

procedure ConfirmDeletion(RecordName: Text): Boolean
begin
    // WRONG: Hardcoded message in Confirm
    exit(Confirm('Are you sure you want to delete %1?', false, RecordName));
end;

procedure LogTelemetry(EventName: Text)
begin
    // WRONG: Telemetry label without Locked = true
    Session.LogMessage('0002', 'Custom Event Triggered', Verbosity::Normal, DataClassification::SystemMetadata);
end;
```

#### Label Naming Convention

- End label variable names with appropriate suffix:
  - `Lbl` - For messages and errors that will be translated
  - `Txt` - For technical/locked messages (use with `Locked = true`)
  - `Qst` - For questions/confirmations
  - `Msg` - For information messages

**Examples:**
- `AmountExceedsMaxLbl` - Translatable error
- `InvalidAmountLbl` - Translatable error
- `ConfirmDeleteQst` - Translatable question
- `SuccessfullyPostedMsg` - Translatable message
- `TelemetryEventTxt` - Non-translatable technical text

---

## 9. Data Upgrade Rules

### 1. Core Principles

#### OnUpgrade Trigger Structure

**MUST:**
- Only contain method calls (no direct implementation)
- Keep logic simple and focused
- Use event subscribers for upgrade tag registration

**✅ CORRECT Example:**
```al
trigger OnUpgradePerDatabase()
begin
    UpgradeMyNewFeature();
end;

local procedure UpgradeMyNewFeature()
var
    UpgradeTag: Codeunit "Upgrade Tag";
    UpgradeTagDefinitions: Codeunit "Upgrade Tag Definitions";
begin
    if UpgradeTag.HasUpgradeTag(UpgradeTagDefinitions.GetMyNewFeatureTag()) then
        exit;

    // Upgrade implementation here
    
    UpgradeTag.SetUpgradeTag(UpgradeTagDefinitions.GetMyNewFeatureTag());
end;
```

**❌ WRONG Example:**
```al
trigger OnUpgradePerDatabase()
var
    Customer: Record Customer;
begin
    // Direct implementation in trigger - WRONG!
    if Customer.FindSet() then
        repeat
            // processing
        until Customer.Next() = 0;
end;
```

---

### 2. Upgrade Tags (Not Version Checks)

**MUST use Upgrade Tags** instead of version checking.

**✅ CORRECT:**
```al
if UpgradeTag.HasUpgradeTag(UpgradeTagDefinitions.GetMyFeatureUpgradeTag()) then
    exit;

// Upgrade logic

UpgradeTag.SetUpgradeTag(UpgradeTagDefinitions.GetMyFeatureUpgradeTag());
```

**❌ WRONG:**
```al
if NavAppInfo.GetCurrentVersion() < Version.Create('22.0.0.0') then begin
    // Upgrade logic - WRONG!
end;
```

---

### 3. Database Operations Protection

**MUST protect all database read operations** with IF-THEN checks.
If record is modified then use FindSet(True)

**✅ CORRECT:**
```al
if Customer.FindSet() then
    repeat
        // Safe processing
    until Customer.Next() = 0;

if not Item.Get(ItemNo) then
    exit;
```

**❌ WRONG:**
```al
Customer.FindSet();  // Unprotected - will error if no records exist!
repeat
    // processing
until Customer.Next() = 0;
```

---

### 4. Avoid OnValidate and OnCheckPreconditions

**AVOID using OnValidate triggers** unless absolutely necessary.

**Rationale:**
- Validation can fail and block upgrades
- Business logic can change between versions
- Performance impact

**Only use when:**
- Explicitly required by design
- Well-documented reason exists
- No alternative approach available

**AVOID OnCheckPreconditions** unless:
- Checking data integrity critical to upgrade success
- Must be documented why it's needed

---

### 5. Avoid External Calls During Upgrade

**MUST NOT call:**
- HTTP requests or web services
- DotNet interop method calls
- Any external system communication

**Rationale:**
- Can fail and block upgrade process
- If they succeed and upgrade fails, rollback may be impossible

---

### 6. Execution Context Awareness

Use `ExecutionContext` to skip code during upgrade when appropriate.

**✅ CORRECT:**
```al
// Don't add report selection entries during upgrade
if GetExecutionContext() = ExecutionContext::Upgrade then
    exit;
```

**Requirements:**
- MUST include comment explaining why code is skipped
- Use sparingly and with clear justification

---

### 7. DataTransfer Usage for Performance

#### When to Use DataTransfer

**MUST use DataTransfer when:**
- Table can contain more than **300,000 records**
- Adding new fields to existing tables
- Adding new tables that need data initialization

**MUST use ONLY for:**
- New fields and tables added in the same PR
- Initializing newly added data structures

**IMPORTANT:**
- If no new fields/tables exist, add comment that validation triggers and event subscribers will not be raised
- If new field is added with `InitValue`, DataTransfer is strongly recommended for fast upgrade

#### DataTransfer vs Loop/Modify

**❌ BAD - Loop/Modify (Avoid for Large Data):**
```al
local procedure UpdatePriceSourceGroupInPriceListLines()
var
    PriceListLine: Record "Price List Line";
    UpgradeTag: Codeunit "Upgrade Tag";
    UpgradeTagDefinitions: Codeunit "Upgrade Tag Definitions";
begin
    if UpgradeTag.HasUpgradeTag(UpgradeTagDefinitions.GetPriceSourceGroupUpgradeTag()) then
        exit;

    PriceListLine.SetRange("Source Group", "Price Source Group"::All);
    if PriceListLine.FindSet(true) then
        repeat
            if PriceListLine."Source Type" in
                ["Price Source Type"::"All Jobs",
                "Price Source Type"::Job,
                "Price Source Type"::"Job Task"]
            then
                PriceListLine."Source Group" := "Price Source Group"::Job
            else
                case PriceListLine."Price Type" of
                    "Price Type"::Purchase:
                        PriceListLine."Source Group" := "Price Source Group"::Vendor;
                    "Price Type"::Sale:
                        PriceListLine."Source Group" := "Price Source Group"::Customer;
                end;
            if PriceListLine."Source Group" <> "Price Source Group"::All then
                PriceListLine.Modify();
        until PriceListLine.Next() = 0;

    UpgradeTag.SetUpgradeTag(UpgradeTagDefinitions.GetPriceSourceGroupFixedUpgradeTag());
end;
```

**✅ GOOD - DataTransfer (Use for Large Data):**
```al
local procedure UpdatePriceSourceGroupInPriceListLines()
var
    PriceListLine: Record "Price List Line";
    UpgradeTag: Codeunit "Upgrade Tag";
    UpgradeTagDefinitions: Codeunit "Upgrade Tag Definitions";
    PriceListLineDataTransfer: DataTransfer;
begin
    if UpgradeTag.HasUpgradeTag(UpgradeTagDefinitions.GetPriceSourceGroupUpgradeTag()) then
        exit;

    // Update Job-related records
    PriceListLineDataTransfer.SetTables(Database::"Price List Line", Database::"Price List Line");
    PriceListLineDataTransfer.AddSourceFilter(PriceListLine.FieldNo("Source Group"), '=%1', "Price Source Group"::All);
    PriceListLineDataTransfer.AddSourceFilter(PriceListLine.FieldNo("Source Type"), '%1|%2|%3', 
        "Price Source Type"::"All Jobs", "Price Source Type"::Job, "Price Source Type"::"Job Task");
    PriceListLineDataTransfer.AddConstantValue("Price Source Group"::Job, PriceListLine.FieldNo("Source Group"));
    PriceListLineDataTransfer.CopyFields();
    Clear(PriceListLineDataTransfer);

    // Update Vendor-related records
    PriceListLineDataTransfer.SetTables(Database::"Price List Line", Database::"Price List Line");
    PriceListLineDataTransfer.AddSourceFilter(PriceListLine.FieldNo("Source Group"), '=%1', "Price Source Group"::All);
    PriceListLineDataTransfer.AddSourceFilter(PriceListLine.FieldNo("Source Type"), '<>%1&<>%2&<>%3', 
        "Price Source Type"::"All Jobs", "Price Source Type"::Job, "Price Source Type"::"Job Task");
    PriceListLineDataTransfer.AddSourceFilter(PriceListLine.FieldNo("Price Type"), '=%1', "Price Type"::Purchase);
    PriceListLineDataTransfer.AddConstantValue("Price Source Group"::Vendor, PriceListLine.FieldNo("Source Group"));
    PriceListLineDataTransfer.CopyFields();
    Clear(PriceListLineDataTransfer);

    // Update Customer-related records
    PriceListLineDataTransfer.SetTables(Database::"Price List Line", Database::"Price List Line");
    PriceListLineDataTransfer.AddSourceFilter(PriceListLine.FieldNo("Source Group"), '=%1', "Price Source Group"::All);
    PriceListLineDataTransfer.AddSourceFilter(PriceListLine.FieldNo("Source Type"), '<>%1&<>%2&<>%3', 
        "Price Source Type"::"All Jobs", "Price Source Type"::Job, "Price Source Type"::"Job Task");
    PriceListLineDataTransfer.AddSourceFilter(PriceListLine.FieldNo("Price Type"), '=%1', "Price Type"::Sale);
    PriceListLineDataTransfer.AddConstantValue("Price Source Group"::Customer, PriceListLine.FieldNo("Source Group"));
    PriceListLineDataTransfer.CopyFields();

    UpgradeTag.SetUpgradeTag(UpgradeTagDefinitions.GetPriceSourceGroupFixedUpgradeTag());
end;
```

---

### 8. InitValue and Upgrade Code Connection

#### Rule: New Fields with InitValue Need Upgrade Code

When a field is added with `InitValue`:
- InitValue applies **ONLY to new records**
- Existing records get datatype default (0 for numbers, false for Boolean)
- Code reviewer **MUST ask if upgrade code is needed** for each field

**Example Field Addition:**
```al
field(100; "New Field"; Boolean)
{
    DataClassification = CustomerContent;
    Caption = 'New Field';
    InitValue = true;
}

field(101; "New Field 2"; Integer)
{
    DataClassification = CustomerContent;
    Caption = 'New Field 2';
    InitValue = 5;
}
```

**Required Upgrade Code:**
```al
local procedure UpgradeMyTables()
var
    BlankMyTable: Record "My Table";
    UpgradeTag: Codeunit "Upgrade Tag";
    UpgradeTagDefinitions: Codeunit "Upgrade Tag Definitions";
    MyTableDataTransfer: DataTransfer;
begin
    if UpgradeTag.HasUpgradeTag(UpgradeTagDefinitions.GetUpgradeMyTablesTag()) then
        exit;

    MyTableDataTransfer.SetTables(Database::"My Table", Database::"My Table");
    MyTableDataTransfer.AddConstantValue(true, BlankMyTable.FieldNo("New Field"));
    MyTableDataTransfer.AddConstantValue(5, BlankMyTable.FieldNo("New Field 2"));    
    MyTableDataTransfer.CopyFields();

    UpgradeTag.SetUpgradeTag(UpgradeTagDefinitions.GetUpgradeMyTablesTag());
end;
```

---

### 9. Review Checklist

When reviewing upgrade code, verify:

- ✅ No direct code in OnUpgrade triggers (only method calls)
- ✅ No OnValidate or OnCheckPreconditions triggers without justification
- ✅ All database read operations are protected with IF-THEN
- ✅ Upgrade tags used instead of version checks
- ✅ No external calls (HTTP, DotNet interop)
- ✅ DataTransfer used for tables > 300k records
- ✅ DataTransfer only used for new fields/tables
- ✅ InitValue fields have corresponding upgrade code (each new field **MUST** be verified)
- ✅ Proper error handling (minimal blocking)
- ✅ Upgrade tags properly registered with event subscribers

---

### 10. Common Anti-Patterns to Flag

- ❌ Version checking instead of upgrade tags
- ❌ Direct database operations without IF protection
- ❌ Loop/Modify pattern on large datasets
- ❌ Missing upgrade code for InitValue fields
- ❌ External service calls during upgrade
- ❌ Complex nested upgrade tag logic
- ❌ Direct implementation in OnUpgrade triggers

---

## Summary

These guidelines ensure:
- **Consistent code structure** across AL projects
- **Better maintainability** and readability
- **Optimized performance** using standard patterns
- **Reliable upgrade processes** with proper data handling
- **AI-assistant friendly** code that's easier to analyze and extend

Always follow these conventions to maintain high-quality Business Central extensions.
