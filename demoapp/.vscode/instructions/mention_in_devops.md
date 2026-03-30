## How to Properly Mention Someone in Azure DevOps Work Item Comments

When adding a comment that mentions a user in Azure DevOps, you must use the proper HTML format for the mention to work correctly and trigger notifications.

### Step-by-Step Process:

1. **Get the user's ID first:**
   ```
   Use: weibel-devops:core_get_identity_ids
   Parameter: searchFilter = user's email or display name
   ```
   This will return the user's unique ID (e.g., `6ef6cfde-3478-6b0c-b644-a6c584b2c5c1`)

2. **Format the comment with proper HTML mention structure:**
   ```html
   <div><a href="#" data-vss-mention="version:2.0,{userId}">@{DisplayName}</a> your comment text here</div>
   ```
   
   **Important elements:**
   - Wrap everything in `<div>` tags
   - Use `<a href="#" data-vss-mention="version:2.0,{userId}">@{DisplayName}</a>` for the mention
   - Replace `{userId}` with the actual user ID from step 1
   - Replace `{DisplayName}` with the user's display name
   - Add your comment text after the closing `</a>` tag

3. **Add the comment:**
   ```
   Use: weibel-devops:wit_add_work_item_comment
   Parameters:
   - comment: the formatted HTML from step 2
   - format: "html"
   - project: project name
   - workItemId: work item ID
   ```

### Example:
For Emil Gade Nielsen (ID: `b8d2dd2e-c87a-49e3-b0f2-0d30e00c1217`):
```html
<div><a href="#" data-vss-mention="version:2.0,b8d2dd2e-c87a-49e3-b0f2-0d30e00c1217">@Emil Gade Nielsen</a> that table has been moved from NAV, but it's not used in BC</div>
```

### Common User IDs:
- Emil Gade Nielsen: `b8d2dd2e-c87a-49e3-b0f2-0d30e00c1217`
- Krzysztof Pospiech: `6ef6cfde-3478-6b0c-b644-a6c584b2c5c1`

**WARNING:** Do NOT use plain text like `@Username` - it will not work as a proper mention and won't trigger notifications!

---
