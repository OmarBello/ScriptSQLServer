 --MIG_TAKE_OVER_COMMITMENT
 --213,993

 --WITH CTE AS(
   SELECT COM.K_KEY , RTRIM(LTRIM('L'+CREDIT.CANUCR)) K_KEY_AUDITORIA,
 COM.AMOUNT,CASE WHEN ((CAST(CREDIT.CRAVCP AS varchar(max)) + (replicate('0',(2 - len(CREDIT.CRMVCP))) + CAST(CREDIT.CRMVCP AS varchar(max)))) + (replicate('0',(2 - len(CREDIT.CRDVCP))) + CAST(CREDIT.CRDVCP AS varchar(max)))) < 20211025 THEN 1 ELSE CASE WHEN (CREDIT.CACAVI - CREDIT.CAATRA) = 0 THEN 1 ELSE (CREDIT.CACAVI - CREDIT.CAATRA) END END AMOUNT_AUDITORIA
 FROM MIG_TAKE_OVER_COMMITMENT COM
LEFT JOIN CACREDIT CREDIT ON COM.K_KEY = RTRIM(LTRIM('L'+CREDIT.CANUCR))
INNER JOIN ( SELECT CANUCR FROM DISCAP_DIS_SIM_SALD_SIMPLES UNION SELECT CANUCR FROM DISCAP_DIS_SIM_SALD_EX_DIST ) DISCAP
ON RTRIM(LTRIM(CREDIT.CANUCR)) = RTRIM(LTRIM(DISCAP.CANUCR))


 --)

----TOTAL DE LA TABLA QUE SE IMPORTO
--SELECT COUNT(*) FROM MIG_TAKE_OVER_COMMITMENT

----K_KEY VS K_KEY_AUDITORIA
--SELECT K_KEY, K_KEY_AUDITORIA FROM CTE
--WHERE K_KEY <> K_KEY_AUDITORIA

----AMOUNT VS AMOUNT_AUDITORIA
--SELECT K_KEY, AMOUNT, AMOUNT_AUDITORIA FROM CTE
--WHERE AMOUNT <> AMOUNT_AUDITORIA
