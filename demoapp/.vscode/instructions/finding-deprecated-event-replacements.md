# Finding Replacement Events for Deprecated AL Code

## Problem
When subscribing to deprecated events (marked with `[Obsolete]`), you need to find the replacement event to migrate your code before the deprecated event is removed.

## Solution: Use AL Preview/Decompiled Source

The **AL Language extension** in VS Code can decompile .app packages and show the full source code, including `[Obsolete]` attribute messages that tell you exactly what the replacement is.

### Steps

1. **Open the object definition** using one of these methods:
   - `F12` (Go to Definition) on any reference to the object
   - `Ctrl+Click` on the object name
   - Use Command Palette: `AL: Go to Definition`

2. **Look at the deprecated member** - the `[Obsolete]` attribute contains the replacement info:
   ```al
   #if not CLEAN27
       [Obsolete('Replaced by event OnBeforeRefreshPage', '27.0')]
       [IntegrationEvent(false, false)]
       local procedure OnBeforeGenerateBOMTree(...)
       begin
       end;
   #endif
   ```

3. **Find the new event** in the same file - it will typically be nearby, outside the `#if not CLEAN27` block:
   ```al
   [IntegrationEvent(false, false)]
   local procedure OnBeforeRefreshPage(...)
   begin
   end;
   ```

4. **Compare signatures** - the new event often has a different signature (e.g., using `Variant` instead of specific record types, or `Enum` instead of `Integer`)

## Why This Works Better Than Symbol Tools

| Method | Shows Obsolete Messages | Shows Local Procedures | Shows Events |
|--------|------------------------|----------------------|--------------|
| AL Symbol tools (MCP) | ❌ No | ❌ No | ❌ No |
| GitHub BCApps search | ⚠️ Sometimes | ✅ Yes | ✅ Yes |
| **AL Preview (F12)** | ✅ Yes | ✅ Yes | ✅ Yes |

The compiled .app symbol files don't include:
- Local procedures
- Integration events  
- Obsolete attributes and their messages
- Conditional compilation blocks (`#if not CLEAN27`)

## Example: BOM Structure Page Event Migration

### Before (BC26 and earlier)
```al
#pragma warning disable AL0432
[EventSubscriber(ObjectType::Page, Page::"BOM Structure", OnBeforeGenerateBOMTree, '', false, false)]
#pragma warning restore AL0432
local procedure "BOM Structure_OnBeforeGenerateBOMTree"(
    var BOMBuffer: Record "BOM Buffer"; 
    var Item: Record Item; 
    var AsmHeader: Record "Assembly Header"; 
    var ProdOrderLine: Record "Prod. Order Line"; 
    ShowBy: Integer; 
    ItemFilter: Code[250]; 
    var IsHandled: Boolean)
begin
    if ShowBy <> Enum::"BOM Structure Show By"::"COL SKU".AsInteger() then
        exit;
    // ...
end;
```

### After (BC27+)
```al
[EventSubscriber(ObjectType::Page, Page::"BOM Structure", OnBeforeRefreshPage, '', false, false)]
local procedure "BOM Structure_OnBeforeRefreshPage"(
    var BOMBuffer: Record "BOM Buffer"; 
    var Item: Record Item; 
    var SourceRecordVar: Variant; 
    ShowBy: Enum "BOM Structure Show By"; 
    ItemFilter: Code[250]; 
    var IsHandled: Boolean)
begin
    if ShowBy <> Enum::"BOM Structure Show By"::"COL SKU" then
        exit;
    // ...
end;
```

### Key Changes
- Event name: `OnBeforeGenerateBOMTree` → `OnBeforeRefreshPage`
- Parameters: `AsmHeader` + `ProdOrderLine` → `SourceRecordVar: Variant`
- ShowBy type: `Integer` → `Enum "BOM Structure Show By"`
- No more `.AsInteger()` needed for enum comparison
- Remove `#pragma warning disable/restore AL0432`

## Best GitHub Resource: Stefan Maron's Code History Repository

**[github.com/StefanMaron/MSDyn365BC.Code.History](https://github.com/StefanMaron/MSDyn365BC.Code.History)**

This repository contains the **complete decompiled source code** of the Base Application, organized by branches:
- `w1-27` - BC27 World-Wide version
- `w1-26` - BC26 World-Wide version  
- `de-27` - BC27 German localization
- etc.

**Example:** To find Page 5870 "BOM Structure" in BC27:
```
https://github.com/StefanMaron/MSDyn365BC.Code.History/blob/w1-27/BaseApp/Source/Base%20Application/Inventory/BOM/BOMStructure.Page.al
```

This shows the full source including:
- `[Obsolete]` attributes with replacement messages
- `[IntegrationEvent]` declarations
- `#if not CLEAN27` conditional compilation blocks
- Local procedures that aren't visible in compiled symbols

### GitHub Repositories Comparison

| Repository | Content | Use For |
|------------|---------|---------|
| **StefanMaron/MSDyn365BC.Code.History** | Full Base Application source | ✅ Finding deprecated code and replacements |
| microsoft/BCApps | System Application | System-level code only |
| microsoft/ALAppExtensions | Localizations, add-ons | Country-specific and optional features |

## Tips

1. **Always check the Obsolete message first** - Microsoft usually documents the replacement
2. **The deprecation tag (e.g., '27.0') indicates when it was deprecated**, not when it will be removed
3. **CLEAN tags** (e.g., `#if not CLEAN27`) indicate when the code will be removed (typically 2 versions later)
4. **Update using statements** after migration - you may no longer need some record types
5. **Use Stefan Maron's repo** for browsing Base Application source on GitHub
