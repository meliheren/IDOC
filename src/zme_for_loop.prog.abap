*&---------------------------------------------------------------------*
*& Report ZME_FOR_LOOP
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zme_for_loop.

TYPES : BEGIN OF ty_aubel,
          aubel TYPE vbeln_va,
        END OF ty_aubel.

DATA : lt_aubel TYPE TABLE OF ty_aubel.


lt_aubel = VALUE #( ( aubel = 1234 )
                    ( aubel = 4567 )
                    ( aubel = 6789 )
                    ( aubel = 1345 ) ).

DATA(lv_num) = lines( lt_aubel ).
     lv_num  = lv_num + 1.

DATA(ls_aubel) = REDUCE #( INIT lv_str TYPE string
                           FOR  i = 1  WHILE i < lines( lt_aubel ) + 1
                           NEXT lv_str = COND #( WHEN i < lines( lt_aubel )
                           THEN lv_str && |{ lt_aubel[ i ]-aubel ALPHA = OUT }| && ','
                           ELSE lv_str && |{ lt_aubel[ i ]-aubel ALPHA = OUT }|  )  ).

CONDENSE ls_aubel NO-GAPS.

BREAK-POINT.
