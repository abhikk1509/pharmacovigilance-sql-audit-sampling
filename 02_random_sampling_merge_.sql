BEGIN
    DBMS_RANDOM.SEED(07062026);
END;
/

MERGE INTO audit_sample_result tgt
USING
(
WITH RAND AS
(
    SELECT 
        CASE_NUMBER,
        REPORT_TYPE,
        DBMS_RANDOM.VALUE AS RAN_NUM
    FROM
        AUDIT_CASE_POOL
),

CRANK AS
(
    SELECT 
        CASE_NUMBER,
        REPORT_TYPE,
        RAN_NUM,
        ROW_NUMBER() OVER
        (
            PARTITION BY REPORT_TYPE
            ORDER BY RAN_NUM
        ) AS RAN
    FROM
        RAND
),

ALL_CASES AS
(
    SELECT
        REPORT_TYPE,
        COUNT(*) AS TOTAL_CASES
    FROM CRANK
    GROUP BY REPORT_TYPE
),

SAMPLING AS
(
    SELECT
        REPORT_TYPE,
        CASE
            WHEN REPORT_TYPE = 'CLINICAL_TRIAL' THEN CEIL(TOTAL_CASES * 0.20)
            WHEN REPORT_TYPE = 'SPONTANEOUS' THEN CEIL(TOTAL_CASES * 0.30)
            ELSE CEIL(TOTAL_CASES*0.22)
        END AS SAMPLE_SIZE
    FROM
        ALL_CASES
)

SELECT
    REPORT_TYPE,
    CASE_NUMBER
FROM
    (
        SELECT
            CRA.REPORT_TYPE,
            CRA.CASE_NUMBER,
            CRA.RAN,
            SAM.SAMPLE_SIZE
        FROM
            CRANK CRA
        JOIN
            SAMPLING SAM
        ON CRA.REPORT_TYPE = SAM.REPORT_TYPE
    )
WHERE RAN <= SAMPLE_SIZE) src

ON (tgt.case_number = src.case_number)

WHEN MATCHED THEN
    UPDATE SET 
               tgt.last_updated = SYSDATE,
               tgt.review_status = 'EXISTING'

WHEN NOT MATCHED THEN
    INSERT(
            case_number,
            report_type,
            sample_date,
            sampling_round,
            audit_status,
            review_status
    )
    VALUES(
            SRC.CASE_NUMBER,
            SRC.REPORT_TYPE,
            SYSDATE,
            2,
            'PENDING',
            'NEW'
    );
COMMIT;