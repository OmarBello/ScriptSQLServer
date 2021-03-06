--LIMIT PRODUCT
--TOTAL 16,328

--SELECT   PRODUCTS.UPLOAD_COMPANY, CASE WHEN EXISTS(SELECT SUCL.COMPANY INTERSECT SELECT NULL) THEN CR.SUCURSAL_T24 ELSE SUCL.COMPANY END COMPANY,
--	   PRODUCTS.APPROVAL_DATE, LCL.LIFEAP,
--	   PRODUCTS.REVIEW_FREQUENCY, CASE WHEN LCL.LIFREV <= 20210621 THEN 'M1218' ELSE 'M12' + SUBSTRING(CAST(LCL.LIFREV AS VARCHAR(MAX)),7,2) END AS REVIEW_FREQUENCY,
--	   PRODUCTS.EXPIRY_DATE, CASE WHEN LCL.LIFVEN <= 20210517 THEN '20210518' ELSE CAST(COALESCE(LCL.LIFVEN,0) AS VARCHAR(MAX)) END AS EXPIRY_DATE,
--	   PRODUCTS.NOTES, 'F.ORIG '+CAST(LCL.LIFCER AS VARCHAR(MAX))+' F.REV '+CAST(LCL.LIFREV AS VARCHAR(MAX))+'::F.APROB '+CAST(LCL.LIFEAP AS VARCHAR(MAX)) NOTES
--FROM MIG_LIMIT_PRODUCTS PRODUCTS
--LEFT JOIN MIG_HOM_SUCURSAL_LIMIT SUCL ON PRODUCTS.UPLOAD_COMPANY = SUCL.COMPANY
--LEFT JOIN LCLINEA LCL ON PRODUCTS.LOCAL_REF = LCL.LINUAP
--LEFT JOIN (SELECT DISTINCT CPMAPR,CPMONE FROM LCCUPOS) LCCU 
--ON CONVERT(DECIMAL(14,2),PRODUCTS.INTERNAL_AMOUNT)=LCCU.CPMAPR 
--LEFT JOIN CUSTOMER_CODE_REL CR ON PRODUCTS.CUSTOMER_NUMBER = CR.CUSTOMER_CODE
----WHERE PRODUCTS.CUSTOMER_NUMBER = '0000000120'




select  CASE
    WHEN trim(LCT.TMMONE) = trim(LCCU.CPMONE) THEN round(
      (LCCU.CPMAPR * LCT.TMTASA),
      2
    )
    WHEN trim(LCT.TMMONE) = trim(LCCU.CPMONE) THEN round(
      (LCCU.CPMAPR * LCT.TMTASA),
      2
    )
    ELSE round(
      (LCCU.CPMAPR * LCT.TMTASA),
      2
    )
  END INTERNAL_AMOUNT, PRODUCTS.INTERNAL_AMOUNT 
from LCLINEA LCL
LEFT JOIN LCCUPOS LCCU ON RTRIM(LTRIM(LCCU.CPCLIE))=RTRIM(LTRIM(LCL.LICLIE))
LEFT JOIN LCTAMON LCT ON RTRIM(LTRIM(LCT.TMMONE))=RTRIM(LTRIM(LCCU.CPMONE))




