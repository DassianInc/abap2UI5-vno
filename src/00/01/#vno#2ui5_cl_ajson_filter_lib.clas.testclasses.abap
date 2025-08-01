CLASS ltcl_filters_test DEFINITION FINAL
  FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.
  PRIVATE SECTION.
    METHODS empty_filter_simple FOR TESTING RAISING /vno/2ui5_cx_ajson_error.
    METHODS empty_filter_deep FOR TESTING RAISING /vno/2ui5_cx_ajson_error.
    METHODS path_filter FOR TESTING RAISING /vno/2ui5_cx_ajson_error.
    METHODS path_filter_string FOR TESTING RAISING /vno/2ui5_cx_ajson_error.
    METHODS path_filter_w_patterns FOR TESTING RAISING /vno/2ui5_cx_ajson_error.
    METHODS path_filter_deep FOR TESTING RAISING /vno/2ui5_cx_ajson_error.
    METHODS and_filter FOR TESTING RAISING /vno/2ui5_cx_ajson_error.
    METHODS mixed_case_filter FOR TESTING RAISING /vno/2ui5_cx_ajson_error.
ENDCLASS.


CLASS ltcl_filters_test IMPLEMENTATION.

  METHOD empty_filter_simple.

    DATA li_json TYPE REF TO /vno/2ui5_if_ajson.
    DATA li_json_filtered TYPE REF TO /vno/2ui5_if_ajson.

    li_json = /vno/2ui5_cl_ajson=>create_empty( ).
    li_json->set(
      iv_path = '/a'
      iv_val  = '1' ).
    li_json->set(
      iv_path = '/b'
      iv_val  = '' ).
    li_json->set(
      iv_path = '/c'
      iv_val  = '3' ).
    li_json->set(
      iv_path = '/d'
      iv_val  = 0 ).

    li_json_filtered = /vno/2ui5_cl_ajson=>create_from(
      ii_source_json = li_json
      ii_filter = /vno/2ui5_cl_ajson_filter_lib=>create_empty_filter( ) ).

    cl_abap_unit_assert=>assert_equals(
      act = li_json_filtered->stringify( )
      exp = '{"a":"1","c":"3"}' ).

  ENDMETHOD.

  METHOD empty_filter_deep.

    DATA li_json TYPE REF TO /vno/2ui5_if_ajson.
    DATA li_json_filtered TYPE REF TO /vno/2ui5_if_ajson.

    li_json = /vno/2ui5_cl_ajson=>create_empty( ).
    li_json->set(
      iv_path = '/a'
      iv_val  = '1' ).
    li_json->set(
      iv_path = '/b/c'
      iv_val  = '' ).
    li_json->set(
      iv_path = '/b/d'
      iv_val  = 0 ).
    li_json->set(
      iv_path = '/d/e'
      iv_val  = 0 ).

    li_json_filtered = /vno/2ui5_cl_ajson=>create_from(
      ii_source_json = li_json
      ii_filter = /vno/2ui5_cl_ajson_filter_lib=>create_empty_filter( ) ).

    cl_abap_unit_assert=>assert_equals(
      act = li_json_filtered->stringify( )
      exp = '{"a":"1"}' ).

  ENDMETHOD.

  METHOD path_filter.

    DATA li_json TYPE REF TO /vno/2ui5_if_ajson.
    DATA li_json_filtered TYPE REF TO /vno/2ui5_if_ajson.
    DATA lt_paths TYPE string_table.

    APPEND '/b/c' TO lt_paths.

    li_json = /vno/2ui5_cl_ajson=>create_empty( ).
    li_json->set(
      iv_path = '/a'
      iv_val  = '1' ).
    li_json->set(
      iv_path = '/b/c'
      iv_val  = '2' ).
    li_json->set(
      iv_path = '/c/d'
      iv_val  = '3' ).

    li_json_filtered = /vno/2ui5_cl_ajson=>create_from(
      ii_source_json = li_json
      ii_filter = /vno/2ui5_cl_ajson_filter_lib=>create_path_filter( it_skip_paths = lt_paths ) ).

    cl_abap_unit_assert=>assert_equals(
      act = li_json_filtered->stringify( )
      exp = '{"a":"1","b":{},"c":{"d":"3"}}' ).

  ENDMETHOD.

  METHOD path_filter_string.

    DATA li_json TYPE REF TO /vno/2ui5_if_ajson.
    DATA li_json_filtered TYPE REF TO /vno/2ui5_if_ajson.

    li_json = /vno/2ui5_cl_ajson=>create_empty( ).
    li_json->set(
      iv_path = '/a'
      iv_val  = '1' ).
    li_json->set(
      iv_path = '/b/c'
      iv_val  = '2' ).
    li_json->set(
      iv_path = '/c/d'
      iv_val  = '3' ).

    li_json_filtered = /vno/2ui5_cl_ajson=>create_from(
      ii_source_json = li_json
      ii_filter = /vno/2ui5_cl_ajson_filter_lib=>create_path_filter( iv_skip_paths = '/b/c,/c/d' ) ).

    cl_abap_unit_assert=>assert_equals(
      act = li_json_filtered->stringify( )
      exp = '{"a":"1","b":{},"c":{}}' ).

  ENDMETHOD.

  METHOD path_filter_w_patterns.

    DATA li_json TYPE REF TO /vno/2ui5_if_ajson.
    DATA li_json_filtered TYPE REF TO /vno/2ui5_if_ajson.

    li_json = /vno/2ui5_cl_ajson=>create_empty( ).
    li_json->set(
      iv_path = '/@meta'
      iv_val  = 'meta' ).
    li_json->set(
      iv_path = '/a'
      iv_val  = '1' ).
    li_json->set(
      iv_path = '/b/c'
      iv_val  = '2' ).
    li_json->set(
      iv_path = '/c/d'
      iv_val  = '3' ).
    li_json->set(
      iv_path = '/c/@meta2'
      iv_val  = 'meta2' ).

    li_json_filtered = /vno/2ui5_cl_ajson=>create_from(
      ii_source_json = li_json
      ii_filter = /vno/2ui5_cl_ajson_filter_lib=>create_path_filter(
        iv_skip_paths = '/*/c,*/@*'
        iv_pattern_search = abap_true ) ).

    cl_abap_unit_assert=>assert_equals(
      act = li_json_filtered->stringify( )
      exp = '{"a":"1","b":{},"c":{"d":"3"}}' ).

  ENDMETHOD.

  METHOD path_filter_deep.

    DATA li_json TYPE REF TO /vno/2ui5_if_ajson.
    DATA li_json_filtered TYPE REF TO /vno/2ui5_if_ajson.
    DATA lt_paths TYPE string_table.

    APPEND '/b' TO lt_paths.

    li_json = /vno/2ui5_cl_ajson=>create_empty( ).
    li_json->set(
      iv_path = '/a'
      iv_val  = '1' ).
    li_json->set(
      iv_path = '/b/c'
      iv_val  = '2' ).
    li_json->set(
      iv_path = '/b/d'
      iv_val  = 'x' ).
    li_json->set(
      iv_path = '/c/d'
      iv_val  = '3' ).

    li_json_filtered = /vno/2ui5_cl_ajson=>create_from(
      ii_source_json = li_json
      ii_filter = /vno/2ui5_cl_ajson_filter_lib=>create_path_filter( it_skip_paths = lt_paths ) ).

    cl_abap_unit_assert=>assert_equals(
      act = li_json_filtered->stringify( )
      exp = '{"a":"1","c":{"d":"3"}}' ).

  ENDMETHOD.

  METHOD and_filter.

    DATA li_json TYPE REF TO /vno/2ui5_if_ajson.
    DATA li_json_filtered TYPE REF TO /vno/2ui5_if_ajson.
    DATA lt_filters TYPE /vno/2ui5_if_ajson_filter=>ty_filter_tab.

    APPEND /vno/2ui5_cl_ajson_filter_lib=>create_empty_filter( ) TO lt_filters.
    APPEND /vno/2ui5_cl_ajson_filter_lib=>create_path_filter( iv_skip_paths = '/c' ) TO lt_filters.

    li_json = /vno/2ui5_cl_ajson=>create_empty( ).
    li_json->set(
      iv_path = '/a'
      iv_val  = '1' ).
    li_json->set(
      iv_path = '/b'
      iv_val  = '' ).
    li_json->set(
      iv_path = '/c'
      iv_val  = '3' ).
    li_json->set(
      iv_path = '/d'
      iv_val  = 0 ).

    li_json_filtered = /vno/2ui5_cl_ajson=>create_from(
      ii_source_json = li_json
      ii_filter = /vno/2ui5_cl_ajson_filter_lib=>create_and_filter( lt_filters ) ).

    cl_abap_unit_assert=>assert_equals(
      act = li_json_filtered->stringify( )
      exp = '{"a":"1"}' ).

  ENDMETHOD.

  METHOD mixed_case_filter.

    DATA li_json TYPE REF TO /vno/2ui5_if_ajson.
    DATA li_json_filtered TYPE REF TO /vno/2ui5_if_ajson.

    li_json = /vno/2ui5_cl_ajson=>create_empty( ).
    li_json->set(
      iv_path = '/a'
      iv_val  = '1' ).
    li_json->set(
      iv_path = '/bB'
      iv_val  = '2' ).
    li_json->set(
      iv_path = '/CC'
      iv_val  = '3' ).
    li_json->set(
      iv_path = '/cc'
      iv_val  = '4' ).
    li_json->set(
      iv_path = '/d'
      iv_val  = 5 ).

    li_json_filtered = /vno/2ui5_cl_ajson=>create_from(
      ii_source_json = li_json
      ii_filter = /vno/2ui5_cl_ajson_filter_lib=>create_path_filter( iv_skip_paths = '/bB,/CC' ) ).

    cl_abap_unit_assert=>assert_equals(
      act = li_json_filtered->stringify( )
      exp = '{"a":"1","cc":"4","d":5}' ).

  ENDMETHOD.

ENDCLASS.
