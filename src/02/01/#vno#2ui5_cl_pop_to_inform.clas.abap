CLASS /vno/2ui5_cl_pop_to_inform DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES /vno/2ui5_if_app.

    CLASS-METHODS factory
      IMPORTING
        i_text          TYPE string
        i_title         TYPE string DEFAULT `Title`
        i_icon          TYPE string DEFAULT 'sap-icon://question-mark'
        i_button_text   TYPE string DEFAULT `OK`
      RETURNING
        VALUE(r_result) TYPE REF TO /vno/2ui5_cl_pop_to_inform.

  PROTECTED SECTION.
    DATA client              TYPE REF TO /vno/2ui5_if_client.
    DATA title               TYPE string.
    DATA icon                TYPE string.
    DATA question_text       TYPE string.
    DATA button_text_confirm TYPE string.

    METHODS view_display.

  PRIVATE SECTION.
ENDCLASS.


CLASS /vno/2ui5_cl_pop_to_inform IMPLEMENTATION.
  METHOD factory.

    r_result = NEW #( ).
    r_result->title               = i_title.
    r_result->icon                = i_icon.
    r_result->question_text       = i_text.
    r_result->button_text_confirm = i_button_text.

  ENDMETHOD.

  METHOD view_display.

    DATA(popup) = /vno/2ui5_cl_xml_view=>factory_popup( )->dialog( title      = title
                                                               icon       = icon
                                                               afterclose = client->_event( 'BUTTON_CONFIRM' )
              )->content(
                  )->vbox( 'sapUiMediumMargin'
                      )->text( question_text
              )->get_parent( )->get_parent(
              )->buttons(
                  )->button( text  = button_text_confirm
                             press = client->_event( 'BUTTON_CONFIRM' )
                             type  = 'Emphasized' ).

    client->popup_display( popup->stringify( ) ).

  ENDMETHOD.

  METHOD /vno/2ui5_if_app~main.

    me->client = client.

    IF client->check_on_init( ).
      view_display( ).
      RETURN.
    ENDIF.

    CASE client->get( )-event.
      WHEN `BUTTON_CONFIRM`.
        client->popup_destroy( ).
        client->nav_app_leave( client->get_app( client->get( )-s_draft-id_prev_app_stack ) ).
      WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.
ENDCLASS.
