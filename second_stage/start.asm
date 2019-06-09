global _start
%include "macros.inc"

%define pc r15		;next command 
%define w r14		;sub commands 
%define rstack r13	;return stack 

section .text

%include "base_words.inc"
%include "interpreter.inc"
%include "utils.inc"

section .bss

resq 1023				;the stack end
rstack_start: resq 1	;the stack start

user_mem: resq 65536	;global data for user

section .data

last_word: dq _lw

dp: dq user_mem		;current global data pointer
stack_start: dq 0	;stores a saved address of data stack

section .text

_start:
	mov rstack, rstack_start
	mov [stack_start], rsp

	mov pc, forth_init

next:
	mov w, pc
	add pc, 8
	mov w, [w]
	jmp [w]
