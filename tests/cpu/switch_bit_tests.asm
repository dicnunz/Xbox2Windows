; coverage: source cpu_aot_switch_bit_tests
; Source-owned differential fixture and negative controls for BT, BTS, BTR and BTC in
; tools/cpu_switch_aot.py. Every differential export takes RCX = x, RDX = y and R8 = address of
; three writable QWORDs. SETB and SETAE bytes go to [r8] and [r8+1].
.code

bt16_reg PROC FRAME
    .endprolog
    mov r9, rdx
    bt r9w, cx
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    mov QWORD PTR [r8+16], r9
    mov rax, r9
    ret
bt16_reg ENDP

bt32_reg PROC FRAME
    .endprolog
    mov r9, rdx
    bt r9d, ecx
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    mov QWORD PTR [r8+16], r9
    mov rax, r9
    ret
bt32_reg ENDP

bt64_reg PROC FRAME
    .endprolog
    mov r9, rdx
    bt r9, rcx
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    mov QWORD PTR [r8+16], r9
    mov rax, r9
    ret
bt64_reg ENDP

bts16_reg PROC FRAME
    .endprolog
    mov r9, rdx
    bts r9w, cx
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    mov QWORD PTR [r8+16], r9
    mov rax, r9
    ret
bts16_reg ENDP

bts32_reg PROC FRAME
    .endprolog
    mov r9, rdx
    bts r9d, ecx
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    mov QWORD PTR [r8+16], r9
    mov rax, r9
    ret
bts32_reg ENDP

bts64_reg PROC FRAME
    .endprolog
    mov r9, rdx
    bts r9, rcx
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    mov QWORD PTR [r8+16], r9
    mov rax, r9
    ret
bts64_reg ENDP

btr16_reg PROC FRAME
    .endprolog
    mov r9, rdx
    btr r9w, cx
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    mov QWORD PTR [r8+16], r9
    mov rax, r9
    ret
btr16_reg ENDP

btr32_reg PROC FRAME
    .endprolog
    mov r9, rdx
    btr r9d, ecx
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    mov QWORD PTR [r8+16], r9
    mov rax, r9
    ret
btr32_reg ENDP

btr64_reg PROC FRAME
    .endprolog
    mov r9, rdx
    btr r9, rcx
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    mov QWORD PTR [r8+16], r9
    mov rax, r9
    ret
btr64_reg ENDP

btc16_reg PROC FRAME
    .endprolog
    mov r9, rdx
    btc r9w, cx
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    mov QWORD PTR [r8+16], r9
    mov rax, r9
    ret
btc16_reg ENDP

btc32_reg PROC FRAME
    .endprolog
    mov r9, rdx
    btc r9d, ecx
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    mov QWORD PTR [r8+16], r9
    mov rax, r9
    ret
btc32_reg ENDP

btc64_reg PROC FRAME
    .endprolog
    mov r9, rdx
    btc r9, rcx
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    mov QWORD PTR [r8+16], r9
    mov rax, r9
    ret
btc64_reg ENDP

bt16_imm PROC FRAME
    .endprolog
    mov r10, rdx
    bt r10w, 0
    setb BYTE PTR [r8]
    bt r10w, 15
    setb BYTE PTR [r8+1]
    bt r10w, 21
    setb BYTE PTR [r8+2]
    mov QWORD PTR [r8+16], r10
    mov rax, r10
    ret
bt16_imm ENDP

bt32_imm PROC FRAME
    .endprolog
    mov r10, rdx
    bt r10d, 0
    setb BYTE PTR [r8]
    bt r10d, 31
    setb BYTE PTR [r8+1]
    bt r10d, 45
    setb BYTE PTR [r8+2]
    mov QWORD PTR [r8+16], r10
    mov rax, r10
    ret
bt32_imm ENDP

bt64_imm PROC FRAME
    .endprolog
    mov r10, rdx
    bt r10, 0
    setb BYTE PTR [r8]
    bt r10, 63
    setb BYTE PTR [r8+1]
    bt r10, 77
    setb BYTE PTR [r8+2]
    mov QWORD PTR [r8+16], r10
    mov rax, r10
    ret
bt64_imm ENDP

bts16_imm PROC FRAME
    .endprolog
    mov r10, rdx
    bts r10w, 0
    setb BYTE PTR [r8]
    bts r10w, 15
    setb BYTE PTR [r8+1]
    bts r10w, 21
    setb BYTE PTR [r8+2]
    mov QWORD PTR [r8+16], r10
    mov rax, r10
    ret
bts16_imm ENDP

bts32_imm PROC FRAME
    .endprolog
    mov r10, rdx
    bts r10d, 0
    setb BYTE PTR [r8]
    bts r10d, 31
    setb BYTE PTR [r8+1]
    bts r10d, 45
    setb BYTE PTR [r8+2]
    mov QWORD PTR [r8+16], r10
    mov rax, r10
    ret
bts32_imm ENDP

bts64_imm PROC FRAME
    .endprolog
    mov r10, rdx
    bts r10, 0
    setb BYTE PTR [r8]
    bts r10, 63
    setb BYTE PTR [r8+1]
    bts r10, 77
    setb BYTE PTR [r8+2]
    mov QWORD PTR [r8+16], r10
    mov rax, r10
    ret
bts64_imm ENDP

btr16_imm PROC FRAME
    .endprolog
    mov r10, rdx
    btr r10w, 0
    setb BYTE PTR [r8]
    btr r10w, 15
    setb BYTE PTR [r8+1]
    btr r10w, 21
    setb BYTE PTR [r8+2]
    mov QWORD PTR [r8+16], r10
    mov rax, r10
    ret
btr16_imm ENDP

btr32_imm PROC FRAME
    .endprolog
    mov r10, rdx
    btr r10d, 0
    setb BYTE PTR [r8]
    btr r10d, 31
    setb BYTE PTR [r8+1]
    btr r10d, 45
    setb BYTE PTR [r8+2]
    mov QWORD PTR [r8+16], r10
    mov rax, r10
    ret
btr32_imm ENDP

btr64_imm PROC FRAME
    .endprolog
    mov r10, rdx
    btr r10, 0
    setb BYTE PTR [r8]
    btr r10, 63
    setb BYTE PTR [r8+1]
    btr r10, 77
    setb BYTE PTR [r8+2]
    mov QWORD PTR [r8+16], r10
    mov rax, r10
    ret
btr64_imm ENDP

btc16_imm PROC FRAME
    .endprolog
    mov r10, rdx
    btc r10w, 0
    setb BYTE PTR [r8]
    btc r10w, 15
    setb BYTE PTR [r8+1]
    btc r10w, 21
    setb BYTE PTR [r8+2]
    mov QWORD PTR [r8+16], r10
    mov rax, r10
    ret
btc16_imm ENDP

btc32_imm PROC FRAME
    .endprolog
    mov r10, rdx
    btc r10d, 0
    setb BYTE PTR [r8]
    btc r10d, 31
    setb BYTE PTR [r8+1]
    btc r10d, 45
    setb BYTE PTR [r8+2]
    mov QWORD PTR [r8+16], r10
    mov rax, r10
    ret
btc32_imm ENDP

btc64_imm PROC FRAME
    .endprolog
    mov r10, rdx
    btc r10, 0
    setb BYTE PTR [r8]
    btc r10, 63
    setb BYTE PTR [r8+1]
    btc r10, 77
    setb BYTE PTR [r8+2]
    mov QWORD PTR [r8+16], r10
    mov rax, r10
    ret
btc64_imm ENDP

bt16_mem PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    bt WORD PTR [r8+16], 19
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    mov rax, rcx
    ret
bt16_mem ENDP

bt32_mem PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    bt DWORD PTR [r8+16], 39
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    mov rax, rcx
    ret
bt32_mem ENDP

bt64_mem PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    bt QWORD PTR [r8+16], 70
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    mov rax, rcx
    ret
bt64_mem ENDP

bts16_mem PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    bts WORD PTR [r8+16], 19
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    mov rax, rcx
    ret
bts16_mem ENDP

bts32_mem PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    bts DWORD PTR [r8+16], 39
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    mov rax, rcx
    ret
bts32_mem ENDP

bts64_mem PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    bts QWORD PTR [r8+16], 70
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    mov rax, rcx
    ret
bts64_mem ENDP

btr16_mem PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    btr WORD PTR [r8+16], 19
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    mov rax, rcx
    ret
btr16_mem ENDP

btr32_mem PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    btr DWORD PTR [r8+16], 39
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    mov rax, rcx
    ret
btr32_mem ENDP

btr64_mem PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    btr QWORD PTR [r8+16], 70
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    mov rax, rcx
    ret
btr64_mem ENDP

btc16_mem PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    btc WORD PTR [r8+16], 19
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    mov rax, rcx
    ret
btc16_mem ENDP

btc32_mem PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    btc DWORD PTR [r8+16], 39
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    mov rax, rcx
    ret
btc32_mem ENDP

btc64_mem PROC FRAME
    .endprolog
    mov QWORD PTR [r8+16], rdx
    btc QWORD PTR [r8+16], 70
    setb BYTE PTR [r8]
    setae BYTE PTR [r8+1]
    mov rax, rcx
    ret
btc64_mem ENDP

jcc_bt PROC FRAME
    .endprolog
    mov rax, rdx
    bt eax, ecx
    jb jcc_bt_set
    ret
jcc_bt_set:
    not rax
    ret
jcc_bt ENDP

jcc_btr_nc PROC FRAME
    .endprolog
    mov rax, rdx
    btr rax, rcx
    jae jcc_btr_nc_clear
    ret
jcc_btr_nc_clear:
    neg rax
    ret
jcc_btr_nc ENDP

cmov_bt PROC FRAME
    .endprolog
    mov rax, rcx
    bts rdx, 5
    mov r9, rdx
    cmovc rax, r9
    mov QWORD PTR [r8], rax
    mov r10, rcx
    btc r10d, edx
    cmovnc r10d, edx
    mov QWORD PTR [r8+8], r10
    mov rax, rdx
    ret
cmov_bt ENDP

; --- Negative controls (untranslated by CMake; tested directly for rejection) ---

neg_bt_mem_reg PROC FRAME
    .endprolog
    mov rax, rcx
    bt DWORD PTR [r8], ecx
    setb al
    ret
neg_bt_mem_reg ENDP

neg_bts_mem_reg PROC FRAME
    .endprolog
    bts QWORD PTR [r8], rcx
    mov rax, rcx
    ret
neg_bts_mem_reg ENDP

neg_bt_sete PROC FRAME
    .endprolog
    mov eax, edx
    bt eax, ecx
    sete al
    ret
neg_bt_sete ENDP

neg_btc_cmovs PROC FRAME
    .endprolog
    mov rax, rdx
    btc rax, 3
    cmovs rax, rcx
    ret
neg_btc_cmovs ENDP

neg_bt_seto PROC FRAME
    .endprolog
    mov eax, edx
    bt rcx, 9
    seto al
    ret
neg_bt_seto ENDP

neg_lock_bts PROC FRAME
    .endprolog
    lock bts DWORD PTR [r8], 3
    mov rax, rcx
    ret
neg_lock_bts ENDP

neg_bt_undef PROC FRAME
    .endprolog
    bt eax, ecx
    setb al
    ret
neg_bt_undef ENDP

neg_bt_setp PROC FRAME
    .endprolog
    mov eax, edx
    bt eax, 3
    setp al
    ret
neg_bt_setp ENDP

neg_bts_cmovl PROC FRAME
    .endprolog
    mov rax, rdx
    bts rcx, 40
    cmovl rax, rcx
    ret
neg_bts_cmovl ENDP

neg_bt_jbe PROC FRAME
    .endprolog
    mov rax, rdx
    bt rax, rcx
    jbe neg_bt_jbe_taken
    ret
neg_bt_jbe_taken:
    not rax
    ret
neg_bt_jbe ENDP

END
