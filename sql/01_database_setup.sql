-- =============================================================================
-- 01: DATABASE SETUP & STRUCTURAL PREPARATION
-- =============================================================================

USE workbench;

-- 1. Initial Dataset Inspection
SELECT COUNT(*) FROM laptopdata;

SELECT DATA_LENGTH / 1024 AS table_size_kb 
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'workbench' AND TABLE_NAME = 'laptopdata';

-- 2. Drop Raw Unnamed Column
ALTER TABLE laptopdata
DROP COLUMN `Unnamed: 0`;

-- 3. Add Auto-Increment Primary Key Index
ALTER TABLE laptopdata
ADD COLUMN `index` INTEGER PRIMARY KEY AUTO_INCREMENT;