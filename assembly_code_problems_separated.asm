; ===== Problem 1 Start =====
Problem No - 1 : Write an assembly language program that can print a
string.
Objectives
1. To set up the program’s memory model and stack for a simple application.
2. To define and initialize a string variable in the data segment for output.
3. To use a DOS interrupt to print the string and then terminate the program.
Algorithm
1. Defining the string
2. Initializing the variable
3. Print the string using DOS interrupter
4. End program
Program Code
1.MODEL SMALL
2.STACK 200H
3
4.DATA
5MSG DB 'Hello World!!', '$' ; Defines a string with ending character
6
7.CODE
8MAIN PROC
9; Initialize the data variables @ data
10 MOV AX, @DATA
11 MOV DS, AX
12
13; Pringing the MSG
14 MOV AH, 09h
15 LEA DX, MSG
16 INT 21h
17
18; Eziting the program
19 MOV AX, 4CH
20 INT 21h
21MAIN ENDP
22END MAIN
1

; ===== Problem 1 End =====


; ===== Problem 2 Start =====
Problem No - 2 : Write an assembly language program that can add two
number up to 3 digits.
Objectives
1. To understand the use of DOS interrupts for input/output operations in 8086 assembly.
2. To learn how to take numeric string input from the user using function INT 21H, AH=0Ah .
3. To perform manual conversion of string input to integer (ASCII to binary).
4. To add two 16-bit numbers using basic arithmetic operations.
5. To convert an integer result back to string format (binary to ASCII).
6. To display the final result on the screen using function INT 21H, AH=09H .
7. To strengthen understanding of memory access, register operations, and control flow in
8086 Assembly.
Algorithm
1. Initialize the data segment by loading the address of the data into the DS register.
2. Display the first prompt message asking for input A.
3. Read the first number as a string using INT 21H, AH=0Ah .
4. Convert the input string to a numeric value using a custom STR TOINT procedure.
5. Store the result in variable A.
6. Display the second prompt message asking for input B.
7. Read the second number as a string using INT 21H, AH=0Ah .
8. Convert the input string to a numeric value using the same STR TOINT procedure.
9. Store the result in variable B.
10. Add the values stored in A and B, and store the result in variable SUM.
11. Convert the numeric result (SUM) to a string using a custom INT TOSTR procedure.
12. Display the result message and the converted string using INT 21H, AH=09H .
13. Terminate the program using INT 21H, AH=4Ch .
3
Program Code
1.MODEL SMALL
2.STACK 100H
3
4.DATA
5A DW ?
6B DW ?
7SUM DW ?
8MSGBUFFER DB 255
9 DB ?
10 DB 255 DUP(?)
11PROMPT1 DB 'Enter A :', '$'
12PROMPT2 DB 'Enter B :', '$'
13NEWLINE DB 0AH, 0DH, '$'
14OUTSTR DB 'The sum = '
15OUTPUT DB 10 DUP('$')
16
17.CODE
18PROC MAIN
19; Initialize the data
20 MOV AX, @DATA
21 MOV DS, AX
22; Prompt for input A
23 LEA DX, PROMPT1
24 MOV AH, 09H
25 INT 21H
26
27; Take input of number string
28 CALL TAKE_INPUT
29
30; Convert it to integer and store in A
31 CALL STR_TO_INT
32 MOV A, AX
33
34; Prompt for input B
35 LEA DX, PROMPT2
36 MOV AH, 09H
37 INT 21H
38
39; Take input of number string
40 CALL TAKE_INPUT
41
42; Convert it to integer and store in B
43 CALL STR_TO_INT
44 MOV B, AX
45
46; SUM = A + B
47 MOV AX, A
48 MOV BX, B
4
49 ADD AX, BX
50 MOV SUM, AX
51
52; Convert SUM to string
53 CALL INT_TO_STR
54
55; print string of SUM
56 LEA DX, OUTSTR
57 MOV AH, 09H
58 INT 21H
59
60; End the program
61 MOV AX, 4CH
62 INT 21H
63ENDP MAIN
64
65TAKE_INPUT:
66 LEA DX, MSGBUFFER
67 MOV AH, 0AH
68 INT 21H
69 LEA DX, NEWLINE
70 MOV AH, 09H
71 INT 21H
72 RET
73
74STR_TO_INT:
75 MOV SI, OFFSET MSGBUFFER + 2
76 XOR AX, AX
77 XOR CX, CX
78 MOV CX, 10
79 XOR BX, BX
80 XOR DX, DX
81NEXT:
82 MOV BL, [SI]
83 CMP BL, 0DH
84 JE DONE
85 MUL CX
86 SUB BL, '0'
87 ADD AX, BX
88 INC SI
89 JMP NEXT
90DONE:
91 RET
92
93INT_TO_STR:
94 LEA SI, OUTPUT
95 MOV BX, 10
96 XOR CX, CX
97 XOR DX, DX
98 CMP AX, 0
5
99 JNZ DIV_LOOP
100 MOV [SI], '0'
101 RET
102
103DIV_LOOP:
104 DIV BX
105 ADD DX, '0'
106 PUSH DX
107 INC CX
108 XOR DX, DX
109 CMP AX, 0
110 JNZ DIV_LOOP
111
112REVERSING:
113 POP DX
114 MOV [SI], DL
115 INC SI
116 LOOP REVERSING
117
118 RET
119END MAIN

; ===== Problem 2 End =====


; ===== Problem 3 Start =====
Problem No - 3 : Write an assembly language program that can subtract
two number up to 3 digits.
Objectives
1. To understand and practice low-level input and output operations using DOS interrupts
in x86 Assembly.
2. To implement string-to-integer and integer-to-string conversions manually.
3. To perform basic arithmetic operations (subtraction) in Assembly.
4. To handle signed results for subtraction and format output with a negative sign where
necessary.
5. To build an interactive console-based program for arithmetic using Assembly language.
Algorithm
1. Input Handling ( TAKE INPUT )
(a) Uses DOS interrupt INT 21h / AH = 0Ah to read a string from the user into a
buffer.
2. String to Integer Conversion (STR TOINT)
(a) Starts at MSGBUFFER + 2 (to skip metadata).
(b) Multiplies the current value in AXby 10 and adds the new digit each iteration.
(c) Stops when carriage return ( 0Dh) is encountered.
3. Subtraction Logic
(a) Loads two input integers A and B into registers.
(b) Performs AX = A - B using SUB AX, BX .
(c) Stores result in ANS .
4. Signed Integer to String Conversion ( INT TOSTR )
(a) Checks if result is negative:
i. If so, adds ’-’ to the output string.
ii. Converts the absolute value of the result.
(b) Converts integer to string by repeated division by 10 and stack-based reversal.
(c) Outputs result using INT 21h / AH = 09h .
7
Program Code
1.MODEL SMALL
2.STACK 100H
3
4.DATA
5A DW ?
6B DW ?
7ANS DW ?
8MSGBUFFER DB 255
9 DB ?
10 DB 255 DUP(?)
11PROMPT1 DB 'Enter A :', '$'
12PROMPT2 DB 'Enter B :', '$'
13NEWLINE DB 0AH, 0DH, '$'
14OUTSTR DB 'A - B = '
15OUTPUT DB 10 DUP('$')
16
17.CODE
18PROC MAIN
19; Initialize the data
20 MOV AX, @DATA
21 MOV DS, AX
22; Prompt for input A
23 LEA DX, PROMPT1
24 MOV AH, 09H
25 INT 21H
26
27; Take input of number string
28 CALL TAKE_INPUT
29
30; Convert it to integer and store in A
31 CALL STR_TO_INT
32 MOV A, AX
33
34; Prompt for input B
35 LEA DX, PROMPT2
36 MOV AH, 09H
37 INT 21H
38
39; Take input of number string
40 CALL TAKE_INPUT
41
42; Convert it to integer and store in B
43 CALL STR_TO_INT
44 MOV B, AX
45
46
47; ANS = A - B
48 MOV AX, A
8
49 MOV BX, B
50 SUB AX, BX
51 MOV ANS, AX
52
53; Convert ANS to string
54 CALL INT_TO_STR
55
56; print string of SUM
57 LEA DX, OUTSTR
58 MOV AH, 09H
59 INT 21H
60
61; End the program
62 MOV AX, 4CH
63 INT 21H
64ENDP MAIN
65
66TAKE_INPUT:
67 LEA DX, MSGBUFFER
68 MOV AH, 0AH
69 INT 21H
70 LEA DX, NEWLINE
71 MOV AH, 09H
72 INT 21H
73 RET
74
75STR_TO_INT:
76 MOV SI, OFFSET MSGBUFFER + 2
77 XOR AX, AX
78 XOR CX, CX
79 MOV CX, 10
80 XOR BX, BX
81 XOR DX, DX
82NEXT:
83 MOV BL, [SI]
84 CMP BL, 0DH
85 JE DONE
86 MUL CX
87 SUB BL, '0'
88 ADD AX, BX
89 INC SI
90 JMP NEXT
91DONE:
92 RET
93
94INT_TO_STR:
95 LEA SI, OUTPUT
96
97 MOV AX, A
98 MOV BX, B
9
99 CMP AX, BX
100 JAE NO_NEGATIVE ; if A >= B
101; ADD negative and negate the number
102 XOR AX, AX
103 MOV AL, '-'
104 MOV [SI], AL
105 INC SI
106 MOV AX, ANS
107 NEG AX
108 MOV ANS, AX
109NO_NEGATIVE:
110 MOV AX, ANS
111 XOR CX, CX
112 MOV BX, 10
113 XOR DX, DX
114 CMP AX, 0
115 JNE DIV_LOOP
116 MOV [SI], '0'
117 RET
118
119DIV_LOOP:
120 DIV BX
121 ADD DX, '0'
122 PUSH DX
123 INC CX
124 XOR DX, DX
125 CMP AX, 0
126 JNZ DIV_LOOP
127
128REVERSING:
129 POP DX
130 MOV [SI], DL
131 INC SI
132 LOOP REVERSING
133
134 RET
135END MAIN

; ===== Problem 3 End =====


; ===== Problem 4 Start =====
Problem No - 4 : Write an assembly language program that can convert an
uppercase letter to a lowercase / a lowercase letter to a
uppercase letter
Objectives
1. To implement a character case converter using Assembly language.
2. To learn the use of basic I/O operations via DOS interrupts ( INT 21h ).
3. To manipulate character encoding using bitwise operations (XOR).
4. To practice conditional logic simplification without using jump-based branching.
5. To understand how ASCII values differ for uppercase and lowercase characters.
Algorithm
1. Input/Output via DOS Interrupts
(a) Uses INT 21h / AH = 09h to print strings.
(b) Uses INT 21h / AH = 01h to take a single character input from the user.
2. Case Conversion Logic
(a) Takes advantage of the ASCII value difference between uppercase and lowercase
letters.
(b) ASCII difference between ’a’and’A’is20H (hex) , which is 32in decimal.
(c) Applying XOR 20H toggles the case:
i.’a’(0x61) XOR 0x20 = ’A’(0x41)
ii.’A’(0x41) XOR 0x20 = ’a’(0x61)
3. Program Flow
(a) Prompt for input.
(b) Read a single character.
(c) Perform XOR 20H to flip case.
(d) Output result string + converted character.
Program Code
1.MODEL SMALL
2.STACK 100H
3
4.DATA
5 STR1 DB 'Enter a character : ', '$'
6 STR2 DB 'Case converted : '
7 A DB ?
8 NEWLINE DB 0AH, 0DH, '$'
9.CODE
12
10MAIN PROC
11; INITIALIZE DATA
12 MOV AX, @DATA
13 MOV DS, AX
14
15; ENTRY PROMPT
16 MOV AH, 09H
17 LEA DX, STR1
18 INT 21H
19
20; TAKE INPUT
21 MOV AH, 01H
22 INT 21H
23 MOV A, AL
24
25; NEWLINE
26 MOV AH, 09H
27 LEA DX, NEWLINE
28 INT 21H
29
30; LOGIC
31 MOV BL, 20H
32 MOV AL, A
33 XOR AL, BL
34 MOV A, AL
35
36LAST:
37; PRINT PROMPT, CHARACTER, AND NEWLINE
38 MOV AH, 09H
39 LEA DX, STR2
40 INT 21H
41; END PROGRAM
42 MOV AX, 4CH
43 INT 21H
44ENDP MAIN
45
46END MAIN

; ===== Problem 4 End =====


; ===== Problem 5 Start =====
Problem No - 5 : Write an assembly language program that can reverse a
bit pattern.
Objectives
•To understand bit-level manipulation using Assembly language.
•To learn how to reverse the bit pattern of an 8-bit binary number.
•To practice using shift and rotate instructions in x86 assembly.
•To gain experience with loop constructs and register operations in low-level programming.
Algorithm
1. Start the program and initialize the data segment.
2. Load the 8-bit binary value from variable ‘A‘ into register ‘AL‘.
3. Clear register ‘BX‘ to use ‘BL‘ for storing the reversed bit pattern.
4. Set loop counter ‘CX‘ to 8 for 8-bit reversal.
5. In each iteration of the loop:
•Shift ‘AL‘ one bit to the left (SHL AL, 1).
•Rotate ‘BL‘ one bit to the right through carry (RCR BL, 1).
6. After the loop, store the contents of ‘BL‘ (reversed bits) into variable ‘B‘.
7. Terminate the program.
Program Code
1.MODEL SMALL
2.STACK 100H
3.DATA
4 A DB 10111011B
5 B DB ?
6.CODE
7PROC MAIN
8; INITIALIZE DATA
9 MOV AX, @DATA
10 MOV DS, AX
11
12; REVERSING A AND STORING IT IN B
13 MOV AL, A
14 MOV CX, 08H
15 XOR BX, BX
16
17; LOOP PART
18RETURN:
15
19 SHL AL, 1
20 RCR BL, 1
21 LOOP RETURN
22; STORING THE REVERSE THE PATTERN IN B
23 MOV B, BL
24
25
26; ENDING THE PROGRAM
27 MOV AX, 4CH
28 INT 21H
29MAIN ENDP
30END MAIN

; ===== Problem 5 End =====


; ===== Problem 6 Start =====
Problem No - 6 : Write an assembly language program that can reverse the
given input.
Objectives
•To learn how to read string input from the user using DOS interrupt services.
•To practice manipulating and storing characters using stack operations.
•To implement string reversal using low-level assembly instructions.
•To gain familiarity with string buffers and the use of the stack for temporary storage.
Algorithm
1. Start the program and initialize the data segment.
2. Display a prompt message asking the user to enter a string.
3. Read the input string into the buffer using DOS function AH = 0Ah .
4. Set the source index (SI) to point to the first character of the string in the buffer (offset
BUFFER + 2).
5. Initialize the counter register (CX) to 0 for counting characters.
6. Loop through the string, pushing each character onto the stack and incrementing SI and
CX.
7. Stop looping once a carriage return (0Dh) is encountered.
8. Print a new line and an output label.
9. Pop characters from the stack one by one and print them to reverse the string.
10. Terminate the program using DOS function AH = 4Ch .
Program Code
1.MODEL SMALL
2.STACK 100H
3.DATA
4 BUFFER DB 255
5 DB ?
6 DB 255 DUP(?)
7 STRING DB 255 DUP(?)
8 NEWLINE DB 0AH, 0DH, '$'
9 PROMPT DB 'ENTER YOUR STRING : ', '$'
10 OUTTXT DB 'YOUR STRING REVERSED : ', '$'
11.CODE
12PROC MAIN
13; Initialize Data
14 MOV AX, @DATA
17
15 MOV DS, AX
16
17 LEA DX, PROMPT
18 MOV AH, 09H
19 INT 21H
20
21 LEA DX, BUFFER
22 MOV AH, 0AH
23 INT 21H
24
25 MOV SI, OFFSET BUFFER+2
26 XOR CX, CX
27LOOPBACK:
28 PUSH [SI]
29 INC SI
30 INC CX
31 CMP [SI], 0DH
32 JNE LOOPBACK
33
34 LEA DX, NEWLINE
35 MOV AH, 09H
36 INT 21H
37
38 LEA DX, OUTTXT
39 INT 21H
40
41BACK:
42 MOV AH, 02H
43 POP DX
44 INT 21H
45 LOOP BACK
46
47; END PROGRAM
48 MOV AH, 4CH
49 INT 21H
50MAIN ENDP
51END MAIN

; ===== Problem 6 End =====


; ===== Problem 7 Start =====
Problem No - 7 : Write an assembly language program for push and pop
operations on a stack.
Objectives
•To understand how stack operations work in low-level assembly.
•To demonstrate the use of PUSH andPOPinstructions.
•To show how data is saved and restored from the stack.
•To develop skills in using registers and stack segment operations.
Algorithm
1. Initialize the data segment.
2. Load values into general purpose registers (e.g., AX, BX).
3. Push the values from registers onto the stack.
4. Clear the registers to simulate data being “lost.”
5. Pop the values back into different registers to verify stack behavior.
6. Optionally, display the values before and after the push/pop operations.
7. Terminate the program.
Program Code
1.MODEL SMALL
2.STACK 100H
3.DATA
4 MSG1 DB 'BEFORE PUSH: AX = $'
5 MSG2 DB 'AFTER POP : BX = $'
6 NEWLINE DB 0AH, 0DH, '$'
7.CODE
8PROC MAIN
9 MOV AX, @DATA
10 MOV DS, AX
11
12; LOAD VALUE INTO AX
13 MOV AX, 1234H
14
15; DISPLAY MESSAGE BEFORE PUSH
16 LEA DX, MSG1
17 MOV AH, 09H
18 INT 21H
19
20; DISPLAY VALUE IN AX
21 MOV DX, AX
20
22 CALL PRINT_HEX
23
24; NEWLINE
25 LEA DX, NEWLINE
26 MOV AH, 09H
27 INT 21H
28
29; PUSH OPERATION
30 PUSH AX
31
32; CLEAR AX TO SIMULATE LOSS
33 MOV AX, 0000H
34
35; POP INTO BX
36 POP BX
37
38; DISPLAY MESSAGE AFTER POP
39 LEA DX, MSG2
40 MOV AH, 09H
41 INT 21H
42
43; DISPLAY VALUE IN BX
44 MOV DX, BX
45 CALL PRINT_HEX
46
47; EXIT
48 MOV AH, 4CH
49 INT 21H
50MAIN ENDP
51
52; CONVERT HIGH BYTE
53PRINT_HEX:
54 MOV AH, DL
55 SHR AH, 4
56 CALL PRINT_DIGIT
57 AND DL, 0FH
58 MOV AH, DL
59 CALL PRINT_DIGIT
60 RET
61
62PRINT_DIGIT:
63 ADD AH, '0'
64 CMP AH, '9'
65 JBE PRINT_CHAR
66 ADD AH, 7
67PRINT_CHAR:
68 MOV DL, AH
69 MOV AH, 02H
70 INT 21H
71 RET
21
72
73END MAIN

; ===== Problem 7 End =====


; ===== Problem 8 Start =====
Problem No - 8 : Write an assembly language program to print the Fibonacci
series.
Objectives
1. To understand and implement iterative loops in assembly language.
2. To perform arithmetic operations and data movement using registers.
3. To convert numerical values to ASCII format for displaying output.
4. To demonstrate the use of stack and procedure calls in modular assembly programming.
Algorithm
1. Initialize Data Segment:
(a) Load segment registers and initialize required variables.
(b) Display a title message using DOS interrupt.
2. Setup Initial Fibonacci Numbers:
(a) Store the first two Fibonacci numbers (0 and 1) in registers AX and BX.
3. Start Loop:
(a) Print the value of AX.
(b) Compute the next Fibonacci number as AX + BX.
(c) Swap values of AX and BX to maintain order.
(d) Repeat the loop until the count (LIMIT) is reached.
4. Conversion & Output:
(a) Call a procedure to convert the current number from binary to ASCII.
(b) Print the string using DOS interrupt INT 21H.
(c) Print a comma to separate numbers, unless the end is reached.
5. Exit:
(a) Return control to the operating system using INT 21H function 4CH.
Program Code
1.MODEL SMALL
2.STACK 100H
3.DATA
4 MSG DB 'FIBONACCI SERIES : ', '$'
5 COMMA DB ', ','$'
6 LIMIT DW 20
7 A DW 0
8 B DW 1
23
9 VAR DW ?
10 OUTSTR DB 10 DUP('$')
11
12.CODE
13PROC MAIN
14; LOAD DATA
15 MOV AX, @DATA
16 MOV DS, AX
17
18; PROMPT
19 LEA DX, MSG
20 MOV AH, 09H
21 INT 21H
22
23; PRINTING FIBONACCI SERIES
24; SETUP
25 MOV AX, A
26 MOV BX, B
27 MOV CX, LIMIT
28; ACTUAL LOOP
29LOOPBACK:
30 MOV VAR, AX
31 CALL CONVERT_VAR
32 CALL PRINT_OUTSTR
33 CMP CX, 0
34 JE END
35 CALL PRINT_COMMA
36
37 ADD AX, BX
38 XOR AX, BX
39 XOR BX, AX
40 XOR AX, BX
41 LOOP LOOPBACK
42
43END:
44; EXIT
45 MOV AH, 4CH
46 INT 21H
47MAIN ENDP
48
49PRINT_COMMA:
50 PUSH AX
51 PUSH BX
52 PUSH CX
53 PUSH DX
54
55 MOV AH, 09H
56 LEA DX, COMMA
57 INT 21H
58
24
59 POP DX
60 POP CX
61 POP BX
62 POP AX
63 RET
64
65PRINT_OUTSTR:
66 PUSH AX
67 PUSH BX
68 PUSH CX
69 PUSH DX
70
71 MOV AH, 09H
72 LEA DX, OUTSTR
73 INT 21H
74
75 POP DX
76 POP CX
77 POP BX
78 POP AX
79 RET
80
81CONVERT_VAR:
82 PUSH AX
83 PUSH BX
84 PUSH CX
85 PUSH DX
86
87 MOV AX, VAR
88 MOV DI, OFFSET OUTSTR
89 XOR CX,CX
90
91 CMP AX, 0
92 JE ZERO
93LOOPING:
94 MOV BX, 10
95 XOR DX,DX
96 DIV BX
97 ADD DL, '0'
98 PUSH DX
99 INC CX
100 CMP AX, 0
101 JNZ LOOPING
102
103POPING:
104 POP DX
105 MOV [DI], DL
106 INC DI
107 LOOP POPING
108
25
109 JMP STREND
110
111ZERO:
112 MOV [DI], '0'
113 INC DI
114
115STREND:
116 MOV [DI], '$'
117
118; RETURN TIME
119 POP DX
120 POP CX
121 POP BX
122 POP AX
123 RET
124
125END MAIN

; ===== Problem 8 End =====


; ===== Problem 9 Start =====
Problem No - 9 : Write an assembly language program to find if a given
number is even or odd.
Objectives
1. To learn how to use logical operations in assembly.
2. To understand how to check the parity (even or odd) of a number.
3. To gain experience in using conditional jumps and flow control.
4. To display appropriate output based on a condition.
Algorithm
1. Initialize the data segment and load the number to be tested.
2. Use bitwise AND operation with 00000001B (i.e., 1) to check the least significant bit
(LSB):
(a) If LSB is 0 →number is even.
(b) If LSB is 1 →number is odd.
3. Based on the result, jump to the corresponding label to display either “EVEN” or “ODD”.
4. Use INT 21H with AH = 09H to display the message.
5. Exit the program cleanly using INT 21H with AH = 4CH.
Program Code
1.MODEL SMALL
2.STACK 100H
3.DATA
4MSG1 DB 'Enter a number (0-9): $'
5EVEN_MSG DB 'Number is EVEN$', '$'
6ODD_MSG DB 'Number is ODD$', '$'
7NEWLINE DB 0AH, 0DH, '$'
8NUMBER DB ?
9
10.CODE
11MAIN PROC
12 MOV AX, @DATA
13 MOV DS, AX
14
15 LEA DX, MSG1
16 MOV AH, 09H
17 INT 21H
18
19 MOV AH, 01H
20 INT 21H
21
27
22 SUB AL, '0'
23 MOV NUMBER, AL
24
25 LEA DX, NEWLINE
26 MOV AH, 09H
27 INT 21H
28
29 MOV AL, NUMBER
30 AND AL, 01H
31
32 JZ EVEN
33
34ODD:
35 LEA DX, ODD_MSG
36 MOV AH, 09H
37 INT 21H
38 JMP EXIT
39
40EVEN:
41 LEA DX, EVEN_MSG
42 MOV AH, 09H
43 INT 21H
44
45EXIT:
46 MOV AH, 4CH
47 INT 21H
48MAIN ENDP
49END MAIN

; ===== Problem 9 End =====


; ===== Problem 10 Start =====
Problem No - 10 : Write an assembly language program for multiplication
and division of two numbers up to 2 or 3 digits.
Objectives
1. To understand the use of multiplication and division instructions in 8086 assembly lan-
guage.
2. To take user input of two numbers (up to 3 digits) and perform multiplication and division.
3. To display the result of multiplication and division operations using DOS interrupts.
Algorithm
1. Display prompts to take two decimal numbers as input.
2. Use DOS function 0AH to read string input and convert ASCII to integer.
3. Store the two numbers in registers.
4. Multiply the numbers using the MUL instruction.
5. Divide the numbers using the DIV instruction.
6. Convert the results back from integer to string.
7. Display the multiplication and division results using DOS interrupts.
Program Code
1.MODEL SMALL
2.STACK 100H
3
4.DATA
5A DW ?
6B DW ?
7ANS DW ?
8MSGBUFFER DB 255
9 DB ?
10 DB 255 DUP(?)
11PROMPT1 DB 'Enter A :', '$'
12PROMPT2 DB 'Enter B :', '$'
13NEWLINE DB 0AH, 0DH, '$'
14OUTSTR DB 'A * B = $'
15OUTSTR2 DB 'A / B = $'
16DZMSG DB 'Error: Division by zero!$'
17OUTPUT DB 10 DUP('$')
18
19.CODE
20PROC MAIN
21; Initialize the data
22 MOV AX, @DATA
29
23 MOV DS, AX
24; Prompt for input A
25 LEA DX, PROMPT1
26 MOV AH, 09H
27 INT 21H
28
29; Take input of number string
30 CALL TAKE_INPUT
31
32; Convert it to integer and store in A
33 CALL STR_TO_INT
34 MOV A, AX
35
36; Prompt for input B
37 LEA DX, PROMPT2
38 MOV AH, 09H
39 INT 21H
40
41; Take input of number string
42 CALL TAKE_INPUT
43
44; Convert it to integer and store in B
45 CALL STR_TO_INT
46 MOV B, AX
47
48; ANS = A * B
49 MOV AX, A
50 MOV BX, B
51 MUL BX
52 MOV ANS, AX
53
54; Convert ANS to string
55 CALL INT_TO_STR
56
57; print string of ANS
58 LEA DX, OUTSTR
59 MOV AH, 09H
60 INT 21H
61 LEA DX, OUTPUT
62 MOV AH, 09H
63 INT 21H
64 LEA DX, NEWLINE
65 MOV AH, 09H
66 INT 21H
67
68
69; Perform division: AX = A / B
70 MOV AX, A
71 MOV BX, B
72
30
73 CMP BX, 0
74 JE DIV_BY_ZERO ; Handle division by zero
75
76 XOR DX, DX ; Clear remainder
77 DIV BX ; AX = A / B
78 MOV ANS, AX ; Store result
79
80; Clear OUTPUT buffer before storing new result
81 LEA DI, OUTPUT
82 MOV CX, 10
83 MOV AL, '$'
84 REP STOSB
85
86 LEA DX, OUTSTR2
87 MOV AH, 09H
88 INT 21H
89
90; Convert ANS to string
91 MOV AX, ANS
92 CALL INT_TO_STR
93
94; Print division result
95 LEA DX, OUTPUT
96 MOV AH, 09H
97 INT 21H
98
99
100 JMP AFTER_DIV
101
102DIV_BY_ZERO:
103 LEA DX, NEWLINE
104 MOV AH, 09H
105 INT 21H
106 LEA DX, DZMSG
107 MOV AH, 09H
108 INT 21H
109
110AFTER_DIV:
111
112
113
114; End the program
115 MOV AX, 4CH
116 INT 21H
117ENDP MAIN
118
119TAKE_INPUT:
120 LEA DX, MSGBUFFER
121 MOV AH, 0AH
122 INT 21H
31
123 LEA DX, NEWLINE
124 MOV AH, 09H
125 INT 21H
126 RET
127
128STR_TO_INT:
129 MOV SI, OFFSET MSGBUFFER + 2
130 XOR AX, AX
131 XOR CX, CX
132 MOV CX, 10
133 XOR BX, BX
134 XOR DX, DX
135NEXT:
136 MOV BL, [SI]
137 CMP BL, 0DH
138 JE DONE
139 MUL CX
140 SUB BL, '0'
141 ADD AX, BX
142 INC SI
143 JMP NEXT
144DONE:
145 RET
146
147INT_TO_STR:
148 LEA SI, OUTPUT
149 MOV BX, 10
150 XOR CX, CX
151 XOR DX, DX
152
153 CMP AX, 0
154 JNZ DIV_LOOP
155 MOV [SI], '0'
156 INC SI
157 JMP DONE_STR
158
159DIV_LOOP:
160 DIV BX
161 ADD DX, '0'
162 PUSH DX
163 INC CX
164 XOR DX, DX
165 CMP AX, 0
166 JNZ DIV_LOOP
167
168REVERSING:
169 POP DX
170 MOV [SI], DL
171 INC SI
172 LOOP REVERSING
32
173
174DONE_STR:
175 MOV [SI], '$' ; Null-terminate the string with '£'
176 RET
177END MAIN

; ===== Problem 10 End =====


; ===== Problem 11 Start =====
Problem No - 11 : Write an assembly language program for grade calcula-
tion for user input≤100 Where,
1. Marks ≥80 then A+
2. Marks ≤70 then A
3. Marks ≤60 then B
4. Marks <60 then C
Objectives
1. Takes user input for marks (0–100).
2. Converts the input from string to integer.
3. Determines the grade based on predefined grading criteria.
4. Displays the corresponding grade (A+, A, B, or C) on the screen.
Algorithm
1. Start the program and initialize the data segment.
2. Display a prompt asking the user to enter their marks.
3. Take the user input as a string using DOS interrupt INT 21H , function 0Ah.
4. Convert the input string to its integer equivalent.
5. Compare the integer marks with the grade boundaries:
(a) If marks ≥80, display ”GRADE : A+”.
(b) Else if marks ≥70, display ”GRADE : A”.
(c) Else if marks ≥60, display ”GRADE : B”.
(d) Else, display ”GRADE : C”.
6. Display the grade using DOS interrupt INT 21H , function 09H.
7. Terminate the program with INT 21H , function 4Ch.
Program Code
1.MODEL SMALL
2.STACK 100H
3.DATA
4 PROMPT DB 'ENTER YOUR MARK : ','$'
5 BUFFER DB 255
6 DB ?
7 DB 255 DUP(?)
8 MARKS DW ?
9 NEWLINE DB 0AH, 0DH, '$'
10 GRADEAP DB 'GRADE : A+', '$'
11 GRADEA DB 'GRADE : A', '$'
34
12 GRADEB DB 'GRADE : B', '$'
13 GRADEC DB 'GRADE : C', '$'
14.CODE
15PROC MAIN
16; INNIT DATA
17 MOV AX, @DATA
18 MOV DS, AX
19
20 LEA DX, PROMPT
21 MOV AH, 09H
22 INT 21H
23
24 LEA DX, BUFFER
25 MOV AH, 0AH
26 INT 21H
27
28 CALL PRINT_NEWLINE
29 CALL STR_TO_INT
30 MOV MARKS, AX
31
32
33 CMP AX, 80
34 JGE PRINT_AP
35
36 CMP AX, 70
37 JGE PRINT_A
38
39 CMP AX, 60
40 JGE PRINT_B
41
42 JMP PRINT_C
43
44PRINT_AP:
45 LEA DX, GRADEAP
46 JMP PRINT_GRADE
47
48PRINT_A:
49 LEA DX, GRADEA
50 JMP PRINT_GRADE
51
52PRINT_B:
53 LEA DX, GRADEB
54 JMP PRINT_GRADE
55
56PRINT_C:
57 LEA DX, GRADEC
58
59PRINT_GRADE:
60 MOV AH, 09H
61 INT 21H
35
62
63EXIT:
64; END
65 MOV AX, 4CH
66 INT 21H
67 MAIN ENDP
68
69PRINT_NEWLINE:
70 MOV AH, 09H
71 LEA DX, NEWLINE
72 INT 21H
73 RET
74
75STR_TO_INT:
76 MOV SI, OFFSET BUFFER + 2
77 XOR AX, AX
78 XOR CX, CX
79 MOV CX, 10
80 XOR BX, BX
81 XOR DX, DX
82NEXT:
83 MOV BL, [SI]
84 CMP BL, 0DH
85 JE DONE
86 MUL CX
87 SUB BL, '0'
88 ADD AX, BX
89 INC SI
90 JMP NEXT
91DONE:
92 RET
93
94END MAIN

; ===== Problem 11 End =====


; ===== Problem 12 Start =====
Problem No - 12 : Write an assembly language program that can compute
the sum of the first 4 natural numbers (1 ,2,3,4), where
the sum is 10.
Objectives
1. Write an assembly language program using 8086 instructions.
2. Compute the sum of the first four natural numbers: 1 + 2 + 3 + 4 = 10.
3. Display the result in the terminal.
Algorithm
1. Initialize data segment.
2. Initialize registers:
(a) Set CX = 4 (loop counter)
(b) Set BX = 1 (starting number)
(c) Set AX = 0 (accumulator for sum)
3. Loop:
(a) Add BX to AX
(b) Increment BX
(c) Decrement CX
(d) Repeat until CX = 0
4. Convert result in AX to ASCII
5. Display result using INT 21h
6. Exit program
Program Code
1.MODEL SMALL
2.STACK 100H
3.DATA
4 MSG DB 'SUM OF 1 TO 4 IS: $'
5 RESULT DB 5 DUP('$') ; SPACE TO STORE ASCII DIGITS
6.CODE
7PROC MAIN
8 MOV AX, @DATA
9 MOV DS, AX
10; DISPLAY MESSAGE
11 LEA DX, MSG
12 MOV AH, 09H
13 INT 21H
14; INITIALIZE REGISTERS
38
15 MOV CX, 4 ; LOOP 4 TIMES
16 MOV BX, 1 ; START WITH 1
17 MOV AX, 0 ; AX WILL HOLD THE SUM
18SUM_LOOP:
19 ADD AX, BX ; AX = AX + BX
20 INC BX ; BX = BX + 1
21 LOOP SUM_LOOP ; REPEAT UNTIL CX = 0
22 MOV BX, 10
23 XOR CX, CX ; CX WILL COUNT DIGITS
24CONVERT:
25 XOR DX, DX
26 DIV BX ; AX ++ 10, QUOTIENT IN AX, REMAINDER IN DX
27 ADD DL, '0' ; CONVERT REMAINDER TO ASCII
28 PUSH DX ; STORE DIGIT ON STACK
29 INC CX ; COUNT DIGITS
30 CMP AX, 0
31 JNE CONVERT
32; POP AND STORE DIGITS IN RESULT
33 LEA DI, RESULT
34STORE_DIGITS:
35 POP DX
36 MOV [DI], DL
37 INC DI
38 LOOP STORE_DIGITS
39 LEA DX, RESULT
40 MOV AH, 09H
41 INT 21H
42 MOV AH, 4CH
43 INT 21H
44MAIN ENDP
45END MAIN
46

; ===== Problem 12 End =====


; ===== Problem 13 Start =====
Problem No - 13 : Write an assembly language program to display ASCII
characters.
Objectives
1. Display a set of IBM extended ASCII characters (from 128 to 255).
2. Use 8086 Assembly Language (EMU8086 compatible).
3. Show characters on the terminal using DOS interrupt INT 21h.
Algorithm
1. Initialize data segment.
2. Set AL = 0 (start of IBM extended characters).
3. Loop from 128 to 255:
(a) Print the character in AL.
(b) Increment AL.
(c) Repeat until AL = 0 (wraps around after 255).
4. Exit program.
Program Code
1.MODEL SMALL
2.STACK 100H
3.DATA
4
5.CODE
6PROC MAIN
7 MOV AX, @DATA
8 MOV DS, AX
9
10 MOV CX, 0
11
12LOOPBACK:
13 MOV AH, 02H
14 MOV DL, CL
15 INT 21H
16 INC CX
17 CMP CX, 256
18 JNE LOOPBACK
19
20 ; EXIT
21 MOV AH, 4CH
22 INT 21H
23MAIN ENDP
24END MAIN
40

; ===== Problem 13 End =====


; ===== Problem 14 Start =====
Problem No - 14 : Write an assembly language program to print the largest
of two or three numbers.
Objectives
1. Take two or three 1-digit numbers.
2. Compare them using conditional logic.
3. Print the largest number to the output screen using DOS interrupt
Algorithm
1. Load three 1-digit numbers into registers (e.g., AL, BL, CL).
2. Compare AL with BL. If BL is greater, move BL to AL.
3. Compare AL with CL. If CL is greater, move CL to AL.
4. AL now contains the largest number.
5. Add ’0’ to convert it to ASCII.
6. Print the result using INT 21h with AH = 02h.
Program Code
1.MODEL SMALL
2.STACK 100H
3.DATA
4MSG DB 'LARGEST NUMBER: $'
5.CODE
6PROC MAIN
7 MOV AX, @DATA
8 MOV DS, AX
9
10 ; DISPLAY MESSAGE
11 LEA DX, MSG
12 MOV AH, 09H
13 INT 21H
14
15 ; LOAD 3 ONE-DIGIT NUMBERS
16 MOV AL, 5 ; FIRST NUMBER
17 MOV BL, 8 ; SECOND NUMBER
18 MOV CL, 3 ; THIRD NUMBER
19
20 ; COMPARE AL AND BL
21 CMP AL, BL
22 JGE CHECK_CL
23 MOV AL, BL ; IF BL > AL, MOVE BL TO AL
24
25CHECK_CL:
42
26 CMP AL, CL
27 JGE PRINT
28 MOV AL, CL ; IF CL > AL, MOVE CL TO AL
29
30PRINT:
31 ADD AL, '0' ; CONVERT TO ASCII
32 MOV DL, AL
33 MOV AH, 02H
34 INT 21H
35
36 ; EXIT
37 MOV AH, 4CH
38 INT 21H
39MAIN ENDP
40END MAIN

; ===== Problem 14 End =====


; ===== Problem 15 Start =====
Problem No - 15 : Write an assembly language program that displays the
character that comes first in a sequence.
Objectives
1. Takes a sequence of characters (e.g., A, B, Z, X),
2. Compares them alphabetically,
3. Displays the character that comes first.
Algorithm
1. Load two characters into AL and BL.
2. Compare AL with BL.
3. If BL ¡ AL, move BL into AL.
4. Display AL (the smallest character) using INT 21h.
Program Code
1.MODEL SMALL
2.STACK 100H
3.DATA
4MSG DB 'FIRST CHARACTER: $'
5.CODE
6MAIN:
7 MOV AX, @DATA
8 MOV DS, AX
9
10 ; SHOW MESSAGE
11 LEA DX, MSG
12 MOV AH, 09H
13 INT 21H
14
15 ; LOAD TWO CHARACTERS
16 MOV AL, 'D' ; FIRST CHARACTER
17 MOV BL, 'B' ; SECOND CHARACTER
18
19 ; COMPARE AND KEEP THE SMALLER ONE IN AL
20 CMP AL, BL
21 JBE PRINT ; IF AL <= BL, KEEP AL
22 MOV AL, BL ; ELSE, MOVE BL INTO AL
23
24PRINT:
25 MOV DL, AL
26 MOV AH, 02H
27 INT 21H
28
44
29 ; EXIT
30 MOV AH, 4CH
31 INT 21H
32END MAIN

; ===== Problem 15 End =====


; ===== Problem 16 Start =====
Problem No - 16 : Write an assembly language program to read characters
until a blank is read.
Objectives
1. Read characters one at a time from the keyboard.
2. Stop reading when a space character (’ ’) is encountered.
3. Echo each character to the screen as it is read.
Algorithm
1. Start an infinite loop.
2. Read a character using INT 21h with AH = 01h.
3. Compare the character with a space (’ ’).
(a) If it is a space, exit the loop.
(b) Otherwise, display the character and continue.
4. Exit the program cleanly.
Program Code
1.MODEL SMALL
2.STACK 100H
3.DATA
4MSG DB 'Enter characters: $'
5.CODE
6PROC MAIN
7 MOV AX, @DATA
8 MOV DS, AX
9; DISPLAY INSTRUCTION MESSAGE
10 LEA DX, MSG
11 MOV AH, 09H
12 INT 21H
13READ_LOOP:
14 MOV AH, 01H ; FUNCTION TO READ A CHARACTER
15 INT 21H ; READ CHARACTER FROM KEYBOARD
16 CMP AL, ' ' ; COMPARE WITH SPACE
17 JE DONE ; IF SPACE, JUMP TO DONE
18; CHARACTER ALREADY IN AL IS ECHOED BY INT 21H AH=01H
19 JMP READ_LOOP ; LOOP AGAIN
20DONE:
21; EXIT PROGRAM
22 MOV AH, 4CH
23 INT 21H
24MAIN ENDP
25END MAIN
46

; ===== Problem 16 End =====


; ===== Problem 17 Start =====
Problem No - 17 : Write an assembly language program with a count-controlled
loop to display a row of 80 stars.
Objectives
1. Write an assembly language program using a count-controlled loop.
2. Display exactly 80 asterisk (*) characters in a single row.
Algorithm
1. Initialize a counter with 80.
2. Set the character to be printed: ’*’.
3. Start a loop:
(a) Print the character using INT 21h (AH = 02h).
(b) Decrement the counter.
(c) Repeat until the counter becomes 0.
4. Exit the program.
Program Code
1.MODEL SMALL
2.STACK 100H
3.DATA
4.CODE
5MAIN:
6 MOV AX, @DATA
7 MOV DS, AX
8
9 MOV CX, 80 ; SET LOOP COUNTER TO 80
10
11PRINT_STAR:
12 MOV DL, '*' ; LOAD '*' INTO DL
13 MOV AH, 02H ; FUNCTION TO PRINT CHARACTER
14 INT 21H ; CALL DOS INTERRUPT TO DISPLAY DL
15 LOOP PRINT_STAR ; DECREMENT CX AND REPEAT IF NOT ZERO
16
17 ; EXIT
18 MOV AH, 4CH
19 INT 21H
20END MAIN
48

; ===== Problem 17 End =====


; ===== Problem 18 Start =====
Problem No - 18 : Write an assembly language program that will display a
single ? (question mark) character on the screen.
Objectives
1. Write an EMU8086 program to display a single ‘¿ character using DOS
Algorithm
1. Load ‘¿ into DL register.
2. Set AH = 02h (function to display a character).
3. Call INT 21h to print the character.
4. Exit the program.
Program Code
1.MODEL SMALL
2.STACK 200H
3.DATA
4A DB '?' ; initialize character ? in A
5.CODE
6MAIN PROC
7 MOV AX, @DATA ; Initialize the data variables @ data
8 MOV DS, AX
9 MOV DL, A ; Print the character stored in A on the dos
10 MOV AH, 02H
11 INT 21H
12 MOV AX, 4CH ; Eziting the program
13 INT 21h
14MAIN ENDP
15END MAIN

; ===== Problem 18 End =====


; ===== Problem 19 Start =====
Problem No - 19 : Write an assembly language program to read two capital
letters and display them in alphabetical order.
Objectives
1. Read two uppercase (capital) letters from the user.
2. Compare them based on ASCII values.
3. Display the two characters in alphabetical order.
Algorithm
1. Prompt the user to enter two capital letters.
2. Read the first character and store it in AL.
3. Read the second character and store it in BL.
4. Compare AL and BL.
(a) If AL ¡= BL, display AL then BL.
(b) Else, display BL then AL.
5. Exit the program.
Program Code
1.MODEL SMALL
2.STACK 100H
3.DATA
4MSG DB 'ENTER TWO CAPITAL LETTERS: $'
5NEWLINE DB 13, 10, '$'
6.CODE
7PROC MAIN
8 MOV AX, @DATA
9 MOV DS, AX
10; DISPLAY PROMPT
11 LEA DX, MSG
12 MOV AH, 09H
13 INT 21H
14; READ FIRST CHARACTER
15 MOV AH, 01H
16 INT 21H
17 MOV AL, AL ; AL HAS FIRST CHARACTER
18; STORE IN CL TEMPORARILY
19 MOV CL, AL
20
21 MOV AH, 01H
22 INT 21H
23 MOV BL, AL ; BL HAS SECOND CHARACTER
51
24 MOV AL, CL ; RESTORE FIRST CHARACTER BACK TO AL
25
26; COMPARE AND ORDER
27 CMP AL, BL
28 JBE DISPLAY ; IF AL <= BL, NO SWAP NEEDED
29 XCHG AL, BL ; ELSE, SWAP TO SORT
30
31DISPLAY:
32 CALL PRINT_NEWLINE
33; PRINT FIRST CHARACTER
34 MOV DL, AL
35 MOV AH, 02H
36 INT 21H
37
38; PRINT SECOND CHARACTER
39 MOV DL, BL
40 MOV AH, 02H
41 INT 21H
42
43; EXIT
44 MOV AH, 4CH
45 INT 21H
46MAIN ENDP
47
48PRINT_NEWLINE:
49 PUSH AX
50 PUSH BX
51 PUSH CX
52 PUSH DX
53 LEA DX, NEWLINE
54 MOV AH, 09H
55 INT 21H
56 POP DX
57 POP CX
58 POP BX
59 POP AX
60 RET
61END MAIN

; ===== Problem 19 End =====


; ===== Problem 20 Start =====
Problem No - 20 : Write an assembly language program to read a character;
if it’s ”Y” or ”y”, display it, otherwise terminate the
program.
Objectives
1. Read a character from the keyboard.
2. If the character is ’Y’ or ’y’, display it.
3. Otherwise, exit the program.
Algorithm
1. Read a character using INT 21h (AH=01h).
2. Compare the character with ’Y’.
3. If equal, display the character.
4. Else compare with ’y’.
5. If equal, display the character.
6. Otherwise, exit.
Program Code
1.MODEL SMALL
2.STACK 100H
3.DATA
4.CODE
5PROC MAIN
6 MOV AX, @DATA
7 MOV DS, AX
8
9 ; READ A CHARACTER
10 MOV AH, 07H
11 INT 21H ; AL = INPUT CHAR
12
13 CMP AL, 'Y'
14 JE DISPLAY_CHAR
15 CMP AL, 'Y'
16 JE DISPLAY_CHAR
17
18 ; IF NOT Y OR Y, EXIT
19 MOV AH, 4CH
20 INT 21H
21
22DISPLAY_CHAR:
23 MOV DL, AL ; MOVE CHAR TO DL FOR DISPLAY
24 MOV AH, 02H
54
25 INT 21H
26
27 ; EXIT PROGRAM
28 MOV AH, 4CH
29 INT 21H
30MAIN ENDP
31END MAIN

; ===== Problem 20 End =====
