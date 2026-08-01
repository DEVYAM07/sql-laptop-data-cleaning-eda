-- =============================================================================
-- 04: EXPLORATORY DATA ANALYSIS (EDA)
-- =============================================================================

USE workbench;

-- Head
SELECT * FROM laptopdata 
ORDER BY `Index` LIMIT 5;

-- Tail
SELECT * FROM laptopdata 
ORDER BY `Index` DESC LIMIT 5;

-- Sample
SELECT * FROM laptopdata 
ORDER BY RAND() DESC LIMIT 5;

-- Numerical Columns 

-- Summary Statistics 
SELECT
    COUNT(Price) AS Total_Count,
    MIN(Price) AS Min_Price,
    MAX(Price) AS Max_Price,
    STD(Price) AS Std_Deviation,
    AVG(Price) AS Avg_Price
FROM laptopdata;

-- Missing Values
SELECT * FROM laptopdata
WHERE Price IS NULL ;

-- Outliers 
SELECT *
FROM (
    SELECT *,
           (Price - AVG(Price) OVER()) / STD(Price) OVER() AS z_score
    FROM laptopdata
) t
WHERE ABS(z_score) > 3;

-- Histogram 
SELECT Category ,REPEAT('*',COUNT(*)/5)FROM (
SELECT Price, CASE 
WHEN Price BETWEEN 0 AND 25000 THEN '0-25K'
WHEN Price BETWEEN 25001 AND 50000 THEN '25-50K'
WHEN Price BETWEEN 50001 AND 75000 THEN '50-75K'
WHEN Price BETWEEN 75001 AND 100000 THEN '75-100K'
WHEN Price > 100000 THEN '<100K'
END AS Category  FROM workbench.laptopdata) t
GROUP BY Category ;

-- Summary Statistics
SELECT
    COUNT(Inches) AS Total_Count,
    MIN(Inches) AS Min_Inches,
    MAX(Inches) AS Max_Inches,
    STD(Inches) AS Std_Deviation,
    AVG(Inches) AS Avg_Inches
FROM laptopdata;

-- Missing Values
SELECT * FROM laptopdata
WHERE Inches IS NULL;

-- Outliers 
SELECT *
FROM (
    SELECT *,
           (Inches - AVG(Inches) OVER()) / STD(Inches) OVER() AS z_score
    FROM laptopdata
) t
WHERE ABS(z_score) > 3;

-- Summary Statistics
SELECT
    COUNT(resolution_width) AS Total_Count,
    MIN(resolution_width) AS Min_Width,
    MAX(resolution_width) AS Max_Width,
    STD(resolution_width) AS Std_Deviation,
    AVG(resolution_width) AS Avg_Width
FROM laptopdata;

-- Missing Values
SELECT * FROM laptopdata
WHERE resolution_width IS NULL;

-- Outliers 
SELECT *
FROM (
    SELECT *,
           (resolution_width - AVG(resolution_width) OVER()) / STD(resolution_width) OVER() AS z_score
    FROM laptopdata
) t
WHERE ABS(z_score) > 3;

-- Summary Statistics
SELECT
    COUNT(resolution_height) AS Total_Count,
    MIN(resolution_height) AS Min_Height,
    MAX(resolution_height) AS Max_Height,
    STD(resolution_height) AS Std_Deviation,
    AVG(resolution_height) AS Avg_Height
FROM laptopdata;

-- Missing Values
SELECT * FROM laptopdata
WHERE resolution_height IS NULL;

-- Outliers 
SELECT *
FROM (
    SELECT *,
           (resolution_height - AVG(resolution_height) OVER()) / STD(resolution_height) OVER() AS z_score
    FROM laptopdata
) t
WHERE ABS(z_score) > 3;

-- Summary Statistics
SELECT
    COUNT(cpu_speed) AS Total_Count,
    MIN(cpu_speed) AS Min_CPU_Speed,
    MAX(cpu_speed) AS Max_CPU_Speed,
    STD(cpu_speed) AS Std_Deviation,
    AVG(cpu_speed) AS Avg_CPU_Speed
FROM laptopdata;

-- Missing Values
SELECT * FROM laptopdata
WHERE cpu_speed IS NULL;

-- Outliers 
SELECT *
FROM (
    SELECT *,
           (cpu_speed - AVG(cpu_speed) OVER()) / STD(cpu_speed) OVER() AS z_score
    FROM laptopdata
) t
WHERE ABS(z_score) > 3;

-- Summary Statistics
SELECT
    COUNT(Ram) AS Total_Count,
    MIN(Ram) AS Min_Ram,
    MAX(Ram) AS Max_Ram,
    STD(Ram) AS Std_Deviation,
    AVG(Ram) AS Avg_Ram
FROM laptopdata;

-- Missing Values
SELECT * FROM laptopdata
WHERE Ram IS NULL;

-- Outliers 
SELECT *
FROM (
    SELECT *,
           (Ram - AVG(Ram) OVER()) / STD(Ram) OVER() AS z_score
    FROM laptopdata
) t
WHERE ABS(z_score) > 3;

-- Summary Statistics
SELECT
    COUNT(primary_storage) AS Total_Count,
    MIN(primary_storage) AS Min_Primary_Storage,
    MAX(primary_storage) AS Max_Primary_Storage,
    STD(primary_storage) AS Std_Deviation,
    AVG(primary_storage) AS Avg_Primary_Storage
FROM laptopdata;

-- Missing Values
SELECT * FROM laptopdata
WHERE primary_storage IS NULL;

-- Outliers 
SELECT *
FROM (
    SELECT *,
           (primary_storage - AVG(primary_storage) OVER()) / STD(primary_storage) OVER() AS z_score
    FROM laptopdata
) t
WHERE ABS(z_score) > 3;

-- Summary Statistics
SELECT
    COUNT(secondary_storage) AS Total_Count,
    MIN(secondary_storage) AS Min_Secondary_Storage,
    MAX(secondary_storage) AS Max_Secondary_Storage,
    STD(secondary_storage) AS Std_Deviation,
    AVG(secondary_storage) AS Avg_Secondary_Storage
FROM laptopdata;

-- Missing Values
SELECT * FROM laptopdata
WHERE secondary_storage IS NULL;

-- Outliers 
SELECT *
FROM (
    SELECT *,
           (secondary_storage - AVG(secondary_storage) OVER()) / STD(secondary_storage) OVER() AS z_score
    FROM laptopdata
) t
WHERE ABS(z_score) > 3;

-- Summary Statistics
SELECT
    COUNT(Weight) AS Total_Count,
    MIN(Weight) AS Min_Weight,
    MAX(Weight) AS Max_Weight,
    STD(Weight) AS Std_Deviation,
    AVG(Weight) AS Avg_Weight
FROM laptopdata;

-- Missing Values
SELECT * FROM laptopdata
WHERE Weight IS NULL;

-- Outliers 
SELECT *
FROM (
    SELECT *,
           (Weight - AVG(Weight) OVER()) / STD(Weight) OVER() AS z_score
    FROM laptopdata
) t
WHERE ABS(z_score) > 3;

-- Categorical Columns 

-- Distribution / Frequency Count
SELECT Company,COUNT(*) FROM laptopdata
GROUP BY Company;

-- Missing Values
SELECT * FROM laptopdata
WHERE Company IS NULL ;

-- Distribution / Frequency Count
SELECT TypeName, COUNT(*) FROM laptopdata
GROUP BY TypeName;

-- Missing Values
SELECT * FROM laptopdata
WHERE TypeName IS NULL;

-- Distribution / Frequency Count
SELECT cpu_brand, COUNT(*) FROM laptopdata
GROUP BY cpu_brand;

-- Missing Values
SELECT * FROM laptopdata
WHERE cpu_brand IS NULL;

-- Distribution / Frequency Count
SELECT cpu_name, COUNT(*) FROM laptopdata
GROUP BY cpu_name;

-- Missing Values
SELECT * FROM laptopdata
WHERE cpu_name IS NULL;

-- Distribution / Frequency Count
SELECT memory_type, COUNT(*) FROM laptopdata
GROUP BY memory_type;

-- Missing Values
SELECT * FROM laptopdata
WHERE memory_type IS NULL;

-- Distribution / Frequency Count
SELECT gpu_brand, COUNT(*) FROM laptopdata
GROUP BY gpu_brand;

-- Missing Values
SELECT * FROM laptopdata
WHERE gpu_brand IS NULL;

-- Distribution / Frequency Count
SELECT gpu_name, COUNT(*) FROM laptopdata
GROUP BY gpu_name;

-- Missing Values
SELECT * FROM laptopdata
WHERE gpu_name IS NULL;

-- Distribution / Frequency Count
SELECT OpSys, COUNT(*) FROM laptopdata
GROUP BY OpSys;

-- Missing Values
SELECT * FROM laptopdata
WHERE OpSys IS NULL;

-- Numerical vs Numerical Column 

-- Side By Side Summary Statistics
SELECT
    COUNT(Price) AS Total_Count,
    MIN(Price) AS Min_Price,
    MIN(cpu_speed) AS Min_CPU_Speed,
    MAX(Price) AS Max_Price,
	MAX(cpu_speed) AS Max_CPU_Speed,
    STD(Price) AS Std_Deviation_Price,
    STD(cpu_speed) AS Std_Deviation_Cpu_Speed,
    AVG(Price) AS Avg_Price,
    AVG(cpu_speed) AS Avg_CPU_Speed
FROM laptopdata;

-- Scatter plot
SELECT Price,cpu_speed FROM laptopdata;

-- Correlation
SELECT 
    (AVG(Price * cpu_speed) - AVG(Price) * AVG(cpu_speed)) / 
    (SQRT(AVG(Price * Price) - AVG(Price) * AVG(Price)) * SQRT(AVG(cpu_speed * cpu_speed) - AVG(cpu_speed) * AVG(cpu_speed))) 
    AS correlation_coefficient
FROM laptopdata;

-- Side By Side Summary Statistics
SELECT
    COUNT(Price) AS Total_Count,
    MIN(Price) AS Min_Price,
    MIN(Ram) AS Min_Ram,
    MAX(Price) AS Max_Price,
    MAX(Ram) AS Max_Ram,
    STD(Price) AS Std_Deviation_Price,
    STD(Ram) AS Std_Deviation_Ram,
    AVG(Price) AS Avg_Price,
    AVG(Ram) AS Avg_Ram
FROM laptopdata;

-- Scatter plot
SELECT Price, Ram FROM laptopdata;

-- Correlation
SELECT 
    (AVG(Price * Ram) - AVG(Price) * AVG(Ram)) / 
    (SQRT(AVG(Price * Price) - AVG(Price) * AVG(Price)) * SQRT(AVG(Ram * Ram) - AVG(Ram) * AVG(Ram))) 
    AS correlation_coefficient
FROM laptopdata;

-- Side By Side Summary Statistics
SELECT
    COUNT(Price) AS Total_Count,
    MIN(Price) AS Min_Price,
    MIN(Weight) AS Min_Weight,
    MAX(Price) AS Max_Price,
    MAX(Weight) AS Max_Weight,
    STD(Price) AS Std_Deviation_Price,
    STD(Weight) AS Std_Deviation_Weight,
    AVG(Price) AS Avg_Price,
    AVG(Weight) AS Avg_Weight
FROM laptopdata;

-- Scatter plot
SELECT Price, Weight FROM laptopdata;

-- Correlation
SELECT 
    (AVG(Price * Weight) - AVG(Price) * AVG(Weight)) / 
    (SQRT(AVG(Price * Price) - AVG(Price) * AVG(Price)) * SQRT(AVG(Weight * Weight) - AVG(Weight) * AVG(Weight))) 
    AS correlation_coefficient
FROM laptopdata;

-- Side By Side Summary Statistics
SELECT
    COUNT(Price) AS Total_Count,
    MIN(Price) AS Min_Price,
    MIN(primary_storage) AS Min_Primary_Storage,
    MAX(Price) AS Max_Price,
    MAX(primary_storage) AS Max_Primary_Storage,
    STD(Price) AS Std_Deviation_Price,
    STD(primary_storage) AS Std_Deviation_Primary_Storage,
    AVG(Price) AS Avg_Price,
    AVG(primary_storage) AS Avg_Primary_Storage
FROM laptopdata;

-- Scatter plot
SELECT Price, primary_storage FROM laptopdata;

-- Correlation
SELECT 
    (AVG(Price * primary_storage) - AVG(Price) * AVG(primary_storage)) / 
    (SQRT(AVG(Price * Price) - AVG(Price) * AVG(Price)) * SQRT(AVG(primary_storage * primary_storage) - AVG(primary_storage) * AVG(primary_storage))) 
    AS correlation_coefficient
FROM laptopdata;

-- Side By Side Summary Statistics
SELECT
    COUNT(Inches) AS Total_Count,
    MIN(Inches) AS Min_Inches,
    MIN(Weight) AS Min_Weight,
    MAX(Inches) AS Max_Inches,
    MAX(Weight) AS Max_Weight,
    STD(Inches) AS Std_Deviation_Inches,
    STD(Weight) AS Std_Deviation_Weight,
    AVG(Inches) AS Avg_Inches,
    AVG(Weight) AS Avg_Weight
FROM laptopdata;

-- Scatter plot
SELECT Inches, Weight FROM laptopdata;

-- Correlation
SELECT 
    (AVG(Inches * Weight) - AVG(Inches) * AVG(Weight)) / 
    (SQRT(AVG(Inches * Inches) - AVG(Inches) * AVG(Inches)) * SQRT(AVG(Weight * Weight) - AVG(Weight) * AVG(Weight))) 
    AS correlation_coefficient
FROM laptopdata;

-- Side By Side Summary Statistics
SELECT
    COUNT(resolution_width) AS Total_Count,
    MIN(resolution_width) AS Min_Width,
    MIN(resolution_height) AS Min_Height,
    MAX(resolution_width) AS Max_Width,
    MAX(resolution_height) AS Max_Height,
    STD(resolution_width) AS Std_Deviation_Width,
    STD(resolution_height) AS Std_Deviation_Height,
    AVG(resolution_width) AS Avg_Width,
    AVG(resolution_height) AS Avg_Height
FROM laptopdata;

-- Scatter plot
SELECT resolution_width, resolution_height FROM laptopdata;

-- Correlation
SELECT 
    (AVG(resolution_width * resolution_height) - AVG(resolution_width) * AVG(resolution_height)) / 
    (SQRT(AVG(resolution_width * resolution_width) - AVG(resolution_width) * AVG(resolution_width)) * SQRT(AVG(resolution_height * resolution_height) - AVG(resolution_height) * AVG(resolution_height))) 
    AS correlation_coefficient
FROM laptopdata;

-- Side By Side Summary Statistics
SELECT
    COUNT(Ram) AS Total_Count,
    MIN(Ram) AS Min_Ram,
    MIN(cpu_speed) AS Min_CPU_Speed,
    MAX(Ram) AS Max_Ram,
    MAX(cpu_speed) AS Max_CPU_Speed,
    STD(Ram) AS Std_Deviation_Ram,
    STD(cpu_speed) AS Std_Deviation_Cpu_Speed,
    AVG(Ram) AS Avg_Ram,
    AVG(cpu_speed) AS Avg_CPU_Speed
FROM laptopdata;

-- Scatter plot
SELECT Ram, cpu_speed FROM laptopdata;

-- Correlation
SELECT 
    (AVG(Ram * cpu_speed) - AVG(Ram) * AVG(cpu_speed)) / 
    (SQRT(AVG(Ram * Ram) - AVG(Ram) * AVG(Ram)) * SQRT(AVG(cpu_speed * cpu_speed) - AVG(cpu_speed) * AVG(cpu_speed))) 
    AS correlation_coefficient
FROM laptopdata;

-- Categorical vs Categorical Columns 

-- Contingency Table 
SELECT Company,SUM(CASE WHEN touchscreen=1 THEN 1 ELSE 0 END) AS touchscreen_yes,SUM(CASE WHEN touchscreen=0 THEN 1 ELSE 0 END) AS touchscreen_no FROM workbench.laptopdata
GROUP BY Company ;

-- Contingency Table
SELECT 
    Company,
    SUM(CASE WHEN OpSys = 'Windows' THEN 1 ELSE 0 END) AS Windows,
    SUM(CASE WHEN OpSys = 'Mac' THEN 1 ELSE 0 END) AS Mac,
    SUM(CASE WHEN OpSys = 'Linux' THEN 1 ELSE 0 END) AS Linux,
    SUM(CASE WHEN OpSys = 'No OS' THEN 1 ELSE 0 END) AS No_OS,
    SUM(CASE WHEN OpSys = 'Other' THEN 1 ELSE 0 END) AS Other
FROM laptopdata
GROUP BY Company;

-- Contingency Table
SELECT 
    Company,
    SUM(CASE WHEN cpu_brand = 'Intel' THEN 1 ELSE 0 END) AS Intel,
    SUM(CASE WHEN cpu_brand = 'AMD' THEN 1 ELSE 0 END) AS AMD,
    SUM(CASE WHEN cpu_brand = 'Samsung' THEN 1 ELSE 0 END) AS Samsung
FROM laptopdata
GROUP BY Company;

-- Contingency Table
SELECT 
    Company,
    SUM(CASE WHEN gpu_brand = 'Intel' THEN 1 ELSE 0 END) AS Intel,
    SUM(CASE WHEN gpu_brand = 'Nvidia' THEN 1 ELSE 0 END) AS Nvidia,
    SUM(CASE WHEN gpu_brand = 'AMD' THEN 1 ELSE 0 END) AS AMD,
    SUM(CASE WHEN gpu_brand = 'ARM' THEN 1 ELSE 0 END) AS ARM
FROM laptopdata
GROUP BY Company;

-- Contingency Table
SELECT 
    TypeName,
    SUM(CASE WHEN touchscreen = 1 THEN 1 ELSE 0 END) AS touchscreen_yes,
    SUM(CASE WHEN touchscreen = 0 THEN 1 ELSE 0 END) AS touchscreen_no
FROM laptopdata
GROUP BY TypeName;

-- Contingency Table
SELECT 
    TypeName,
    SUM(CASE WHEN cpu_brand = 'Intel' THEN 1 ELSE 0 END) AS Intel,
    SUM(CASE WHEN cpu_brand = 'AMD' THEN 1 ELSE 0 END) AS AMD,
    SUM(CASE WHEN cpu_brand = 'Samsung' THEN 1 ELSE 0 END) AS Samsung
FROM laptopdata
GROUP BY TypeName;

-- Contingency Table
SELECT 
    TypeName,
    SUM(CASE WHEN gpu_brand = 'Intel' THEN 1 ELSE 0 END) AS Intel,
    SUM(CASE WHEN gpu_brand = 'Nvidia' THEN 1 ELSE 0 END) AS Nvidia,
    SUM(CASE WHEN gpu_brand = 'AMD' THEN 1 ELSE 0 END) AS AMD,
    SUM(CASE WHEN gpu_brand = 'ARM' THEN 1 ELSE 0 END) AS ARM
FROM laptopdata
GROUP BY TypeName;

-- Contingency Table
SELECT 
    cpu_brand,
    SUM(CASE WHEN gpu_brand = 'Intel' THEN 1 ELSE 0 END) AS Intel,
    SUM(CASE WHEN gpu_brand = 'Nvidia' THEN 1 ELSE 0 END) AS Nvidia,
    SUM(CASE WHEN gpu_brand = 'AMD' THEN 1 ELSE 0 END) AS AMD,
    SUM(CASE WHEN gpu_brand = 'ARM' THEN 1 ELSE 0 END) AS ARM
FROM laptopdata
GROUP BY cpu_brand;

-- Contingency Table
SELECT 
    cpu_brand,
    SUM(CASE WHEN touchscreen = 1 THEN 1 ELSE 0 END) AS touchscreen_yes,
    SUM(CASE WHEN touchscreen = 0 THEN 1 ELSE 0 END) AS touchscreen_no
FROM laptopdata
GROUP BY cpu_brand;

-- Contingency Table
SELECT 
    OpSys,
    SUM(CASE WHEN touchscreen = 1 THEN 1 ELSE 0 END) AS touchscreen_yes,
    SUM(CASE WHEN touchscreen = 0 THEN 1 ELSE 0 END) AS touchscreen_no
FROM laptopdata
GROUP BY OpSys;

-- Numerical vs Categorical Bivarite Analysis 

-- Comparing Distribution
SELECT 
    Company,
    MIN(Price) AS Min_Price,
    MAX(Price) AS Max_Price,
    AVG(Price) AS Avg_Price,
    STD(Price) AS Std_Price
FROM laptopdata
GROUP BY Company;

-- Comparing Distribution
SELECT 
    TypeName,
    MIN(Price) AS Min_Price,
    MAX(Price) AS Max_Price,
    AVG(Price) AS Avg_Price,
    STD(Price) AS Std_Price
FROM laptopdata
GROUP BY TypeName;

-- Comparing Distribution
SELECT 
    TypeName,
    MIN(Weight) AS Min_Weight,
    MAX(Weight) AS Max_Weight,
    AVG(Weight) AS Avg_Weight,
    STD(Weight) AS Std_Weight
FROM laptopdata
GROUP BY TypeName;

-- Comparing Distribution
SELECT 
    TypeName,
    MIN(Ram) AS Min_Ram,
    MAX(Ram) AS Max_Ram,
    AVG(Ram) AS Avg_Ram,
    STD(Ram) AS Std_Ram
FROM laptopdata
GROUP BY TypeName;

-- Comparing Distribution
SELECT 
    cpu_brand,
    MIN(Price) AS Min_Price,
    MAX(Price) AS Max_Price,
    AVG(Price) AS Avg_Price,
    STD(Price) AS Std_Price
FROM laptopdata
GROUP BY cpu_brand;

-- Comparing Distribution
SELECT 
    cpu_brand,
    MIN(cpu_speed) AS Min_Speed,
    MAX(cpu_speed) AS Max_Speed,
    AVG(cpu_speed) AS Avg_Speed,
    STD(cpu_speed) AS Std_Speed
FROM laptopdata
GROUP BY cpu_brand;

-- Comparing Distribution
SELECT 
    gpu_brand,
    MIN(Price) AS Min_Price,
    MAX(Price) AS Max_Price,
    AVG(Price) AS Avg_Price,
    STD(Price) AS Std_Price
FROM laptopdata
GROUP BY gpu_brand;

-- Comparing Distribution
SELECT 
    gpu_brand,
    MIN(Weight) AS Min_Weight,
    MAX(Weight) AS Max_Weight,
    AVG(Weight) AS Avg_Weight,
    STD(Weight) AS Std_Weight
FROM laptopdata
GROUP BY gpu_brand;

-- Comparing Distribution
SELECT 
    OpSys,
    MIN(Price) AS Min_Price,
    MAX(Price) AS Max_Price,
    AVG(Price) AS Avg_Price,
    STD(Price) AS Std_Price
FROM laptopdata
GROUP BY OpSys;

-- Comparing Distribution
SELECT 
    OpSys,
    MIN(Ram) AS Min_Ram,
    MAX(Ram) AS Max_Ram,
    AVG(Ram) AS Avg_Ram,
    STD(Ram) AS Std_Ram
FROM laptopdata
GROUP BY OpSys;

-- Comparing Distribution
SELECT 
    touchscreen,
    MIN(Price) AS Min_Price,
    MAX(Price) AS Max_Price,
    AVG(Price) AS Avg_Price,
    STD(Price) AS Std_Price
FROM laptopdata
GROUP BY touchscreen;

-- Comparing Distribution
SELECT 
    touchscreen,
    MIN(Weight) AS Min_Weight,
    MAX(Weight) AS Max_Weight,
    AVG(Weight) AS Avg_Weight,
    STD(Weight) AS Std_Weight
FROM laptopdata
GROUP BY touchscreen;

-- Comparing Distribution
SELECT 
    memory_type,
    MIN(primary_storage) AS Min_Storage,
    MAX(primary_storage) AS Max_Storage,
    AVG(primary_storage) AS Avg_Storage,
    STD(primary_storage) AS Std_Storage
FROM laptopdata
GROUP BY memory_type;

-- Comparing Distribution
SELECT 
    Company,
    MIN(Weight) AS Min_Weight,
    MAX(Weight) AS Max_Weight,
    AVG(Weight) AS Avg_Weight,
    STD(Weight) AS Std_Weight
FROM laptopdata
GROUP BY Company;

-- Comparing Distribution
SELECT 
    Company,
    MIN(Ram) AS Min_Ram,
    MAX(Ram) AS Max_Ram,
    AVG(Ram) AS Avg_Ram,
    STD(Ram) AS Std_Ram
FROM laptopdata
GROUP BY Company;
