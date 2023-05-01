CLASS zmke_cx_business_error DEFINITION PUBLIC FINAL INHERITING FROM cx_static_check CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_t100_dyn_msg.

    ALIASES msg_type FOR if_t100_dyn_msg~msgty.
    ALIASES msg_var1 FOR if_t100_dyn_msg~msgv1.
    ALIASES msg_var2 FOR if_t100_dyn_msg~msgv2.
    ALIASES msg_var3 FOR if_t100_dyn_msg~msgv3.
    ALIASES msg_var4 FOR if_t100_dyn_msg~msgv4.

    ALIASES msg_key FOR if_t100_message~t100key.

    CONSTANTS: BEGIN OF error_codes,
                 input_not_valid TYPE sysubrc VALUE 1,
                 no_data         TYPE sysubrc VALUE 2,
                 wrong_data      TYPE sysubrc VALUE 3,
                 unknown         TYPE sysubrc VALUE 4,
               END OF error_codes.

    DATA error_code TYPE sysubrc READ-ONLY.
    DATA error_details TYPE string_table READ-ONLY.

    METHODS constructor
      IMPORTING
        textid        LIKE if_t100_message=>t100key OPTIONAL
        previous      LIKE previous OPTIONAL
        error_code    TYPE sysubrc OPTIONAL
        error_details TYPE string_table OPTIONAL.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zmke_cx_business_error IMPLEMENTATION.

  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).

    CLEAR me->textid.

    IF textid IS INITIAL.
      msg_key = if_t100_message=>default_textid.
    ELSE.
      msg_key = textid.
    ENDIF.

    IF error_code IS NOT INITIAL.
      me->error_code = error_code.
    ELSE.
      me->error_code = error_codes-unknown.
    ENDIF.

    me->error_details = error_details.
  ENDMETHOD.

ENDCLASS.
