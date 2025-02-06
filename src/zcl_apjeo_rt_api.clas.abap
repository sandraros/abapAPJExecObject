"! Usage of CL_APJ_RT_API, based on the example code Z_CL_RT_API_DEMO at https://help.sap.com/docs/ABAP_PLATFORM_NEW/b5670aaaa2364a29935f40b16499972d/1491e6c075c04e7c9a485a2e24b82653.html
"! (SAP Library > Home > ABAP_PLATFORM_NEW > ABAP Platform > Developing on the ABAP Platform > Extensibility > Developer Extensibility > Reuse Components
"! > Application Jobs > Maintaining Application Jobs using an API)
CLASS zcl_apjeo_rt_api DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_apjeo_rt_api IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA lv_template_name   TYPE cl_apj_rt_api=>ty_template_name.
    DATA ls_start_info      TYPE cl_apj_rt_api=>ty_start_info.
    DATA ls_scheduling_info TYPE cl_apj_rt_api=>ty_scheduling_info.
    DATA ls_end_info        TYPE cl_apj_rt_api=>ty_end_info.
    DATA ls_job_parameters  TYPE cl_apj_rt_api=>ty_job_parameter_value.
    DATA ls_value           TYPE cl_apj_rt_api=>ty_value_range.
    DATA lt_job_parameters  TYPE cl_apj_rt_api=>tt_job_parameter_value.
    DATA lv_job_text        TYPE cl_apj_rt_api=>ty_job_text VALUE 'Demo_Job'.

    DATA lv_jobname         TYPE cl_apj_rt_api=>ty_jobname.
    DATA lv_jobcount        TYPE cl_apj_rt_api=>ty_jobcount.

    DATA lv_status          TYPE cl_apj_rt_api=>ty_job_status.
    DATA lv_statustext      TYPE cl_apj_rt_api=>ty_job_status_text.

    DATA lv_txt             TYPE string.
    DATA ls_ret             TYPE bapiret2.

    " choose the name of the existing job template !
    lv_template_name = 'ZTEST_MY_SIMPLE_JOB_TEMPL'.

    "  the immediate start can't be used when being called from within a RAP business object
    "  because the underlying API performs an implicit COMMIT WORK.
    ls_start_info-start_immediately = 'X'.

*    " Start the job using a timestamp instead. This will start the job immediately but can have a delay depending on the current workload.
*    GET TIME STAMP FIELD DATA(ls_ts1).
*    " add 1 hour
*    DATA(ls_ts2) = cl_abap_tstmp=>add( tstmp = ls_ts1
*                                       secs  = 3600 ).
*
*    ls_start_info-timestamp = ls_ts2.

    " periodicity ------------------------------

    ls_scheduling_info-periodic_granularity = 'D'.
    ls_scheduling_info-periodic_value       = 1.
    ls_scheduling_info-test_mode            = abap_false.
    ls_scheduling_info-timezone             = 'CET'.

    ls_end_info-type           = 'NUM'.
    ls_end_info-max_iterations = 3.

    " fill parameter table ------------------------------
    " fill the table only if you want to overrule the parameter values
    " which are stored in the template
    " the field names in this program must match the field names of the template

    lt_job_parameters = VALUE #( ( name    = 'S_ID'
                                   t_value = VALUE #( ( sign = 'I' option = 'EQ' low = '1555' ) ) )
                                 ( name    = 'P_RB_1'
                                   t_value = VALUE #( ( sign = 'I' option = 'EQ' low = 'X' ) ) )
                                 ( name    = 'P_RB_2'
                                   t_value = VALUE #( ( sign = 'I' option = 'EQ' low = ' ' ) ) ) ).

    " ----------------------------------------------------

    TRY.

        " some scenarios require that the job key ( = jobname, jobcount) is already known
        " before the job is created. The method generate_jobkey creates a valid job key.
        " This key can then be passed later on to the method schedule_job, and a job with
        " exactly this key is created.

* optional. You need this call only if you have to know the job key in advance
*       cl_apj_rt_api=>generate_jobkey(
*                       importing
*                            ev_jobname  = lv_jobname
*                            ev_jobcount = lv_jobcount ).

        " If you pass the table lt_job_parameters , then the parameters
        " contained in this table are used.
        " If you don't pass the table, the parameters contained in the
        " job template are used.

        cl_apj_rt_api=>schedule_job( EXPORTING iv_job_template_name   = lv_template_name
                                               iv_job_text            = lv_job_text
                                               is_start_info          = ls_start_info
                                               is_scheduling_info     = ls_scheduling_info
                                               is_end_info            = ls_end_info
                                               it_job_parameter_value = lt_job_parameters
* the following two parameters are optional. If you pass them, they must have been generated
* with the call of generate_jobkey above
*                                               iv_jobname             = lv_jobname
*                                               iv_jobcount            = lv_jobcount
                                     IMPORTING ev_jobname             = lv_jobname
                                               ev_jobcount            = lv_jobcount ).

        out->write( lv_jobname ).
        out->write( lv_jobcount ).

        cl_apj_rt_api=>get_job_status( EXPORTING iv_jobname         = lv_jobname
                                                 iv_jobcount        = lv_jobcount
                                       IMPORTING ev_job_status      = lv_status
                                                 ev_job_status_text = lv_statustext ).

        out->write( lv_status ).
        out->write( lv_statustext ).

*        " via the following method you can cancel the job
*        " in the application job context 'cancel' means (as in the Fiori app):
*        " 1. if the job is running, it will be canceled
*        " 2. if the job has not yet started, it will be deleted.
*        " In case the job is periodic, the whole periodicity chain is deleted.
*
*        cl_apj_rt_api=>cancel_job( iv_jobname  = lv_jobname
*                                   iv_jobcount = lv_jobcount ).
      CATCH cx_apj_rt INTO DATA(exc).
        lv_txt = exc->get_longtext( ).
        ls_ret = exc->get_bapiret2( ).
        out->write( 'ERROR:' ). out->write( lv_txt ).
        out->write( 'msg type =' ). out->write( ls_ret-type ).
        out->write( 'msg id =' ). out->write( ls_ret-id ).
        out->write( 'msg number =' ). out->write( ls_ret-number ).
        out->write( 'msg message =' ). out->write( ls_ret-message ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
