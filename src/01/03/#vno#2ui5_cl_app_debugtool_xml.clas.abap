CLASS /vno/2ui5_cl_app_debugtool_xml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS get
      RETURNING
        VALUE(result) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS /vno/2ui5_cl_app_debugtool_xml IMPLEMENTATION.

  METHOD get.

    result = `<core:FragmentDefinition` &&
             `    xmlns="sap.m"` &&
             `    xmlns:mvc="sap.ui.core.mvc"` &&
             `    xmlns:core="sap.ui.core"` &&
             `    xmlns:html="http://www.w3.org/1999/xhtml"` &&
             `    xmlns:ce="sap.ui.codeeditor"` &&
             `>` &&
             `    <Dialog` &&
             `        title="abap2UI5 - DebugTool"` &&
             `        stretch="true"` &&
             `    >` &&
             `        <IconTabHeader` &&
             `            selectedKey="PLAIN"` &&
             `            select=".onItemSelect"` &&
             `        >` &&
             `            <items>` &&
             `         <IconTabFilter` &&
             `                    text="Config"` &&
             `                    key="CONFIG"` &&
             ` enabled="true"` &&
             `                />` &&
             `                <IconTabFilter` &&
             `                    text="Previous Request"` &&
             `                    key="REQUEST"` &&
             ` enabled="true"` &&
             `                />` &&
             `                <IconTabFilter` &&
             `                    text="Response"` &&
             `                    key="PLAIN"` &&
             `                />` &&
             `                <IconTabFilter` &&
             `                    text="Source Code"` &&
             `                    key="SOURCE"` &&
             `                />` &&
             `                <IconTabFilter` &&
             `                    text="View"` &&
             `                    key="VIEW"` &&
             `                />` &&
             `                <IconTabFilter` &&
             `                    text="View Model"` &&
             `                    key="MODEL"` &&
             `                />` &&
             `                <IconTabFilter` &&
             `                    text="Popup"` &&
             `                    key="POPUP"` &&
             ` enabled="{/activePopup}"` &&
             `                />` &&
             `                <IconTabFilter` &&
             `                    text="Popup Model"` &&
             `                    key="POPUP_MODEL"` &&
             ` enabled="{/activePopup}"` &&
             `                />` &&
             `                <IconTabFilter` &&
             `                    text="Popover"` &&
             `                    key="POPOVER"` &&
             ` enabled="{/activePopover}"` &&
             `                />` &&
             `                <IconTabFilter` &&
             `                    text="Popover Model"` &&
             `                    key="POPOVER_MODEL"` &&
             ` enabled="{/activePopover}"` &&
             `                />` &&
             `                <IconTabFilter` &&
             `                    text="Nest1"` &&
             `                    key="NEST1"` &&
             ` enabled="{/activeNest1}"` &&
             `                />` &&
             `                <IconTabFilter` &&
             `                    text="Nest1 Model"` &&
             `                    key="NEST1_MODEL"` &&
             ` enabled="{/activeNest1}"` &&
             `                />` &&
             `                <IconTabFilter` &&
             `                    text="Nest2"` &&
             `                    key="NEST2"` &&
             ` enabled="{/activeNest2}"` &&
             `                />` &&
             `                <IconTabFilter` &&
             `                    text="Nest2 Model"` &&
             `                    key="NEST2_MODEL"` &&
             ` enabled="{/activeNest2}"` &&
             `                />` &&
             `            </items>` &&
             `        </IconTabHeader>` &&
             ` <VBox>` &&
             ` <ToggleButton text="Source XML after Templating" visible="{/isTemplating}" pressed="{/templatingSource}" press=".onTemplatingPress" />` &&
             `        <ce:CodeEditor` &&
             `            type="{/type}"` &&
             `            value="{/value}"` &&
             `            height="2000px"` &&
             `            width="10000px"` &&
             `            visible="{/editor_visible}"` &&
             `        /></VBox>` &&
             ` <VBox visible="{/source_visible}">` &&
             ` <core:HTML/>` &&
             ` </VBox>` &&
             `        <endButton>` &&
             `            <Button` &&
             `                text="Close"` &&
             `                press=".onClose"` &&
             `            />` &&
             `        </endButton>` &&
             `    </Dialog>` &&
             `</core:FragmentDefinition>` &&
             `` &&
              ``.

  ENDMETHOD.

ENDCLASS.
