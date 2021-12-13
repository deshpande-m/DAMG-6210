-- Index on table ORDER_TRACKING col TRACKING NUMBER
create index order_tracking_tracking_number_I on order_tracking (tracking_number);

-- Index on table ORDER_TRACKING col ORDER ID
create index order_tracking_order_id_I on order_tracking (order_id);

-- Index on table REVIEWS col ORDER_ITEM_ID
create index reviews_order_item_id_I on reviews (order_item_id);

-- Index on table TRANSACTION col ORDER_ID
create index transaction_order_id_I on transaction (order_id);