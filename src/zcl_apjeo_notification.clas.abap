CLASS zcl_apjeo_notification DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_apj_rt_job_notif_exit.
ENDCLASS.


CLASS zcl_apjeo_notification IMPLEMENTATION.
  METHOD if_apj_rt_job_notif_exit~notify_jt_end.
    BREAK-POINT ID zapjeo_all_exit_methods.
  ENDMETHOD.

  METHOD if_apj_rt_job_notif_exit~notify_jt_start.
    BREAK-POINT ID zapjeo_all_exit_methods.
  ENDMETHOD.
ENDCLASS.
