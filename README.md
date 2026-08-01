# 💻 Laptop Specification Pipeline: SQL Cleaning, Feature Engineering & EDA

Hey there! 👋 Welcome to my end-to-end SQL data project. 

I built this project using **MySQL Workbench** to take a raw, messy dataset of laptop specifications and turn it into a clean, well-structured database ready for real analysis (or machine learning). 

Instead of dumping everything into one massive file, I broke the pipeline down into **4 clear, sequential SQL scripts**—covering everything from initial schema setup and messy string parsing to missing value imputation and mathematical exploratory data analysis.

---

## 📁 How This Repo is Organized

```text
.
├── data/
│   ├── laptop_raw.csv              # The original, uncleaned CSV file
│   └── laptop_cleaned.csv          # The final, fully transformed output
├── sql/
│   ├── 01_database_setup.sql       # Schema setup, primary keys & quick sanity checks
│   ├── 02_data_cleaning.sql         # String cleaning, type conversions & deduplication
│   ├── 03_feature_engineering.sql   # Imputing missing values, calculating PPI & encoding
│   └── 04_eda.sql                   # Summary stats, Z-scores, correlation & crosstabs
└── README.md
🛠️ How the SQL Pipeline WorksI split the workflow into four distinct steps so it's easy to follow and execute:1️⃣ Database Setup (sql/01_database_setup.sql)Sets up our working database environment (USE workbench;).Checks overall table sizes and row counts.Drops unnecessary index columns from the raw import and adds a clean AUTO_INCREMENT primary key (index).2️⃣ Data Cleaning (sql/02_data_cleaning.sql)Removes duplicates: Drops completely empty records and duplicate hardware rows.Strips text units & fixes types: Removes trailing text units (GB, kg, GHz) from numeric columns and converts them into proper SQL data types (INTEGER, DOUBLE, DECIMAL).Splits messy text columns:Memory ➡️ Broken down into memory_type, primary_storage, and secondary_storageCpu ➡️ Split into cpu_brand, cpu_name, and cpu_speedGpu ➡️ Split into gpu_brand and gpu_nameScreenResolution ➡️ Separated into resolution_width, resolution_height, and a touchscreen boolean flag.Standardizes labels: Cleans up scattered Operating System names into clear categories (Windows, Mac, Linux, Chrome, Android).3️⃣ Feature Engineering & Imputation (sql/03_feature_engineering.sql)Group-Mean Imputation: Rather than dropping rows with missing values, I filled in NULL entries using conditional averages (e.g., imputing missing Price based on the manufacturer's average, or Weight based on screen size).Engineered PPI (Pixels Per Inch): Calculated display density by running pixel height, width, and screen size through the Pythagorean distance formula in SQL:$$\text{PPI} = \frac{\sqrt{\text{width}^2 + \text{height}^2}}{\text{Inches}}$$Categorical One-Hot Encoding: Created binary flag columns (CASE WHEN) for categorical hardware fields to prepare the dataset for predictive machine learning models.4️⃣ Exploratory Data Analysis (sql/04_eda.sql)Univariate Stats & Outliers: Calculated standard averages, variations, and identified price outliers using Z-score window functions ($|Z| > 3$).Terminal Histograms: Built text-based distribution histograms directly inside the MySQL terminal using REPEAT('*', ...).Pearson Correlation in Pure SQL: Wrote raw mathematical SQL queries to compute correlation coefficients ($r$) between hardware specs and price.Contingency Tables: Evaluated multi-category relationships using conditional aggregate sums (SUM(CASE WHEN...)).💡 Key Insights from the DataWhat drives price the most? RAM capacity and CPU clock speed showed the strongest positive correlation with a laptop's price tag.Screen size vs Weight: Unsurprisingly, physical screen size (Inches) has a direct linear relationship with total weight—bigger screen, heavier bag!The Touchscreen Premium: Laptops featuring a touchscreen display carry a noticeable (~20%) price markup across almost every brand category.🚀 Want to Run It Yourself?PrerequisitesMySQL Server or MySQL Workbench installed locally.Step-by-StepClone this repo:Bashgit clone [https://github.com/YOUR_GITHUB_USERNAME/YOUR_REPO_NAME.git](https://github.com/YOUR_GITHUB_USERNAME/YOUR_REPO_NAME.git)
cd YOUR_REPO_NAME
Import the Raw Data:Open MySQL Workbench.Create a database schema called workbench.Import data/laptop_raw.csv into a table named laptopdata.Run the SQL scripts in order:SQLSOURCE sql/01_database_setup.sql;
SOURCE sql/02_data_cleaning.sql;
SOURCE sql/03_feature_engineering.sql;
SOURCE sql/04_eda.sql;
🧰 Tech StackDatabase Engine: MySQLKey SQL Skills: Window Functions (OVER, PARTITION BY), CTEs, String Parsing (SUBSTRING_INDEX, REGEXP), Mathematical Calculations, Data Imputation Logic, DDL/DML.
