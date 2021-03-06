--MIG_LIMIT_PRODUCT
--11,613

SELECT  PROD.UPLOAD_COMPANY, CASE WHEN EXISTS(SELECT SUCL.COMPANY INTERSECT SELECT NULL) THEN CR.SUCURSAL_T24 ELSE SUCL.COMPANY END UPLOAD_COMPANY_AUDITORIA,
PROD.LIMIT_CURRENCY , MHC.CURRENCY_V LIMIT_CURRENCY_AUDITORIA,
PROD.EXPIRY_DATE,
CASE WHEN LCL.LIFVEN <= 20210621 THEN 20210622 ELSE LCL.LIFVEN END AS EXPIRY_DATE_AUDITORIA
FROM MIG_LIMIT_PRODUCT PROD
LEFT JOIN MIG_HOM_CURRENCY MHC ON PROD.LIMIT_CURRENCY = MHC.CURRENCY_V
LEFT JOIN (SELECT DISTINCT LIFVEN FROM LCLINEA) LCL 
ON PROD.EXPIRY_DATE = LCL.LIFVEN
LEFT JOIN (SELECT DISTINCT SUCURSAL_T24,CUSTOMER_CODE FROM CUSTOMER_CODE_REL) CR ON PROD.CUSTOMER_NUMBER = CR.CUSTOMER_CODE
LEFT JOIN MIG_HOM_SUCURSAL_LIMIT SUCL ON PROD.UPLOAD_COMPANY = CASE WHEN EXISTS(SELECT SUCL.COMPANY INTERSECT SELECT NULL) THEN CR.SUCURSAL_T24 ELSE SUCL.COMPANY END







---------------------------------------------------------
----APPROVAL_DATE
--WITH CTE2 AS(
--SELECT   
--		 PROD.APPROVAL_DATE,LCL.LIFEAP  APPROVAL_DATE_AUDITORIA
--FROM MIG_LIMIT_PRODUCT PROD
--LEFT JOIN (SELECT DISTINCT LIFEAP FROM LCLINEA) LCL 
--ON PROD.APPROVAL_DATE =  LCL.LIFEAP )

--SELECT APPROVAL_DATE,APPROVAL_DATE_AUDITORIA FROM CTE2 
--WHERE APPROVAL_DATE <> APPROVAL_DATE_AUDITORIA






