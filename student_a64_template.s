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

    MOV X8, X0  
    MOV X0, #0
    MOV X1, #60

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

    MOV X0, #1
    SUB X0, X0, #2
    B ended

loop_to_add_decimal_to_X0:
    //for loop to mult
    ADD X0, X0, X7

    CMP X1, XZR
    B.LT ended

    MOV X7, X0

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
