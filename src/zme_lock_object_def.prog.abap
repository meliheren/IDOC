*&---------------------------------------------------------------------*
*& Include          ZME_LOCK_OBJECT_DEF
*&---------------------------------------------------------------------*


SELECTION-SCREEN BEGIN OF BLOCK blk1 WITH FRAME TITLE TEXT-001.
  PARAMETERS : p_vbeln TYPE vbrk-vbeln.

  PARAMETERS : rd_lck   RADIOBUTTON GROUP rd1,
               rd_unlck RADIOBUTTON GROUP rd1.

SELECTION-SCREEN END OF BLOCK blk1.
