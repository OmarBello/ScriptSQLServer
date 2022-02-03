--LIMIT CUPOS
--TOTAL 27,579
WITH CTE AS(
SELECT   CUPOS_V.UPLOAD_COMPANY, CASE WHEN EXISTS(SELECT SUCL.COMPANY INTERSECT SELECT NULL) THEN CR.SUCURSAL_T24 ELSE SUCL.COMPANY END UPLOAD_COMPANY_AUDITORIA,
		 CUPOS_V.LIMIT_CURRENCY, MHC.CURRENCY_V LIMIT_CURRENCY_AUDITORIA,
		 CUPOS_V.EXPIRY_DATE, CASE WHEN CUPOS_V.EXPIRY_DATE = LCL.LIFVEN THEN LCL.LIFVEN
								   WHEN CUPOS_V.EXPIRY_DATE = '20350229' THEN '20350228' ELSE CUPOS_V.EXPIRY_DATE
								   END EXPIRY_DATE_AUDITORIA,
		CONVERT(DECIMAL(14,2),CUPOS_V.INTERNAL_AMOUNT)INTERNAL_AMOUNT,LCCU.CPMAPR INTERNAL_AMOUNT_AUDITORIA,
		CONVERT(DECIMAL(14,2),CUPOS_V.MAXIMUM_TOTAL)MAXIMUM_TOTAL,LCCU.CPMAPR MAXIMUM_TOTAL_AUDITORIA,
		CONVERT(DECIMAL(14,2),CUPOS_V.ORIGINAL_LIMIT)ORIGINAL_LIMIT,LCCU.CPMAPR ORIGINAL_LIMIT_AUDITORIA,
		CUPOS_V.CUSTOMER_NUMBER, CR.CUSTOMER_CODE CUSTOMER_NUMBER_AUDITORIA,
		CUPOS_V.LIMIT_PRODUCT , HCUP.LIMITE_SUBPRODUCTO LIMIT_PRODUCT_AUDITORIA
FROM MIG_LIMIT_GEN_CUPOS_S CUPOS_V
LEFT JOIN MIG_HOM_CURRENCY MHC ON CUPOS_V.LIMIT_CURRENCY = MHC.CURRENCY_V
LEFT JOIN (SELECT DISTINCT LIFVEN FROM LCLINEA) LCL 
ON CUPOS_V.EXPIRY_DATE = LCL.LIFVEN
LEFT JOIN (SELECT DISTINCT CPMAPR FROM LCCUPOS) LCCU 
ON CONVERT(DECIMAL(14,2),CUPOS_V.INTERNAL_AMOUNT)=LCCU.CPMAPR 
LEFT JOIN (SELECT DISTINCT SUCURSAL_T24,CUSTOMER_CODE FROM CUSTOMER_CODE_REL) CR ON CUPOS_V.CUSTOMER_NUMBER = CR.CUSTOMER_CODE
LEFT JOIN MIG_HOM_SUCURSAL_LIMIT SUCL ON CUPOS_V.UPLOAD_COMPANY = CASE WHEN EXISTS(SELECT SUCL.COMPANY INTERSECT SELECT NULL) THEN CR.SUCURSAL_T24 ELSE SUCL.COMPANY END
LEFT JOIN (SELECT DISTINCT LIMITE_SUBPRODUCTO FROM MIG_HOM_CUPO) HCUP ON CUPOS_V.LIMIT_PRODUCT = HCUP.LIMITE_SUBPRODUCTO
)

--SELECT UPLOAD_COMPANY,UPLOAD_COMPANY_AUDITORIA FROM CTE 
--WHERE UPLOAD_COMPANY <> UPLOAD_COMPANY_AUDITORIA

--SELECT LIMIT_CURRENCY, LIMIT_CURRENCY_AUDITORIA FROM CTE 
--WHERE LIMIT_CURRENCY <> LIMIT_CURRENCY_AUDITORIA


--SELECT EXPIRY_DATE,EXPIRY_DATE_AUDITORIA FROM CTE 
--WHERE EXPIRY_DATE <> EXPIRY_DATE_AUDITORIA

--SELECT INTERNAL_AMOUNT,INTERNAL_AMOUNT_AUDITORIA FROM CTE 
--WHERE INTERNAL_AMOUNT <> INTERNAL_AMOUNT_AUDITORIA

--SELECT MAXIMUM_TOTAL,MAXIMUM_TOTAL_AUDITORIA FROM CTE 
--WHERE MAXIMUM_TOTAL <> MAXIMUM_TOTAL_AUDITORIA

--SELECT ORIGINAL_LIMIT,ORIGINAL_LIMIT_AUDITORIA FROM CTE 
--WHERE ORIGINAL_LIMIT <> ORIGINAL_LIMIT_AUDITORIA

--SELECT CUSTOMER_NUMBER,CUSTOMER_NUMBER_AUDITORIA FROM CTE 
--WHERE CUSTOMER_NUMBER <> CUSTOMER_NUMBER_AUDITORIA

--SELECT LIMIT_PRODUCT,LIMIT_PRODUCT_AUDITORIA FROM CTE 
--WHERE LIMIT_PRODUCT <> LIMIT_PRODUCT_AUDITORIA


---------------------------------------------------------
--APPROVAL_DATE
WITH CTE2 AS(
SELECT   
		 CUPOS_V.APPROVAL_DATE,LCL.LIFEAP  APPROVAL_DATE_AUDITORIA
FROM MIG_LIMIT_GEN_CUPOS_S CUPOS_V
LEFT JOIN (SELECT DISTINCT LIFEAP FROM LCLINEA) LCL 
ON CUPOS_V.APPROVAL_DATE =  LCL.LIFEAP )

--SELECT APPROVAL_DATE,APPROVAL_DATE_AUDITORIA FROM CTE2 
--WHERE APPROVAL_DATE <> APPROVAL_DATE_AUDITORIA


