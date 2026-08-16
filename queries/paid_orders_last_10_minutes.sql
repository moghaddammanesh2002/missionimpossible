-- Source: https://metabase.basalam.dev/question/106567
-- Description: Paid orders in the last 10 minutes.

SELECT
    pi.*,
    pii.*
FROM laravel.payment_invoices AS pi
INNER JOIN laravel.payment_invoice_items AS pii
    ON pii.invoice_id = pi.id
WHERE pi.status = 2999
  AND pii.deleted_at IS NULL
  AND pi.paid_at >= CURRENT_TIMESTAMP - INTERVAL '10 minutes'
  AND pi.paid_at < CURRENT_TIMESTAMP
ORDER BY pi.paid_at DESC;
