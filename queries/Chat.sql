WITH target_users AS (
  SELECT
    16561820::bigint AS sender_id,
    25875522::bigint AS receiver_id
)
SELECT
  m.conversation_id,
  m.id AS message_id,
  m.created_at,
  t.sender_id AS "sender-id",
  t.receiver_id AS "receiver-id",
  m.sender AS actual_sender_id,
  m.receiver AS actual_receiver_id,
  CASE
    WHEN m.sender = t.sender_id
      AND m.receiver = t.receiver_id
      THEN 'sender-id -> receiver-id'
    WHEN m.sender = t.receiver_id
      AND m.receiver = t.sender_id
      THEN 'receiver-id -> sender-id'
  END AS direction,
  m.message
FROM laravel.conversation_messages m
CROSS JOIN target_users t
WHERE (
    m.sender = t.sender_id
    AND m.receiver = t.receiver_id
  )
  OR (
    m.sender = t.receiver_id
    AND m.receiver = t.sender_id
  )
ORDER BY
  m.created_at ASC,
  m.id ASC;
