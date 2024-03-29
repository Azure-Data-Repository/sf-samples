CREATE DATABASE IF NOT EXISTS SPCS_SNOWDRIVER_LIB;
CREATE SCHEMA IF NOT EXISTS GO;

CREATE IMAGE REPOSITORY IF NOT EXISTS REPO;

CREATE COMPUTE POOL IF NOT EXISTS SPCS_SNOWSRIVER_LIB
  MIN_NODES=1
  MAX_NODES=1
  INSTANCE_FAMILY=STANDARD_1;

USE SCHEMA SPCS_SNOWDRIVER_LIB.GO;
EXECUTE SERVICE
IN COMPUTE POOL SPCS_SNOWSRIVER_LIB
FROM SPECIFICATION $$
spec:
  containers:
  - name: go
    image: /spcs_snowdriver_lib/go/repo/connection_test_go:v0.1
    command:
    - bash
    args:
    - -c
    - "./connection_test_go"
$$;

SET JOB_ID = LAST_QUERY_ID();

CALL SYSTEM$GET_JOB_LOGS($JOB_ID, 'go');
