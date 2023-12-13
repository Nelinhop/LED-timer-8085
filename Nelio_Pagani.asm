.org 1000h

; armazenamento prévio dos primeiros numeros nos enderecos e saidas
mvi a, 10000000b
sta 3000h
out 00h

mvi a, 00000001b
out 01h
sta 3001h

loop:
;;------delay de 1ms-----
;; 7+ N*(4+10)-3= 2*10^3 (quantidade de T-states total, baseada no clock de 2Mhz) -> N=143(decimal) = 8F (hex) 
	 	 
		 
	 	 mvi c, 8Fh
delay_normal:dcr c
		 jnz delay_normal
		 
		 
;;----------------
; fazendo a rotação no sentido normal e jogando na saida
lda 3000h
rrc
jc pular1; caso identifique carry, deixa esse numero da forma que esta para dps poder fazer a inverção de rotacao
sta 3000h
out 00h


pular1:lda 3001h
	 rlc
	 jc inverte ;caso identifique carry, significa que o sentido de rotação mudou e pula para outro endereco
	 sta 3001h
	 out 01h

jmp loop ;loop do sentido normal

.org 2000h

	 	    mvi c, 8Fh
delay_invertido:dcr c
	 	    jnz delay_invertido

; fazendo a rotação apos inverção e jogando na saida
inverte:lda 3000h
	  rlc
	  jc loop ;caso identifique carry, significa que o sentido de rotação mudou dnv
	  sta 3000h
	  out 00h


lda 3001h
rrc
sta 3001h
out 01h

jmp 2000h ; loop do sentido invertido
