CREATE TABLE audit_sample_result
(
    audit_ID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    case_number     VARCHAR2(20)    NOT NULL,
    report_type     VARCHAR2(30)    NOT NULL,
    sample_date     DATE            NOT NULL,
    sampling_round  NUMBER          NOT NULL,
    audit_status VARCHAR2(20) DEFAULT 'PENDING'
                 CHECK (audit_status IN('PENDING', 'IN_REVIEW', 'COMPLETED', 'FAILED')),
    review_status VARCHAR2(20) DEFAULT  'NEW',
    reviewer VARCHAR2(50),
    comments VARCHAR2(200),
    last_updated DATE DEFAULT SYSDATE               
);