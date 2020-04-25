; Command prompt calculator using masm
Include Irvine32.inc
Include Macros.inc
.data
adding BYTE "+",0
subing BYTE "-",0
muling BYTE "*",0
diving BYTE "/",0
facting BYTE "!",0
userInput BYTE ?
sval1 SDWORD ?
sval2 SDWORD ?
val1 DWORD ?
sanswer SDWORD ?
remainder SDWORD ?
answer DWORD ?
.code
main proc
	call Clrscr
	mov dh,0		;row
	mov dl,40		;column
	call GoToXY
	mWrite "What function would you like to use? "
	call ReadChar
	call WriteChar
	mov userInput,al
	inc dh
	call GoToXY
	cmp al,facting
	je factin
	mWrite "Enter the first Integer: "
	call ReadInt
	mov sval1,eax
	inc dh
	call GoToXY
	mWrite "Enter the second Integer: "
	call ReadInt
	mov sval2,eax
	mov al,userInput
	jmp expression
factin:
	mWrite "Enter unsigned Integer: "
	call ReadInt
	push eax
	mov val1,eax
	call factorial
	mov answer,eax
	jmp finalF
expression:
	
	cmp al,adding
	jne subin
	call addition
	jmp final
subin:
	
	cmp al,subing
	jne mulin
	call subtraction
	jmp final
mulin:
	
	cmp al,muling
	jne divin
	call division
	jmp final
divin:
	call division
	jmp finalD
final:
	mov dh,3
	mov dl,40
	call GoToXY
	mov eax,sanswer
	call WriteInt
	jmp done
finalD:
	mov dh,3
	mov dl,40
	call GoToXY
	mov eax,sanswer
	call WriteInt
	mWrite " remainder: "
	mov eax,remainder
	call WriteInt
	jmp done
finalF:
	mov dh,3
	mov dl,40
	mov eax,answer
	call GoToXY
	call WriteInt
done:
	exit
main endp
addition PROC
	mov eax,sval1
	add eax,sval2
	mov sanswer,eax
	ret
addition endp
subtraction PROC
	mov eax,sval1
	sub eax,sval2
	mov sanswer,eax
	ret
subtraction endp
multiplication PROC
	mov eax,sval1
	imul eax,sval2
	mov sanswer,eax
	ret
multiplication endp
division PROC
	mov eax,sval1
	cdq
	idiv sval2
	mov sanswer,eax
	mov remainder,edx
	ret
division endp
factorial PROC
	push ebp
	mov ebp,esp
	mov eax,[ebp+8]
	cmp eax,0
	ja L1
	mov eax,1
	jmp L2
L1: dec eax
	push eax
	call factorial
returnFact:
	mov ebx,[ebp+8]
	mul ebx
L2: pop ebp
	ret 4
factorial endp
end main