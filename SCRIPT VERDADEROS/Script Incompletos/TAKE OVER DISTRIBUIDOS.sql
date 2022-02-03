--TAKE OVER DISTRIBUIDOS
--10,582
SELECT  distinct
	D.K_KEY,
CASE
	WHEN RTRIM(LTRIM(D.K_KEY)) = RTRIM(LTRIM('LA'+CREDIT.CANUCR)) THEN RTRIM(LTRIM('LA'+CREDIT.CANUCR))
	WHEN RTRIM(LTRIM(D.K_KEY)) = RTRIM(LTRIM('LB'+CREDIT.CANUCR)) THEN RTRIM(LTRIM('LB'+CREDIT.CANUCR))
	END AS CANUCR_OMAR,
	D.UPLOAD_COMPANY, CREDIT.CAAGEN,
	--	D.AAA_ID,CASE
	--WHEN RTRIM(LTRIM(D.AAA_ID)) = RTRIM(LTRIM('LA'+CREDIT.CANUCR)) THEN RTRIM(LTRIM('LA'+CREDIT.CANUCR))
	--WHEN RTRIM(LTRIM(D.AAA_ID)) = RTRIM(LTRIM('LB'+CREDIT.CANUCR)) THEN RTRIM(LTRIM('LB'+CREDIT.CANUCR))
	--END AS AAA_ID_CANUCR_OMAR,
	RIGHT(D.CUSTOMER,7)CUSTOMER,  C.V3CUIP,
	D.CUSTOMER_ROLE, E.CUSTOMER_ROLE_V,
	D.PRODUCT,  ISNULL(PROD7X.PRODUCT,PROD.PRODUCT) PRODUCTO,
	D.CURRENCY, CASE WHEN CREDIT.PRMONE = 000 THEN 'DOP' 
					 WHEN CREDIT.PRMONE = 034 THEN 'USD'
					 WHEN CREDIT.PRMONE IN (035,004) THEN 'EU' END AS MONEDA,
	D.ORIG_CONTRACT_DATE, CONVERT(VARCHAR(MAX),CAACOC)+''+right(('00'+''+CONVERT(VARCHAR(MAX),CAMCOC)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),CADCOC)),2) AS [ORIG.CONTRACT.DATE]
FROM MIG_TAKE_OVER_D D
LEFT JOIN  CACREDIT CREDIT
ON	RTRIM(LTRIM(D.K_KEY)) = RTRIM(LTRIM('LA'+CREDIT.CANUCR)) 
OR	RTRIM(LTRIM(D.K_KEY)) = RTRIM(LTRIM('LB'+CREDIT.CANUCR))
LEFT JOIN  ( SELECT V3CUIP FROM PEMVNI30 GROUP BY  V3CUIP) C ON  C.V3CUIP =  RIGHT(D.CUSTOMER,7)
LEFT JOIN  ( SELECT CUSTOMER_ROLE_V FROM MIG_HOME_CUSTOMER_ROLE GROUP BY  CUSTOMER_ROLE_V) E ON E.CUSTOMER_ROLE_V = D.CUSTOMER_ROLE
LEFT JOIN MIG_HOM_PRODUCT PROD
ON CREDIT.CAPROD = PROD.CAPROD
AND CREDIT.CASUBP = PROD.CASUBP
AND PROD.PLANTILLA = 'S'
LEFT JOIN ACTAB1 TAB1
ON TAB1.CODTAB = 'K7'
AND CREDIT.CAPROD = 1
AND CREDIT.CASUBP IN (70,71)
AND RTRIM(LTRIM(CREDIT.AXASER)) = RTRIM(LTRIM(TAB1.CODELE))
LEFT JOIN MIG_HOM_PRODUCT_70_71 PROD7X
ON CREDIT.CAPROD = PROD7X.CAPROD
AND CREDIT.CASUBP = PROD7X.CASUBP
AND ISNULL(RTRIM(LTRIM(TAB1.SW02)),'P') = RTRIM(LTRIM(PROD7X.SW02))
--WHERE RTRIM(LTRIM(D.K_KEY)) = 'LA2747215'

--RTRIM(LTRIM('L'+CASE WHEN DISCAP2.DSCORR = 1 THEN 'A' WHEN DISCAP2.DSCORR = 2 THEN 'B' END+CREDIT.CANUCR))
	



--SELECT * FROM MIG_TAKE_OVER_D

--SELECT * FROM CURRENCY

select * from PRODUCT