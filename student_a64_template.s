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

    //last
    ANDS X2, X1, 0xF

    //second last
    ANDS X3, X1, 0b110000
    ANDS X4, X1, 0b1100000000
    LSR X4, X4, 2
    ADD X3, X3, X4

    //last
    ANDS X4, X1, 0b1110000000000
    LSR X4, X4, 2

    ADD X2, X2, X3
    ADD X2, X2, X4

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
    ANDS X0, X2, 0xFFF

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



// make a for loop that goes through n times
// check if current iteration of loop and num are same
        // if so return 2
// check if the characters at the cur position are the same
        // if they are move onto the next 
// if they arent the same
        // check if either of them are the null terminator
            // if so return 100
        // if both are non null ASCII vals,
            // return 1 if ASCCI val at cur pos in str1 is greater
            // and -1 if ASCII val at cur pos in str2 is greater
ustrncmp:
    // (STUDENT TODO) Code for ustrncmp goes here.
    // Input parameter str1 is passed in X0; input parameter str2 is passed in X1;
    //  input parameter num is passed in X2
    // Output value is returned in X0.

    MOVZ X3, #0
    

// 1 and 3 supposed to equal 2
// 2 supposed to be -1
// 4 supposed to be 100
// 5 supposed to be 1
for_loop2:
    //ANDS X0, X2, #0xFF
    //ret
    CMP X3, X2
    B.EQ the_end

    LDUR X4, [X0]
    LDUR X5, [X1]
    ANDS X4, X4, #0xFF
    ANDS X5, X5, #0xFF
    CMP X4, X5
    //ret
    B.NE different_vals
    
    ADD X3, X3, #1
    ADD X0, X0, #1
    ADD X1, X1, #1
    B for_loop2

different_vals:
    CMP X4, #0
    B.EQ null_terminator
    CMP X5, #0
    B.EQ null_terminator

    CMP X4, X5
    B.LT less_than
    MOVZ X0, #1
    RET

less_than:
    MOVZ X0, #1
    SUB X0, X0, #2
    RET
    
null_terminator:
    MOVZ X0, #100
    RET

the_end:
    MOVZ X0, #2
    RET



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

    //if a = 0, or b = 0, return -1
    
    //CMP X0, #10
   // B.GT finished

    CMP X0, XZR
    B.EQ val_zero
    CMP X1, XZR
    B.EQ val_zero

    MOVZ X2, #0
    
recursion:
    SUB SP, SP, #16
    STUR X29, [SP]
    STUR X30, [SP, #8]   
    ADD X29, SP, XZR  

    
    //ADDS X2, X2, #1

    CMP X0, XZR
    B.EQ finished

    CMP X0, X1
    B.GT base_case1

    ANDS X2, X0, #0xFFFFFFF
    ANDS X0, X1, #0xFFFFFFF
    ANDS X1, X2, #0xFFFFFFF
    MOVZ X2, #0
    

    // make into BL
    //B recursion

base_case1:
    SUBS X0, X0, X1
    
    //make into BL and then return
    BL recursion

    LDUR X30, [X29, #8]
    LDUR X29, [X29]
    ADD SP, SP, #16

    ret
    

finished:
    ANDS X0, X1, #0xFFFFFFF
    ret

val_zero:
    MOVZ X0, #1
    SUBS X0, X0, #2
    ret

    RET

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
    CMP X2, XZR
    B.EQ returnNeg

traverse:
    CMP X0, #0
    B.EQ returnNeg

    CMP X2, XZR
    B.EQ found

    SUB X2, X2, #1

    ANDS X3, X1, 0b01
    LSR X1, X1, #1
    CMP X3, #1
    B.EQ rightChild

    LDUR X0, [X0]
    B traverse



rightChild:
    LDUR X0, [X0, #8]
    B traverse

    

found:
    LDUR X0, [X0, #16]
   // MOVZ X0, 0
    ret


returnNeg:
    MOVZ X0, #1
    SUB X0, X0, #2
    ret

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
    MOVZ X3, #0
    EOR X3, X3, 0x00FF00FF00FF00FF
    EOR X3, X3, 0xFF00FF00FF00FF00

collatLoop:
    CMP X0, #1
    B.EQ exit

    //ADD X3, X3, #1
    LSL X3, X3, 1

    AND X1, X0, #1
    CMP X1, XZR
    B.EQ  even

    ADD X2, X0, #0
    ADD X0, X0, X2
    ADD X0, X0, X2
    ADD X0, X0, #1
    B collatLoop

even:
    LSR X0, X0, #1
    B collatLoop

exit:
    ADD X0, X3, #0
    B ntz
    

    //ret

    .size   collatz_TST, .-collatz_TST
    // ... and ends with the .size above this line.



    .section    .rodata
    .align  4
    // (STUDENT TODO) Any read-only global variables go here.
    .data
    // (STUDENT TODO) Any modifiable global variables go here.
    .align  3
