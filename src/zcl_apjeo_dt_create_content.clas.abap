"! Usage of CL_APJ_DT_CREATE_CONTENT, based on the example code ZCL_TEST_APJ_SIMPLE_OBJ_GEN at https://help.sap.com/docs/ABAP_PLATFORM_NEW/b5670aaaa2364a29935f40b16499972d/1f04ad22db0147b99ebc476708b749b6.html
"! (SAP Library > Home > ABAP_PLATFORM_NEW > ABAP Platform > Developing on the ABAP Platform > Extensibility > Developer Extensibility > Reuse Components
"! > Application Jobs > Creating a Job Catalog Entry and a Job Template in ADT > Creating the Job Template)
CLASS zcl_apjeo_dt_create_content DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_apjeo_dt_create_content IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    CONSTANTS lc_catalog_name      TYPE cl_apj_dt_create_content=>ty_catalog_name      VALUE 'ZTEST_MY_SIMPLE_JOB'.
    CONSTANTS lc_catalog_text      TYPE cl_apj_dt_create_content=>ty_text              VALUE 'My first simple application job'.
    CONSTANTS lc_class_name        TYPE cl_apj_dt_create_content=>ty_class_name        VALUE 'ZCL_APJEO_EXECUTE'.

    CONSTANTS lc_template_name     TYPE cl_apj_dt_create_content=>ty_template_name     VALUE 'ZTEST_MY_SIMPLE_JOB_TEMPL'.
    CONSTANTS lc_template_text     TYPE cl_apj_dt_create_content=>ty_text              VALUE 'My first simple job template'.

    CONSTANTS lc_transport_request TYPE cl_apj_dt_create_content=>ty_transport_request VALUE ''.
    CONSTANTS lc_package           TYPE cl_apj_dt_create_content=>ty_package           VALUE '$APJEXECOBJECT'.

    " Create job template (corresponds to the former system selection variant) which is mandatory
    " to select the job later on in the Fiori app to schedule the job
    DATA lt_parameters TYPE if_apj_dt_exec_object=>tt_templ_val.

    DATA(lo_dt) = cl_apj_dt_create_content=>get_instance( ).

    " Create job catalog entry (corresponds to the former report incl. selection parameters)
    " Provided implementation class iv_class_name shall implement two interfaces:
    " - if_apj_dt_exec_object to provide the definition of all supported selection parameters of the job
    "   (corresponds to the former report selection parameters) and to provide the actual default values
    " - if_apj_rt_exec_object to implement the job execution
    TRY.
        lo_dt->create_job_cat_entry( iv_catalog_name       = lc_catalog_name
                                     iv_class_name         = lc_class_name
                                     iv_check_class_name   = 'ZCL_APJEO_CHECK'
                                     iv_vh_class_name      = 'ZCL_APJEO_VALUE_HELP'
                                     iv_notif_class_name   = 'ZCL_APJEO_NOTIFICATION'
                                     iv_text               = lc_catalog_text
                                     iv_catalog_entry_type = cl_apj_dt_create_content=>class_based
                                     iv_transport_request  = lc_transport_request
                                     iv_package            = lc_package ).
        out->write( |Job catalog { lc_catalog_name } entry created successfully| ).

      CATCH cx_apj_dt_content INTO DATA(lx_apj_dt_content).
        out->write( |Creation of job catalog entry { lc_catalog_name } failed: { lx_apj_dt_content->get_text( ) }| ).
    ENDTRY.

    NEW zcl_apjeo_execute( )->if_apj_dt_exec_object~get_parameters( IMPORTING et_parameter_val = lt_parameters ).

    TRY.
        lo_dt->create_job_template_entry( iv_template_name     = lc_template_name
                                          iv_catalog_name      = lc_catalog_name
                                          iv_text              = lc_template_text
                                          it_parameters        = lt_parameters
                                          iv_transport_request = lc_transport_request
                                          iv_package           = lc_package ).
        out->write( |Job template { lc_template_name } created successfully| ).

      CATCH cx_apj_dt_content INTO lx_apj_dt_content.
        out->write( |Creation of job template { lc_template_name } failed: { lx_apj_dt_content->get_text( ) }| ).
        RETURN.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
