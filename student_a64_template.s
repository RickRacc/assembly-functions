  // This is the general format of an assembly-language program file.
    // Written by: REPLACE THIS WITH YOUR NAME AND UT EID
    .arch armv8-a
    .text
    // Code for all functions go here.



    // ***** WEEK 1 deliverables *****



    // Every function starts from the .align below this line ...
    .align  2
    .p2align 3,,7
    .global ntz
    .type   ntz, %function

ntz:
    // (STUDENT TODO) Code for ntz goes here.
    // Input parameter n is passed in X0
    // Output value is returned in X0.
    LSL X1, X0, #1
    ORR X0, X0, X1
    LSL X1, X0, #2
    ORR X0, X0, X1
    LSL X1, X0, #4
    ORR X0, X0, X1
    LSL X1, X0, #8
    ORR X0, X0, X1
    LSL X1, X0, #16
    ORR X0, X0, X1
    LSL X1, X0, #32
    ORR X0, X0, X1

    MVN X0, X0

    LSR X1, X0, #1
    ANDS X1, X1, 0x5555555555555555
    ANDS X0, X0, 0x5555555555555555
    ADD X0, X0, X1

    LSR X1, X0, #2
    ANDS X1, X1, 0x3333333333333333
    ANDS X0, X0, 0x3333333333333333
    ADD X0, X0, X1

    LSR X1, X0, #4
    ANDS X1, X1, 0x0F0F0F0F0F0F0F0F
    ANDS X0, X0, 0x0F0F0F0F0F0F0F0F
    ADD X0, X0, X1

    LSR X1, X0, #8
    ANDS X1, X1, 0x00FF00FF00FF00FF
    ANDS X0, X0, 0x00FF00FF00FF00FF
    ADD X0, X0, X1

    LSR X1, X0, #16
    ANDS X1, X1, 0x0000FFFF0000FFFF
    ANDS X0, X0, 0x0000FFFF0000FFFF
    ADD X0, X0, X1

    LSR X1, X0, #32
    ANDS X1, X1, 0x00000000FFFFFFFF
    ANDS X0, X0, 0x00000000FFFFFFFF
    ADD X0, X0, X1

    ANDS X0, X0, 0x000000000000007F

    //MOV X0, 0x42
    //ADD X0, X0, XZR 

    ret
    .size   ntz, .-ntz
    // ... and ends with the .size above this line.



    // Every function starts from the .align below this line ...
    .align  2
    .p2align 3,,7
    .global aiken_to_long
    .type   aiken_to_long, %function

aiken_to_long:
    // Input parameter buf is passed in X0
    // Output value is returned in X0.


    // go through each 4 bits of a 64 bit long
    // rewrite those 4 bits as their decimal representation:
    //              0x0 = 0, 0x1 = 1, 0x2 = 2, 0x3 = 3, 0x4 = 4
    //              if between 0x5 and 0xA, return -1
    //              otherwise the number will be between '0xB' through '0xF'
                                //                  , return those as '' - 0x6


    //MOVZ X8, X0
    ANDS X8, X0, 0xFFFFFFFFFFFFFFF
    //LDUR X8, [sp]
    MOVZ X0, #0
    MOVZ X1, #60


for_loop:
    CMP X1, XZR
    B.LT ended


    LSR X7, X8, X1
    ANDS X7, X7, #0xF


    SUB X1, X1, #4


    CMP X7, #0xB
    B.LT IF_LT_0xB


    SUB X7, X7, #0x6
    B loop_to_add_decimal_to_X0


IF_LT_0xB:
    CMP x7, #0x5
    B.LT loop_to_add_decimal_to_X0


    MOVZ X0, #1
    SUB X0, X0, #2
    B ended


loop_to_add_decimal_to_X0:
    //for loop to mult
    ADD X0, X0, X7


    CMP X1, XZR
    B.LT ended


    //MOVZ X7, X0
    ANDS X7, X0, #0xFFFFFFFFFFFFFFF
    //LDUR X7, [sp]


    ADD X0, X0, X7
    ADD X0, X0, X7
    ADD X0, X0, X7
    ADD X0, X0, X7
    LSL X0, X0, #1
    B for_loop


ended:
    RET


    ret


    .size   aiken_to_long, .-aiken_to_long
    // ... and ends with the .size above this line.






    // Every function starts from the .align below this line ...
    .align  2
    .p2align 3,,7
    .global unicode_to_UTF8
    .type   unicode_to_UTF8, %function


unicode_to_UTF8:
    // (STUDENT TODO) Code for unicode_to_UTF8 goes here.
    // Input parameter a is passed in X0; input parameter utf8 is passed in X1.
    // There are no output values.


    //LDUR X2, [X1]
    //MOVZ X3, 0xFF
   
    MOVZ X3, 0x7F
    CMP X0, X3
    B.LE one_byte

    MOVZ X3, 0x07FF
    CMP X0, X3
    B.LE two_bytes

    MOVZ X3, 0xFFFF
    CMP X0, X3
    B.LE three_bytes

    MOVZ X3, 0x10FF
    MOVK X3, 0xFFF, LSL 16
    CMP X0, X3
    B.LE four_bytes

    MOVZ X3, 0xFF
    STUR X3, [X1]
    STUR X3, [X1, #1]
    STUR X3, [X1, #2]
    STUR X3, [X1, #3]


one_byte:
    STUR X0, [X1]
    RET

two_bytes:
    LSR X3, X0, #6
    ANDS X3, X3, #0x1F
    ORR X3, X3, 0xC0
    STUR X3, [X1]
   
    ANDS X3, X0, #0x3F
    ORR X3, X3, #0x80
    STUR X3, [X1, #1]
    RET

three_bytes:
    LSR X3, X0, #12
    ANDS X3, X3, #0x0F
    ORR X3, X3, 0xE0
    STUR X3, [X1]

    LSR X3, X0, #6
    ANDS X3, X3, #0x3F
    ORR X3, X3, 0x80
    STUR X3, [X1, #1]

    //LSR X3, X0, #18
    ANDS X3, X0, #0x3F
    ORR X3, X3, 0x80
    STUR X3, [X1, #2]

    RET


four_bytes:
    LSR X3, X0, #18
    ANDS X3, X3, #0x07
    ORR X3, X3, 0xF0
    STUR X3, [X1]

    LSR X3, X0, #12
    ANDS X3, X3, #0x3F
    ORR X3, X3, 0x80
    STUR X3, [X1, #1]

    LSR X3, X0, #6
    ANDS X3, X3, #0x3F
    ORR X3, X3, 0x80
    STUR X3, [X1, #2]

    //LSR X3, X0, #18
    ANDS X3, X0, #0x3F
    ORR X3, X3, 0x80
    STUR X3, [X1, #3]

    
    RET

    ret
    .size   unicode_to_UTF8, .-unicode_to_UTF8
    // ... and ends with the .size above this line.



    // Every function starts from the .align below this line ...
    .align  2
    .p2align 3,,7
    .global UTF8_to_unicode
    .type   UTF8_to_unicode, %function

UTF8_to_unicode:
    // (STUDENT TODO) Code for UTF8_to_unicode goes here.
    // Input parameter utf8 is passed in X0.
    // Output value is returned in X0.
    LDUR X1, [X0]
    //check if 1st element in array 0, if it is then return 0
    ANDS X1, X1, #0xFF
    CMP X1, XZR
    B.NE first_byte_not_zero
    MOVZ X0, #0
    RET

first_byte_not_zero:
    // first byte is not zero
    LDUR X2, [X0, #1]
    ANDS X2, X2, #0xFF
    CMP X2, XZR
    // check if second byte is zero, just do encoding for 1 byte
    B.NE second_byte_not_zero
    ANDS X0, X1, #0x7F
    RET
    

second_byte_not_zero:
   LSL X1, X1, 8
   EOR x1, X1, 0x00FF

   EOR X2, X2, 0xFF00
   ANDS X1, X1, X2

    LDUR X3, [X0, #2]
    ANDS X3, X3, #0xFF
    CMP X3, XZR
    //check if third byte is zero, just do encoding for 2 bytes
    B.NE third_byte_not_zero
    MOVZ X0, #1
    RET

third_byte_not_zero:
    LSL X1, X1, 8
    EOR x1, X1, 0x0000FF

    EOR X3, X3, 0xFFFF00
    ANDS X1, X1, X3


    LDUR X4, [X0, #3]
    ANDS X4, X4, #0xFF
    CMP X4, XZR
    B.NE fourth_byte_not_zero

    //last
    ANDS X2, X1, 0xF

    //second last
    ANDS X3, X1, 0b110000
    ANDS X4, X1, 0b1100000000
    LSR X4, X4, 2
    ADD X3, X3, X4

    // third last 
    ANDS X4, X1, 0b11110000000000
    LSR X4, X4, 2

    // 4th last
    ANDS X5, X1, 0xF0000
    LSR X5, X5, 4

    ADD X2, X2, X3
    ADD X2, X2, X4
    ADD X2, X2, X5
 
    ANDS X0, X2, 0xFFFF
    RET

fourth_byte_not_zero: 
    LSL X1, X1, 8
    EOR x1, X1, 0x000000FF

    EOR X4, X4, 0xFFFFFF00
    ANDS X1, X1, X4

    
    //last 
    ANDS X2, X1, 0xF

    //MOVZ X9, 0xFFF
    //LSL X9, X9, 12
    //MOVK X9, 0xFF0
    
    //EOR X2, X2, X9

    //second last 
    ANDS X3, X1, 0xF0 
    LSR X3, X3, 4
    ANDS X3, X3, 0b0011

    ANDS X4, X1, 0xF00
    LSR X4, X4, 6
    ANDS X4, X4, 0b1100
    
    ADD X3, X3, X4
    LSL X3, X3, 4

    //MOVZ X9, 0xFFF
    //LSL X9, X9, 12
    //MOVK X9, 0xF0F
    //EOR X2, X2, X9


    // third last
    ANDS X4, X1, 0b11110000000000
    LSR X4, X4, 2

   // MOVZ X9, 0xFFF
   // LSL X9, X9, 12
   // MOVK X9, 0x0FF
   // EOR X4, X4, X9

    //4th last
    ANDS X5, X1, 0xF0000
                 
    LSR X5, X5, 4

   // MOVZ X9, 0xFF0
   // LSL X9, X9, 12
   // MOVK X9, 0xFFF
   // EOR X5, X5, X9

    //5th last
    ANDS X6, X1, 0b1100000000000000000000
    LSR X6, X6, 20

    ANDS X7, X1, 0b11000000000000000000000000
    LSR X7, X7, 22
    
    ADD X6, X6, X7
    //0xF0FFFF
    LSL X6, X6, 16

    // 6th last
    ANDS X7, X1, 0b100000000000000000000000000
    //0x0FFFFF
    LSR X7, X7, 6
    

    ADD X2, X2, X3
    ADD X2, X2, X4
    ADD X2, X2, X5
    ADD X2, X2, X6
    ADD X2, X2, X7


    ANDS X0, X2, 0xFFFFFF
    RET
    

    ret
    .size   UTF8_to_unicode, .-UTF8_to_unicode
    // ... and ends with the .size above this line.



    // ***** WEEK 2 deliverables *****



    // Every function starts from the .align below this line ...
    .align  2
    .p2align 3,,7
    .global ustrncmp
    .type   ustrncmp, %function

ustrncmp:
    // (STUDENT TODO) Code for ustrncmp goes here.
    // Input parameter str1 is passed in X0; input parameter str2 is passed in X1;
    //  input parameter num is passed in X2
    // Output value is returned in X0.
    ret

    .size   ustrncmp, .-ustrncmp
    // ... and ends with the .size above this line.



    // Every function starts from the .align below this line ...
    .align  2
    .p2align 3,,7
    .global gcd_rec
    .type   gcd_rec, %function

gcd_rec:
    // (STUDENT TODO) Code for gcd_rec goes here.
    // Input parameter a is passed in X0; input parameter b is passed in X1.
    // Output value is returned in X0.
    ret

    .size   gcd_rec, .-gcd_rec
    // ... and ends with the .size above this line.



    // Every function starts from the .align below this line ...
    .align  2
    .p2align 3,,7
    .global tree_traversal
    .type   tree_traversal, %function

tree_traversal:
    // (STUDENT TODO) Code for tree_traversal goes here.
    // Input parameter root is passed in X0; input parameter bit_string is passed in X1;
    //  input parameter bit_string_length is passed in X2
    // Output value is returned in X0.
    ret

    .size   tree_traversal, .-tree_traversal
    // ... and ends with the .size above this line.



    // Every function starts from the .align below this line ...
    .align  2
    .p2align 3,,7
    .global collatz_TST
    .type   collatz_TST, %function

collatz_TST:
    // Input parameter n is passed in X0
    // Output value is returned in X0.
    ret

    .size   collatz_TST, .-collatz_TST
    // ... and ends with the .size above this line.



    .section    .rodata
    .align  4
    // (STUDENT TODO) Any read-only global variables go here.
    .data
    // (STUDENT TODO) Any modifiable global variables go here.
    .align  3
