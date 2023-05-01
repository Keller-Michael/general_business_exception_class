CLASS zmke_cl_exceptions_playground DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.

  PRIVATE SECTION.
    METHODS raise_business_exception RAISING zmke_cx_business_error.

    METHODS raise_business_exception_msg1 RAISING zmke_cx_business_error.

    METHODS raise_business_exception_msg2 RAISING zmke_cx_business_error.

    METHODS raise_business_exception_obj RAISING zmke_cx_business_error.

ENDCLASS.



CLASS zmke_cl_exceptions_playground IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA business_error TYPE REF TO zmke_cx_business_error.

    TRY.
        raise_business_exception( ).
      CATCH zmke_cx_business_error INTO business_error.
    ENDTRY.

    TRY.
        raise_business_exception_msg1( ).
      CATCH zmke_cx_business_error INTO business_error.
        DATA(text) = business_error->get_longtext( ).

        business_error->get_source_position(
          IMPORTING
            program_name = DATA(program)
            include_name = DATA(include)
            source_line  = DATA(line)  ).
    ENDTRY.

    TRY.
        raise_business_exception_msg1( ).
      CATCH zmke_cx_business_error INTO business_error.
    ENDTRY.

    TRY.
        raise_business_exception_obj( ).
      CATCH zmke_cx_business_error INTO business_error.
    ENDTRY.
  ENDMETHOD.

  METHOD raise_business_exception.
    RAISE EXCEPTION NEW zmke_cx_business_error( error_code = zmke_cx_business_error=>error_codes-input_not_valid ).
  ENDMETHOD.

  METHOD raise_business_exception_msg1.
    RAISE EXCEPTION TYPE zmke_cx_business_error
      MESSAGE ID 'ZMKE_EXCEPTION_MSGS' TYPE 'E' NUMBER '000' WITH 'V1' 'V2' 'V3' 'V4'
      EXPORTING
         error_code = zmke_cx_business_error=>error_codes-input_not_valid.
  ENDMETHOD.

  METHOD raise_business_exception_msg2.
    MESSAGE ID 'ZMKE_EXCEPTION_MSGS' TYPE 'E' NUMBER '000' WITH 'V1' 'V2' 'V3' 'V4' INTO DATA(dummy).

    RAISE EXCEPTION TYPE zmke_cx_business_error USING MESSAGE
      EXPORTING
        error_code = zmke_cx_business_error=>error_codes-input_not_valid.
  ENDMETHOD.

  METHOD raise_business_exception_obj.
    DATA(error_details) = VALUE string_table( ( `Line 1` )
                                              ( `Line 2` ) ).

    DATA(business_exception) = NEW zmke_cx_business_error( textid        = VALUE #( msgid = 'ZMKE_EXCEPTION_MSGS' msgno = '000' )
                                                           error_code    = zmke_cx_business_error=>error_codes-input_not_valid
                                                           error_details = error_details ).

    RAISE EXCEPTION business_exception.
  ENDMETHOD.

ENDCLASS.
