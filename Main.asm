.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxW@16 : PROC
extern __write : PROC ; (dwa znaki podkreúlenia)
extern __read : PROC ; (dwa znaki podkreúlenia)
public _main


.data
    
    koniec db ?
    tekstP db 'wpisz znaki i kliknij ','enter',10
    tekstK db ?
    magazyn db 80 dup (?)
    wynik dw 80 dup (?)
    tytulUnicode dw 'U','T','F','-','1','6',0
    dlugoscTekstu dd ?
.code
_main:


mov ecx,(offset tekstK) - (offset tekstP)  ;wyswietliÊ tekst "wpisz znaki"
push ecx
push offset tekstP
push 1
call __write
add esp,12

push 80             ;zapisaÊ z klawiatury tekst
push offset magazyn
push 0
call __read
add esp,12
mov dlugoscTekstu,eax





    mov ecx, dlugoscTekstu
    mov edx,offset magazyn
    
    
    ptl:                        ;zapis tekstu na stos
    mov al ,[edx]
    push eax
    inc edx
    dec ecx
    jnz ptl

    mov ecx,dlugoscTekstu
    mov edx,offset magazyn
   
   
    ptl1:               ;odczytanie tesktu ze stosu
    pop eax
    mov [edx],al
    inc edx
    dec ecx
    jnz ptl1

    mov ecx, dlugoscTekstu

    mov eax ,0
    mov ebx ,0
    mov edx ,0

    ptl2:
    mov dl,magazyn[ebx]
    mov wynik[eax],dx
    inc ebx
    add eax,2
    dec ecx
    jnz ptl2

    mov ecx, dlugoscTekstu

    mov eax ,0
    mov ebx ,0
    mov edx ,0

    ptl3:
    mov dx,wynik[eax]
    cmp dx,0A5H;π
    jnz con1
    mov dx,0105H
    jmp next
    con1:
    cmp dx,86H;Ê
    jnz con2
    mov dx,0107H
    jmp next
    con2:
    cmp dx,0A9H;Í
    jnz con3
    mov dx,0119H
    jmp next
    con3:
    cmp dx,88H;≥
    jnz con4
    mov dx,0142H
    jmp next
    con4:
    cmp dx,0E4H;Ò
    jnz con5
    mov dx,0144H
    jmp next
    con5:
    cmp dx,0A2H;Û
    jnz con6
    mov dx,00F3H
    jmp next
    con6:
    cmp dx,98H;ú
    jnz con7
    mov dx,015BH
    jmp next
    con7:
    cmp dx,0ABH;ü
    jnz con8
    mov dx,017AH
    jmp next
    con8:
    cmp dx,0BEH;ø
    jnz con9
    mov dx,017CH
    jmp next
    con9:
    cmp dx,0A4H;•
    jnz con10
    mov dx,0104H
    jmp next
    con10:
    cmp dx,8FH;∆
    jnz con11
    mov dx,0106H
    jmp next
    con11:
    cmp dx,0A8H; 
    jnz con12
    mov dx,0118H
    jmp next
    con12:
    cmp dx,9DH;£
    jnz con13
    mov dx,0141H
    jmp next
    con13:
    cmp dx,0E3H;—
    jnz con14
    mov dx,0143H
    jmp next
    con14:
    cmp dx,0E0H;”
    jnz con15
    mov dx,00D3H
    jmp next
    con15:
    cmp dx,97H;å
    jnz con16
    mov dx,015AH
    jmp next
    con16:
    cmp dx,8DH;è
    jnz con17
    mov dx,0179H
    jmp next
    con17:
    cmp dx,0BDH;Ø
    jnz next
    mov dx,017BH
    next:

    mov wynik[eax],dx
    add eax,2
    dec ecx
    jnz ptl3
    mov ecx, dlugoscTekstu
    push ecx ; liczba znakÛw wyúwietlanego tekstu
    push dword PTR OFFSET magazyn ; po≥oøenie obszaru
    ; ze znakami
    push dword PTR 1 ; uchwyt urzπdzenia wyjúciowego
    call __write ; wyúwietlenie znakÛw
    ; (dwa znaki podkreúlenia _ )
    add esp, 12 ; usuniÍcie parametrÛw ze stosu
    ; zakoÒczenie wykonywania programu

    push 0
    push offset tytulUnicode
    push offset wynik
    push 0
    call _MessageBoxW@16  


    push dword PTR 0 ; kod powrotu programu
    call _ExitProcess@4
END


