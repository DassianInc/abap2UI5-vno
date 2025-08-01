
CLASS ltcl_test DEFINITION FINAL
  FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.

  PRIVATE SECTION.
    METHODS test_func_get_uuid_32  FOR TESTING RAISING cx_static_check.
    METHODS test_func_get_uuid_22  FOR TESTING RAISING cx_static_check.
    METHODS test_encoding          FOR TESTING RAISING cx_static_check.
    METHODS test_element_text      FOR TESTING RAISING cx_static_check.
    METHODS test_classes_impl_intf FOR TESTING RAISING cx_static_check.
    METHODS test_func_get_callstack FOR TESTING RAISING cx_static_check.

ENDCLASS.


CLASS ltcl_test IMPLEMENTATION.

  METHOD test_func_get_callstack.

    "DATA(lt_stack) = z2ui5_cl_util_abap_c=>context_get_callstack( ).

  ENDMETHOD.

  METHOD test_func_get_uuid_32.

    DATA(lv_uuid) = /vno/2ui5_cl_util_abap_c=>uuid_get_c32( ).
    cl_abap_unit_assert=>assert_not_initial( lv_uuid ).
    cl_abap_unit_assert=>assert_equals( exp = strlen( lv_uuid )
                                        act = 32 ).

  ENDMETHOD.

  METHOD test_func_get_uuid_22.

    DATA(lv_uuid) = /vno/2ui5_cl_util_abap_c=>uuid_get_c22( ).
    cl_abap_unit_assert=>assert_not_initial( lv_uuid ).
    cl_abap_unit_assert=>assert_equals( exp = strlen( lv_uuid )
                                        act = 22 ).

  ENDMETHOD.

  METHOD test_encoding.

    DATA(lv_string)   = `my string`.
    DATA(lv_xstring)  = /vno/2ui5_cl_util_abap_c=>conv_get_xstring_by_string( lv_string ).
    DATA(lv_string2)  = /vno/2ui5_cl_util_abap_c=>conv_encode_x_base64( lv_xstring ).
    DATA(lv_xstring2) = /vno/2ui5_cl_util_abap_c=>conv_decode_x_base64( lv_string2 ).
    DATA(lv_string3)  = /vno/2ui5_cl_util_abap_c=>conv_get_string_by_xstring( lv_xstring2 ).

    cl_abap_unit_assert=>assert_equals( exp = lv_string
                                        act = lv_string3 ).

  ENDMETHOD.

  METHOD test_element_text.

    IF sy-sysid = 'ABC'.
      RETURN.
    ENDIF.

    DATA(ls_result) = /vno/2ui5_cl_util_abap_c=>rtti_get_data_element_texts( `UNAME` ).
    IF /vno/2ui5_cl_util=>context_check_abap_cloud( ) = abap_false.
      cl_abap_unit_assert=>assert_not_initial( ls_result ).
    ENDIF.

  ENDMETHOD.

  METHOD test_classes_impl_intf.

    RETURN.

    IF sy-sysid = 'ABC'.
      RETURN.
    ENDIF.

    DATA(mt_classes) = /vno/2ui5_cl_util_abap_c=>rtti_get_classes_impl_intf( `IF_SERIALIZABLE_OBJECT`  ).
    cl_abap_unit_assert=>assert_not_initial( mt_classes ).

  ENDMETHOD.
ENDCLASS.
