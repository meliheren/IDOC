*&---------------------------------------------------------------------*
*& Include          ZBC_IDOC_CLS
*&---------------------------------------------------------------------*
CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    "  CLASS-DATA:

    CLASS-METHODS:
      get_data.

ENDCLASS.
CLASS lcl_main IMPLEMENTATION.

  METHOD get_data.

    DATA: lt_edidd TYPE TABLE OF edidd,
          lt_edidc TYPE TABLE OF edidc.

    CLEAR : lt_edidc, lt_edidd.

    SELECT SINGLE vbeln,
                  erdat,
                  erzet,
                  ernam
       FROM vbak
      INTO @DATA(ls_vbak).

    IF sy-subrc EQ 0.

      APPEND INITIAL LINE TO lt_temp ASSIGNING FIELD-SYMBOL(<fs_temp>).
      MOVE-CORRESPONDING ls_vbak TO <fs_temp>.
      MODIFY zbc_test_001 FROM TABLE lt_temp.
      COMMIT WORK AND WAIT.


*başlık bilgileri dolduruluyor / control record...
*WE20 işlem kodunda doldurduğumuz alanlar
*mestyp -> mesaj tip alanı, WE81 deki ileti tipimiz
*doctyp -> dokuman tip, temel tipimiz WE30 da yarattığımız
*rcvprn -> muhatap alanına, WE20de tanımladığımız porttaki alıcı kısmını veriyoruz
*rcvprn -> muhatap türü, WE20deki tanımladığımız rol
      DATA(ls_edidc) = VALUE edidc( mestyp = 'ZME_IDOC_SEGMENT'
                                    doctyp = 'ZME_IDOC_SEGMENT'
                                    rcvprn = 'S4HCLNT500'
                                    rcvprt = 'LS' ).

*verilerin iletileceği kısım / data record...
*WE30 içerisinde belirttiğim ZBC_IDOC temel tipi kullanıyorum ve bunun içerisindeki alanları dolduruyorum
*segnam -> WE30 da yarattığım temel tipin adı
*sdata  -> yarattığım tipi
      APPEND INITIAL LINE TO lt_edidd ASSIGNING FIELD-SYMBOL(<fs_edidd>).
      <fs_edidd>-segnam = 'ZME_IDOC_SEGMENT'.
      <fs_edidd>-sdata  = |{ ls_vbak-vbeln }{ ls_vbak-erdat }{ ls_vbak-erzet }{ ls_vbak-erdat }|.


*data record ve control record bilgilerini gönderdik...
      CALL FUNCTION 'MASTER_IDOC_DISTRIBUTE'
        EXPORTING
          master_idoc_control            = ls_edidc
        TABLES
          communication_idoc_control     = lt_edidc
          master_idoc_data               = lt_edidd
        EXCEPTIONS
          error_in_idoc_control          = 1
          error_writing_idoc_status      = 2
          error_in_idoc_data             = 3
          sending_logical_system_unknown = 4
          OTHERS                         = 5.

      IF sy-subrc EQ 0.
*idocları 03 statusune çekerek ilgili sisteme iletir
        CALL FUNCTION 'DB_COMMIT'.
        CALL FUNCTION 'DEQUEUE_ALL'.
        COMMIT WORK.

      ENDIF.

    ENDIF.

  ENDMETHOD.

ENDCLASS.
