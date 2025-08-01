INTERFACE /vno/2ui5_if_app PUBLIC.
  INTERFACES if_serializable_object.

  CONSTANTS version TYPE string VALUE '1.140.0'.
  CONSTANTS origin  TYPE string VALUE 'https://github.com/abap2UI5/abap2UI5'.
  CONSTANTS author  TYPE string VALUE 'https://github.com/abap2UI5/abap2UI5/graphs/contributors'.
  CONSTANTS license TYPE string VALUE 'MIT'.

  DATA id_draft          TYPE string.
  DATA id_app            TYPE string.
  DATA check_initialized TYPE abap_bool.
  DATA check_sticky      TYPE abap_bool.

  METHODS main
    IMPORTING
      client TYPE REF TO /vno/2ui5_if_client.

ENDINTERFACE.
