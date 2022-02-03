--MIG_TAKE_OVER_D_SCHEDULE
--21,249
truncate table MIG_TAKE_OVER_D_SCHEDULE

--12,060
WITH CTE AS(
SELECT DISTINCT
X.K_KEY,
X.K_KEY_AUDITORIA,
X.ACTUAL_AMT,
X.ACTUAL_AMT_AUDITORIA,
X.START_DATE,
CASE WHEN START_DATE >= 20211025  THEN X.START_DATE 
	 WHEN START_DATE = 20211025 THEN 20211025 ELSE '' END AS START_DATE_AUDITORIA,
X.END_DATE,
CASE 
            WHEN ( X.CDCFRE = 7 OR X.END_DATE  < CASE WHEN START_DATE >= 20211025 THEN X.START_DATE ELSE 20211025 END)
                THEN 
                CASE  WHEN START_DATE >= 20211025  THEN X.START_DATE 
					  WHEN START_DATE = 20211025 THEN 20211025 ELSE ''  END
            ELSE 
                X.END_DATE 
            END 
    AS END_DATE_AUDITORIA 

FROM
(
SELECT DISTINCT RTRIM(LTRIM(DULE.K_KEY))K_KEY , CASE WHEN DULE.K_KEY = RTRIM(LTRIM('LA'+CREDIT.CANUCR)) THEN RTRIM(LTRIM('LA'+CREDIT.CANUCR)) 
ELSE RTRIM(LTRIM('LB'+CREDIT.CANUCR)) END K_KEY_AUDITORIA,
DULE.ACTUAL_AMT,  CASE WHEN DULE.ACTUAL_AMT = COMDIS.CDVACP THEN COMDIS.CDVACP 
WHEN DULE.ACTUAL_AMT = 1 THEN 1 ELSE NULL END ACTUAL_AMT_AUDITORIA,
DULE.START_DATE, CASE WHEN COMDIS.CDCFRE = 13 THEN 'R''_''MATURITY' ELSE CONVERT(VARCHAR(MAX),COMDIS.CDANCP)+''+right(('00'+''+CONVERT(VARCHAR(MAX),COMDIS.CDMECP)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),COMDIS.CDDICP)),2)
END START_DATE_AUDITORIA,
CDCFRE,
DULE.END_DATE, CASE WHEN COMDIS.CDCFRE = 13 THEN 'R''_''MATURITY' 
WHEN COMDIS.CDCFRE = 7 THEN CONVERT(VARCHAR(MAX),COMDIS.CDANCP)+''+right(('00'+''+CONVERT(VARCHAR(MAX),COMDIS.CDMECP)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),COMDIS.CDDICP)),2)
ELSE CONVERT(VARCHAR(MAX),COMDIS.CDMANO)+''+right(('00'+''+CONVERT(VARCHAR(MAX),COMDIS.CDMMES)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),COMDIS.CDMDIA)),2)
END END_DATE_AUDITORIA
FROM MIG_TAKE_OVER_D_SCHEDULE_2 DULE
LEFT JOIN CACREDIT CREDIT
ON RTRIM(LTRIM(RIGHT(DULE.K_KEY,7))) = RTRIM(LTRIM(CREDIT.CANUCR))
LEFT JOIN (SELECT DISTINCT CANUCR,CDVACP,CDCFRE,CDANCP,CDMECP,CDDICP,CDMANO,CDMMES,CDMDIA FROM CACOMDIS) COMDIS
ON RTRIM(LTRIM(CREDIT.CANUCR)) = RTRIM(LTRIM(COMDIS.CANUCR))
AND DULE.ACTUAL_AMT = CASE WHEN COMDIS.CDVACP = 0 THEN NULL ELSE COMDIS.CDVACP END 
AND DULE.START_DATE = CONVERT(VARCHAR(MAX),COMDIS.CDANCP)+''+right(('00'+''+CONVERT(VARCHAR(MAX),COMDIS.CDMECP)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),COMDIS.CDDICP)),2)
WHERE DULE.TIPO = 'CAP'
UNION ALL
SELECT DISTINCT RTRIM(LTRIM(DULE.K_KEY))K_KEY , CASE WHEN DULE.K_KEY = RTRIM(LTRIM('LA'+CREDIT.CANUCR)) THEN RTRIM(LTRIM('LA'+CREDIT.CANUCR)) 
ELSE RTRIM(LTRIM('LB'+CREDIT.CANUCR)) END K_KEY_AUDITORIA,
DULE.ACTUAL_AMT,  CASE WHEN DULE.ACTUAL_AMT = COMDIS.CAVACP THEN COMDIS.CAVACP 
WHEN DULE.ACTUAL_AMT = 1 THEN 1 ELSE NULL END ACTUAL_AMT_AUDITORIA,
DULE.START_DATE, CASE WHEN COMDIS.CACFRE = 13 THEN 'R''_''MATURITY' ELSE CONVERT(VARCHAR(MAX),COMDIS.CAANCP)+''+right(('00'+''+CONVERT(VARCHAR(MAX),COMDIS.CAMECP)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),COMDIS.CADICP)),2)
END START_DATE_AUDITORIA,
CACFRE,
DULE.END_DATE, CASE WHEN COMDIS.CACFRE = 13 THEN 'R''_''MATURITY' 
WHEN COMDIS.CACFRE = 7 THEN CONVERT(VARCHAR(MAX),COMDIS.CAANCP)+''+right(('00'+''+CONVERT(VARCHAR(MAX),COMDIS.CAMECP)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),COMDIS.CADICP)),2)
ELSE CONVERT(VARCHAR(MAX),COMDIS.COMANO)+''+right(('00'+''+CONVERT(VARCHAR(MAX),COMDIS.COMMES)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),COMDIS.COMDIA)),2)
END END_DATE_AUDITORIA
FROM MIG_TAKE_OVER_D_SCHEDULE_2 DULE
LEFT JOIN CACREDIT CREDIT
ON RTRIM(LTRIM(RIGHT(DULE.K_KEY,7))) = RTRIM(LTRIM(CREDIT.CANUCR))
LEFT JOIN (SELECT DISTINCT CANUCR,CAVACP,CACFRE,CAANCP,CAMECP,CADICP,COMANO,COMMES,COMDIA FROM CACOMTRX) COMDIS
ON RTRIM(LTRIM(CREDIT.CANUCR)) = RTRIM(LTRIM(COMDIS.CANUCR))
AND DULE.ACTUAL_AMT = CASE WHEN DULE.ACTUAL_AMT = COMDIS.CAVACP THEN COMDIS.CAVACP 
WHEN DULE.ACTUAL_AMT = 1 THEN 1 ELSE NULL END  
AND DULE.START_DATE = CONVERT(VARCHAR(MAX),COMDIS.CAANCP)+''+right(('00'+''+CONVERT(VARCHAR(MAX),COMDIS.CAMECP)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),COMDIS.CADICP)),2)
WHERE DULE.TIPO = 'CAP2'

)X)




----9,189
--SELECT DISTINCT
--X.K_KEY,
--X.K_KEY_AUDITORIA,
--X.ACTUAL_AMT,
--X.ACTUAL_AMT_AUDITORIA,
--X.START_DATE,
--CASE WHEN START_DATE >= 20210621  THEN X.START_DATE 
--	 WHEN START_DATE = 20210621 THEN 20210621 ELSE '' END AS START_DATE_AUDITORIA,
--X.END_DATE,
--CASE 
--            WHEN ( X.CAFRRE = 7 OR X.END_DATE  < CASE WHEN START_DATE >= 20210621 THEN X.START_DATE ELSE 20210621 END)
--                THEN 
--                CASE  WHEN START_DATE >= 20210621  THEN X.START_DATE 
--					  WHEN START_DATE = 20210621 THEN 20210621 ELSE ''  END
--            ELSE 
--                X.END_DATE 
--            END 
--    AS END_DATE_AUDITORIA 


--FROM(
--SELECT DISTINCT
--RTRIM(LTRIM(DULE.K_KEY))K_KEY , CASE WHEN DULE.K_KEY = RTRIM(LTRIM('LA'+CREDIT.CANUCR)) THEN RTRIM(LTRIM('LA'+CREDIT.CANUCR)) 
--ELSE RTRIM(LTRIM('LB'+CREDIT.CANUCR)) END K_KEY_AUDITORIA,
--DULE.ACTUAL_AMT,  CASE WHEN DULE.ACTUAL_AMT = BADI.CAMFRE THEN BADI.CAMFRE
--WHEN DULE.ACTUAL_AMT = 1 THEN 1 ELSE NULL END ACTUAL_AMT_AUDITORIA,
--DULE.START_DATE, CASE WHEN BADI.CAFRRE = 13 THEN 'R''_''MATURITY' ELSE CONVERT(VARCHAR(MAX),BADI.CAASRE)+''+right(('00'+''+CONVERT(VARCHAR(MAX),BADI.CAMSRE)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),BADI.CADSRE)),2)
--END START_DATE_AUDITORIA,
--DULE.END_DATE,
--CASE
--	WHEN BADI.CAFRRE = 13 
--		 THEN 'R''_''MATURITY'
--    WHEN BADI.CAFRRE = 7 
--		 THEN CASE WHEN CONVERT(VARCHAR(MAX),DISCAP.DSAVCP)+''+right(('00'+''+CONVERT(VARCHAR(MAX),DISCAP.DSMVCP)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),DISCAP.DSDVCP)),2) <= CONVERT(VARCHAR(MAX),BADI.CAASRE)+''+right(('00'+''+CONVERT(VARCHAR(MAX),BADI.CAMSRE)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),BADI.CADSRE)),2) THEN CONVERT(VARCHAR(MAX),CREDIT.CRAVCP)+''+right(('00'+''+CONVERT(VARCHAR(MAX),CREDIT.CRMVCP)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),CREDIT.CRDVCP)),2) ELSE CONVERT(VARCHAR(MAX),BADI.CAASRE)+''+right(('00'+''+CONVERT(VARCHAR(MAX),BADI.CAMSRE)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),BADI.CADSRE)),2) END
--	ELSE
--		CASE WHEN CONVERT(VARCHAR(MAX),DISCAP.DSAVCP)+''+right(('00'+''+CONVERT(VARCHAR(MAX),DISCAP.DSMVCP)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),DISCAP.DSDVCP)),2) <= CONVERT(VARCHAR(MAX),BADI.CAAVRE)+''+right(('00'+''+CONVERT(VARCHAR(MAX),BADI.CAMVRE)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),BADI.CADVRE)),2) THEN CONVERT(VARCHAR(MAX),DISCAP.DSAVCP)+''+right(('00'+''+CONVERT(VARCHAR(MAX),DISCAP.DSMVCP)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),DISCAP.DSDVCP)),2) ELSE CONVERT(VARCHAR(MAX),BADI.CAAVRE)+''+right(('00'+''+CONVERT(VARCHAR(MAX),BADI.CAMVRE)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),BADI.CADVRE)),2) END
--	END END_DATE_AUDITORIA,
--	BADI.CAFRRE
--FROM MIG_TAKE_OVER_D_SCHEDULE_2 DULE
--LEFT JOIN CACREDIT CREDIT
--ON RTRIM(LTRIM(RIGHT(DULE.K_KEY,7))) = RTRIM(LTRIM(CREDIT.CANUCR))
--LEFT JOIN (SELECT  CANUCR,CAMFRE,CAFRRE,CAASRE,CAMSRE,CADSRE,CAAVRE,CAMVRE,CADVRE FROM CACOBADI) BADI
--ON  RTRIM(LTRIM(RIGHT(DULE.K_KEY,7))) = RTRIM(LTRIM(BADI.CANUCR))
--AND DULE.ACTUAL_AMT =  CASE WHEN DULE.ACTUAL_AMT = BADI.CAMFRE THEN BADI.CAMFRE
--WHEN DULE.ACTUAL_AMT = 1 THEN 1 ELSE NULL END
--AND DULE.START_DATE =  CONVERT(VARCHAR(MAX),BADI.CAASRE)+''+right(('00'+''+CONVERT(VARCHAR(MAX),BADI.CAMSRE)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),BADI.CADSRE)),2)
--LEFT JOIN (SELECT  CANUCR,DSAVCP,DSMVCP,DSDVCP FROM CADISCAP) DISCAP
--ON  RTRIM(LTRIM(RIGHT(DULE.K_KEY,7))) = RTRIM(LTRIM(DISCAP.CANUCR))
--AND DULE.END_DATE = CONVERT(VARCHAR(MAX),CREDIT.CRAVCP)+''+right(('00'+''+CONVERT(VARCHAR(MAX),CREDIT.CRMVCP)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),CREDIT.CRDVCP)),2)
--AND DULE.END_DATE = CONVERT(VARCHAR(MAX),BADI.CAASRE)+''+right(('00'+''+CONVERT(VARCHAR(MAX),BADI.CAMSRE)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),BADI.CADSRE)),2)
--AND DULE.END_DATE = CONVERT(VARCHAR(MAX),DISCAP.DSAVCP)+''+right(('00'+''+CONVERT(VARCHAR(MAX),DISCAP.DSMVCP)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),DISCAP.DSDVCP)),2)
--AND DULE.END_DATE = CONVERT(VARCHAR(MAX),BADI.CAAVRE)+''+right(('00'+''+CONVERT(VARCHAR(MAX),BADI.CAMVRE)),2)+''+right(('00'+''+CONVERT(VARCHAR(MAX),BADI.CADVRE)),2)
--WHERE DULE.TIPO = 'INT'
--)X)



--SELECT K_KEY,K_KEY_AUDITORIA FROM CTE
--WHERE K_KEY <> K_KEY_AUDITORIA

--SELECT ACTUAL_AMT, ACTUAL_AMT_AUDITORIA FROM CTE
--WHERE ACTUAL_AMT <>  ACTUAL_AMT_AUDITORIA  

----REVISAR CON LOS MUCHACHOS DE GERENCIAL
--SELECT K_KEY,START_DATE,  START_DATE_AUDITORIA
--FROM CTE
--WHERE START_DATE<>  START_DATE_AUDITORIA 

----REVISAR CON LOS MUCHACHOS DE GERENCIAL
--SELECT K_KEY,END_DATE,  END_DATE_AUDITORIA
--FROM CTE
--WHERE END_DATE<>  END_DATE_AUDITORIA 