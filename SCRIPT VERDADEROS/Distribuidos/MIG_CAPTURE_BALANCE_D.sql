-- MIG_CAPTURE_BALANCE_D
--11,274

WITH CTE AS(
SELECT DISTINCT
BALANCE.K_KEY, CASE WHEN BALANCE.K_KEY = RTRIM(LTRIM('LA'+CREDIT.CANUCR)) THEN RTRIM(LTRIM('LA'+CREDIT.CANUCR)) 
ELSE RTRIM(LTRIM('LB'+CREDIT.CANUCR)) END K_KEY_AUDITORIA,
BALANCE.UPLOAD_COMPANY, SUC.COMPANY UPLOAD_COMPANY_AUDITORIA,
BALANCE.PRODUCT,  PROD.PRODUCT PRODUCT_AUDITORIA
FROM MIG_CAPTURE_BALANCE_D BALANCE
LEFT JOIN CACREDIT CREDIT
ON RTRIM(LTRIM(RIGHT(BALANCE.K_KEY,7))) = RTRIM(LTRIM(CREDIT.CANUCR))
LEFT JOIN (SELECT DISTINCT * FROM MIG_HOM_SUCURSAL) SUC
ON CREDIT.CAAGEN = SUC.CODIGO
AND BALANCE.UPLOAD_COMPANY = SUC.COMPANY
LEFT JOIN (SELECT DISTINCT * FROM MIG_HOM_PRODUCT) PROD
ON BALANCE.PRODUCT =  PROD.PRODUCT
)


----K_KEY VS K_KEY_AUDITORIA
--SELECT K_KEY, K_KEY_AUDITORIA FROM CTE
--WHERE K_KEY <> K_KEY_AUDITORIA


----UPLOAD_COMPANY VS UPLOAD_COMPANY_AUDITORIA
--SELECT UPLOAD_COMPANY, UPLOAD_COMPANY_AUDITORIA FROM CTE
--WHERE UPLOAD_COMPANY <> UPLOAD_COMPANY_AUDITORIA


----PRODUCT VS UPLOAD_COMPANY_AUDITORIA
--SELECT PRODUCT, PRODUCT_AUDITORIA FROM CTE
--WHERE PRODUCT <> PRODUCT_AUDITORIA




