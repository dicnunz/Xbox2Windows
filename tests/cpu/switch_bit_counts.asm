; coverage: source cpu_aot_switch_bit_counts
; Source-owned differential fixture and negative controls for POPCNT, LZCNT and TZCNT in
; tools/cpu_switch_aot.py. Every differential export takes RCX = x, RDX = y and R8 = address of
; three writable QWORDs. SETcc bytes go to [r8] in the order O NO B AE E NE BE A S NS P NP L GE LE G
; after POPCNT, and B AE E NE BE A after LZCNT and TZCNT.
.code

popcnt16_reg PROC FRAME
    .endprolog
    mov r9, rcx
    popcnt r9w, dx
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
popcnt16_reg ENDP

popcnt16_mem PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    mov rax, rcx
    popcnt ax, WORD PTR [r8+16]
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
    ret
popcnt16_mem ENDP

popcnt32_reg PROC FRAME
    .endprolog
    mov r9, rcx
    popcnt r9d, edx
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
popcnt32_reg ENDP

popcnt32_mem PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    mov rax, rcx
    popcnt eax, DWORD PTR [r8+16]
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
    ret
popcnt32_mem ENDP

popcnt64_reg PROC FRAME
    .endprolog
    mov r9, rcx
    popcnt r9, rdx
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
popcnt64_reg ENDP

popcnt64_mem PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    mov rax, rcx
    popcnt rax, QWORD PTR [r8+16]
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
    ret
popcnt64_mem ENDP

lzcnt16_reg PROC FRAME
    .endprolog
    mov r9, rcx
    lzcnt r9w, dx
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    mov QWORD PTR [r8+16], r9
    mov rax, r9
    ret
lzcnt16_reg ENDP

lzcnt16_mem PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    mov rax, rcx
    lzcnt ax, WORD PTR [r8+16]
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    ret
lzcnt16_mem ENDP

lzcnt32_reg PROC FRAME
    .endprolog
    mov r9, rcx
    lzcnt r9d, edx
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    mov QWORD PTR [r8+16], r9
    mov rax, r9
    ret
lzcnt32_reg ENDP

lzcnt32_mem PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    mov rax, rcx
    lzcnt eax, DWORD PTR [r8+16]
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    ret
lzcnt32_mem ENDP

lzcnt64_reg PROC FRAME
    .endprolog
    mov r9, rcx
    lzcnt r9, rdx
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    mov QWORD PTR [r8+16], r9
    mov rax, r9
    ret
lzcnt64_reg ENDP

lzcnt64_mem PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    mov rax, rcx
    lzcnt rax, QWORD PTR [r8+16]
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    ret
lzcnt64_mem ENDP

tzcnt16_reg PROC FRAME
    .endprolog
    mov r9, rcx
    tzcnt r9w, dx
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    mov QWORD PTR [r8+16], r9
    mov rax, r9
    ret
tzcnt16_reg ENDP

tzcnt16_mem PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    mov rax, rcx
    tzcnt ax, WORD PTR [r8+16]
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    ret
tzcnt16_mem ENDP

tzcnt32_reg PROC FRAME
    .endprolog
    mov r9, rcx
    tzcnt r9d, edx
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    mov QWORD PTR [r8+16], r9
    mov rax, r9
    ret
tzcnt32_reg ENDP

tzcnt32_mem PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    mov rax, rcx
    tzcnt eax, DWORD PTR [r8+16]
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    ret
tzcnt32_mem ENDP

tzcnt64_reg PROC FRAME
    .endprolog
    mov r9, rcx
    tzcnt r9, rdx
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    mov QWORD PTR [r8+16], r9
    mov rax, r9
    ret
tzcnt64_reg ENDP

tzcnt64_mem PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    mov rax, rcx
    tzcnt rax, QWORD PTR [r8+16]
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    sete BYTE PTR [r8+2]
    setne BYTE PTR [r8+3]
    setbe BYTE PTR [r8+4]
    seta BYTE PTR [r8+5]
    ret
tzcnt64_mem ENDP

jcc_tzcnt_b PROC FRAME
    .endprolog
    mov rax, rdx
    tzcnt rax, rcx
    jb jcc_tzcnt_b_taken
    ret
jcc_tzcnt_b_taken:
    not rax
    ret
jcc_tzcnt_b ENDP

jcc_lzcnt_e PROC FRAME
    .endprolog
    mov rax, rdx
    lzcnt eax, ecx
    je jcc_lzcnt_e_taken
    ret
jcc_lzcnt_e_taken:
    not rax
    ret
jcc_lzcnt_e ENDP

jcc_popcnt_ne PROC FRAME
    .endprolog
    mov rax, rcx
    popcnt rax, rdx
    jne jcc_popcnt_ne_taken
    ret
jcc_popcnt_ne_taken:
    not rax
    ret
jcc_popcnt_ne ENDP

cmov_counts PROC FRAME
    .endprolog
    mov rax, rcx
    lzcnt r9, rdx
    mov r10, rdx
    cmova rax, r10
    mov QWORD PTR [r8], rax
    popcnt r10d, ecx
    cmovle r10d, edx
    mov QWORD PTR [r8+8], r10
    mov QWORD PTR [r8+16], r9
    mov rax, rdx
    ret
cmov_counts ENDP

; --- Native only: CPUID bits for POPCNT (bit 0), BMI1 TZCNT (bit 1) and ABM LZCNT (bit 2) ---

host_bit_counts PROC FRAME
    push rbx
    .pushreg rbx
    .endprolog
    xor eax, eax
    cpuid
    mov r9d, eax
    mov eax, 1
    cpuid
    shr ecx, 23
    and ecx, 1
    mov r8d, ecx
    cmp r9d, 7
    jb host_bit_counts_ext
    mov eax, 7
    xor ecx, ecx
    cpuid
    shr ebx, 3
    and ebx, 1
    shl ebx, 1
    or r8d, ebx
host_bit_counts_ext:
    mov eax, 80000000h
    cpuid
    cmp eax, 80000001h
    jb host_bit_counts_done
    mov eax, 80000001h
    cpuid
    shr ecx, 5
    and ecx, 1
    shl ecx, 2
    or r8d, ecx
host_bit_counts_done:
    mov eax, r8d
    pop rbx
    ret
host_bit_counts ENDP

; --- Negative controls (untranslated by CMake; tested directly for rejection) ---

neg_tzcnt_seto PROC FRAME
    .endprolog
    mov eax, edx
    tzcnt ecx, ecx
    seto al
    ret
neg_tzcnt_seto ENDP

neg_lzcnt_cmovs PROC FRAME
    .endprolog
    mov rax, rdx
    lzcnt rcx, rcx
    cmovs rax, rcx
    ret
neg_lzcnt_cmovs ENDP

neg_lzcnt_setp PROC FRAME
    .endprolog
    mov eax, edx
    lzcnt cx, cx
    setp al
    ret
neg_lzcnt_setp ENDP

neg_tzcnt_setl PROC FRAME
    .endprolog
    mov eax, edx
    tzcnt rcx, rdx
    setl al
    ret
neg_tzcnt_setl ENDP

neg_popcnt_undef PROC FRAME
    .endprolog
    popcnt eax, r10d
    ret
neg_popcnt_undef ENDP

neg_tzcnt_setg PROC FRAME
    .endprolog
    mov eax, edx
    tzcnt ecx, ecx
    setg al
    ret
neg_tzcnt_setg ENDP

neg_lzcnt_cmovns PROC FRAME
    .endprolog
    mov rax, rdx
    lzcnt r9, rcx
    cmovns rax, r9
    ret
neg_lzcnt_cmovns ENDP

neg_bsr PROC FRAME
    .endprolog
    bsr rax, rcx
    ret
neg_bsr ENDP

neg_bsf PROC FRAME
    .endprolog
    bsf rax, rcx
    ret
neg_bsf ENDP

END
