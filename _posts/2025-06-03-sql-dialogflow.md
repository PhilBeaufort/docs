---
layout: post
title: SQL Dialogflow
date: 2025-06-03 00:04 -0400
---

SQL Query for dialogflow monitoring wuith Google Cloud

```sql
WITH sources AS (
  SELECT * FROM  `PROJECT_ID.northamerica-northeast1.dialogflow._AllLogs`
),

logs_bucket AS (
  SELECT
    severity,
    timestamp,
    EXTRACT(MINUTE FROM timestamp) AS minute,
    EXTRACT(HOUR FROM timestamp) AS hour,
    EXTRACT(DAY FROM timestamp) AS day,
    EXTRACT(MONTH FROM timestamp) AS month,
    EXTRACT(YEAR FROM timestamp) AS year,
    insert_id,
    log_id,
    log_name,
    JSON_VALUE(resource.labels.project_id) AS project_id,
    labels,
    text_payload,
    proto_payload,
    json_payload,
  FROM sources
),

es_logs AS (
  SELECT
    *,
    JSON_VALUE(labels.request_id) as intent_response_id,
    REGEXP_EXTRACT(text_payload, r'session_id: "([^"]+)"') AS session_id,
    REGEXP_EXTRACT(text_payload, r'lang: "([^"]+)"') AS language_code,
    REGEXP_EXTRACT(text_payload, r'intent_name: "([^"]+)"') AS intent_name,
	  REGEXP_EXTRACT(text_payload, r'resolved_query: "([^"]+)"') AS userText,
	  REGEXP_EXTRACT(text_payload, r'speech: "([^"]+)"') AS responseText,
    ROW_NUMBER() OVER (
      PARTITION BY 
        REGEXP_EXTRACT(text_payload, r'session_id: "([^"]+)"'), 
        REGEXP_EXTRACT(text_payload, r'intent_name: "([^"]+)"'), 
        TIMESTAMP_TRUNC(timestamp, MINUTE) 
        ORDER BY timestamp
    ) AS row_num
  FROM logs_bucket
  WHERE
    NORMALIZE_AND_CASEFOLD(severity , NFKC) = "info"
    AND NORMALIZE_AND_CASEFOLD(log_name , NFKC) = "projects/mega-agent-xllj/logs/dialogflow_agent"
    AND NORMALIZE_AND_CASEFOLD(SAFE.STRING(labels ["type"]), NFKC) = "dialogflow_response"
    AND NORMALIZE_AND_CASEFOLD(REGEXP_EXTRACT(text_payload, r'intent_name: "([^"]+)"'), NFKC) != "default welcome intent"
    AND DATE(timestamp) NOT IN (DATE '2024-07-04', DATE '2024-07-15', DATE '2024-07-16') --Date to exclude
),

es_logs_filtered AS (
    SELECT *
    FROM es_logs
    WHERE row_num = 1
),

es_request_logs AS (
  SELECT
    *,
    JSON_VALUE(json_payload.responseId) as intent_response_id,
    JSON_VALUE(json_payload.originalDetectIntentRequest.payload.applicationId) as application_id,
    JSON_VALUE(json_payload.originalDetectIntentRequest.payload.botId) as bot_id,
    TRIM(JSON_VALUE(json_payload.originalDetectIntentRequest.payload.firstName)) as first_name,
    JSON_VALUE(json_payload.originalDetectIntentRequest.payload.from) as from_user,
    JSON_VALUE(json_payload.originalDetectIntentRequest.payload.groupId) as session_id,
  FROM logs_bucket
  WHERE
    log_name="projects/mega-agent-xllj/logs/run.googleapis.com%2Fstdout"
    AND json_payload.originalDetectIntentRequest.payload IS NOT NULL
),

es_resquest_response_logs_join as (
  SELECT 
    b.timestamp as timestamp,
    b.severity,
    b.log_name,
    b.session_id,
    b.intent_response_id,
    a.insert_id as insert_id_a,
    b.insert_id as insert_id_b,
    a.application_id,
    a.bot_id,
    a.first_name,
    a.from_user,
    b.intent_name as response_intent,
    b.userText,
    b.responseText,
    b.language_code,
    b.text_payload,
    ROW_NUMBER() OVER (PARTITION BY b.insert_id ORDER BY b.timestamp DESC) AS row_num
  FROM es_request_logs a
  LEFT JOIN es_logs_filtered b
    ON a.intent_response_id = b.intent_response_id
    AND a.timestamp <= b.timestamp  -- Prevent duplicate pairs
    AND a.session_id = b.session_id
),

cx_logs AS (
  SELECT
    *,
    JSON_VALUE(labels.agent_id) as agent_id,
    JSON_VALUE(labels.session_id) as session_id,
    JSON_VALUE(json_payload.responseId) as intent_response_id,
    JSON_VALUE(json_payload.queryResult.match.matchType) as matchType,
    JSON_VALUE(json_payload.queryResult.match.intent.displayName) as intent_name,
    JSON_VALUE(json_payload.queryResult.match.event) as event_name,
    JSON_VALUE(json_payload.queryResult.generativeInfo.actionTracingInfo.actions[0].userUtterance.text) as userText,
    JSON_VALUE(json_payload.queryResult.generativeInfo.actionTracingInfo.actions[1].agentUtterance.text) as responseText,
    JSON_VALUE(json_payload.queryResult.languageCode) as language_code,
  FROM logs_bucket
  WHERE
    log_name="projects/mega-agent-xllj/logs/dialogflow-runtime.googleapis.com%2Frequests"
    AND json_payload.queryResult.match IS NOT NULL
),

cx_logs_filtered AS (
  SELECT *
  FROM cx_logs
  WHERE
    agent_id = "DIALOGFLOW_CX_AGENT_ID"
    AND NOT (
      (intent_name IS NOT DISTINCT FROM "Default Welcome Intent")
      OR (event_name IS NOT DISTINCT FROM "welcome_sti")
    )
),

cx_resquest_logs as (
  SELECT 
    *,
    JSON_VALUE(labels.agent_id) as agent_id,
    JSON_VALUE(labels.session_id) as session_id,
    JSON_VALUE(json_payload.fulfillmentInfo.tag) as tag,
    JSON_VALUE(json_payload.detectIntentResponseId) as intent_response_id,
    JSON_VALUE(json_payload.payload.applicationId) as application_id,
    JSON_VALUE(json_payload.payload.botId) as bot_id,
    JSON_VALUE(json_payload.payload.firstName) as first_name,
    JSON_VALUE(json_payload.payload.from) as from_user,
    JSON_VALUE(json_payload.payload.groupId) as group_id,
    JSON_VALUE(json_payload.triggerEvent) as triggerEvent,
    JSON_VALUE(json_payload.text) as text
  FROM logs_bucket
  WHERE 
    log_name = "projects/mega-agent-xllj/logs/dialogflow-runtime.googleapis.com%2Frequests"
    AND JSON_VALUE(labels.agent_id) = "DIALOGFLOW_CX_AGENT_ID"
    AND json_payload.payload IS NOT NULL
),

cx_resquest_response_logs_join as (
  SELECT 
    a.timestamp as timestamp,
    a.severity,
    a.log_name,
    a.session_id,
    a.intent_response_id,
    a.insert_id as insert_id_a,
    b.insert_id as insert_id_b,
    a.application_id,
    a.bot_id,
    a.first_name,
    a.from_user,
    a.tag as request_tag,
    a.triggerEvent as request_event,
    a.text as request_text,
    b.matchType as response_match,
    b.intent_name as response_intent,
    b.event_name as response_event,
    b.userText,
    b.responseText,
    b.language_code,
    b.json_payload,
    ROW_NUMBER() OVER (PARTITION BY a.insert_id ORDER BY a.timestamp DESC) AS row_num
  FROM cx_resquest_logs a
  LEFT JOIN cx_logs_filtered b
    ON a.intent_response_id = b.intent_response_id
    AND a.timestamp <= b.timestamp  -- Prevent duplicate pairs
    AND a.session_id = b.session_id
),

combined_response_logs AS (
  SELECT 
    'ES' AS source_data,
    severity,
    timestamp,
    minute,
    hour,
    day,
    month,
    year,
    insert_id,
    log_id,
    log_name,
    session_id,
    language_code,
    intent_name,
    userText,
    responseText,
    text_payload,
    NULL as json_payload,
  FROM es_logs_filtered

  UNION ALL

  SELECT 
    'CX' AS source_data,
    severity,
    timestamp,
    minute,
    hour,
    day,
    month,
    year,
    insert_id,
    log_id,
    log_name,
    session_id,
    language_code,
    intent_name,
    userText,
    responseText,
    NULL as text_payload,
    json_payload
  FROM cx_logs_filtered
),

combined_response_logs_null AS (
  SELECT
    'ES' AS source_data, 
    severity,
    timestamp,
    minute,
    hour,
    day,
    month,
    year,
    insert_id,
    log_id,
    log_name,
    NULL AS project_id,  -- Not present in ES logs
    NULL AS agent_id,     -- Not present in ES logs
    session_id,
    NULL AS matchType,    -- Not present in ES logs
    intent_name,
    NULL AS event_name,   -- Not present in ES logs
    userText,
    responseText,
    language_code,
    text_payload,
    NULL as json_payload,
  FROM es_logs_filtered

  UNION ALL 

  SELECT
    'CX' AS source_data,
    severity,
    timestamp,
    minute,
    hour,
    day,
    month,
    year,
    insert_id,
    log_id,
    log_name,
    project_id,
    agent_id,
    session_id,
    matchType,
    intent_name,
    event_name,
    userText,
    responseText,
    language_code,
    NULL as text_payload,
    json_payload
  FROM cx_logs_filtered
),

combined_request_logs AS (
  SELECT
    'ES' AS source_data, 
    severity,
    timestamp,
    EXTRACT(MINUTE FROM timestamp) AS minute,
    EXTRACT(HOUR FROM timestamp) AS hour,
    EXTRACT(DAY FROM timestamp) AS day,
    EXTRACT(MONTH FROM timestamp) AS month,
    EXTRACT(YEAR FROM timestamp) AS year,
    session_id,
    intent_response_id,
    insert_id_a,
    insert_id_b,
    application_id,
    bot_id,
    first_name,
    from_user,
    NULL AS request_tag,
    NULL AS request_event,
    NULL AS request_text,
    NULL AS response_match,
    NULL AS response_event,
    response_intent,
    userText,
    responseText,
    language_code,
    text_payload,
    NULL as json_payload,
  FROM es_resquest_response_logs_join
  WHERE row_num = 1

  UNION ALL 

  SELECT
    'CX' AS source_data,
    severity,
    timestamp,
    EXTRACT(MINUTE FROM timestamp) AS minute,
    EXTRACT(HOUR FROM timestamp) AS hour,
    EXTRACT(DAY FROM timestamp) AS day,
    EXTRACT(MONTH FROM timestamp) AS month,
    EXTRACT(YEAR FROM timestamp) AS year,
    session_id,
    intent_response_id,
    insert_id_a,
    insert_id_b,
    application_id,
    bot_id,
    first_name,
    from_user,
    request_tag,
    request_event,
    request_text,
    response_match,
    response_event,
    response_intent,
    userText,
    responseText,
    language_code,
    NULL as text_payload,
    json_payload
  FROM cx_resquest_response_logs_join
  WHERE row_num = 1
)

SELECT
  #ROW_NUMBER() OVER() AS order_id,
  FORMAT_TIMESTAMP('%Y-%m', TIMESTAMP_TRUNC(timestamp, MONTH)) AS month,
  COUNT(month) AS total_requests
FROM combined_response_logs
GROUP BY month
ORDER BY month
```
