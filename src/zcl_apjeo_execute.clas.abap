"! Copy of ZCL_TEST_APJ_SIMPLE from https://help.sap.com/docs/ABAP_PLATFORM_NEW/b5670aaaa2364a29935f40b16499972d/99dcde1a72ed4e7fb0959ead46a7fbf5.html
"! (SAP Library > Home > ABAP_PLATFORM_NEW > ABAP Platform > Developing on the ABAP Platform > Extensibility > Developer Extensibility > Reuse Components
"! > Application Jobs > Creating a Job Catalog Entry and a Job Template in ADT > Implementing the Business Logic)
CLASS zcl_apjeo_execute DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_apj_dt_exec_object.
    INTERFACES if_apj_rt_exec_object.
ENDCLASS.


CLASS zcl_apjeo_execute IMPLEMENTATION.
  METHOD if_apj_dt_exec_object~get_parameters.
    BREAK-POINT ID zapjeo_all_exit_methods.

    " Return the supported selection parameters here
    et_parameter_def = VALUE #( ( selname         = 'S_ID'
                                  kind            = if_apj_dt_exec_object=>select_option
                                  datatype        = 'C'
                                  length          = 10
                                  param_text      = 'My ID'
                                  changeable_ind  = abap_true )
                                ( selname         = 'P_DESCR'
                                  kind            = if_apj_dt_exec_object=>parameter
                                  datatype        = 'C'
                                  length          = 80
                                  param_text      = 'My Description 2'
                                  lowercase_ind   = abap_true
                                  changeable_ind  = abap_true )
                                ( selname         = 'P_DATE'
                                  kind            = if_apj_dt_exec_object=>parameter
                                  datatype        = 'D'
                                  param_text      = 'My Date'
                                  lowercase_ind   = abap_true
                                  changeable_ind  = abap_true )
                                ( selname         = 'P_TIME'
                                  kind            = if_apj_dt_exec_object=>parameter
                                  datatype        = 'T'
                                  param_text      = 'My Time'
                                  changeable_ind  = abap_true )
                                ( selname         = 'P_INT'
                                  kind            = if_apj_dt_exec_object=>parameter
                                  datatype        = 'I'
                                  param_text      = 'My Integer'
                                  changeable_ind  = abap_true )
                                ( selname         = 'P_CHECK'
                                  kind            = if_apj_dt_exec_object=>parameter
                                  datatype        = 'C'
                                  length          = 1
                                  param_text      = 'Checkbox'
                                  group_text      = 'Group'   " Ignored in Private Cloud and On-Premises systems
                                  section_text    = 'Section' " Ignored in Private Cloud and On-Premises systems
                                  checkbox_ind    = abap_true
                                  changeable_ind  = abap_true )
                                ( selname         = 'P_FIXED'
                                  kind            = if_apj_dt_exec_object=>parameter
                                  datatype        = 'C'
                                  length          = 1
                                  param_text      = 'Not changeable'
                                  changeable_ind  = abap_false )
                                ( selname         = 'P_RB_1'
                                  kind            = if_apj_dt_exec_object=>parameter
                                  param_text      = 'Option 1'
                                  datatype        = 'C'
                                  length          = 1
                                  radio_group_ind = abap_true
                                  radio_group_id  = 'RBG1'
                                  changeable_ind  = abap_true )
                                ( selname         = 'P_RB_2'
                                  kind            = if_apj_dt_exec_object=>parameter
                                  param_text      = 'Option 2'
                                  datatype        = 'C'
                                  length          = 1
                                  radio_group_ind = abap_true
                                  radio_group_id  = 'RBG1'
                                  changeable_ind  = abap_true )
                                ( selname         = 'P_HIDDEN'
                                  kind            = if_apj_dt_exec_object=>parameter
                                  datatype        = 'g'
                                  param_text      = 'Hidden'
                                  hidden_ind      = abap_true ) ).

    " Return the default parameters values here
    et_parameter_val = VALUE #( sign   = 'I'
                                option = 'EQ'
                                ( selname = 'S_ID'     kind = if_apj_dt_exec_object=>select_option low = '4711' )
                                ( selname = 'P_DESCR'  kind = if_apj_dt_exec_object=>parameter     low = 'My Default Description' )
                                ( selname = 'P_INT'    kind = if_apj_dt_exec_object=>parameter     low = '200' )
                                ( selname = 'P_DATE'   kind = if_apj_dt_exec_object=>parameter     low = '20250205' )
                                ( selname = 'P_TIME'   kind = if_apj_dt_exec_object=>parameter     low = '212300' )
                                ( selname = 'P_CHECK'  kind = if_apj_dt_exec_object=>parameter     low = abap_true )
                                ( selname = 'P_RB_1'   kind = if_apj_dt_exec_object=>parameter     low = abap_true )
                                ( selname = 'P_RB_2'   kind = if_apj_dt_exec_object=>parameter     low = abap_false )
                                ( selname = 'P_HIDDEN' kind = if_apj_dt_exec_object=>parameter     low = 'Very long text' ) ).
  ENDMETHOD.

  METHOD if_apj_rt_exec_object~execute.
    TYPES ty_id TYPE c LENGTH 10.

    DATA s_id    TYPE RANGE OF ty_id ##NEEDED.
    DATA p_descr TYPE c LENGTH 80 ##NEEDED.
    DATA p_count TYPE i ##NEEDED.
    DATA p_simul TYPE abap_boolean ##NEEDED.

    BREAK-POINT ID zapjeo_all_exit_methods.

    " Getting the actual parameter values
    LOOP AT it_parameters INTO DATA(ls_parameter).
      CASE ls_parameter-selname.
        WHEN 'S_ID'.
          APPEND VALUE #( sign   = ls_parameter-sign
                          option = ls_parameter-option
                          low    = ls_parameter-low
                          high   = ls_parameter-high ) TO s_id.
        WHEN 'P_DESCR'. p_descr = ls_parameter-low.
        WHEN 'P_COUNT'. p_count = ls_parameter-low.
        WHEN 'P_SIMUL'. p_simul = ls_parameter-low.
      ENDCASE.
    ENDLOOP.

    " Implement the job execution
*    IF sy-datum = '20250206'.
*      DO.
*      ENDDO.
*    ENDIF.
  ENDMETHOD.
ENDCLASS.
