CLASS zcl_apjeo_check DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_apj_jt_check_20.
ENDCLASS.


CLASS zcl_apjeo_check IMPLEMENTATION.
  METHOD if_apj_jt_check_20~adjust_hidden.
    BREAK-POINT ID zapjeo_all_exit_methods.
  ENDMETHOD.

  METHOD if_apj_jt_check_20~adjust_read_only.
    BREAK-POINT ID zapjeo_all_exit_methods.
  ENDMETHOD.

  METHOD if_apj_jt_check_20~check_and_adjust.
    BREAK-POINT ID zapjeo_all_exit_methods.
    DATA(lv_order) = ct_value[ KEY param
                               parameter_name = 'S_ID' ]-low.

    IF lv_order = '4711'.
      MESSAGE e001(zapjeo) INTO DATA(dummy) ##NEEDED.
      INSERT VALUE #( id     = sy-msgid
                      type   = sy-msgty
                      number = sy-msgno ) INTO TABLE et_msg.
    ELSE.
      ev_successful = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD if_apj_jt_check_20~check_and_adjust_parameter.
    BREAK-POINT ID zapjeo_all_exit_methods.
  ENDMETHOD.

  METHOD if_apj_jt_check_20~check_authorizations.
    BREAK-POINT ID zapjeo_all_exit_methods.
    ev_successful = abap_true.
  ENDMETHOD.

  METHOD if_apj_jt_check_20~check_start_condition.
    BREAK-POINT ID zapjeo_all_exit_methods.
  ENDMETHOD.

  METHOD if_apj_jt_check_20~get_dynamic_properties.
    BREAK-POINT ID zapjeo_all_exit_methods.
  ENDMETHOD.

  METHOD if_apj_jt_check_20~initialize.
    BREAK-POINT ID zapjeo_all_exit_methods.
  ENDMETHOD.
ENDCLASS.
