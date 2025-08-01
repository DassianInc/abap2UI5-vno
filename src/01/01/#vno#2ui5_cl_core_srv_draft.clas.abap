CLASS /vno/2ui5_cl_core_srv_draft DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES ty_s_db TYPE /vno/2ui5_t_01.

    METHODS count_entries
      RETURNING
        VALUE(result) TYPE i.

    METHODS create
      IMPORTING
        draft     TYPE /vno/2ui5_if_types=>ty_s_draft
        model_xml TYPE clike.

    METHODS read_draft
      IMPORTING
        id            TYPE clike
      RETURNING
        VALUE(result) TYPE ty_s_db.

    METHODS read_info
      IMPORTING
        id            TYPE clike
      RETURNING
        VALUE(result) TYPE /vno/2ui5_if_types=>ty_s_draft.

    METHODS cleanup.

  PROTECTED SECTION.
    METHODS read
      IMPORTING
        id             TYPE clike
        check_load_app TYPE abap_bool DEFAULT abap_true
      RETURNING
        VALUE(result)  TYPE ty_s_db.

  PRIVATE SECTION.
ENDCLASS.


CLASS /vno/2ui5_cl_core_srv_draft IMPLEMENTATION.

  METHOD cleanup.

    DATA(ls_config) = VALUE /vno/2ui5_if_types=>ty_s_http_config_post( ).
    /vno/2ui5_cl_exit=>get_instance( )->set_config_http_post( CHANGING cs_config = ls_config ).

    DATA(lv_n_hours_ago) = /vno/2ui5_cl_util=>time_substract_seconds( time    = /vno/2ui5_cl_util=>time_get_timestampl( )
                                                                  seconds = 60 * 60 * ls_config-draft_exp_time_in_hours ).

    DELETE FROM /vno/2ui5_t_01 WHERE timestampl < @lv_n_hours_ago.
    COMMIT WORK.

  ENDMETHOD.

  METHOD create.

    ASSERT draft-id IS NOT INITIAL.

    DATA(ls_db) = VALUE ty_s_db( id                = draft-id
                                 id_prev           = draft-id_prev
                                 id_prev_app       = draft-id_prev_app
                                 id_prev_app_stack = draft-id_prev_app_stack
                                 timestampl        = /vno/2ui5_cl_util=>time_get_timestampl( )
                                 data              = model_xml ).

    MODIFY /vno/2ui5_t_01 FROM @ls_db.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /vno/2ui5_cx_util_error
        EXPORTING
          val = `CREATE_OF_DRAFT_ENTRY_ON_DATABASE_FAILED`.
    ENDIF.
    COMMIT WORK AND WAIT.

  ENDMETHOD.

  METHOD read.

    IF check_load_app = abap_true.

      SELECT SINGLE * FROM /vno/2ui5_t_01
        WHERE id = @id
        INTO @result ##SUBRC_OK.

    ELSE.

      SELECT SINGLE id, id_prev, id_prev_app, id_prev_app_stack
        FROM /vno/2ui5_t_01
        WHERE id = @id
        INTO CORRESPONDING FIELDS OF @result ##SUBRC_OK.

    ENDIF.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE /vno/2ui5_cx_util_error
        EXPORTING
          val = `NO_DRAFT_ENTRY_OF_PREVIOUS_REQUEST_FOUND`.
    ENDIF.

  ENDMETHOD.

  METHOD read_draft.

    result = read( id ).

  ENDMETHOD.

  METHOD read_info.

    DATA(ls_db) = read( id             = id
                        check_load_app = abap_false ).

    result = CORRESPONDING #( ls_db ).

  ENDMETHOD.

  METHOD count_entries.

    SELECT COUNT( * ) FROM /vno/2ui5_t_01
      INTO @result.

  ENDMETHOD.

ENDCLASS.
