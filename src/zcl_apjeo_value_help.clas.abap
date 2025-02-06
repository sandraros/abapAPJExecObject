CLASS zcl_apjeo_value_help DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_apj_rt_value_help_exit.
ENDCLASS.


CLASS zcl_apjeo_value_help IMPLEMENTATION.
  METHOD if_apj_rt_value_help_exit~adjust.
    BREAK-POINT ID zapjeo_all_exit_methods.
  ENDMETHOD.
ENDCLASS.
