-- =============================================================================
-- 03: FEATURE ENGINEERING & IMPUTATION
-- =============================================================================

USE workbench;

-- Missing Value Treatment

UPDATE laptopdata t1
SET Price = (
    SELECT Price
    FROM (
        SELECT AVG(Price) AS primary_storage 
        FROM laptopdata t2 
        WHERE t1.Company = t2.Company
    ) AS temp_data
)
WHERE Price IS NULL;

UPDATE laptopdata t1
SET primary_storage = (
    SELECT primary_storage 
    FROM (
        SELECT AVG(primary_storage) AS primary_storage 
        FROM laptopdata t2 
        WHERE t1.TypeName = t2.TypeName
    ) AS temp_data
)
WHERE primary_storage IS NULL;

UPDATE laptopdata t1
SET secondary_storage = (
    SELECT secondary_storage 
    FROM (
        SELECT AVG(secondary_storage) AS secondary_storage 
        FROM laptopdata t2 
        WHERE t1.TypeName = t2.TypeName
    ) AS temp_data
)
WHERE secondary_storage IS NULL;

UPDATE laptopdata t1
SET Weight = (
    SELECT Weight 
    FROM (
        SELECT AVG(Weight) AS Weight 
        FROM laptopdata t2 
        WHERE t1.Inches = t2.Inches
    ) AS temp_data
)
WHERE Weight IS NULL;

-- Feature Engineering

ALTER TABLE laptopdata
ADD COLUMN ppi INTEGER;

UPDATE laptopdata t1
SET ppi=(SELECT ppi FROM (SELECT ROUND(SQRT(resolution_height*resolution_height+resolution_width*resolution_width)/Inches) AS ppi FROM laptopdata t2 WHERE t1.index=t2.index) AS laptop_data);

-- One Hot Encoding 

SELECT 
    gpu_brand,
    CASE WHEN gpu_brand = 'Intel'  THEN 1 ELSE 0 END AS Intel,
    CASE WHEN gpu_brand = 'Nvidia' THEN 1 ELSE 0 END AS Nvidia,
    CASE WHEN gpu_brand = 'AMD'    THEN 1 ELSE 0 END AS AMD,
    CASE WHEN gpu_brand = 'ARM'    THEN 1 ELSE 0 END AS ARM
FROM laptopdata;