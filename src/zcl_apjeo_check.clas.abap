CLASS zcl_apjeo_check DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_apj_jt_check_20.
ENDCLASS.


CLASS zcl_apjeo_check IMPLEMENTATION.
  METHOD if_apj_jt_check_20~adjust_hidden.
  ENDMETHOD.

  METHOD if_apj_jt_check_20~adjust_read_only.
  ENDMETHOD.

  METHOD if_apj_jt_check_20~check_and_adjust.
    DATA(lv_order) = ct_value[ KEY param parameter_name = 'S_ID' ]-low.

    IF lv_order = '4711'.
      MESSAGE e012(zapjeo) INTO DATA(dummy).
      INSERT VALUE #( id = sy-msgid type = sy-msgty number = sy-msgno ) INTO TABLE et_msg.
    ELSE.
      ev_successful = abap_true.
    ENDIF.
  ENDMETHOD.

  METHOD if_apj_jt_check_20~check_and_adjust_parameter.
  ENDMETHOD.

  METHOD if_apj_jt_check_20~check_authorizations.
  ENDMETHOD.

  METHOD if_apj_jt_check_20~check_start_condition.
  ENDMETHOD.

  METHOD if_apj_jt_check_20~get_dynamic_properties.
  ENDMETHOD.

  METHOD if_apj_jt_check_20~initialize.
  ENDMETHOD.
ENDCLASS.
