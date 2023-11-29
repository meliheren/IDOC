*&---------------------------------------------------------------------*
*& Include          ZME_NEW_SYNTAX750_CLS
*&---------------------------------------------------------------------*

CLASS lcl_main DEFINITION.

  PUBLIC SECTION.
  PRIVATE SECTION.
    METHODS : get_data.
    METHODS : show_alv.

    "ALV Related data
    CLASS-METHODS create_containers_and_grids.
    CLASS-METHODS set_fieldcatalog  IMPORTING iv_structure_name TYPE dd02l-tabname
                                    RETURNING VALUE(rt_fcat)    TYPE lvc_t_fcat.
    CLASS-METHODS create_layout     RETURNING VALUE(rs_layout)  TYPE lvc_s_layo.
    CLASS-METHODS display_alv.
    CLASS-METHODS refresh_alv       IMPORTING io_grid            TYPE REF TO cl_gui_alv_grid.
    CLASS-METHODS fcat_exit         CHANGING ct_fcat             TYPE lvc_t_fcat.
    CLASS-METHODS toolbar_excluding RETURNING VALUE(rt_toolbar_excluding) TYPE ui_functions.
    CLASS-METHODS on_toolbar        FOR EVENT toolbar OF cl_gui_alv_grid  IMPORTING sender e_object e_interactive.

    "ALV Events
    CLASS-METHODS on_user_command   FOR EVENT user_command OF cl_gui_alv_grid IMPORTING sender e_ucomm.



ENDCLASS.


CLASS lcl_main IMPLEMENTATION.

  METHOD get_data.

  ENDMETHOD.
  METHOD show_alv.

  ENDMETHOD.
  METHOD create_containers_and_grids.

  ENDMETHOD.
  METHOD create_layout.

  ENDMETHOD.
  METHOD display_alv.

  ENDMETHOD.
  METHOD fcat_exit.

  ENDMETHOD.
  METHOD on_toolbar.

  ENDMETHOD.
  METHOD on_user_command.

  ENDMETHOD.
  METHOD refresh_alv.

  ENDMETHOD.
  METHOD set_fieldcatalog.

  ENDMETHOD.
  METHOD toolbar_excluding.

  ENDMETHOD.

ENDCLASS.
