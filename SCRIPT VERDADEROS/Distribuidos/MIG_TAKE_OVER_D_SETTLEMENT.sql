--MIG_TAKE_OVER_D_SETTLEMENT
--10,624

WITH CTE AS(
SELECT RTRIM(LTRIM(OVER_D.K_KEY))K_KEY, CASE WHEN OVER_D.K_KEY = RTRIM(LTRIM('LA'+CREDIT.CANUCR)) THEN RTRIM(LTRIM('LA'+CREDIT.CANUCR)) 
ELSE RTRIM(LTRIM('LB'+CREDIT.CANUCR)) END K_KEY_AUDITORIA,
OVER_D.LT_DISB_ACCT,CASE WHEN MACTA1.CCNCLI IS NOT NULL THEN  CASE WHEN CAST(CATICT AS  varchar(max)) = 0 THEN NULL ELSE CAST(CATICT AS  varchar(max)) END + CASE WHEN CANCTA  = 0 THEN NULL ELSE dbo.LPAD(CANCTA ,10,'0')  END  END  LT_DISB_ACCT_AUDITORIA,
OVER_D.LT_AA_PAY_IN, CASE WHEN MACTA1.CCNCLI IS NOT NULL THEN  CASE WHEN CAST(CATICT AS  varchar(max)) = 0 THEN NULL ELSE CAST(CATICT AS  varchar(max)) END + CASE WHEN CANCTA  = 0 THEN NULL ELSE dbo.LPAD(CANCTA ,10,'0')  END  END LT_AA_PAY_IN_AUDITORIA
FROM MIG_TAKE_OVER_D_SETTLEMENT OVER_D
LEFT JOIN CACREDIT CREDIT 
ON RTRIM(LTRIM(RIGHT(OVER_D.K_KEY,7))) =  RTRIM(LTRIM(CREDIT.CANUCR))
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


--SELECT K_KEY, K_KEY_AUDITORIA FROM CTE
--WHERE K_KEY <> K_KEY_AUDITORIA



--SELECT LT_DISB_ACCT, LT_DISB_ACCT_AUDITORIA FROM CTE
--WHERE LT_DISB_ACCT <> LT_DISB_ACCT_AUDITORIA


--SELECT LT_AA_PAY_IN, LT_AA_PAY_IN_AUDITORIA FROM CTE
--WHERE LT_AA_PAY_IN <> LT_AA_PAY_IN_AUDITORIA