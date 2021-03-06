--MIG_TAKE_OVER_XRESTRUCTURES
--TOTAL 53,395

WITH CTE2 AS(
--CAMPO RESTRUCT_DATE
SELECT  RES.K_KEY, RTRIM(LTRIM('L'+CREDIT.CANUCR)) K_KEY_AUDITORIA,
RES.RESTRUCT_DATE, CONVERT(VARCHAR(MAX),PTM.CAARTR)+''+right(('00'+''+CONVERT(VARCHAR(MAX),PTM.CAMRTR)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),PTM.CADRTR)),2) RESTRUCT_DATE_AUDITORIA
FROM MIG_TAKE_OVER_XRESTRUCTURES RES
LEFT JOIN (select DISTINCT  CANUCR,CAARTR,CAMRTR,CADRTR/*,CACSTH,CATIPO*/ FROM CAHISPTM) PTM
ON RES.K_KEY= RTRIM(LTRIM('L'+PTM.CANUCR))
AND RES.RESTRUCT_DATE = CONVERT(VARCHAR(MAX),PTM.CAARTR)+''+right(('00'+''+CONVERT(VARCHAR(MAX),PTM.CAMRTR)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),PTM.CADRTR)),2) 
LEFT JOIN CACREDIT CREDIT ON  RES.K_KEY = RTRIM(LTRIM('L'+CREDIT.CANUCR))
LEFT JOIN MIG_HOM_REFINANCIAMIENTO REFI
ON RTRIM(LTRIM(CREDIT.AXASER)) = RTRIM(LTRIM(REFI.AXASER))

)
----K_KEY VS K_KEY_AUDITORIA
--SELECT K_KEY , K_KEY_AUDITORIA FROM CTE2
--WHERE K_KEY <> K_KEY_AUDITORIA


----RESTRUCT_DATE VS RESTRUCT_DATE_AUDITORIA
--SELECT RESTRUCT_DATE , RESTRUCT_DATE_AUDITORIA FROM CTE2
--WHERE RESTRUCT_DATE <> RESTRUCT_DATE_AUDITORIA



------------------------------------------------------------------------------------------------
--CAMPO CLASIF_REST
WITH CTE3 AS(
SELECT  RES.K_KEY, RTRIM(LTRIM('L'+CREDIT.CANUCR))K_KEY_AUDITORIA,
RES.CLASIF_REST, CLCR.CLASIFICACION CLASIF_REST_AUDITORIA
FROM MIG_TAKE_OVER_XRESTRUCTURES RES
LEFT JOIN CACREDIT CREDIT ON  RES.K_KEY = RTRIM(LTRIM('L'+CREDIT.CANUCR))
LEFT JOIN MIG_HOM_CLASIF_CREDITO CLCR
ON CASE WHEN CREDIT.CADIMC > CREDIT.CADIMI THEN CREDIT.CADIMC
ELSE CREDIT.CADIMI END BETWEEN DESDE AND HASTA
AND RES.CLASIF_REST = CLCR.CLASIFICACION
)


----K_KEY VS K_KEY_AUDITORIA
--SELECT K_KEY , K_KEY_AUDITORIA FROM CTE3
--WHERE K_KEY <> K_KEY_AUDITORIA


--CLASIF_REST VS CLASIF_REST_AUDITORIA
SELECT CLASIF_REST , CLASIF_REST_AUDITORIA FROM CTE3
WHERE CLASIF_REST <> CLASIF_REST_AUDITORIA



--------------------------------------------------------------------------------------
--CAMPO REASONS_RESTRUCT, PRODUCTS_CANCEL, BALANCE_CANCEL
WITH CTE4 AS(
SELECT  RES.K_KEY, RTRIM(LTRIM('L'+CREDIT.CANUCR))K_KEY_AUDITORIA,
RES.REASONS_RESTRUCT, REFI.CACMRF AS REASONS_RESTRUCT_AUDITORIA,
RES.PRODUCTS_CANCEL, REFI.RENUCR AS PRODUCTS_CANCEL_AUDITORIA,
RES.BALANCE_CANCEL, CASCAP+CASINT+CASMOR+CASOTR AS BALANCE_CANCEL_AUDITORIA
FROM MIG_TAKE_OVER_XRESTRUCTURES RES
LEFT JOIN CACREDIT CREDIT ON  RES.K_KEY = RTRIM(LTRIM('L'+CREDIT.CANUCR))
LEFT JOIN (SELECT DISTINCT XXNUCR,CACMRF,RENUCR,CASCAP,CASINT,CASMOR,CASOTR FROM CAREFI) REFI
ON RTRIM(LTRIM(REFI.XXNUCR)) = RTRIM(LTRIM(CREDIT.CANUCR))
AND RES.REASONS_RESTRUCT = REFI.CACMRF
AND RES.PRODUCTS_CANCEL = REFI.RENUCR
)

----K_KEY VS K_KEY_AUDITORIA
--SELECT K_KEY , K_KEY_AUDITORIA FROM CTE4
--WHERE K_KEY <> K_KEY_AUDITORIA


----REASONS_RESTRUCT VS CLASIF_REST_AUDITORIA
--SELECT REASONS_RESTRUCT , REASONS_RESTRUCT_AUDITORIA FROM CTE4
--WHERE REASONS_RESTRUCT <> REASONS_RESTRUCT_AUDITORIA


----PRODUCTS_CANCEL VS PRODUCTS_CANCEL_AUDITORIA
--SELECT PRODUCTS_CANCEL , PRODUCTS_CANCEL_AUDITORIA FROM CTE4
--WHERE PRODUCTS_CANCEL <> PRODUCTS_CANCEL_AUDITORIA

--BALANCE_CANCEL VS BALANCE_CANCEL_AUDITORIA
SELECT BALANCE_CANCEL , BALANCE_CANCEL_AUDITORIA FROM CTE4
WHERE BALANCE_CANCEL <> BALANCE_CANCEL_AUDITORIA

---------------------------------------------------------------------------------------
WITH CTE5 AS(
--CAMPO EXTENDED.STATUS
SELECT  RES.K_KEY, RTRIM(LTRIM('L'+CREDIT.CANUCR))K_KEY_AUDITORIA,
RES.EXTENDED_STATUS, CASE WHEN CACSTC = 20 THEN 'J' WHEN CREDIT.CACSTC = 15 OR CREDIT.CODFGA =1 THEN 'R' END   AS EXTENDED_STATUS_AUDITORIA
FROM MIG_TAKE_OVER_XRESTRUCTURES RES
LEFT JOIN CACREDIT CREDIT ON  RES.K_KEY = RTRIM(LTRIM('L'+CREDIT.CANUCR))
)

----K_KEY VS K_KEY_AUDITORIA
--SELECT K_KEY , K_KEY_AUDITORIA FROM CTE5
--WHERE K_KEY <> K_KEY_AUDITORIA


--EXTENDED_STATUS VS EXTENDED_STATUS_AUDITORIA
SELECT K_KEY, EXTENDED_STATUS , EXTENDED_STATUS_AUDITORIA FROM CTE5
WHERE EXTENDED_STATUS <> EXTENDED_STATUS_AUDITORIA



--------------------------------------------------------------------
WITH CTE6 AS(
--YEAR.PENALTY
SELECT  RES.K_KEY, RTRIM(LTRIM('L'+CREDIT.CANUCR))K_KEY_AUDITORIA,
RES.YEAR_PENALTY, CONVERT(VARCHAR(MAX),PTM.CAARTR)+''+right(('00'+''+CONVERT(VARCHAR(MAX),PTM.CAMRTR)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),PTM.CADRTR)),2) YEAR_PENALTY_AUDITORIA
FROM MIG_TAKE_OVER_XRESTRUCTURES RES
LEFT JOIN (select DISTINCT  CANUCR,CAARTR,CAMRTR,CADRTR/*,CACSTH,CATIPO*/ FROM CAHISPTM) PTM
ON RES.K_KEY= RTRIM(LTRIM('L'+PTM.CANUCR))
AND RES.YEAR_PENALTY = CONVERT(VARCHAR(MAX),PTM.CAARTR)+''+right(('00'+''+CONVERT(VARCHAR(MAX),PTM.CAMRTR)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),PTM.CADRTR)),2)
LEFT JOIN CACREDIT CREDIT ON  RES.K_KEY = RTRIM(LTRIM('L'+CREDIT.CANUCR))
)


----K_KEY VS K_KEY_AUDITORIA
--SELECT K_KEY , K_KEY_AUDITORIA FROM CTE6
--WHERE K_KEY <> K_KEY_AUDITORIA


--YEAR_PENALTY VS EXTENDED_STATUS_AUDITORIA
SELECT YEAR_PENALTY, YEAR_PENALTY_AUDITORIA FROM CTE6
WHERE YEAR_PENALTY <> YEAR_PENALTY_AUDITORIA



