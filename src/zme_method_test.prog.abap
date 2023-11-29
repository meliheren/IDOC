*&---------------------------------------------------------------------*
*& Report ZME_METHOD_TEST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zme_method_test.

DATA : ls_return       TYPE bapiret2.
DATA : lv_year_low(4)  TYPE n.
DATA : lv_year_high(4) TYPE n.
DATA : et_return_table TYPE TABLE OF bapiret2.
DATA : lv_barcode_year(4) TYPE c.
DATA : iv_year(4) TYPE c.

" Mevcut yıldan bir düşük yada bir yıl yüksek girilebilir sadece.

BREAK-POINT.

iv_year = sy-datum(4).
lv_barcode_year = 'A022'.
IF lv_barcode_year CP '++++'.

  IF lv_barcode_year CO '1234567890'.

    lv_year_low  = iv_year - 1.
    lv_year_high = iv_year + 1.

    IF lv_barcode_year LT lv_year_low.

      et_return_table = VALUE #( ( message    =  TEXT-003
                                   type       =  'E'
                                   message_v1 = 'Year entered : ' && lv_barcode_year  ) ).
    ELSE.
      IF lv_barcode_year GT lv_year_high.
        et_return_table =  VALUE #( ( message    =  TEXT-004
                                      type       =  'E'
                                      message_v1 = 'Year entered : ' && lv_barcode_year ) ).
      ELSE.
        "all correct
      ENDIF.
    ENDIF.
  ELSE.
    et_return_table  = VALUE #( ( message    =  TEXT-002
                                        type       =  'E'
                                        message_v1 = 'Year entered : ' && lv_barcode_year )  ).
  ENDIF.
ELSE.
  et_return_table = VALUE #( ( message    =  TEXT-001
                                     type       =  'E'
                                     message_v1 = 'Year entered : ' && lv_barcode_year )  ).
ENDIF.

BREAK-POINT.
