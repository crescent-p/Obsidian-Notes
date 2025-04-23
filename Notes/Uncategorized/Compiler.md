
# Checking if LL(1)
## **Summary Table**

|Condition|Requirement|
|---|---|
|**No Left Recursion**|Eliminate rules like `A → Aα`|
|**Left-Factored**|No common prefixes in productions|
|**FIRST Sets Disjoint**|`FIRST(α) ∩ FIRST(β) = ∅` for all `A → α \| β`|
|**FOLLOW Compatibility**|If `α ⇒* ε`, `FIRST(β) ∩ FOLLOW(A) = ∅`|
## How to compute FOLLOW()

To compute **FOLLOW sets** for a non-terminal in a context-free grammar, follow these rules systematically:

---

### **Steps to Compute FOLLOW Sets**

1. **Initialize FOLLOW for the Start Symbol**  
   - Add `$` (end-of-input marker) to `FOLLOW(S)`, where `S` is the start symbol.

2. **Iterate Through All Productions**  
   For each production `A → αBβ`, where `B` is a non-terminal and `α`, `β` are strings of grammar symbols:
   - **Case 1 (β is not ε):**  
     Add `FIRST(β) - {ε}` to `FOLLOW(B)`.
   - **Case 2 (β is ε or β ⇒* ε):**  
     Add `FOLLOW(A)` to `FOLLOW(B)`.

3. **Repeat Until No Changes**  
   Reapply the rules until no new elements are added to any `FOLLOW` set.

### **Rules in Detail**

| Scenario                                | Action                                                                 |
|-----------------------------------------|-----------------------------------------------------------------------|
| **A → αBβ** (β ≠ ε)                     | Add `FIRST(β) - {ε}` to `FOLLOW(B)`.                                |
| **A → αB** or **A → αBβ** (β ⇒* ε)      | Add `FOLLOW(A)` to `FOLLOW(B)`.                                      |
| **A → αBC** (C is a non-terminal)       | Add `FIRST(C) - {ε}` to `FOLLOW(B)`. If `C ⇒* ε`, add `FOLLOW(A)` to `FOLLOW(B)`. |

### **Example**

**Grammar:**  
```
E → TE'  
E' → +TE' | ε  
T → FT'  
T' → *FT' | ε  
F → (E) | id  
```

**FOLLOW Sets Computation:**

1. **Initialize:**  
   - `FOLLOW(E) = { $, ) }` (from `F → (E)` and start symbol rule).

2. **Apply Rules:**  
   - **For `E → TE'`:**  
     - `E'` follows `T` → Add `FIRST(E') = {+, ε}` to `FOLLOW(T)`.  
     - Since `E' ⇒* ε`, add `FOLLOW(E)` to `FOLLOW(T)`.  
     - `FOLLOW(T) = {+, ), $}`.

   - **For `T → FT'`:**  
     - `T'` follows `F` → Add `FIRST(T') = {*, ε}` to `FOLLOW(F)`.  
     - Since `T' ⇒* ε`, add `FOLLOW(T)` to `FOLLOW(F)`.  
     - `FOLLOW(F) = {*, +, ), $}`.

   - **For `E' → +TE'`:**  
     - `T` follows `+` → Add `FIRST(T) = {(, id}` to `FOLLOW(+)` (not relevant here).  

3. **Final FOLLOW Sets:**  
   ```
   FOLLOW(E)  = { ), $ }
   FOLLOW(E') = { ), $ }
   FOLLOW(T)  = { +, ), $ }
   FOLLOW(T') = { +, ), $ }
   FOLLOW(F)  = { *, +, ), $ }
   ```

### **Key Points**

- **Fixed-Point Algorithm:** Reapply rules until no changes occur.  
- **ε Productions:** If a non-terminal derives ε, propagate `FOLLOW` sets.  
- **Overlap Handling:** Ensure no conflicts in parsing tables (critical for LL(1) grammars).  



![[Pasted image 20250420154338.png]]