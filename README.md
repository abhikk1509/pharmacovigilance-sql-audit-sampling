# pharmacovigilance-sql-audit-sampling
Advanced SQL project: stratified random sampling of pharmacovigilance cases for audits and retrospective analysis

<img width="1536" height="1024" alt="Copilot_20260606_221359" src="https://github.com/user-attachments/assets/383435ce-ade2-4e17-aa10-9acb0f2a7edd" />

# 🎲 Random Sampling of Cases by Report Type for Pharmacovigilance Audit & Retrospective Analysis

## 📖 Project Overview
This project demonstrates how to perform **stratified random sampling of pharmacovigilance cases from the database** across different report types (Clinical Trial, Spontaneous, Post-Marketing) with **configurable sample sizes**.  
It is designed for **audit reviews, retrospective analysis, and QA validation** — ensuring reproducibility, compliance, and efficiency in drug safety workflows.

---

## 🛠️ Features
- ✅ Audit‑ready schema with constraints, defaults, and metadata  
- 🎲 Reproducible random sampling using `DBMS_RANDOM.SEED`  
- 📊 Stratified sampling with different percentages per report type  
- 🔄 MERGE logic for upsert (update existing, insert new)  
- 📝 Audit trail with sampling round, review status, and comments  
- 📈 Validation query to summarize sampling outcomes  

---

## 🧩 Source Table: AUDIT_CASE_POOL
All sampling operations originate from the `AUDIT_CASE_POOL` table, which stores the complete pool of cases available for audit.  
Each record represents a pharmacovigilance case with attributes like case_id, case number, report type, product_name, receipt_date and country_code
The random sampling logic uses this table to:
- Generate random values per case  
- Rank cases within each report type  
- Select stratified samples based on predefined percentages  
- Merge selected cases into the `AUDIT_SAMPLE_RESULT` table for audit tracking  

---

## 📂 Project Structure
/sql-scripts
├── 00_create_audit_case_pool.sql
├── 01_create_audit_table.sql
├── 02_random_sampling_merge.sql
├── 03_validation_query.sql
/docs
├── project_overview.md
├── use_cases.md
README.md
LICENSE

---

# 📌 Use Cases
- **Retrospective case review***
- **Audit review sampling** for compliance checks  
- **QA validation** of case pools  
---

# 🧰 Technologies Used
- Oracle SQL  
- Window functions (`ROW_NUMBER()`)  
- Randomization (`DBMS_RANDOM`)  
- Conditional logic (`CASE`, `CEIL`)  
- MERGE for upsert operations  

---

# 📈 Example Output
| Review Status | Sampling Round | Count |
|---------------|----------------|-------|
| NEW           | 2              | 120   |
| EXISTING      | 2              | 45    |

---

# 🎯 Why This Project Matters
Pharmacovigilance and QA teams often need **representative samples of cases** for audits and retrospective reviews.  
This project shows how SQL can enforce:
- **Reproducibility** → same random sample when seeded  
- **Auditability** → metadata for tracking rounds and statuses  
- **Compliance** → stratified sampling ensures fair coverage across report types  

---
## 🤝 Connect & Collaborate
This portfolio project connects **pharmacovigilance** with its **technical side using Oracle SQL**, showcasing the SQL skills essential for **data analysis and retrospective review**.  
If you have any questions, feedback, or are interested in collaborating, feel free to reach out.

**LinkedIn:** [linkedin.com/in/abhik-kar-397b09130](https://linkedin.com/in/abhik-kar-397b09130)  
**Email:** abhik666.ak@gmail.com



