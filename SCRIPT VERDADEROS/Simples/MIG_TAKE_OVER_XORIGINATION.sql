--MIG_TAKE_OVER_XORIGINATION
--TOTAL 213,933

WITH CTE AS(
SELECT DISTINCT TION.K_KEY, RTRIM(LTRIM('L'+CREDIT.CANUCR)) K_KEY_AUDITORIA,
TION.CIIU_ID, CREDIT.CAFG11 CIIU_ID_AUDITORIA,
TION.ECONOMIC_GROUP, CREDIT.CACGRU ECONOMIC_GROUP_AUDITORIA,
TION.PROVINCE,
CASE WHEN AR10CGB IS NOT NULL THEN DBO.LPAD(LOCA.PROVINCIA,2,'0') WHEN AR10CGB IS NULL AND CREDIT.CAPROD = 1 THEN DBO.LPAD(CREDIT.CACLUG,2,'0') WHEN AR10CGB IS NULL AND CREDIT.CAPROD = 2 THEN SUBSTRING(SIBLOCA,1,2) END AS PROVINCE_AUDITORIA,
TION.MUNICIPALITY, CASE WHEN AR10CGB IS NOT NULL THEN DBO.LPAD(LOCA.MUNICIPIO,2,'0') WHEN AR10CGB IS NULL AND CREDIT.CAPROD = 1 THEN DBO.LPAD(AUX.CACDMU,2,'0') WHEN AR10CGB IS NULL AND CREDIT.CAPROD = 2 THEN SUBSTRING(SIBLOCA,3,2) END AS MUNICIPALITY_AUDITORIA,
TION.MUN_DISTRICT, CASE WHEN AR10CGB IS NOT NULL THEN DBO.LPAD(LOCA.MUNICIPIO,2,'0') WHEN AR10CGB IS NULL AND CREDIT.CAPROD = 1 THEN '01' WHEN AR10CGB IS NULL AND CREDIT.CAPROD = 2 THEN SUBSTRING(SIBLOCA,5,2) END AS MUN_DISTRICT_AUDITORIA,
TION.PROD_SECTOR, ANRE.SECTOR_PRODUCTIVO AS PROD_SECTOR_AUDITORIA,
TION.APPROARCH_ID, CREDIT.AXASER APPROARCH_ID_AUDITORIA,
TION.CRM_PRODUCT, PCRM.PRODUCTO_CRM AS CRM_PRODUCT_AUDITORIA,
TION.SOURCE_FUNDS, CASE WHEN CREDIT.CAORFF >= 900 THEN 20 ELSE CREDIT.CAORFF END AS SOURCE_FUNDS_AUDITORIA,
TION.RESOL_YEAR, ANRE.ANO AS RESOL_YEAR_AUDITORIA,
TION.FACILITY_SIB, CREDIT.CAFG12 AS FACILITY_SIB_AUDITORIA
FROM MIG_TAKE_OVER_XORIGINATION TION
LEFT JOIN CACREDIT CREDIT ON
TION.K_KEY = RTRIM(LTRIM('L'+CREDIT.CANUCR))
LEFT JOIN MIG_HOM_ANO_RESOLUCION ANRE
ON  RTRIM(LTRIM(CREDIT.CAPROD)) = RTRIM(LTRIM(ANRE.CAPROD))
AND RTRIM(LTRIM(CREDIT.CASUBP)) = RTRIM(LTRIM(ANRE.CASUBP))
AND RTRIM(LTRIM(CREDIT.CAORFF)) = RTRIM(LTRIM(ANRE.CAORFF))
LEFT JOIN MIG_HOM_PRODUCTO_CRM PCRM
ON  RTRIM(LTRIM(CREDIT.CAPROD)) = RTRIM(LTRIM(PCRM.CAPROD))
AND RTRIM(LTRIM(CREDIT.CASUBP)) = RTRIM(LTRIM(PCRM.CASUBP))
LEFT JOIN AR10CGB GBC ON RTRIM(LTRIM(SUBSTRING(GBC.AR10CGB,1,7))) = RTRIM(LTRIM(CREDIT.CANUCR)) 
LEFT JOIN MIG_HOM_LOCALIDAD LOCA ON RTRIM(LTRIM(SUBSTRING(GBC.AR10CGB,195,40))) = RTRIM(LTRIM(LOCA.DESCRIPCION))
AND GBC.AR10CGB IS NOT NULL 
LEFT JOIN CLAGEN AGEN
ON AGEN.CLAGCD = CREDIT.CAAGEN
LEFT JOIN SIBRSULC SULC
ON AGEN.CLCAGE = SULC.SIBSUCU
LEFT JOIN CACREAUX AUX
ON RTRIM(LTRIM(CREDIT.CANUCR)) = RTRIM(LTRIM(AUX.CANUCR))

)

----TOTAL DE LA TABLA QUE SE IMPORTO
--SELECT COUNT(*) FROM CTE


----K_KEY VS K_KEY_AUDITORIA
--SELECT K_KEY , K_KEY_AUDITORIA FROM CTE
--WHERE K_KEY <> K_KEY_AUDITORIA



----CIIU_ID vs CIIU_ID_AUDITORIA
--SELECT CIIU_ID , CIIU_ID_AUDITORIA FROM CTE 
--WHERE CIIU_ID <> CIIU_ID_AUDITORIA


----ECONOMIC_GROUP VS ECONOMIC_GROUP_AUDITORIA
--SELECT ECONOMIC_GROUP , ECONOMIC_GROUP_AUDITORIA FROM CTE 
--WHERE ECONOMIC_GROUP <> ECONOMIC_GROUP_AUDITORIA



----PROVINCE VS PROVINCE_AUDITORIA
--SELECT PROVINCE , PROVINCE_AUDITORIA FROM CTE 
--WHERE PROVINCE <> PROVINCE_AUDITORIA


----MUNICIPALITY VS MUNICIPALITY_AUDITORIA
--SELECT MUNICIPALITY , MUNICIPALITY_AUDITORIA FROM CTE 
--WHERE MUNICIPALITY <> MUNICIPALITY_AUDITORIA



----MUN_DISTRICT VS MUN_DISTRICT_AUDITORIA
--SELECT MUN_DISTRICT , MUN_DISTRICT_AUDITORIA FROM CTE 
--WHERE MUN_DISTRICT <> MUN_DISTRICT_AUDITORIA


----PROD_SECTOR VS PROD_SECTOR_AUDITORIA
--SELECT PROD_SECTOR , PROD_SECTOR_AUDITORIA FROM CTE 
--WHERE PROD_SECTOR <> PROD_SECTOR_AUDITORIA



----APPROARCH_ID VS APPROARCH_ID_AUDITORIA
--SELECT APPROARCH_ID , APPROARCH_ID_AUDITORIA FROM CTE 
--WHERE APPROARCH_ID <> APPROARCH_ID_AUDITORIA


----CRM_PRODUCT VS CRM_PRODUCT_AUDITORIA
--SELECT CRM_PRODUCT , CRM_PRODUCT_AUDITORIA FROM CTE 
--WHERE CRM_PRODUCT <> CRM_PRODUCT_AUDITORIA


----SOURCE_FUNDS VS SOURCE_FUNDS_AUDITORIA
--SELECT SOURCE_FUNDS , SOURCE_FUNDS_AUDITORIA FROM CTE 
--WHERE SOURCE_FUNDS <> SOURCE_FUNDS_AUDITORIA



----RESOL_YEAR VS RESOL_YEAR_AUDITORIA
--SELECT RESOL_YEAR , RESOL_YEAR_AUDITORIA FROM CTE 
--WHERE RESOL_YEAR <> RESOL_YEAR_AUDITORIA



----FACILITY_SIB VS FACILITY_SIB_AUDITORIA
--SELECT FACILITY_SIB , FACILITY_SIB_AUDITORIA FROM CTE 
--WHERE FACILITY_SIB <> FACILITY_SIB_AUDITORIA

