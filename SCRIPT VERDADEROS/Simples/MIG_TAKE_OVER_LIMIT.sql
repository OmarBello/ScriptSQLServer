--MIG_TAKE_OVER_LIMIT
--TOTAL 3,579

WITH CTE AS(
SELECT DISTINCT RTRIM(LTRIM(MIT.K_KEY)) K_KEY, RTRIM(LTRIM('L'+CREDIT.CANUCR)) K_KEY_AUDITORIA,
MIT.LIMIT_SERIAL, CASE WHEN MIT.LIMIT_SERIAL = 1 THEN 1 ELSE CCGB.SERIAL_NUMBER END LIMIT_SERIAL_AUDITORIA,
MIT.LIMIT_REFERENCE, CASE WHEN MIT.LIMIT_REFERENCE = CCGB.LIMIT_PRODUCT THEN CCGB.LIMIT_PRODUCT ELSE CUPS.LIMITE_SUBPRODUCTO
END LIMIT_REFERENCE_AUDITORIA
FROM MIG_TAKE_OVER_LIMIT MIT
LEFT JOIN CACREDIT CREDIT
ON RTRIM(LTRIM(MIT.K_KEY)) = RTRIM(LTRIM('L'+CREDIT.CANUCR))
LEFT JOIN MIG_HOM_CUPOS CUPS
ON MIT.LIMIT_REFERENCE = CUPS.LIMITE_SUBPRODUCTO
LEFT JOIN(
SELECT 
        PRODUCTO,
        LIMIT_PRODUCT,
        SERIAL_NUMBER
    FROM KIM_ESP_REL_PRODUCTO_PROPIEDAD RPP
    INNER JOIN KIM_ESP_RELACION_GARANTIA_PROP RGP
    ON RPP.NUMERO_DE_PROPIEDAD = RGP.ID_PROPIEDAD_RGP
    INNER JOIN KIM_CONTRATO_2 KC2
    ON RGP.ID_GARANTIA_RGP = KC2.ID_GARANTIA_RGP
    INNER JOIN mig_limit_contrato CONT
    ON KC2.ID_CTR = SUBSTRING(CONT.NUMERO_CONTRATO,10,(LEN(CONT.NUMERO_CONTRATO)-9))
    WHERE KC2.CONDICION_CONTRATO_CGB <> 'Retirado'
)CCGB
ON CCGB.PRODUCTO = TRIM(CREDIT.CANUCR) 
--AND MIT.LIMIT_REFERENCE = CASE WHEN MIT.LIMIT_REFERENCE = CCGB.LIMIT_PRODUCT THEN CCGB.LIMIT_PRODUCT ELSE CUPS.LIMITE_SUBPRODUCTO
--END
AND MIT.LIMIT_SERIAL = CASE WHEN MIT.LIMIT_SERIAL = 1 THEN 1 ELSE CCGB.SERIAL_NUMBER END
AND MIT.LIMIT_REFERENCE = CASE WHEN MIT.LIMIT_REFERENCE = CCGB.LIMIT_PRODUCT THEN CCGB.LIMIT_PRODUCT ELSE CUPS.LIMITE_SUBPRODUCTO
END 


)

----TOTAL DE REGISTRO QUE SE IMPORTO
--SELECT COUNT(*)  FROM CTE


----K_KEY VS K_KEY_AUDITORIA
--SELECT K_KEY, K_KEY_AUDITORIA FROM CTE
--WHERE K_KEY <> K_KEY_AUDITORIA


----LIMIT_REFERENCE VS LIMIT_REFERENCE_AUDITORIA
--SELECT LIMIT_REFERENCE, LIMIT_REFERENCE_AUDITORIA FROM CTE
--WHERE LIMIT_REFERENCE <> LIMIT_REFERENCE_AUDITORIA


----LIMIT_SERIAL VS LIMIT_SERIAL_AUDITORIA
--SELECT K_KEY,LIMIT_SERIAL, LIMIT_SERIAL_AUDITORIA FROM CTE
--WHERE LIMIT_SERIAL <> LIMIT_SERIAL_AUDITORIA






