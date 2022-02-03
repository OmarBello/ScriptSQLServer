--MIG_CAPTURE_BILL_D
--3,860
WITH CTE AS(
SELECT  distinct
		BILL.DBNUM_V, SUC.COMPANY DBNUM_V_AUDITORIA,
		BILL.ARRANGEMENT, CASE WHEN BILL.ARRANGEMENT = RTRIM(LTRIM('LA'+CREDIT.CANUCR)) THEN RTRIM(LTRIM('LA'+CREDIT.CANUCR)) 
ELSE RTRIM(LTRIM('LB'+CREDIT.CANUCR)) END ARRANGEMENT_AUDITORIA,
		BILL.EFFECTIVE_DATE_D, CONVERT(VARCHAR(MAX),PAG.CAAFYM)+''+right(('00'+''+CONVERT(VARCHAR(MAX),PAG.CAMFYM)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),CADFYM)),2)  EFFECTIVE_DATE_D_AUDITORIA,
		BILL.PRODUCT, PROD.PRODUCT PRODUCTO_AUDITORIA
FROM MIG_CAPTURE_BILL_D BILL
LEFT JOIN CACREDIT CREDIT
ON RTRIM(LTRIM(RIGHT(BILL.ARRANGEMENT,7))) = RTRIM(LTRIM(CREDIT.CANUCR))
LEFT JOIN MIG_HOM_SUCURSAL SUC
ON BILL.DBNUM_V = SUC.COMPANY
LEFT JOIN CAFYMPAG PAG 
ON  RTRIM(LTRIM(RIGHT(BILL.ARRANGEMENT,7))) = RTRIM(LTRIM(PAG.CANUCR))
AND BILL.EFFECTIVE_DATE_D = CONVERT(VARCHAR(MAX),PAG.CAAFYM)+''+right(('00'+''+CONVERT(VARCHAR(MAX),PAG.CAMFYM)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),CADFYM)),2)
LEFT JOIN MIG_HOM_PRODUCT PROD
ON CREDIT.CAPROD = PROD.CAPROD
AND CREDIT.CASUBP = PROD.CASUBP
AND PROD.PLANTILLA = 'D'
and BILL.PRODUCT= PROD.PRODUCT 
LEFT JOIN ACTAB1 TAB1
ON RTRIM(LTRIM(CREDIT.AXASER)) = RTRIM(LTRIM(TAB1.CODELE))
)

--SELECT * FROM CTE

----DBNUM_V VS DBNUM_V_AUDITORIA
--SELECT DBNUM_V , DBNUM_V_AUDITORIA FROM CTE
--WHERE DBNUM_V <> DBNUM_V_AUDITORIA



----ARRANGEMENT VS ARRANGEMENT_AUDITORIA
--SELECT ARRANGEMENT , ARRANGEMENT_AUDITORIA FROM CTE
--WHERE ARRANGEMENT <> ARRANGEMENT_AUDITORIA


----EFFECTIVE_DATE_D VS EFFECTIVE_DATE_D_AUDITORIA
--SELECT EFFECTIVE_DATE_D , EFFECTIVE_DATE_D_AUDITORIA FROM CTE
--WHERE EFFECTIVE_DATE_D <> EFFECTIVE_DATE_D_AUDITORIA

----PRODUCT VS PRODUCTO_AUDITORIA
--SELECT PRODUCT , PRODUCTO_AUDITORIA FROM CTE
--WHERE PRODUCT <> PRODUCTO_AUDITORIA