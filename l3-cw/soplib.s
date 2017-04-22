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
	movl	$24, %ecx
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
	.globl	nsleep
	.type	nsleep, @function
nsleep:
.LFB5:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movl	%edi, -36(%rbp)
	movl	%esi, -40(%rbp)
	movl	%edx, -44(%rbp)
	movl	%ecx, -48(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	-36(%rbp), %eax
	cltq
	movq	%rax, -32(%rbp)
	movl	-44(%rbp), %eax
	imull	$1000, %eax, %edx
	movl	-48(%rbp), %eax
	addl	%eax, %edx
	movl	-40(%rbp), %eax
	imull	$1000000, %eax, %eax
	addl	%edx, %eax
	cltq
	movq	%rax, -24(%rbp)
	leaq	-32(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	nanosleep@PLT
	nop
	movq	-8(%rbp), %rax
	xorq	%fs:40, %rax
	je	.L9
	call	__stack_chk_fail@PLT
.L9:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5:
	.size	nsleep, .-nsleep
	.globl	bulk_read
	.type	bulk_read, @function
bulk_read:
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
.L12:
	movq	-56(%rbp), %rdx
	movq	-48(%rbp), %rcx
	movl	-36(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	read@PLT
	movq	%rax, -8(%rbp)
	cmpq	$-1, -8(%rbp)
	jne	.L11
	call	__errno_location@PLT
	movl	(%rax), %eax
	cmpl	$4, %eax
	je	.L12
.L11:
	movq	-8(%rbp), %rax
	movl	%eax, -20(%rbp)
	cmpl	$0, -20(%rbp)
	jns	.L13
	movl	-20(%rbp), %eax
	cltq
	jmp	.L14
.L13:
	cmpl	$0, -20(%rbp)
	jne	.L15
	movq	-16(%rbp), %rax
	jmp	.L14
.L15:
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
	jne	.L12
	movq	-16(%rbp), %rax
.L14:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	bulk_read, .-bulk_read
	.globl	bulk_write
	.type	bulk_write, @function
bulk_write:
.LFB7:
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
.L18:
	movq	-56(%rbp), %rdx
	movq	-48(%rbp), %rcx
	movl	-36(%rbp), %eax
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	write@PLT
	movq	%rax, -8(%rbp)
	cmpq	$-1, -8(%rbp)
	jne	.L17
	call	__errno_location@PLT
	movl	(%rax), %eax
	cmpl	$4, %eax
	je	.L18
.L17:
	movq	-8(%rbp), %rax
	movl	%eax, -20(%rbp)
	cmpl	$0, -20(%rbp)
	jns	.L19
	movl	-20(%rbp), %eax
	cltq
	jmp	.L20
.L19:
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
	jne	.L18
	movq	-16(%rbp), %rax
.L20:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	bulk_write, .-bulk_write
	.section	.rodata
.LC3:
	.string	"socket"
.LC4:
	.string	"setsockopt"
.LC5:
	.string	"bind"
	.text
	.globl	bindinet
	.type	bindinet, @function
bindinet:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movl	%edi, %eax
	movl	%esi, -56(%rbp)
	movw	%ax, -52(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$1, -40(%rbp)
	movl	-56(%rbp), %eax
	movl	$0, %edx
	movl	%eax, %esi
	movl	$2, %edi
	call	socket@PLT
	movl	%eax, -36(%rbp)
	cmpl	$0, -36(%rbp)
	jns	.L22
	leaq	.LC3(%rip), %rdi
	call	err
.L22:
	leaq	-32(%rbp), %rax
	movl	$16, %edx
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	movw	$2, -32(%rbp)
	movzwl	-52(%rbp), %eax
	movl	%eax, %edi
	call	htons@PLT
	movw	%ax, -30(%rbp)
	movl	$0, %edi
	call	htonl@PLT
	movl	%eax, -28(%rbp)
	leaq	-40(%rbp), %rdx
	movl	-36(%rbp), %eax
	movl	$4, %r8d
	movq	%rdx, %rcx
	movl	$2, %edx
	movl	$1, %esi
	movl	%eax, %edi
	call	setsockopt@PLT
	testl	%eax, %eax
	je	.L23
	leaq	.LC4(%rip), %rdi
	call	err
.L23:
	leaq	-32(%rbp), %rax
	movq	%rax, %rcx
	movl	-36(%rbp), %eax
	movl	$16, %edx
	movq	%rcx, %rsi
	movl	%eax, %edi
	call	bind@PLT
	testl	%eax, %eax
	jns	.L24
	leaq	.LC5(%rip), %rdi
	call	err
.L24:
	movl	-36(%rbp), %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L26
	call	__stack_chk_fail@PLT
.L26:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	bindinet, .-bindinet
	.section	.rodata
.LC6:
	.string	"getaddrinfo: %s\n"
	.text
	.globl	makeaddress
	.type	makeaddress, @function
makeaddress:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$112, %rsp
	movq	%rdi, -104(%rbp)
	movq	%rsi, -112(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-80(%rbp), %rdx
	movl	$0, %eax
	movl	$6, %ecx
	movq	%rdx, %rdi
	rep stosq
	movl	$2, -76(%rbp)
	leaq	-88(%rbp), %rcx
	leaq	-80(%rbp), %rdx
	movq	-112(%rbp), %rsi
	movq	-104(%rbp), %rax
	movq	%rax, %rdi
	call	getaddrinfo@PLT
	movl	%eax, -92(%rbp)
	cmpl	$0, -92(%rbp)
	je	.L28
	movl	-92(%rbp), %eax
	movl	%eax, %edi
	call	gai_strerror@PLT
	movq	%rax, %rdx
	movq	stderr(%rip), %rax
	leaq	.LC6(%rip), %rsi
	movq	%rax, %rdi
	movl	$0, %eax
	call	fprintf@PLT
	movl	$1, %edi
	call	exit@PLT
.L28:
	movq	-88(%rbp), %rax
	movq	24(%rax), %rax
	movq	8(%rax), %rdx
	movq	(%rax), %rax
	movq	%rax, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-88(%rbp), %rax
	movq	%rax, %rdi
	call	freeaddrinfo@PLT
	movq	-32(%rbp), %rax
	movq	-24(%rbp), %rdx
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L30
	call	__stack_chk_fail@PLT
.L30:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	makeaddress, .-makeaddress
	.ident	"GCC: (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005"
	.section	.note.GNU-stack,"",@progbits
