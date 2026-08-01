💻 Laptop Specification Pipeline: SQL Cleaning, Feature Engineering & EDA

Hey there! 👋 Welcome to my end-to-end SQL data project. I'm Devyam Malhotra, and in this project, I built a complete pipeline to clean, engineer, and analyze laptop specification data using MySQL Workbench.

Instead of dumping everything into one massive file, I structured the workflow into 4 sequential, modular SQL scripts—covering everything from schema initialization and complex string parsing to conditional missing value imputation and exploratory data analysis.

📁 Repository Structure
.
├── data/
│   ├── laptop_raw.csv              # Messy dataset before any changes
│   └── laptop_cleaned.csv          # Clean dataset after fixing missing values and errors
├── sql/
│   ├── 01_database_setup.sql       # Database creation, primary keys, and quick checks
│   ├── 02_data_cleaning.sql         # Fixing column types, cleaning text, and removing duplicates
│   ├── 03_feature_engineering.sql   # Filling missing values, calculating screen density, and encoding
│   └── 04_eda.sql                   # Summary numbers, finding outliers, and analyzing trends
└── README.md

🛠️ How the SQL Pipeline Works
The workflow is broken into four distinct steps so it's easy to run and review:

1️⃣ Database Setup (sql/01_database_setup.sql)
Opens the database (USE workbench;).

Checks the initial row counts and memory usage.

Drops unwanted index columns from the raw CSV import (Unnamed: 0) and adds a unique primary key ID column (index) to organize every row.

2️⃣ Data Cleaning (sql/02_data_cleaning.sql)
Removes duplicates: Deletes completely empty rows and repeated laptop listings.

Strips text units & fixes types: Removes unit labels (GB, kg, GHz) from values so columns can be converted into true numeric SQL types (INTEGER, DOUBLE, DECIMAL) for math calculations.

Splits messy text columns:

Memory ➡️ Broken into memory_type, primary_storage, and secondary_storage

Cpu ➡️ Broken into cpu_brand, cpu_name, and cpu_speed

Gpu ➡️ Broken into gpu_brand and gpu_name

ScreenResolution ➡️ Broken into resolution_width, resolution_height, and a touchscreen boolean flag (1 or 0)

Standardizes names: Unifies inconsistent operating system names into clean categories (Windows, Mac, Linux, Chrome, Android).

3️⃣ Feature Engineering & Imputation (sql/03_feature_engineering.sql)
Fills missing values (Imputation): Replaces missing NULL values using smart group averages (e.g., filling missing Price using the manufacturer's average price, or Weight based on screen size).
Calculates screen sharpness (PPI): Computes Pixels Per Inch (PPI) using display width, height, and screen size math in SQL:$$\text{PPI} = \frac{\sqrt{\text{width}^2 + \text{height}^2}}{\text{Inches}}$$
Categorical Encoding: Creates binary flags (1 or 0 using CASE WHEN) for text columns like gpu_brand so machine learning algorithms can read them.

4️⃣ Exploratory Data Analysis (sql/04_eda.sql)
Calculates summary stats & outliers: Finds basic averages, ranges, and uses Z-scores ($\vert{}Z\vert{} > 3$) to spot extreme price outliers.
Builds text histograms: Draws visual distribution charts directly inside the MySQL console using REPEAT('*', ...).
Measures price drivers (Pearson Correlation): Runs correlation formulas ($r$) in raw SQL to see how strongly specs like RAM or CPU speed impact laptop prices.
Cross-tabulates categories: Uses SUM(CASE WHEN...) tables to compare features across different laptop types and brands.

💡 Key Insights Discovered
1. Primary Price Drivers: RAM capacity , Resolution_width and Resolution_height followed by  CPU clock speed showed the strongest positive Pearson correlation ($r$) with overall price.
2. Premium Features: Laptops equipped with Touchscreen displays command a ~[20-30]% higher average price across identical brand categories.

🚀 How to Run
Prerequisites
-> MySQL Server 8.0+ or MySQL Workbench installed locally.

Step-by-Step Instructions

1. Clone this repository:
Bash
git clone https://github.com/[YOUR_GITHUB_USERNAME]/[YOUR_REPO_NAME].git
cd [YOUR_REPO_NAME]

3. Database Import:
Open MySQL Workbench.
Create a database schema named workbench.
Import data/laptop_raw.csv into a table named laptopdata.

3. Execute the SQL scripts in order:
SQL
SOURCE sql/01_database_setup.sql;
SOURCE sql/02_data_cleaning.sql;
SOURCE sql/03_feature_engineering.sql;
SOURCE sql/04_eda.sql;

🧰 Tech Stack
1. Database Engine: MySQL
2. Key SQL Skills: Window Functions (OVER etc), CTEs, String Parsing (SUBSTRING_INDEX, REGEXP), Mathematical Aggregations, Group Imputation Logic, DDL/DML.
