-- =============================================================================
-- 02: DATA CLEANING & TRANSFORMATION
-- =============================================================================

USE workbench;

-- Delete completely empty rows
DELETE FROM laptopdata
WHERE `index` IN (
    SELECT `index` FROM (
        SELECT `index` FROM laptopdata
        WHERE Company IS NULL AND TypeName IS NULL AND Inches IS NULL
          AND ScreenResolution IS NULL AND Cpu IS NULL AND Ram IS NULL
          AND Memory IS NULL AND Gpu IS NULL AND OpSys IS NULL
          AND Weight IS NULL AND Price IS NULL
    ) AS temp_laptop
);

-- Remove duplicate records (keeping the first instance)
DELETE FROM laptopdata
WHERE `index` NOT IN (
    SELECT cnt FROM (
        SELECT MIN(`index`) AS cnt
        FROM laptopdata
        GROUP BY Company, TypeName, Inches, ScreenResolution, Cpu, Ram, Memory, Gpu, OpSys, Weight, Price
    ) AS temp_laptop
);

-- Round Price values
UPDATE laptopdata l1
SET Price = (
    SELECT price 
    FROM (SELECT ROUND(Price) AS price FROM laptopdata l2 WHERE l1.index = l2.index) AS temp_laptop
);

-- Clean and convert Ram to INTEGER
UPDATE laptopdata 
SET Ram = REPLACE(Ram, 'GB', '');

ALTER TABLE laptopdata
MODIFY COLUMN Ram INTEGER;

-- Clean and convert Weight to DOUBLE
UPDATE laptopdata
SET Weight = REPLACE(Weight, 'kg', '');

UPDATE laptopdata
SET Weight = NULL
WHERE Weight = '?';

ALTER TABLE laptopdata
MODIFY COLUMN Weight DOUBLE;

-- Standardize Operating Systems
UPDATE laptopdata
SET OpSys = CASE 
    WHEN OpSys LIKE '%Mac%' THEN 'Mac'
    WHEN OpSys LIKE '%Windows%' THEN 'Windows'
    WHEN OpSys LIKE '%Linux%' THEN 'Linux'
    WHEN OpSys LIKE '%Chrome%' THEN 'Chrome'
    WHEN OpSys LIKE '%Android%' THEN 'Android'
    WHEN OpSys LIKE '%No Os%' THEN 'N/A'
    ELSE 'others'
END;

-- Parse Memory Column
ALTER TABLE laptopdata
ADD COLUMN memory_type VARCHAR(255) AFTER Memory,
ADD COLUMN primary_storage INTEGER AFTER memory_type,
ADD COLUMN secondary_storage INTEGER AFTER primary_storage;

UPDATE laptopdata l1
SET Memory = (SELECT Memory FROM laptop_backup l2 WHERE l1.index = (l2.`Unnamed: 0`) + 1);

UPDATE laptopdata
SET Memory = NULL 
WHERE Memory = '?';

UPDATE laptopdata
SET primary_storage = REPLACE(REPLACE(SUBSTRING_INDEX(Memory, ' ', 1), 'GB', ''), 'TB', ''),
    secondary_storage = REPLACE(REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(Memory, '+', 1), ' ', 1), 'GB', ''), 'TB', '');

-- Standardize Storage Capacities to MB/GB equivalent
UPDATE laptopdata
SET primary_storage = CASE WHEN primary_storage <= 2 THEN primary_storage * 1024 ELSE primary_storage END,
    secondary_storage = CASE WHEN secondary_storage <= 2 THEN secondary_storage * 1024 ELSE secondary_storage END;

UPDATE laptopdata
SET memory_type = CASE 
    WHEN Memory LIKE '%+%' THEN 'Hybrid'
    WHEN Memory LIKE '%SSD%' THEN 'SSD'
    WHEN Memory LIKE '%HDD%' THEN 'HDD'
    WHEN Memory LIKE '%Flash Storage%' THEN 'Flash Storage'
    WHEN Memory LIKE '%Hybird%' THEN 'Hybrid'
    ELSE 'Others'
END;

ALTER TABLE laptopdata
DROP COLUMN Memory;

-- Parse GPU Column
ALTER TABLE laptopdata
ADD COLUMN gpu_brand VARCHAR(255) AFTER Gpu,
ADD COLUMN gpu_name VARCHAR(255) AFTER gpu_brand;

UPDATE laptopdata
SET gpu_brand = SUBSTRING_INDEX(Gpu, ' ', 1),
    gpu_name = TRIM(REPLACE(Gpu, gpu_brand, ''));

ALTER TABLE laptopdata
DROP COLUMN Gpu;

-- Parse CPU Column
ALTER TABLE laptopdata
ADD COLUMN cpu_brand VARCHAR(255) AFTER Cpu,
ADD COLUMN cpu_name VARCHAR(255) AFTER cpu_brand,
ADD COLUMN cpu_speed DECIMAL(10,1) AFTER cpu_name;

UPDATE laptopdata
SET cpu_brand = SUBSTRING_INDEX(Cpu, ' ', 1),
    cpu_speed = REPLACE(SUBSTRING_INDEX(Cpu, ' ', -1), 'GHz', ''),
    cpu_name = TRIM(REPLACE(REPLACE(Cpu, cpu_brand, ''), SUBSTRING_INDEX(Cpu, ' ', -1), ''));

ALTER TABLE laptopdata
DROP COLUMN Cpu;

-- Parse Screen Resolution Column
ALTER TABLE laptopdata
ADD COLUMN resolution_width INTEGER AFTER ScreenResolution,
ADD COLUMN resolution_height INTEGER AFTER resolution_width,
ADD COLUMN touchscreen INTEGER AFTER resolution_height;

UPDATE laptopdata l1
SET resolution_width = SUBSTRING_INDEX(SUBSTRING_INDEX(ScreenResolution, ' ', -1), 'x', 1),
    resolution_height = SUBSTRING_INDEX(SUBSTRING_INDEX(ScreenResolution, ' ', -1), 'x', -1),
    touchscreen = ScreenResolution LIKE '%Touch%';

ALTER TABLE laptopdata
DROP COLUMN ScreenResolution;

