# AL Community Guidelines - Vibe Coding Rules

> **Source:** [alguidelines.dev](https://alguidelines.dev/docs/agentic-coding/vibe-coding-rules/)  
> **Created by:** Business Central Community, Microsoft MVPs, and Product Team  
> **Purpose:** AI-optimized coding rules for AL development in Business Central

---

## ⚠️ Priority Notice

**AL_Development_Guidelines.md takes precedence over this document.**

When conflicts arise, follow AL Development Guidelines for:
- **Prefix convention:** Use `COL` prefix (not generic examples)
- **Character limit:** 25 characters for field names (stricter than community's 26)
- **Interface naming:** `COL ICustomerService` (include project prefix)
- **Event subscriber naming:** Must start with `Run` prefix (e.g., `RunOnBeforePostSalesDoc`)
- **API Publisher:** Use `columbus` as default

This document provides supplementary guidance for areas not covered in AL Development Guidelines.

---

## Core Principles

- Follow event-driven programming model; **never modify standard application objects**
- Use clear, meaningful names and maintain consistent code structure
- Prioritize performance optimization and proper error handling
- Focus on main application implementation by default
- Only generate test code when explicitly requested
- Maintain proper AL-Go workspace structure separation

---

## 1. Code Style & Formatting

### 1.1 Indentation and Formatting

- Use **two spaces** for indentation consistently throughout the project
- Use **PascalCase** for variable and function names
- Use **PascalCase** for object names (tables, pages, reports, codeunits)

```al
// ✅ Good example
procedure CalculateDiscount(Amount: Decimal; DiscountPct: Decimal): Decimal
begin
  if DiscountPct > 0 then
    exit(Amount * DiscountPct / 100);
    
  exit(0);
end;
```

### 1.2 Feature-Based Folder Organization

Organize code by **business features**, not by object types:

```
// ✅ Good - Feature-based organization
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

```
// ❌ Bad - Object-type segregation (avoid)
src/
├── Tables/
├── Pages/
└── Codeunits/
```

### 1.3 Code Documentation

Use **XML documentation** for global functions in codeunits:

```al
// ✅ Good - XML documentation for global functions
codeunit 50100 "Base64 Convert"
{
    /// <summary>
    /// Converts the input string to its base-64 encoded representation.
    /// </summary>
    /// <param name="String">The string to convert.</param>
    /// <returns>The base-64 encoded string.</returns>
    procedure ToBase64(String: Text): Text
    begin
        exit(Base64ConvertImpl.ToBase64(String));
    end;
}
```

### 1.4 Modular Code Structure

Write small, focused procedures that do one thing well:

```al
// ✅ Good - Modular approach
procedure PostDocument(var DocumentHeader: Record "Sales Header")
begin
  ValidateDocument(DocumentHeader);
  CalculateTotals(DocumentHeader);
  CreateLedgerEntries(DocumentHeader);
  UpdateStatus(DocumentHeader);
end;

local procedure ValidateDocument(var DocumentHeader: Record "Sales Header")
begin
  if DocumentHeader."No." = '' then
    Error('Document number cannot be empty');
end;
```

---

## 2. Naming Conventions

### 2.1 Object Naming

- Use **PascalCase** for all object names
- Maximum **26 characters** for name (reserve 4 for prefix/affix)
- Use meaningful, descriptive names

```al
// ✅ Good examples (within 26 character limit)
table 50100 "Customer Ledger Entry"     // 20 chars
page 50101 "Sales Invoice"              // 13 chars  
codeunit 50102 "Sales Invoice Posting"  // 21 chars

// ❌ Bad examples
table 50100 "CustLE"                           // Too abbreviated
table 50104 "Very Long Customer Ledger Entry"  // Exceeds limit
```

### 2.2 File Naming

Use pattern: `<ObjectName>.<ObjectType>.al`

```
// ✅ Good examples
NoSeries.Page.al
NoSeries.Table.al
CustomerCard.Page.al
SalesHeader.TableExt.al
INoSeries.Interface.al
NoSeriesImpl.Codeunit.al
NoSeriesTests.Codeunit.al
```

### 2.3 Variable and Function Naming

```al
// ✅ Good - Variables
var
  CustomerLedgerEntry: Record "Cust. Ledger Entry";
  TotalAmount: Decimal;
  DiscountPercentage: Decimal;
  IsValidTransaction: Boolean;

// ✅ Good - Functions
procedure CalculateCustomerBalance(CustomerNo: Code[20]): Decimal
procedure ValidateSalesDocument(var SalesHeader: Record "Sales Header")
procedure UpdateInventoryQuantity(ItemNo: Code[20]; Quantity: Decimal)
```

### 2.4 Event Subscriber Parameters

Use **descriptive parameter names**, avoid generic "Rec":

```al
// ✅ Good - Descriptive parameter names
[EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforeInsert, '', false, false)]
local procedure AddDefaultValuesOnBeforeInsertSalesHeader(var SalesHeader: Record "Sales Header"; RunTrigger: Boolean)
begin
  // Event handling logic
end;
```

### 2.5 Interface and Implementation Naming

- Prefix interfaces with **"I"** (e.g., `ICustomerService`)
- Use **"Impl"** suffix for implementations (e.g., `CustomerServiceImpl`)

---

## 3. Performance Optimization

### 3.1 Early Data Filtering

Apply filters **before** processing records:

```al
// ✅ Good - Early filtering
procedure GetNumberOfCustomersByCity(CityFilter: Text): Integer
var
  Customer: Record Customer;
begin
  Customer.SetRange(City, CityFilter);
  Customer.SetRange(Blocked, Customer.Blocked::" ");
  exit(Customer.Count);
end;

// ❌ Bad - Processing all records then filtering
procedure GetNumberOfCustomersByCity(CityFilter: Text): Integer
var
  Customer: Record Customer;
  Count: Integer;
begin
  if Customer.FindSet() then
    repeat
      if Customer.City = CityFilter then
        Count += 1;
    until Customer.Next() = 0;
  exit(Count);
end;
```

### 3.2 Use SetLoadFields

Place `SetLoadFields` **before** the Get/Find operation:

```al
// ✅ Good - SetLoadFields before filtering
Item.SetRange("Third Party Item Exists", false);
Item.SetLoadFields("Item Category Code");
Item.FindFirst();

// ❌ Bad - SetLoadFields after filtering
Item.SetLoadFields("Item Category Code");
Item.SetRange("Third Party Item Exists", false);
Item.FindFirst();
```

### 3.3 Use Temporary Tables, Dictionaries, and Lists

```al
// ✅ Good - Temporary table for multiple operations
procedure ProcessSalesData(var TempSalesLine: Record "Sales Line" temporary)
begin
  // Load data once, process multiple times without DB hits
  ProcessDiscounts(TempSalesLine);
  CalculateTotals(TempSalesLine);
  ValidateInventory(TempSalesLine);
end;

// ✅ Good - Dictionary for key-value lookups
var
  CustomerCache: Dictionary of [Code[20], Text];
begin
  if Customer.FindSet() then
    repeat
      CustomerCache.Add(Customer."No.", Customer.Name);
    until Customer.Next() = 0;
end;
```

### 3.4 Avoid Unnecessary Loops - Use Set-Based Operations

```al
// ✅ Good - Set-based aggregation
procedure GetTotalSalesAmount(CustomerNo: Code[20]): Decimal
var
  CustLedgerEntry: Record "Cust. Ledger Entry";
begin
  CustLedgerEntry.SetRange("Customer No.", CustomerNo);
  CustLedgerEntry.CalcSums(Amount);
  exit(CustLedgerEntry.Amount);
end;

// ❌ Bad - Manual loop for aggregation
procedure GetTotalSalesAmount(CustomerNo: Code[20]): Decimal
var
  TotalAmount: Decimal;
begin
  CustLedgerEntry.SetRange("Customer No.", CustomerNo);
  if CustLedgerEntry.FindSet() then
    repeat
      TotalAmount += CustLedgerEntry.Amount;
    until CustLedgerEntry.Next() = 0;
  exit(TotalAmount);
end;
```

---

## 4. Error Handling & Troubleshooting

### 4.1 Use TryFunctions

```al
// ✅ Good - TryFunction with proper error handling
procedure ProcessPayment(Amount: Decimal): Boolean
var
  PaymentProcessingFailedLbl: Label 'Payment processing failed: %1', Comment = '%1 = Error message';
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
begin
  PaymentService.ProcessPayment(Amount);
end;
```

### 4.2 Use Error Labels (No Hardcoded Messages)

```al
// ✅ Good - Using error labels
var
  CustomerNotFoundErr: Label 'Customer %1 does not exist for sales document %2.', 
    Comment = '%1 = Customer No., %2 = Sales Header No.';
  CustomerBlockedErr: Label 'Customer %1 is blocked (%2). Cannot process sales document %3.', 
    Comment = '%1 = Customer No., %2 = Blocked reason, %3 = Sales Header No.';
begin
  if not Customer.Get(SalesHeader."Sell-to Customer No.") then
    Error(CustomerNotFoundErr, SalesHeader."Sell-to Customer No.", SalesHeader."No.");
end;

// ❌ Bad - Hardcoded error messages
Error('Customer not found');
```

### 4.3 Custom Telemetry (When Requested)

```al
// ✅ Good - Custom telemetry with proper structure
procedure PostSalesDocument(var SalesHeader: Record "Sales Header")
var
  TelemetryCustomDimensions: Dictionary of [Text, Text];
  SalesDocPostedMsg: Label 'Sales document posted successfully', Locked = true;
begin
  TelemetryCustomDimensions.Add('DocumentType', Format(SalesHeader."Document Type"));
  TelemetryCustomDimensions.Add('CustomerNo', SalesHeader."Sell-to Customer No.");
  
  Session.LogMessage('SAL001', SalesDocPostedMsg, 
    Verbosity::Normal, DataClassification::SystemMetadata,
    TelemetryScope::ExtensionPublisher, TelemetryCustomDimensions);
end;
```

---

## 5. Event-Driven Development

### 5.1 Use Events for Extensibility

**Never modify standard application objects** - use event subscribers:

```al
// ✅ Good - Event subscriber with Handler suffix
codeunit 50100 "Sales Document Events Handler"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", OnBeforeInsert, '', false, false)]
    local procedure OnBeforeInsertSalesHeader(var SalesHeader: Record "Sales Header"; RunTrigger: Boolean)
    begin
        ValidateCustomFields(SalesHeader);        
    end;    
}
```

### 5.2 Add Integration Events for Extensibility

```al
// ✅ Good - Integration events with handled pattern
codeunit 50101 "Customer Management"
{
    procedure CreateCustomer(var Customer: Record Customer): Boolean
    var
        IsHandled: Boolean;
    begin
        OnBeforeCreateCustomer(Customer, IsHandled);
        if IsHandled then
            exit(true);
        
        if not Customer.Insert(true) then
            exit(false);
        
        OnAfterCreateCustomer(Customer);
        exit(true);        
    end;
    
    [IntegrationEvent(false, false)]
    procedure OnBeforeCreateCustomer(var Customer: Record Customer; var IsHandled: Boolean)
    begin
        // Allow extensions to modify customer data before creation
    end;
    
    [IntegrationEvent(false, false)]
    procedure OnAfterCreateCustomer(var Customer: Record Customer)
    begin
        // Allow extensions to perform actions after customer creation
    end;
}
```

---

## 6. Testing & Project Structure

### 6.1 AL-Go Workspace Structure

```
Repository/
├── .AL-Go/
├── .github/
├── App/                    # Application code ONLY
│   ├── src/
│   │   ├── Setup/
│   │   ├── Feature1/
│   │   ├── APIs/
│   ├── app.json
│   └── launch.json
├── Test/                   # Test code ONLY
│   ├── src/
│   │   ├── SetupTests/
│   │   ├── Feature1Tests/
│   │   ├── IntegrationTests/
│   ├── app.json
│   └── launch.json
└── al.code-workspace
```

### 6.2 Test Generation Guidelines

- **DO NOT** automatically generate test code unless explicitly requested
- Focus on main application implementation by default
- Only generate tests when user specifically requests them

### 6.3 Unit Testing Best Practices

- Use **Given/When/Then** structure for test naming
- Use standard library codeunits (`Library - Sales`, `Library - Inventory`, etc.)
- Use `Assert` statements for validating critical conditions

```al
// ✅ Good - Well-structured unit test
[Test]
procedure GivenValidCustomer_WhenCreatingCustomer_ThenCustomerIsCreated()
var
  Customer: Record Customer;
  LibrarySales: Codeunit "Library - Sales";
  Assert: Codeunit Assert;
begin
  // Given - Valid customer data using library
  LibrarySales.CreateCustomer(Customer);
  
  // When - Creating customer
  CustomerNo := CustomerManagement.CreateCustomer(Customer);
  
  // Then - Customer is created successfully
  Assert.IsTrue(Customer.Get(CustomerNo), 'Customer should be created');
end;
```

---

## 7. Upgrade Code Guidelines

### 7.1 Upgrade Codeunit Structure

```al
codeunit [ID] [CodeunitName]
{
    Subtype = Upgrade;
    
    trigger OnUpgradePerCompany()
    begin
        UpgradeMyFeature();
        UpgradeSecondFeature();
    end;

    local procedure UpgradeMyFeature()
    begin
        // Implementation here - NOT in trigger
    end;
}
```

### 7.2 Critical Rules

- **NO direct code in OnUpgrade triggers** - only method calls
- **AVOID** `OnValidateUpgrade` and `OnCheckPreconditions` triggers
- **NO external calls** (HTTP, DotNet interop) during upgrade
- All read operations (Get, Find) **MUST** be protected with `if-then`

### 7.3 Use Upgrade Tags (Not Version Checks)

```al
// ✅ Good - Upgrade tags
local procedure UpgradeMyFeature()
var
  UpgradeTag: Codeunit "Upgrade Tag";
begin
  if UpgradeTag.HasUpgradeTag(MyUpgradeTag()) then
    exit;

  // Your upgrade code here

  UpgradeTag.SetUpgradeTag(MyUpgradeTag());
end;

// ❌ Bad - Version checks
if MyApplication.DataVersion().Major > 14 then 
    exit;
```

### 7.4 Use DataTransfer for Large Tables (>300k records)

```al
// ✅ Good - DataTransfer for large data
MyTableDataTransfer.SetTables(Database::"My Table", Database::"My Table");
MyTableDataTransfer.AddConstantValue(true, BlankMyTable.FieldNo("New Field"));
MyTableDataTransfer.CopyFields();

// ❌ Bad - Loop/Modify for large data
if MyTable.FindSet() then
  repeat
    MyTable."New Field" := true;
    MyTable.Modify();
  until MyTable.Next() = 0;
```

### 7.5 InitValue Fields Need Upgrade Code

When adding fields with `InitValue`, existing records need upgrade code:

```al
field(100; "New Field"; Boolean)
{
    InitValue = true;  // Only applies to NEW records!
}

// Required upgrade code for existing records
MyTableDataTransfer.AddConstantValue(true, BlankMyTable.FieldNo("New Field"));
```

---

## 8. Upgrade Code Review Checklist

- [ ] No direct code in OnUpgrade triggers (only method calls)
- [ ] No OnValidate or OnCheckPreconditions triggers without justification
- [ ] All database read operations protected with IF-THEN
- [ ] Upgrade tags used instead of version checks
- [ ] No external calls (HTTP, DotNet interop)
- [ ] DataTransfer used for tables > 300k records
- [ ] InitValue fields have corresponding upgrade code
- [ ] Proper error handling (minimal blocking)
- [ ] Upgrade tags properly registered with event subscribers

---

## Quick Reference Summary

| Area | Rule |
|------|------|
| **File Naming** | `<ObjectName>.<ObjectType>.al` |
| **Code Style** | 2 spaces indentation, PascalCase |
| **Folder Structure** | Feature-based (`src/feature/subfeature/`) |
| **Performance** | Filter early, use SetLoadFields, temporary tables |
| **Events** | Prefer integration events, use "Handler" suffix |
| **Testing** | Separate App/Test projects, generate only when requested |
| **Error Handling** | TryFunctions, Labels (no hardcoded text), telemetry |
| **Upgrades** | Use upgrade tags, DataTransfer for large data |

---

## Resources

- **GitHub:** [microsoft/alguidelines](https://github.com/microsoft/alguidelines)
- **Website:** [alguidelines.dev](https://alguidelines.dev)
- **Discord:** [discord.gg/4wbfNv3](https://discord.gg/4wbfNv3)
- **Twitter:** [#bcalhelp](https://twitter.com/search?q=%23bcalhelp)
