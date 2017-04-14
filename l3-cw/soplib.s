	.file	"soplib.c"
	.section	.rodata
.LC0:
	.string	"USAGE: %s\n"
	.text
	.globl	usage
	.type	usage, @function
usage:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	stderr(%rip), %rax
	movq	-8(%rbp), %rdx
	leaq	.LC0(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	usage, .-usage
	.section	.rodata
.LC1:
	.string	"soplib.c"
.LC2:
	.string	"%s:%d\n"
	.text
	.globl	err
	.type	err, @function
err:
.LFB3:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movq	stderr(%rip), %rax
	movl	$20, %ecx
	leaq	.LC1(%rip), %rdx
	leaq	.LC2(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$1, %edi
	call	exit@PLT
	.cfi_endproc
.LFE3:
	.size	err, .-err
	.globl	sethandler
	.type	sethandler, @function
sethandler:
.LFB4:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$176, %rsp
	movq	%rdi, -168(%rbp)
	movl	%esi, -172(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-160(%rbp), %rax
	movl	$152, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	movq	-168(%rbp), %rax
	movq	%rax, -160(%rbp)
	leaq	-160(%rbp), %rcx
	movl	-172(%rbp), %eax
	movl	$0, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	sigaction@PLT
	cmpl	$-1, %eax
	jne	.L4
	movl	$-1, %eax
	jmp	.L6
.L4:
	movl	$0, %eax
.L6:
	movq	-8(%rbp), %rdx
	xorq	%fs:40, %rdx
	je	.L7
	call	__stack_chk_fail@PLT
.L7:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4:
	.size	sethandler, .-sethandler
	.globl	bulk_read
	.type	bulk_read, @function
bulk_read:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movl	%edi, -36(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movq	$0, -16(%rbp)
.L10:
	movq	-56(%rbp), %rdx
	movq	-48(%rbp), %rcx
	movl	-36(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read@PLT
	movq	%rax, -8(%rbp)
	cmpq	$-1, -8(%rbp)
	jne	.L9
	call	__errno_location@PLT
	movl	(%rax), %eax
	cmpl	$4, %eax
	je	.L10
.L9:
	movq	-8(%rbp), %rax
	movl	%eax, -20(%rbp)
	cmpl	$0, -20(%rbp)
	jns	.L11
	movl	-20(%rbp), %eax
	cltq
	jmp	.L12
.L11:
	cmpl	$0, -20(%rbp)
	jne	.L13
	movq	-16(%rbp), %rax
	jmp	.L12
.L13:
	movl	-20(%rbp), %eax
	cltq
	addq	%rax, -48(%rbp)
	movl	-20(%rbp), %eax
	cltq
	addq	%rax, -16(%rbp)
	movl	-20(%rbp), %eax
	cltq
	subq	%rax, -56(%rbp)
	cmpq	$0, -56(%rbp)
	jne	.L10
	movq	-16(%rbp), %rax
.L12:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	bulk_read, .-bulk_read
	.globl	bulk_write
	.type	bulk_write, @function
bulk_write:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movl	%edi, -36(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movq	$0, -16(%rbp)
.L16:
	movq	-56(%rbp), %rdx
	movq	-48(%rbp), %rcx
	movl	-36(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	write@PLT
	movq	%rax, -8(%rbp)
	cmpq	$-1, -8(%rbp)
	jne	.L15
	call	__errno_location@PLT
	movl	(%rax), %eax
	cmpl	$4, %eax
	je	.L16
.L15:
	movq	-8(%rbp), %rax
	movl	%eax, -20(%rbp)
	cmpl	$0, -20(%rbp)
	jns	.L17
	movl	-20(%rbp), %eax
	cltq
	jmp	.L18
.L17:
	movl	-20(%rbp), %eax
	cltq
	addq	%rax, -48(%rbp)
	movl	-20(%rbp), %eax
	cltq
	addq	%rax, -16(%rbp)
	movl	-20(%rbp), %eax
	cltq
	subq	%rax, -56(%rbp)
	cmpq	$0, -56(%rbp)
	jne	.L16
	movq	-16(%rbp), %rax
.L18:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	bulk_write, .-bulk_write
	.ident	"GCC: (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005"
	.section	.note.GNU-stack,"",@progbits
