TITLE GCD_and_LCM     (template.asm)

; Author: Hongyiel Suh
; Last Modified: Aug/16/2019
; OSU email address: suhho@oregonstate.edu
; Course number/section: CS271
; Project Number:    Final             Due Date: (Extended) Aug/18/2019 8am
; Description:	Using array, pointer and Stack All of the class's material contain this Final Project. 
;				The LCM, GCD are cover almost every thing in the class material.
;				There are a lot of coner case, need to consider register byte size, length.
;				Most of register need to consider what memories are using during calculation.
;Documentation in your asm code file.
;Overall readability. (5 pts)	-done
;Add comments every line	-done
;Uses readable indentation, white-space, etc.	-done
;You need to describe and explain your design.
;How do you design your calculator? (5 pts)
;	I designed my calculator, divied each inputs (maximum 4) And GCD calculater; 
;How do you choose algorithms for GCD and LCM? (5 pts)
;	I used sub function that compare two input in GCD functions EX) GCD( EAX, EBX)...
;	Also, LCM contain 3 input LCM( G1( first GCD ) , EAX, EBX)
;How do you modularize them? (5 pts)
;	I modularize them GCD first and the GCD result input LCM function to get LCM
;How do you optimize your code? (5 pts)
;	I tried to optimaize code with PROC END, so which mean is I usually used call function
;What are the corner cases that you estimate? (5 pts)
;	when value's are 0
;	when QWORD value input
;	when negative number get			-> NOT YET!!!!!!!!
;	overflow 
;	one input
;How do you handle corner cases? (5 pts)
;	QWORD case get result all 0 in functions
;	negative number get neg function
;You need to describe and explain each procedure. (5 pts)
INCLUDE Irvine32.inc

; (insert constant definitions here)
Getbenchmark	MACRO	benchmark, num
	push	OFFSET		benchmark	; Values of Benchmark
	push	TYPE		benchmark	; Benchmark type
	push	LENGTHOF	benchmark	; Lengthof Bench mark
	push				num			; What Benchmark number
	call				check_input	; call check_input

ENDM
; Do not change the name of Benchmarks. Data Types and Values may change when your code is tested.
.data
Benchmark1		BYTE	56, 24
Benchmark2		BYTE	8, 8
Benchmark3		WORD	6, 32766
Benchmark4		WORD	7536, 28260
Benchmark5		QWORD	-988422, 286331153
Benchmark6		DWORD	-65537, 6700417
Benchmark7		BYTE	56, -77, 42
Benchmark8		BYTE	3
Benchmark9		WORD	6, 28038, 27444
Benchmark10		WORD	11538, 32691, 3205
Benchmark11		DWORD	13400834, -34614, -201274
Benchmark12		DWORD	4673, 65537, 274177
Benchmark13		BYTE	124, 104, 56, 118
Benchmark14		BYTE	16, 4, 8, 2
Benchmark15		TBYTE	112152, 6, 33332, 12
Benchmark16		WORD	8224, 18504, 16448, 30840
Benchmark17		DWORD	83898162, 1039405007, 1542793979, -20416337
Benchmark18		DWORD	4001, 5573, 4649, 6047
Benchmark19		DWORD	104831, 104827, 0, 0
Benchmark20		DWORD	16, 32, 64, 128
Result_Benchmark_GCD	DWORD	20 DUP(?)
Result_Benchmark_LCM	DWORD	20 DUP(?)
;Result_Benchmark_LCM	QWORD	20 DUP(?)	; Extra credit option

; (insert variable definitions here)

get_value_array		DWORD	80	DUP(?),0
get_array			DWORD	20	DUP(?),0
get_length_array	DWORD	20	DUP(?),0
get_type_array		DWORD	20	DUP(?),0
get_num_array		DWORD	20	DUP(?),0
measure_time		DWORD	0
count_add			DWORD	0
count_number		DWORD	0
count_GCD			DWORD	0
count_length		DWORD	0
get_ecx				DWORD	0
flag_point			DWORD	0	; flag_point in the LCM_cal
String_execute		BYTE	"The excution time is: ",0
String_benchmark	BYTE	"The Benchmark ",0
String_colon		BYTE	": ",0
String_space		BYTE	" ",0
String_comma		BYTE	",",0
check_loop			DWORD	0
String_GCD			BYTE	"GCD is  ",0
; result of GCD
String_LCM			BYTE	"LCM is  ",0
; result of LCM


.code
main PROC
	rdtsc			; meausre your time
	mov	ebx,	eax	; measure my time
	mov		edi,	OFFSET	get_value_array	; get_value_array

	Getbenchmark	Benchmark1, 0
	Getbenchmark	Benchmark2, 1
	Getbenchmark	Benchmark3, 2
	Getbenchmark	Benchmark4, 3
	Getbenchmark	Benchmark5, 4
	Getbenchmark	Benchmark6,	5
	Getbenchmark	Benchmark7, 6	; neg
	Getbenchmark	Benchmark8,	7	; overflow
	Getbenchmark	Benchmark9,	8
	Getbenchmark	Benchmark10, 9
	Getbenchmark	Benchmark11, 10	
	Getbenchmark	Benchmark12, 11
	Getbenchmark	Benchmark13, 12
	Getbenchmark	Benchmark14, 13
	Getbenchmark	Benchmark15, 14	
	Getbenchmark	Benchmark16, 15
	Getbenchmark	Benchmark17, 16
	Getbenchmark	Benchmark18, 17
	Getbenchmark	Benchmark19, 18
	Getbenchmark	Benchmark20, 19

; Calculate GCD and LCM for 20 Benchmarks.
; (insert executable instructions here)
	rdtsc			; meausre your time
	sub		eax,	ebx				; starttime-lasttime
	mov		measure_time,	eax		; move to time
;*****************************************************************************
; Do not change this section
;*****************************************************************************	
	call print_result	; print your final result

	exit	; exit to operating system
main ENDP
;*****************************************************************************


;*****************************************************************************
;Procedure print_result
;explain your print_result procedure here
;*****************************************************************************
print_result	PROC
	; your code here
	
	mov		ecx,			0								; for print 20 tinmes
	mov		edi,	OFFSET	get_value_array
	mov		ebx,			0							;initialization
	mov		count_number,	0							;intialization
	mov		eax,			0							; for count_number

	give_result_print:
	mov		edx,	OFFSET	String_benchmark			; "Benchmark"
	call	WriteString
	inc		count_number								; ++i
	mov		eax,	count_number						; eax = ++i
	
	call	WriteDec
	mov		edx,	OFFSET	String_colon				; get : colon
	call	WriteString
	mov		ebx,	count_length
	inc		count_length
	mov		ecx,	get_length_array[ebx*4]				; for loop
	mov		edx,	OFFSET	String_comma				; get , comma

	Show_number:
	call	Loop_show_num								; until ecx

	cmp		ecx,	1
	jle		skip_print_Dec
	call	WriteString						; get space " "

	Loop	Show_number
	skip_print_Dec:
	call	Crlf
	call	get_print_result							; print reult about GCD and LCM
	; need to compare ecx
	;inc		edi	;for increase address that for print values
	mov		ebx,	check_loop
	mov		ecx,	count_add
	dec		count_add
	call	Crlf
	Loop	give_result_print
	
	mov		eax,		measure_time	; measure time
	mov		edx,	OFFSET	String_execute
	call	WriteString
	call	WriteDec

	ret				; return to main
print_result	ENDP
;*****************************************************************************
Loop_show_num	PROC

	mov		eax,		[edi]				; get value to eax

	add		edi,		4					; add 1 for next array
	call	WriteDec						; Get value from benchmark?[?] ... 
	inc		check_loop

	ret
Loop_show_num	ENDP
get_print_result	PROC
	mov		ebx,	count_GCD				;for increase value each call functions
	inc		count_GCD
	mov		edx,	OFFSET	String_GCD
	call	WriteString						; print String GCD
	mov		eax,	Result_Benchmark_GCD[ebx*4]
	call	WriteDec						; print GCD
	mov		edx,	OFFSET	String_space
	call	WriteString
	mov		edx,	OFFSET	String_LCM
	call	WriteString						; Print LCM is...
	mov		eax,	Result_Benchmark_LCM[ebx*4]
	call	WriteDec	;LCM result

	ret
get_print_result	ENDP
; (insert additional procedures here)

check_input		PROC
	
	push	ebp			; push+1 
	mov		ebp,	esp
		; ebp = esp
		;--------------------
	mov		esi,	[ebp+20]	; offset
	mov		ebx,	[ebp+16]	; Type
	mov		ecx,	[ebp+12]	; lengthof
	mov		edx,	[ebp+08]	; 0..1...2...3..4...5.. it will increase below the functions (num)
	
	mov		eax,	edx			; num benchmark					
	mov		get_num_array[eax*4],	edx	; get_num_benchmark 1...2...3...4...

	call	get_data
	;add	edi,		4		; For add next benchmark array 
	pop ebp
	ret		16
check_input		ENDP

get_data		PROC

	mov		ecx,						[ebp+12]; lengthof
	mov		get_length_array[eax*4],		ecx	; get lengthof benchmark
	mov		get_type_array[eax*4],			ebx	; also same increase type each array's values....
	mov		edx,							ebx ; type input in edx
	; get length and type is correst	

	;** compare with Type of memory
	;ecx = lengthof benchmark
	cmp		ecx,	0	;nothing type
	je		Error_type
	cmp		ecx,	1	;one input
	je		Error_type
	cmp		ecx,	5	;five input
	jge		Error_type

	cmp		edx,	1
	je		byte_type

	cmp		edx,	2
	je		word_type
	
	cmp		edx,	4
	je		Dword_type
	
	cmp		edx,	8
	jge		Error_type
	jmp		skip
;	je		Qword_type
;*******************************
	
byte_type:
	call	get_byte		;first value in benchmark
	mov		[edi],		eax		; get_value in the first value
	add		edi,		4
	mov		[edi],		ebx		; get_second value in the [edi]
	mov		ecx,		[ebp+12]; lengthof
	sub		ecx,		1		; already get 2 value from benchmark
	mov		get_ecx,	ecx		; get_ecx
	add		esi,		[ebp+16]; because already input 2
	;word_loop:
	; first GCD will come
	; if ecx = 3 : input 4
	; if ecx = 2 : input 3
	; if ecx = 1 : input 2

	; Also need to conside connercase that has 5 input
	mov		get_ecx,	ecx		; ecx -> get_ecx
	cmp		ecx,	2			; input 3
	jge		go_input3_byte

	; need to make conner case that has one input
	cmp		ecx,	1			; input 1
	je		go_input2_byte

	go_input2_byte:
	call	get_calculate_byte_GCD	; array1 and array2 compare => G1
	mov		eax,	[edi-4]	; first value
	call	get_calculate_byte_LCM_input2; L1

	jmp		skip
	go_input3_byte:

	call	get_calculate_byte_GCD	; array1 and array2 compare => G1
	mov		eax,	[edi-4]	; first value
	call	get_calculate_byte_LCM_input2	; L1 evem input is 3 need to
	call	after_cal_byte
	;ebx -> third value
	mov		[edi],		ebx	; will get index array	; [edi] get third value
	;call	get_word		;3 AND 4 benchmark array
	;eax -> third value 
	;ebx -> fourth value
	mov		edx,		0				; get edx 0
	mov		eax,	get_array[0]		; G1
	call	get_calculate_byte_GCD		; compare with GCD(C,G1)
	call	get_calculate_byte_LCM_input3	; compare with LCM(G2,L1,C)
	dec		get_ecx
	mov		ecx,		get_ecx	; get origin ecx value for compare each others
	dec		ecx					; if get 3 input ecx will get 1
	mov		get_ecx,	ecx		; store
	cmp		ecx,		1		; input 4 = 2 ecx so dec 1 is 1 -> input 4
	je		go_input4_byte			; 
	jmp		skip				
	go_input4_byte:	
	call	after_cal_byte
	mov		edx,		[ebp+16]	; type of benchmark
	mov		ebx,		[esi+edx]
	mov		edx,		0
	mov		dl,			bl
	mov		ebx,		edx			; store ebx value from edx (initialization)
	mov		[edi],		ebx			; will get index array	; [edi] get third value
	mov		eax,	get_array[0]			; G2
	call	get_calculate_byte_GCD			;(D,G2)
	call	get_calculate_byte_LCM_input3	; compare with LCM (G3, L2, D)
	mov		ecx,		get_ecx				; get origin ecx
	dec		ecx
	cmp		ecx,		0
	jg		Error_type

	;--- check --- ;
	jmp		skip

word_type:

	call	get_word		;first value in benchmark
	mov		[edi],		eax		; get_value in the first value
	add		edi,		4
	mov		[edi],		ebx		; get_second value in the [edi]
	mov		ecx,		[ebp+12]; lengthof
	sub		ecx,		1		; already get 2 value from benchmark
	mov		get_ecx,	ecx		; get_ecx
	add		esi,		[ebp+16]; because already input 2
	;word_loop:
	; first GCD will come
	; if ecx = 3 : input 4
	; if ecx = 2 : input 3
	; if ecx = 1 : input 2

	; Also need to conside connercase that has 5 input
	mov		get_ecx,	ecx		; ecx -> get_ecx
	cmp		ecx,	2			; input 3
	jge		go_input3_word

	; need to make conner case that has one input
	cmp		ecx,	1			; input 1
	je		go_input2_word

	go_input2_word:
	call	get_calculate_word_GCD	; array1 and array2 compare => G1
	call	get_calculate_word_LCM_input2; L1
	jmp		skip
	go_input3_word:
	call	get_calculate_word_GCD	; array1 and array2 compare => G1
	mov		eax,	[edi-4]	; first value
	call	get_calculate_word_LCM_input2	; L1 evem input is 3 need to
	call	after_cal_word
	;ebx -> third value
	mov		[edi],		ebx	; will get index array	; [edi] get third value
	;call	get_word		;3 AND 4 benchmark array
	;eax -> third value 
	;ebx -> fourth value
	mov		edx,		0				; get edx 0
	mov		eax,	get_array[0]		; G1
	call	get_calculate_word_GCD		; compare with GCD(C,G1)
	call	get_calculate_word_LCM_input3	; compare with LCM(G2,L1,C)

	dec		get_ecx

	mov		ecx,		get_ecx	; get origin ecx value for compare each others
	dec		ecx					; if get 3 input ecx will get 1
	mov		get_ecx,	ecx		; store
	cmp		ecx,		1		; input 4 = 2 ecx so dec 1 is 1 -> input 4
	je		go_input4_word			; 
	jmp		skip				
	go_input4_word:	
	call	after_cal_word
	mov		edx,		[ebp+16]	; type of benchmark
	mov		ebx,		[esi+edx]
	mov		edx,		0
	mov		dx,			bx
	mov		ebx,		edx			; store ebx value from edx (initialization)
	mov		[edi],		ebx			; will get index array	; [edi] get third value
	mov		eax,	get_array[0]			; G2
	call	get_calculate_word_GCD			;(D,G2)
	call	get_calculate_word_LCM_input3	; compare with LCM (G3, L2, D)
	mov		ecx,		get_ecx				; get origin ecx
	dec		ecx
	cmp		ecx,		0
	jg		Error_type
	;--- check --- ;
	jmp		skip

Dword_type:
	call	get_Dword		;first value in benchmark
	mov		[edi],		eax		; get_value in the first value
	add		edi,		4
	mov		[edi],		ebx		; get_second value in the [edi]
	mov		ecx,		[ebp+12]; lengthof
	sub		ecx,		1		; already get 2 value from benchmark
	mov		get_ecx,	ecx		; get_ecx
	add		esi,		[ebp+16]; because already input 2
	;word_loop:
	; first GCD will come
	; if ecx = 3 : input 4
	; if ecx = 2 : input 3
	; if ecx = 1 : input 2

	; Also need to conside connercase that has 5 input
	mov		get_ecx,	ecx		; ecx -> get_ecx
	cmp		ecx,	2			; input 3
	jge		go_input3_Dword

	; need to make conner case that has one input
	cmp		ecx,	1			; input 1
	je		go_input2_Dword

	go_input2_Dword:
	call	get_calculate_Dword_GCD	; array1 and array2 compare => G1
	call	get_calculate_Dword_LCM_input2; L1
	jmp		skip
	go_input3_Dword:
	call	get_calculate_Dword_GCD	; array1 and array2 compare => G1
	mov		eax,	[edi-4]	; first value
	call	get_calculate_Dword_LCM_input2	; L1 evem input is 3 need to
	call	after_cal_Dword
	;ebx -> third value
	mov		[edi],		ebx	; will get index array	; [edi] get third value
	;call	get_word		;3 AND 4 benchmark array
	;eax -> third value 
	;ebx -> fourth value
	mov		edx,		0				; get edx 0
	mov		eax,	get_array[0]		; G1
	call	get_calculate_Dword_GCD		; compare with GCD(C,G1)
	call	get_calculate_Dword_LCM_input3	; compare with LCM(G2,L1,C)
	
	dec		get_ecx

	mov		ecx,		get_ecx	; get origin ecx value for compare each others
	dec		ecx				; if get 3 input ecx will get 1
	mov		get_ecx,	ecx		; store
	cmp		ecx,		1		; input 4 = 2 ecx so dec 1 is 1 -> input 4
	je		go_input4_Dword			; 
	jmp		skip				
	go_input4_Dword:	
	call	after_cal_Dword
	mov		edx,		[ebp+16]	; type of benchmark
	mov		ebx,		[esi+edx]
	call	setting_neg_Dword
	mov		edx,		0
	mov		edx,		ebx
	mov		ebx,		edx			; store ebx value from edx (initialization)
	mov		[edi],		ebx			; will get index array	; [edi] get third value
	mov		eax,	get_array[0]			; G2
	call	get_calculate_Dword_GCD			;(D,G2)
	call	get_calculate_Dword_LCM_input3	; compare with LCM (G3, L2, D)
	mov		ecx,		get_ecx				; get origin ecx
	dec		ecx
	cmp		ecx,		0
	jg		Error_type
	;--- check --- ;
	jmp		skip

Error_type:
	
	mov	ecx,	[ebp+12]						; set ecx lengthof benchmark to loop until 0

	Error_type_loop:
	
	mov		eax,		0							; all values input 0
	mov		[edi],		eax						; get 0 value ecn(n) times	
	add		edi,		4									; get next value in the Benchmark[?] address

	loop Error_type_loop
	mov		edx,		0
	mov		get_array[edx],				eax			; mov 0 value in GCD
	mov		get_array[edx+4],			eax			; mov 0 value in LCM

	; ecx times = lengthof benchmark
	jmp		skip								;for skip below data input

	skip:

	mov		edx,		0						; give value ro edx <- 0..1..2..3.....20
	mov		eax,		get_array[edx]			; get_array will replaced several times
	mov		edx,		4						; for get next array : input LCM values
	mov		ebx,		get_array[edx]			; get_array[4] contains LCM value

	mov		edx,		count_add				; edx will initialization in count_add

	mov		Result_Benchmark_GCD[edx*4],	eax	; Result_GCD will replace each 4 byte
	mov		Result_Benchmark_LCM[edx*4],	ebx	; Result_LCM will replace each 4 byte

	add		count_add,			1				; +1 count_add fot get value into Result_Benchmark_...
	;until 20 [19]
	ret
get_data		ENDP

get_byte		PROC
	mov		eax,	[esi]
	mov		edx,	[ebp+16]	;type of benchmark
	add		esi,	edx		; add type = next array
	

	mov		ebx,	eax		; get initialization
	call	setting_neg_byte
	mov		eax,	ebx		; get originvalue

	mov		edx,	0		; edx =0
	mov		dl,		al		; al = -- 
	mov		eax,	0		; eax initialization
	mov		eax,	edx		; move eax to ecx	(dl value)

	mov		ebx,	[esi]	; ebx is now next value 

	mov		edx,	0		; edx =0
	mov		dl,		bl		; bl = -- 
	mov		ebx,	0		; ebx initialization
	mov		ebx,	edx		; move ebx to ecx	(dl value)

	call	setting_neg_byte

	; so this function can handle two input value array[?] and array[?+type]

	ret

get_byte		ENDP
setting_neg_byte	PROC
	cmp		bl,		0
	jge		skip_neg_byte
	neg		bl				; compare negative number
	mov		[esi],	bl

;	cmp		bx,		0
;	jge		skip_neg_byte
;	neg		bx				; compare negative number
;	mov		[esi],	bx
	
;	cmp		ebx,	0
;	jge		skip_neg_Dword
;	neg		ebx				; compare negative number
;	mov		[esi],	ebx

	skip_neg_byte:
	ret
setting_neg_byte	ENDP

get_word		PROC
	mov		eax,	[esi]
	mov		edx,	[ebp+16]	;type of benchmark
	add		esi,	edx		; add type = next array
	
	mov		ebx,	eax		; get initialization
	call	setting_neg_word
	mov		eax,	ebx		; get originvalue

	mov		edx,	0		; edx =0
	mov		dx,		ax		; al = -- 
	mov		eax,	0		; eax initialization
	mov		eax,	edx		; move eax to ecx	(dl value)

	mov		ebx,	[esi]	; ebx is now next value 

	mov		edx,	0		; edx =0
	mov		dx,		bx		; bl = -- 
	mov		ebx,	0		; ebx initialization
	mov		ebx,	edx		; move ebx to ecx	(dl value)
	
	call	setting_neg_word

	ret
get_word		ENDP
setting_neg_word	PROC
;	cmp		bl,		0
;	jge		skip_neg_ebx_Dword
;	neg		bl				; compare negative number
;	mov		[esi],	bl

	cmp		bx,		0
	jge		skip_neg_word
	neg		bx				; compare negative number
	mov		[esi],	bx
	
;	cmp		ebx,	0
;	jge		skip_neg_Dword
;	neg		ebx				; compare negative number
;	mov		[esi],	ebx

	skip_neg_word:
	ret
setting_neg_word	ENDP

get_Dword		PROC
	mov		eax,	[esi]
	mov		edx,	[ebp+16]	;type of benchmark
	add		esi,	edx		; add type = next array

	mov		ebx,	eax		; get initialization
	call	setting_neg_Dword
	mov		eax,	ebx		; get originvalue

	mov		edx,	0		; edx =0
	mov		edx,		eax		; al = -- 
	mov		eax,	0		; eax initialization
	mov		eax,	edx		; move eax to ecx	(dl value)

	mov		ebx,	[esi]	; ebx is now next value 
	
	mov		edx,	0		; edx =0
	mov		edx,		ebx		; bl = -- 
	mov		ebx,	0		; ebx initialization
	mov		ebx,	edx		; move ebx to ecx	(dl value)
	call	setting_neg_Dword

	skip_neg_ebx_Dword:

	ret
get_Dword		ENDP
setting_neg_Dword	PROC
;	cmp		bl,		0
;	jge		skip_neg_ebx_Dword
;	neg		bl				; compare negative number
;	mov		[esi],	bl

;	cmp		bx,		0
;	jge		skip_neg_ebx_Dword
;	neg		bx				; compare negative number
;	mov		[esi],	bx
	
	cmp		ebx,	0
	jge		skip_neg_Dword
	neg		ebx				; compare negative number
	mov		[esi],	ebx

	skip_neg_Dword:
	ret
setting_neg_Dword	ENDP

get_calculate_byte_GCD	PROC
	
	GCD_cal:
	mov		ecx,	2		; for infinity loop
	cmp		al,		bl		; GCD(al,bl)
	jl		change_value	; al<bl
	jge		keep_cal		; al>bl
	change_value:
	mov		edx,	eax		; temp = benchmark1[0]
	mov		eax,	ebx		; benchmark[0] = benchmark[1]
	mov		ebx,	edx		; benchmark[1] = benchmark[0]
	keep_cal:
	sub		al,		bl		; benchmark
	cmp		bl,		0		; GCD(al,0[bl])
	je		get_value

	Loop GCD_cal
	get_value:

	mov		bl,		al		; For initialization eax register
	mov		eax,	0
	mov		al,		bl		; It has GCD
	mov		edx,	0		; using just one array for GCD value 
	mov	get_array[edx*4],		eax		; get_GCD
	; make LCM loop
	; should keep eax because it is GCD
	ret

get_calculate_byte_GCD	ENDP
get_calculate_byte_LCM_input2	PROC
	LCM_cal:
	push	esi		; because keep esi address
	mov		ebx,	[edi]	; setting ecx B1 1 is byte type			 ; setting LCM(G1, A, B)

	;*** for get right number
	mov		edx,	0
	mov		dl,		cl		; input dl
	mov		ecx,	edx		; edx input ecx =	 ecx ->B
	mov		edx,	eax		; edx to eax (A1)	edx	
	mov		ecx,	get_array[0]	; get_GCE
	CDQ		
	Idiv	ecx				; A/G1
	; edx will be changed because of div
	; so before change it, it should transfer to another value to another register
	; And div first !!! because of overflow
	mov		edx,	0
	mov		dl,		bl
	mov		ebx,	edx
	Imul	ebx				; (A/G1)*B

	; so after this calculater eax contains LCM result
	; but it need to chunk to al value

;	mov		bx,		ax		; For initialization eax register
;	mov		eax,	0
;	mov		ax,		bx		; It has LCM
	mov		edx,	1		; using just one array for LCM value 
	mov	get_array[edx*4],		eax		; get_LCM
	; need to make get value input to LCM_result_arry
	add		edi,	4		 ; to get next array 
	mov		ecx,	[ebp+12] ; lengthof benchmark

	pop	esi	; get original value address
	ret

get_calculate_byte_LCM_input2	ENDP
get_calculate_byte_LCM_input3	PROC
	LCM_cal:
	push	esi		; because keep esi address
	mov		ebx,	eax		; setting ebx A1
	mov		ecx,	[edi]	; setting ecx B1 1 is byte type			 ; setting LCM(G1, A, B)

	;*** for get right number
	mov		edx,	0
	mov		dl,		cl		; input dl
	mov		ecx,	edx		; edx input ecx
	mov		edx,	get_array[4]	; get_LCM
	mov		eax,	edx		; L1
	; EBX is G2
	; ECX is C1
	CDQ		
	Idiv	ebx				; L1/G2
	; edx will be changed because of div
	; so before change it, it should transfer to another value to another register
	; And div first !!! because of overflow
	mov		edx,	0
	mov		dl,		al
	mov		eax,	edx
	Imul	ecx				; (L1/G2)*C

	; so after this calculater eax contains LCM result
	; but it need to chunk to al value
	mov	get_array[4],		eax		; get_LCM
	; need to make get value input to LCM_result_arry
	add		edi,	4		 ; to get next array 
	mov		ecx,	[ebp+12] ; lengthof benchmark

	pop	esi	; get original value address
	ret

get_calculate_byte_LCM_input3	ENDP



get_calculate_word_GCD	PROC

	GCD_cal:
	mov		ecx,	2		; for infinity loop
	cmp		ax,		bx		; GCD(al,bl)
	jl		change_value	; al<bl
	jge		keep_cal		; al>bl
	change_value:
	mov		edx,	eax		; temp = benchmark1[0]
	mov		eax,	ebx		; benchmark[0] = benchmark[1]
	mov		ebx,	edx		; benchmark[1] = benchmark[0]
	keep_cal:
	sub		ax,		bx		; benchmark
	cmp		bx,		0		; GCD(al,0[bl])
	je		get_value

	Loop GCD_cal
	get_value:

	mov		bx,		ax		; For initialization eax register
	mov		eax,	0
	mov		ax,		bx		; It has GCD
	mov		edx,	0		; using just one array for GCD value 
	mov	get_array[edx*4],		eax		; get_GCD
	; make LCM loop
	; should keep eax because it is GCD
	ret
get_calculate_word_GCD	ENDP

get_calculate_word_LCM_input2	PROC

	LCM_cal:
	push	esi		; because keep esi address
	mov		ebx,	eax		; setting ebx A1
	mov		ecx,	[edi]	; setting ecx B1 1 is byte type			 ; setting LCM(G1, A, B)
	;*** for get right number
	mov		edx,	0
	mov		dx,		cx		; input dl
	mov		ecx,	edx		; edx input ecx
	;mov		edx,	get_array[0]	; get_GCE
	mov		edx,	eax		; edx to eax (A1)	edx	
	mov		eax,	ecx		; eax to ecx (B1)	eax
	mov		ecx,	get_array[0]	; get_GCE
	CDQ		
	Idiv	ecx				; A/G1
	; edx will be changed because of div
	; so before change it, it should transfer to another value to another register
	; And div first !!! because of overflow
	mov		edx,	0
	mov		dx,		bx
	mov		ebx,	edx
	Imul	ebx				; (A/G1)*B

	; so after this calculater eax contains LCM result
	; but it need to chunk to al value

;	mov		bx,		ax		; For initialization eax register
;	mov		eax,	0
;	mov		ax,		bx		; It has LCM
	mov		edx,	1		; using just one array for LCM value 
	mov	get_array[edx*4],		eax		; get_LCM
	; need to make get value input to LCM_result_arry
	add		edi,	4		 ; to get next array 
	mov		ecx,	[ebp+12] ; lengthof benchmark

	pop	esi	; get original value address
	ret

get_calculate_word_LCM_input2	ENDP
get_calculate_word_LCM_input3	PROC

	LCM_cal:
	push	esi		; because keep esi address
	mov		ebx,	eax		; setting ebx A1
	mov		ecx,	[edi]	; setting ecx B1 1 is byte type			 ; setting LCM(G1, A, B)

	;*** for get right number
	mov		edx,	0
	mov		dx,		cx		; input dl
	mov		ecx,	edx		; edx input ecx
	mov		edx,	get_array[4]	; get_LCM
	mov		eax,	edx		; L1
	; EBX is G2
	; ECX is C1
	CDQ		
	Idiv	ebx				; L1/G2
	; edx will be changed because of div
	; so before change it, it should transfer to another value to another register
	; And div first !!! because of overflow
	mov		edx,	0
	mov		dx,		ax
	mov		eax,	edx
	Imul	ecx				; (L1/G2)*C

	; so after this calculater eax contains LCM result
	; but it need to chunk to al value
	mov	get_array[4],		eax		; get_LCM
	; need to make get value input to LCM_result_arry
	add		edi,	4		 ; to get next array 
	mov		ecx,	[ebp+12] ; lengthof benchmark

	pop	esi	; get original value address
	ret

get_calculate_word_LCM_input3	ENDP

get_calculate_Dword_GCD	PROC

	GCD_cal:
	mov		ecx,	2		; for infinity loop
	cmp		eax,		ebx		; GCD(al,bl)
	jl		change_value	; al<bl
	jge		keep_cal		; al>bl
	change_value:
	mov		edx,	eax		; temp = benchmark1[0]
	mov		eax,	ebx		; benchmark[0] = benchmark[1]
	mov		ebx,	edx		; benchmark[1] = benchmark[0]
	keep_cal:
	sub		eax,		ebx		; benchmark
	cmp		ebx,		0		; GCD(al,0[bl])
	je		get_value

	Loop GCD_cal
	get_value:

	mov		ebx,		eax		; For initialization eax register
	mov		eax,	0
	mov		eax,		ebx		; It has GCD
	mov		edx,	0		; using just one array for GCD value 
	mov	get_array[edx*4],		eax		; get_GCD
	; make LCM loop
	; should keep eax because it is GCD
	ret

get_calculate_Dword_GCD	ENDP
get_calculate_Dword_LCM_input2	PROC
	LCM_cal:
	push	esi		; because keep esi address
	mov		ebx,	eax		; setting ebx A1
	mov		ecx,	[edi]	; setting ecx B1 1 is byte type			 ; setting LCM(G1, A, B)
	;*** for get right number
	mov		edx,	0
	mov		edx,	ecx		; input dl
	mov		ecx,	edx		; edx input ecx
	;mov		edx,	get_array[0]	; get_GCE
	mov		edx,	eax		; edx to eax (A1)	edx	
	mov		eax,	ecx		; eax to ecx (B1)	eax
	mov		ecx,	get_array[0]	; get_GCE
	CDQ		
	Idiv	ecx				; A/G1
	; edx will be changed because of div
	; so before change it, it should transfer to another value to another register
	; And div first !!! because of overflow
	mov		edx,	0
	mov		edx,	ebx
	mov		ebx,	edx
	Imul	ebx				; (A/G1)*B

	; so after this calculater eax contains LCM result
	; but it need to chunk to al value

;	mov		bx,		ax		; For initialization eax register
;	mov		eax,	0
;	mov		ax,		bx		; It has LCM
	mov		edx,	1		; using just one array for LCM value 
	mov	get_array[edx*4],		eax		; get_LCM
	; need to make get value input to LCM_result_arry
	add		edi,	4		 ; to get next array 
	mov		ecx,	[ebp+12] ; lengthof benchmark

	pop	esi	; get original value address
	ret

get_calculate_Dword_LCM_input2	ENDP
get_calculate_Dword_LCM_input3	PROC
	LCM_cal:
	push	esi		; because keep esi address
	mov		ebx,	eax		; setting ebx A1
	mov		ecx,	[edi]	; setting ecx B1 1 is byte type			 ; setting LCM(G1, A, B)

	;*** for get right number
	mov		edx,	0
	mov		edx,		ecx		; input dl
	mov		ecx,	edx		; edx input ecx
	mov		edx,	get_array[4]	; get_LCM
	mov		eax,	edx		; L1
	; EBX is G2
	; ECX is C1
	CDQ		
	Idiv	ebx				; L1/G2
	; edx will be changed because of div
	; so before change it, it should transfer to another value to another register
	; And div first !!! because of overflow
	mov		edx,	0
	mov		edx,		eax
	mov		eax,	edx
	Imul	ecx				; (L1/G2)*C

	; so after this calculater eax contains LCM result
	; but it need to chunk to al value
	mov	get_array[4],		eax		; get_LCM
	; need to make get value input to LCM_result_arry
	add		edi,	4		 ; to get next array 
	mov		ecx,	[ebp+12] ; lengthof benchmark

	pop	esi	; get original value address
	ret

get_calculate_Dword_LCM_input3	ENDP


;******** after_cal function ********;
after_cal_byte	PROC
	mov		edx,		[ebp+16]	; type of benchmark
	mov		ebx,		[esi]	; benchmark1[2] over 3 values in array

	call	setting_neg_byte

	mov		edx,	0		; edx =0
	mov		dl,		bl		; bl = -- 
	mov		ebx,	0		; ebx initialization
	mov		ebx,	edx		; move ebx to ecx	(dl value)

	ret
after_cal_byte	ENDP

after_cal_word	PROC
	mov		ebx,		[esi]	; benchmark1[2] over 3 values in array
	
	call	setting_neg_word	


	mov		edx,	0			; edx =0
	mov		dx,		bx			; bl = -- 
	mov		ebx,	0			; ebx initialization
	mov		ebx,	edx			; move ebx to ecx	(dl value)

	ret
after_cal_word	ENDP

after_cal_Dword	PROC
	mov		edx,		[ebp+16]; type of benchmark
	mov		ebx,		[esi]	; benchmark1[2] over 3 values in array

	call	setting_neg_Dword

	mov		edx,		0		; edx =0
	mov		edx,		ebx		; bl = -- 
	mov		ebx,		0		; ebx initialization
	mov		ebx,		edx		; move ebx to ecx	(dl value)
	cmp		ebx,		eax		; compare benchmark1[2] and GCD
	je		next_value			; + array
	jmp		next_cal			; call calculate
	next_value:

	next_cal:

	ret
after_cal_Dword	ENDP



END main