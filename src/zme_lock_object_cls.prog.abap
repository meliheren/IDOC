*&---------------------------------------------------------------------*
*& Include          ZME_LOCK_OBJECT_CLS
*&---------------------------------------------------------------------*

CLASS lcl_main DEFINITION.

  PUBLIC SECTION.


  PRIVATE SECTION.
    METHODS : belge_kitle.
    METHODS : belge_ac.
ENDCLASS.

DATA : go_main TYPE REF TO lcl_main.

CLASS lcl_main IMPLEMENTATION.

  METHOD belge_ac.
  ENDMETHOD.

  METHOD belge_kitle.
  ENDMETHOD.

ENDCLASS.
