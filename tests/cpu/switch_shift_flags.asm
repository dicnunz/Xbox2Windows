; coverage: source cpu_aot_switch_shift_flags
; Source-owned differential fixture and negative controls for SHL, SHR and SAR by an immediate
; count as flag producers in tools/cpu_switch_aot.py. Every differential export takes RCX = x,
; RDX = y and R8 = address of three writable QWORDs. SETcc bytes go to [r8] in the order
; O NO B AE E NE BE A S NS P NP L GE LE G (count 1) or B AE E NE BE A S NS P NP (larger counts).
.code

shl1_8 PROC FRAME
    .endprolog
    mov rax, rdx
    shl al, 1
    seto BYTE PTR [r8]
    setno BYTE PTR [r8+1]
    setb BYTE PTR [r8+2]
    setae BYTE PTR [r8+3]
    sete BYTE PTR [r8+4]
    setne BYTE PTR [r8+5]
    setbe BYTE PTR [r8+6]
    seta BYTE PTR [r8+7]
    sets BYTE PTR [r8+8]
    setns BYTE PTR [r8+9]
    setp BYTE PTR [r8+10]
    setnp BYTE PTR [r8+11]
    setl BYTE PTR [r8+12]
    setge BYTE PTR [r8+13]
    setle BYTE PTR [r8+14]
    setg BYTE PTR [r8+15]
    mov QWORD PTR [r8+16], rax
    ret
shl1_8 ENDP

shr1_8 PROC FRAME
    .endprolog
    mov rax, rdx
    shr al, 1
    seto BYTE PTR [r8]
    setno BYTE PTR [r8+1]
    setb BYTE PTR [r8+2]
    setae BYTE PTR [r8+3]
    sete BYTE PTR [r8+4]
    setne BYTE PTR [r8+5]
    setbe BYTE PTR [r8+6]
    seta BYTE PTR [r8+7]
    sets BYTE PTR [r8+8]
    setns BYTE PTR [r8+9]
    setp BYTE PTR [r8+10]
    setnp BYTE PTR [r8+11]
    setl BYTE PTR [r8+12]
    setge BYTE PTR [r8+13]
    setle BYTE PTR [r8+14]
    setg BYTE PTR [r8+15]
    mov QWORD PTR [r8+16], rax
    ret
shr1_8 ENDP

sar1_8 PROC FRAME
    .endprolog
    mov rax, rdx
    sar al, 33
    seto BYTE PTR [r8]
    setno BYTE PTR [r8+1]
    setb BYTE PTR [r8+2]
    setae BYTE PTR [r8+3]
    sete BYTE PTR [r8+4]
    setne BYTE PTR [r8+5]
    setbe BYTE PTR [r8+6]
    seta BYTE PTR [r8+7]
    sets BYTE PTR [r8+8]
    setns BYTE PTR [r8+9]
    setp BYTE PTR [r8+10]
    setnp BYTE PTR [r8+11]
    setl BYTE PTR [r8+12]
    setge BYTE PTR [r8+13]
    setle BYTE PTR [r8+14]
    setg BYTE PTR [r8+15]
    mov QWORD PTR [r8+16], rax
    ret
sar1_8 ENDP

shl1_16 PROC FRAME
    .endprolog
    mov r9, rdx
    shl r9w, 1
    seto BYTE PTR [r8]
    setno BYTE PTR [r8+1]
    setb BYTE PTR [r8+2]
    setae BYTE PTR [r8+3]
    sete BYTE PTR [r8+4]
    setne BYTE PTR [r8+5]
    setbe BYTE PTR [r8+6]
    seta BYTE PTR [r8+7]
    sets BYTE PTR [r8+8]
    setns BYTE PTR [r8+9]
    setp BYTE PTR [r8+10]
    setnp BYTE PTR [r8+11]
    setl BYTE PTR [r8+12]
    setge BYTE PTR [r8+13]
    setle BYTE PTR [r8+14]
    setg BYTE PTR [r8+15]
    mov QWORD PTR [r8+16], r9
    mov rax, r9
    ret
shl1_16 ENDP

shr1_16 PROC FRAME
    .endprolog
    mov r9, rdx
    shr r9w, 1
    seto BYTE PTR [r8]
    setno BYTE PTR [r8+1]
    setb BYTE PTR [r8+2]
    setae BYTE PTR [r8+3]
    sete BYTE PTR [r8+4]
    setne BYTE PTR [r8+5]
    setbe BYTE PTR [r8+6]
    seta BYTE PTR [r8+7]
    sets BYTE PTR [r8+8]
    setns BYTE PTR [r8+9]
    setp BYTE PTR [r8+10]
    setnp BYTE PTR [r8+11]
    setl BYTE PTR [r8+12]
    setge BYTE PTR [r8+13]
    setle BYTE PTR [r8+14]
    setg BYTE PTR [r8+15]
    mov QWORD PTR [r8+16], r9
    mov rax, r9
    ret
shr1_16 ENDP

sar1_16 PROC FRAME
    .endprolog
    mov r9, rdx
    sar r9w, 1
    seto BYTE PTR [r8]
    setno BYTE PTR [r8+1]
    setb BYTE PTR [r8+2]
    setae BYTE PTR [r8+3]
    sete BYTE PTR [r8+4]
    setne BYTE PTR [r8+5]
    setbe BYTE PTR [r8+6]
    seta BYTE PTR [r8+7]
    sets BYTE PTR [r8+8]
    setns BYTE PTR [r8+9]
    setp BYTE PTR [r8+10]
    setnp BYTE PTR [r8+11]
    setl BYTE PTR [r8+12]
    setge BYTE PTR [r8+13]
    setle BYTE PTR [r8+14]
    setg BYTE PTR [r8+15]
    mov QWORD PTR [r8+16], r9
    mov rax, r9
    ret
sar1_16 ENDP

shl1_32 PROC FRAME
    .endprolog
    mov rax, rdx
    shl eax, 1
    seto BYTE PTR [r8]
    setno BYTE PTR [r8+1]
    setb BYTE PTR [r8+2]
    setae BYTE PTR [r8+3]
    sete BYTE PTR [r8+4]
    setne BYTE PTR [r8+5]
    setbe BYTE PTR [r8+6]
    seta BYTE PTR [r8+7]
    sets BYTE PTR [r8+8]
    setns BYTE PTR [r8+9]
    setp BYTE PTR [r8+10]
    setnp BYTE PTR [r8+11]
    setl BYTE PTR [r8+12]
    setge BYTE PTR [r8+13]
    setle BYTE PTR [r8+14]
    setg BYTE PTR [r8+15]
    mov QWORD PTR [r8+16], rax
    ret
shl1_32 ENDP

shr1_32 PROC FRAME
    .endprolog
    mov rax, rdx
    shr eax, 33
    seto BYTE PTR [r8]
    setno BYTE PTR [r8+1]
    setb BYTE PTR [r8+2]
    setae BYTE PTR [r8+3]
    sete BYTE PTR [r8+4]
    setne BYTE PTR [r8+5]
    setbe BYTE PTR [r8+6]
    seta BYTE PTR [r8+7]
    sets BYTE PTR [r8+8]
    setns BYTE PTR [r8+9]
    setp BYTE PTR [r8+10]
    setnp BYTE PTR [r8+11]
    setl BYTE PTR [r8+12]
    setge BYTE PTR [r8+13]
    setle BYTE PTR [r8+14]
    setg BYTE PTR [r8+15]
    mov QWORD PTR [r8+16], rax
    ret
shr1_32 ENDP

sar1_32 PROC FRAME
    .endprolog
    mov rax, rdx
    sar eax, 1
    seto BYTE PTR [r8]
    setno BYTE PTR [r8+1]
    setb BYTE PTR [r8+2]
    setae BYTE PTR [r8+3]
    sete BYTE PTR [r8+4]
    setne BYTE PTR [r8+5]
    setbe BYTE PTR [r8+6]
    seta BYTE PTR [r8+7]
    sets BYTE PTR [r8+8]
    setns BYTE PTR [r8+9]
    setp BYTE PTR [r8+10]
    setnp BYTE PTR [r8+11]
    setl BYTE PTR [r8+12]
    setge BYTE PTR [r8+13]
    setle BYTE PTR [r8+14]
    setg BYTE PTR [r8+15]
    mov QWORD PTR [r8+16], rax
    ret
sar1_32 ENDP

shl1_64 PROC FRAME
    .endprolog
    mov r10, rdx
    shl r10, 65
    seto BYTE PTR [r8]
    setno BYTE PTR [r8+1]
    setb BYTE PTR [r8+2]
    setae BYTE PTR [r8+3]
    sete BYTE PTR [r8+4]
    setne BYTE PTR [r8+5]
    setbe BYTE PTR [r8+6]
    seta BYTE PTR [r8+7]
    sets BYTE PTR [r8+8]
    setns BYTE PTR [r8+9]
    setp BYTE PTR [r8+10]
    setnp BYTE PTR [r8+11]
    setl BYTE PTR [r8+12]
    setge BYTE PTR [r8+13]
    setle BYTE PTR [r8+14]
    setg BYTE PTR [r8+15]
    mov QWORD PTR [r8+16], r10
    mov rax, r10
    ret
shl1_64 ENDP

shr1_64 PROC FRAME
    .endprolog
    mov r10, rdx
    shr r10, 1
    seto BYTE PTR [r8]
    setno BYTE PTR [r8+1]
    setb BYTE PTR [r8+2]
    setae BYTE PTR [r8+3]
    sete BYTE PTR [r8+4]
    setne BYTE PTR [r8+5]
    setbe BYTE PTR [r8+6]
    seta BYTE PTR [r8+7]
    sets BYTE PTR [r8+8]
    setns BYTE PTR [r8+9]
    setp BYTE PTR [r8+10]
    setnp BYTE PTR [r8+11]
    setl BYTE PTR [r8+12]
    setge BYTE PTR [r8+13]
    setle BYTE PTR [r8+14]
    setg BYTE PTR [r8+15]
    mov QWORD PTR [r8+16], r10
    mov rax, r10
    ret
shr1_64 ENDP

sar1_64 PROC FRAME
    .endprolog
    mov r10, rdx
    sar r10, 1
    seto BYTE PTR [r8]
    setno BYTE PTR [r8+1]
    setb BYTE PTR [r8+2]
    setae BYTE PTR [r8+3]
    sete BYTE PTR [r8+4]
    setne BYTE PTR [r8+5]
    setbe BYTE PTR [r8+6]
    seta BYTE PTR [r8+7]
    sets BYTE PTR [r8+8]
    setns BYTE PTR [r8+9]
    setp BYTE PTR [r8+10]
    setnp BYTE PTR [r8+11]
    setl BYTE PTR [r8+12]
    setge BYTE PTR [r8+13]
    setle BYTE PTR [r8+14]
    setg BYTE PTR [r8+15]
    mov QWORD PTR [r8+16], r10
    mov rax, r10
    ret
sar1_64 ENDP

shln_8 PROC FRAME
    .endprolog
    mov rax, rdx
    shl al, 3
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    sets BYTE PTR [r8+6]
    setns BYTE PTR [r8+7]
    setp BYTE PTR [r8+8]
    setnp BYTE PTR [r8+9]
    mov QWORD PTR [r8+16], rax
    ret
shln_8 ENDP

shrn_8 PROC FRAME
    .endprolog
    mov rax, rdx
    shr al, 7
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    sets BYTE PTR [r8+6]
    setns BYTE PTR [r8+7]
    setp BYTE PTR [r8+8]
    setnp BYTE PTR [r8+9]
    mov QWORD PTR [r8+16], rax
    ret
shrn_8 ENDP

sarn_8 PROC FRAME
    .endprolog
    mov rax, rdx
    sar al, 5
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    sets BYTE PTR [r8+6]
    setns BYTE PTR [r8+7]
    setp BYTE PTR [r8+8]
    setnp BYTE PTR [r8+9]
    mov QWORD PTR [r8+16], rax
    ret
sarn_8 ENDP

shln_16 PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    shl WORD PTR [r8+16], 9
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    sets BYTE PTR [r8+6]
    setns BYTE PTR [r8+7]
    setp BYTE PTR [r8+8]
    setnp BYTE PTR [r8+9]
    mov rax, rcx
    ret
shln_16 ENDP

shrn_16 PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    shr WORD PTR [r8+16], 15
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    sets BYTE PTR [r8+6]
    setns BYTE PTR [r8+7]
    setp BYTE PTR [r8+8]
    setnp BYTE PTR [r8+9]
    mov rax, rcx
    ret
shrn_16 ENDP

sarn_16 PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    sar WORD PTR [r8+16], 4
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    sets BYTE PTR [r8+6]
    setns BYTE PTR [r8+7]
    setp BYTE PTR [r8+8]
    setnp BYTE PTR [r8+9]
    mov rax, rcx
    ret
sarn_16 ENDP

shln_32 PROC FRAME
    .endprolog
    mov rax, rdx
    shl eax, 31
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    sets BYTE PTR [r8+6]
    setns BYTE PTR [r8+7]
    setp BYTE PTR [r8+8]
    setnp BYTE PTR [r8+9]
    mov QWORD PTR [r8+16], rax
    ret
shln_32 ENDP

shrn_32 PROC FRAME
    .endprolog
    mov rax, rdx
    shr eax, 5
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    sets BYTE PTR [r8+6]
    setns BYTE PTR [r8+7]
    setp BYTE PTR [r8+8]
    setnp BYTE PTR [r8+9]
    mov QWORD PTR [r8+16], rax
    ret
shrn_32 ENDP

sarn_32 PROC FRAME
    .endprolog
    mov rax, rdx
    sar eax, 37
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    sets BYTE PTR [r8+6]
    setns BYTE PTR [r8+7]
    setp BYTE PTR [r8+8]
    setnp BYTE PTR [r8+9]
    mov QWORD PTR [r8+16], rax
    ret
sarn_32 ENDP

shln_64 PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    shl QWORD PTR [r8+16], 13
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    sets BYTE PTR [r8+6]
    setns BYTE PTR [r8+7]
    setp BYTE PTR [r8+8]
    setnp BYTE PTR [r8+9]
    mov rax, rcx
    ret
shln_64 ENDP

shrn_64 PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    shr QWORD PTR [r8+16], 63
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    sets BYTE PTR [r8+6]
    setns BYTE PTR [r8+7]
    setp BYTE PTR [r8+8]
    setnp BYTE PTR [r8+9]
    mov rax, rcx
    ret
shrn_64 ENDP

sarn_64 PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    sar QWORD PTR [r8+16], 32
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    sets BYTE PTR [r8+6]
    setns BYTE PTR [r8+7]
    setp BYTE PTR [r8+8]
    setnp BYTE PTR [r8+9]
    mov rax, rcx
    ret
sarn_64 ENDP

shlw_16 PROC FRAME
    .endprolog
    mov r9, rdx
    shl r9w, 15
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    sets BYTE PTR [r8+6]
    setns BYTE PTR [r8+7]
    setp BYTE PTR [r8+8]
    setnp BYTE PTR [r8+9]
    mov QWORD PTR [r8+16], r9
    mov rax, r9
    ret
shlw_16 ENDP

sarw_8 PROC FRAME
    .endprolog
    mov rax, rdx
    sar al, 7
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    sets BYTE PTR [r8+6]
    setns BYTE PTR [r8+7]
    setp BYTE PTR [r8+8]
    setnp BYTE PTR [r8+9]
    mov QWORD PTR [r8+16], rax
    ret
sarw_8 ENDP

shlw_64 PROC FRAME
    .endprolog
    mov r10, rdx
    shl r10, 63
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    sets BYTE PTR [r8+6]
    setns BYTE PTR [r8+7]
    setp BYTE PTR [r8+8]
    setnp BYTE PTR [r8+9]
    mov QWORD PTR [r8+16], r10
    mov rax, r10
    ret
shlw_64 ENDP

shln_32m PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    shl DWORD PTR [r8+16], 3
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    sets BYTE PTR [r8+6]
    setns BYTE PTR [r8+7]
    setp BYTE PTR [r8+8]
    setnp BYTE PTR [r8+9]
    mov rax, rcx
    ret
shln_32m ENDP

jcc_shl64_o PROC FRAME
    .endprolog
    mov rax, rcx
    shl rax, 1
    jo jcc_shl64_o_taken
    ret
jcc_shl64_o_taken:
    not rax
    ret
jcc_shl64_o ENDP

jcc_shr32_b PROC FRAME
    .endprolog
    mov eax, ecx
    shr eax, 1
    jb jcc_shr32_b_taken
    ret
jcc_shr32_b_taken:
    not rax
    ret
jcc_shr32_b ENDP

jcc_sar16_s PROC FRAME
    .endprolog
    mov rax, rdx
    sar ax, 5
    js jcc_sar16_s_taken
    ret
jcc_sar16_s_taken:
    not rax
    ret
jcc_sar16_s ENDP

jcc_shl8_be PROC FRAME
    .endprolog
    mov rax, rdx
    shl al, 3
    jbe jcc_shl8_be_taken
    ret
jcc_shl8_be_taken:
    not rax
    ret
jcc_shl8_be ENDP

jcc_sar64_g PROC FRAME
    .endprolog
    mov rax, rcx
    sar rax, 1
    jg jcc_sar64_g_taken
    ret
jcc_sar64_g_taken:
    not rax
    ret
jcc_sar64_g ENDP

jcc_shr8_ge PROC FRAME
    .endprolog
    mov rax, rcx
    shr al, 1
    jge jcc_shr8_ge_taken
    ret
jcc_shr8_ge_taken:
    not rax
    ret
jcc_shr8_ge ENDP

jcc_shrn_np PROC FRAME
    .endprolog
    mov rax, rdx
    shr eax, 9
    jnp jcc_shrn_np_taken
    ret
jcc_shrn_np_taken:
    not rax
    ret
jcc_shrn_np ENDP

cmov_shift PROC FRAME
    .endprolog
    mov rax, rcx
    shr eax, 7
    mov r9, rdx
    cmova rax, r9
    mov QWORD PTR [r8], rax
    mov r10, rdx
    sar r10d, 1
    cmovl r10d, ecx
    mov QWORD PTR [r8+8], r10
    mov QWORD PTR [r8+16], rdx
    shl QWORD PTR [r8+16], 13
    mov rax, rcx
    cmovnp rax, QWORD PTR [r8+16]
    ret
cmov_shift ENDP

; --- Negative controls (untranslated by CMake; tested directly for rejection) ---

neg_shl_cl_setcc PROC FRAME
    .endprolog
    mov eax, edx
    shl eax, cl
    setb al
    ret
neg_shl_cl_setcc ENDP

neg_sar_cl_cmov PROC FRAME
    .endprolog
    mov rax, rdx
    sar rax, cl
    cmovs rax, rcx
    ret
neg_sar_cl_cmov ENDP

neg_shl_zero_setcc PROC FRAME
    .endprolog
    mov eax, edx
    shl eax, 32
    sete al
    ret
neg_shl_zero_setcc ENDP

neg_shr_zero_cmov PROC FRAME
    .endprolog
    mov rax, rdx
    shr rax, 64
    cmove rax, rcx
    ret
neg_shr_zero_cmov ENDP

neg_shl8_wide_setcc PROC FRAME
    .endprolog
    mov eax, edx
    shl al, 9
    setb al
    ret
neg_shl8_wide_setcc ENDP

neg_shr16_wide_setcc PROC FRAME
    .endprolog
    mov eax, edx
    shr ax, 16
    sete al
    ret
neg_shr16_wide_setcc ENDP

neg_shrn_seto PROC FRAME
    .endprolog
    mov eax, edx
    shr eax, 2
    seto al
    ret
neg_shrn_seto ENDP

neg_shln_cmovg PROC FRAME
    .endprolog
    mov rax, rcx
    shl rdx, 4
    cmovg rax, rdx
    ret
neg_shln_cmovg ENDP

neg_shl_ah_setcc PROC FRAME
    .endprolog
    mov rax, rcx
    shl ah, 1
    setb al
    ret
neg_shl_ah_setcc ENDP

neg_cmp_shl_cl_setcc PROC FRAME
    .endprolog
    mov eax, edx
    cmp ecx, edx
    shl eax, cl
    setb al
    ret
neg_cmp_shl_cl_setcc ENDP

neg_sar8_wide_setcc PROC FRAME
    .endprolog
    mov eax, edx
    sar al, 8
    sets al
    ret
neg_sar8_wide_setcc ENDP

neg_sarn_jl PROC FRAME
    .endprolog
    mov rax, rdx
    sar eax, 3
    jl neg_sarn_jl_taken
    ret
neg_sarn_jl_taken:
    not rax
    ret
neg_sarn_jl ENDP

neg_rol_after_cmp PROC FRAME
    .endprolog
    mov rax, rdx
    cmp rcx, rdx
    rol eax, 1
    setb al
    ret
neg_rol_after_cmp ENDP

END
