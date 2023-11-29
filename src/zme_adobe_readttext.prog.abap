*&---------------------------------------------------------------------*
*& Report ZME_ADOBE_READTTEXT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zme_adobe_readttext.

TABLES : apb_lpd_otr_keys.
*Data Types

DATA: gv_fm_name         TYPE rs38l_fnam,
      gs_fp_docparams    TYPE sfpdocparams,
      gs_fp_formoutput   TYPE fpformoutput,
      gs_fp_outputparams TYPE sfpoutputparams,
      gv_form_name       TYPE fpname,
      gv_logo            TYPE xstring.

CONSTANTS : gc_btype  TYPE tdbtype    VALUE 'BCOL',
            gc_id     TYPE tdidgr     VALUE 'BMAP',
            gc_object TYPE tdobjectgr VALUE 'GRAPHICS'.

DATA  gt_att_content_hex TYPE solix_tab.

PARAMETERS : p_check TYPE c AS CHECKBOX.

START-OF-SELECTION.
  PERFORM f_get_form.


FORM f_get_form.

  DATA : lv_url  TYPE char255.

  SELECT vbeln,
         posnr,
         matnr,
         matkl,
         arktx,
         kwmeng,
         vrkme,
         netwr,
         waerk
    FROM vbap
    INTO TABLE @DATA(lt_vbap) UP TO 100 ROWS.

  gs_fp_outputparams-dest     = 'LP01'.
  gs_fp_outputparams-nodialog = 'X'.
  gs_fp_outputparams-preview  = 'X'.


  CALL FUNCTION 'FP_JOB_OPEN'
    CHANGING
      ie_outputparams = gs_fp_outputparams
    EXCEPTIONS
      cancel          = 1
      usage_error     = 2
      system_error    = 3
      internal_error  = 4
      OTHERS          = 5.

  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
    WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  gv_form_name = 'ZME_AF_ADOBEFOM_PRACTICE'.

  CALL FUNCTION 'FP_FUNCTION_MODULE_NAME'
    EXPORTING
      i_name     = gv_form_name
    IMPORTING
      e_funcname = gv_fm_name.

  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
    WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  DATA: lv_atype TYPE char1,
        lv_adrnr TYPE ad_addrnum,
        lv_pernr TYPE ad_persnum,
        lv_land1 TYPE land1.

  lv_atype = '1'.
  lv_adrnr = '0000022515'.
  lv_land1 = 'TR'.
  lv_url   = 'https://www.kadikoy.bel.tr'.

  CALL FUNCTION gv_fm_name
    EXPORTING
      /1bcdwb/docparams  = gs_fp_docparams
      gv_value           = p_check
    IMPORTING
      /1bcdwb/formoutput = gs_fp_formoutput
    EXCEPTIONS
      usage_error        = 1
      system_error       = 2
      internal_error     = 3
      OTHERS             = 4.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
    WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  CALL FUNCTION 'FP_JOB_CLOSE'
    EXCEPTIONS
      usage_error    = 1
      system_error   = 2
      internal_error = 3
      OTHERS         = 4.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
    WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDFORM.
