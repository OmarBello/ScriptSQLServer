--MIG_TAKE_OVER_SETTLEMENT
--TOTAL 213,933

WITH CTE AS(
SELECT DISTINCT RTRIM(LTRIM(SETT.K_KEY)) K_KEY , RTRIM(LTRIM('L'+CREDIT.CANUCR)) K_KEY_AUDITORIA,
SETT.LT_DISB_ACCT,CASE WHEN MACTA1.CCNCLI IS NOT NULL THEN  CASE WHEN CAST(CATICT AS  varchar(max)) = 0 THEN NULL ELSE CAST(CATICT AS  varchar(max)) END + CASE WHEN CANCTA  = 0 THEN NULL ELSE dbo.LPAD(CANCTA ,10,'0')  END  END  LT_DISB_ACCT_AUDITORIA,
SETT.LT_AA_PAY_IN, CASE WHEN MACTA1.CCNCLI IS NOT NULL THEN  CASE WHEN CAST(CATICT AS  varchar(max)) = 0 THEN NULL ELSE CAST(CATICT AS  varchar(max)) END + CASE WHEN CANCTA  = 0 THEN NULL ELSE dbo.LPAD(CANCTA ,10,'0')  END  END LT_AA_PAY_IN_AUDITORIA
FROM MIG_TAKE_OVER_SETTLEMENT SETT
LEFT JOIN CACREDIT CREDIT 
ON RTRIM(LTRIM(SETT.K_KEY)) = RTRIM(LTRIM('L'+CREDIT.CANUCR))
INNER JOIN ( SELECT CANUCR FROM DISCAP_DIS_SIM_SALD_SIMPLES UNION SELECT CANUCR FROM DISCAP_DIS_SIM_SALD_EX_DIST ) DISCAP
ON RTRIM(LTRIM(CREDIT.CANUCR)) = RTRIM(LTRIM(DISCAP.CANUCR))
left outer join CCMACTA MACTA1
    on (
      RTRIM(LTRIM(MACTA1.CCNCLI)) = substring(
        (cast(case
          when CATICT = 0 then null
          else CATICT
        end as varchar(max)) + cast(case
          when CANCTA = 0 then null
          else (replicate(
            '0',
            (10 - len(CANCTA))
          ) + cast(CANCTA as varchar(max)))
        end as varchar(max))),
        2,
        7
      )
      and RTRIM(LTRIM(MACTA1.CCNCTA)) = cast(substring(
        (cast(case
          when CATICT = 0 then null
          else CATICT
        end as varchar(max)) + cast(case
          when CANCTA = 0 then null
          else (replicate(
            '0',
            (10 - len(CANCTA))
          ) + cast(CANCTA as varchar(max)))
        end as varchar(max))),
        8,
        3
      ) as numeric)
      and RTRIM(LTRIM(MACTA1.CCDVER)) = substring(
        (cast(case
          when CATICT = 0 then null
          else CATICT
        end as varchar(max)) + cast(case
          when CANCTA = 0 then null
          else (replicate(
            '0',
            (10 - len(CANCTA))
          ) + cast(CANCTA as varchar(max)))
        end as varchar(max))),
        11,
        1
      )
    )

)

----TOTAL DE REGISTRO QUE SE IMPORTARON
--SELECT COUNT(*) FROM CTE


----K_KEY VS K_KEY_AUDITORIA
--SELECT K_KEY, K_KEY_AUDITORIA FROM CTE
--WHERE K_KEY <> K_KEY_AUDITORIA


----LT_DISB_ACCT VS LT_DISB_ACCT_AUDITORIA
--SELECT LT_DISB_ACCT , LT_DISB_ACCT_AUDITORIA FROM CTE
--WHERE LT_DISB_ACCT <> LT_DISB_ACCT_AUDITORIA

----LT_AA_PAY_IN VS LT_AA_PAY_IN_AUDITORIA
--SELECT LT_AA_PAY_IN , LT_AA_PAY_IN_AUDITORIA FROM CTE
--WHERE LT_AA_PAY_IN <> LT_AA_PAY_IN_AUDITORIA

