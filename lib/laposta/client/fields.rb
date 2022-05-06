module Laposta
  class Client
    module Fields
      # Parameters
      # Name      Type    Description
      # ------------------------------------------------------------
      # field_id  string  The ID of the list to which the field belongs
      # ------------------------------------------------------------
      #
      # Allowed attributes:
      # Name     Type    Description
      # ------------------------------------------------------------
      # list_id  string  The ID of the list to which the field belongs
      # ------------------------------------------------------------
      def get_field(field_id, params = {})
        cleaned = params.permit(:list_id)
        list("field/#{field_id}", cleaned)
      end

      # Allowed attributes:
      # Name     Type    Description
      # ------------------------------------------------------------
      # list_id  string  The ID of the list to which the field belongs
      # ------------------------------------------------------------
      def get_fields_for_list(params = {})
        cleaned = params.permit(:list_id)
        list("field", cleaned)
      end

      # Allowed attributes:
      # Name                         Type               Description
      # ------------------------------------------------------------
      # list_id                      string             The ID of the list to which the field belongs
      # name                         string             A name for this field
      # defaultvalue                 string (optional)  A potential default value
      # datatype                     string             The data type: text, numeric, date, select_single or select_multiple
      # datatype_display             string (optional)  Only applicable for select_single: the desired display (select, radio)
      # options                      array (optional)   What selection options are available? (mandatory for the data types select_single of select_multiple).
      #                                                 The options can be given as an array. In the answer the options are repeated, but there is also an extra field options_full.
      #                                                 Also listed are the option IDs, which may eventually be used to change the options later.
      # required                     boolean            Is this a mandatory field?
      # in_form                      boolean            Does this field occur in the subscription form?
      # in_list                      boolean            Is this field visible in Laposta's overview?
      # ------------------------------------------------------------
      def create_field!(params = {})
        cleaned = params.permit(:list_id,
                                :name,
                                :defaultvalue,
                                :datatype,
                                :datatype_display,
                                :options,
                                :required,
                                :in_form,
                                :in_list)
        create("field", cleaned)
      end


      # Parameters
      # Name      Type    Description
      # ------------------------------------------------------------
      # field_id  string  The field's ID
      # ------------------------------------------------------------
      #
      # Allowed attributes:
      # Name                         Type                Description
      # ------------------------------------------------------------
      # list_id                      string              The ID of the list to which the field belongs
      # name                         string (optional)   A name for this field
      # defaultvalue                 string (optional)   A potential default value
      # datatype                     string (optional)   The data type: text, numeric, date, select_single or select_multiple
      # datatype_display             string (optional)   Only applicable for select_single: the desired display (select, radio)
      # options                      array (optional)    What selection options are available? (mandatory for the data types select_single of select_multiple).
      #                                                  The options can be given as an array. In the answer the options are repeated, but there is also an extra field options_full.
      #                                                  Also listed are the option IDs, which may eventually be used to change the options later.
      # required                     boolean (optional)  Is this a mandatory field?
      # in_form                      boolean (optional)  Does this field occur in the subscription form?
      # in_list                      boolean (optional)  Is this field visible in Laposta's overview?
      # ------------------------------------------------------------
      def update_field!(field_id, params = {})
        cleaned = params.permit(:list_id,
                                :name,
                                :defaultvalue,
                                :datatype,
                                :datatype_display,
                                :options,
                                :required,
                                :in_form,
                                :in_list)
        update("field/#{field_id}", cleaned)
      end

      # Parameters
      # Name      Type    Description
      # ------------------------------------------------------------
      # list_id   string  The ID of the list to which the field belongs
      # ------------------------------------------------------------
      #
      # Allowed attributes:
      # Name     Type    Description
      # ------------------------------------------------------------
      # list_id  string  The ID of the list to which the field belongs
      # ------------------------------------------------------------
      def delete_field!(field_id, params = {})
        cleaned = params.permit(:list_id)
        delete("field/#{field_id}", cleaned)
      end
    end
  end
end