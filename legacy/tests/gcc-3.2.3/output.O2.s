	.file	1 "output.c"
	.rdata
	.align	3
table:
	.word	0
	.word	0
	.word	0
	.word	1072693248
	.word	0
	.word	-1073479680
	.word	1413754129
	.word	1074340347
	.word	-2013235812
	.word	2117592124
	.word	-1023872167
	.word	27618847
	.globl	ftable
	.align	2
ftable:
	.word	0
	.word	1069547520
	.word	1036831949
	.word	-1027047424
	.globl	big
	.sdata
	.align	3
big:
	.dword	0x123456789abcdef
	.globl	ubig
	.align	3
ubig:
	.dword	0xfedcba9876543210
	.globl	high
	.align	2
high:
	.word	-234881024
	.globl	neg
	.align	2
neg:
	.word	-1
	.globl	text
	.align	2
text:
	.ascii	"output\n\000"
	.text
	.align	2
	.globl	masks
	.ent	masks
masks:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$3,-16			# 0xfffffffffffffff0
	and	$2,$4,$3
	li	$4,-234881024			# 0xfffffffff2000000
	.set	noreorder
	.set	nomacro
	j	$31
	or	$2,$2,$4
	.set	macro
	.set	reorder

	.end	masks
	.align	2
	.globl	compare
	.ent	compare
compare:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	j	$31
	srl	$2,$4,31
	.set	macro
	.set	reorder

	.end	compare
	.align	2
	.globl	division
	.ent	division
division:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$5,274857984			# 0x10620000
	ori	$5,$5,0x4dd3
	mult	$4,$5
	li	$2,-1840709632			# 0xffffffff92490000
	ori	$2,$2,0x2493
	sra	$6,$4,31
	mfhi	$5
	#nop
	#nop
	sra	$5,$5,6
	subu	$5,$5,$6
	mult	$4,$2
	sll	$3,$5,5
	subu	$3,$3,$5
	sll	$3,$3,2
	addu	$3,$3,$5
	sll	$3,$3,3
	subu	$3,$4,$3
	mfhi	$2
	#nop
	#nop
	addu	$2,$2,$4
	sra	$2,$2,2
	subu	$2,$2,$6
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,$3
	.set	macro
	.set	reorder

	.end	division
	.align	2
	.globl	wide
	.ent	wide
wide:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	mult	$4,$7
	sll	$2,$5,29
	srl	$10,$4,3
	or	$10,$10,$2
	sra	$11,$5,3
	mflo	$8
	#nop
	#nop
	multu	$4,$6
	mfhi	$3
	mflo	$2
	#nop
	#nop
	addu	$8,$8,$3
	addu	$2,$2,$10
	mult	$6,$5
	li	$5,-1
	li	$4,0
	mflo	$6
	#nop
	#nop
	addu	$3,$8,$6
	addu	$3,$3,$11
	sltu	$6,$2,$10
	addu	$3,$3,$6
	addu	$2,$2,$4
	sltu	$6,$2,$4
	addu	$3,$3,$5
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$3,$3,$6
	.set	macro
	.set	reorder

	.end	wide
	.align	2
	.globl	shifted
	.ent	shifted
shifted:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sll	$3,$4,8
	move	$2,$0
	li	$5,255
	li	$4,0
	or	$2,$2,$4
	.set	noreorder
	.set	nomacro
	j	$31
	or	$3,$3,$5
	.set	macro
	.set	reorder

	.end	shifted
	.align	2
	.globl	doubles
	.ent	doubles
doubles:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	move	$6,$4
	sw	$31,16($sp)
	.set	noreorder
	.set	nomacro
	jal	dpadd
	move	$7,$5
	.set	macro
	.set	reorder

	li.d	$6,5.00000000000000000000e-1
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	dpadd
	move	$5,$3
	.set	macro
	.set	reorder

	li.d	$6,3.14159265358979000737e0
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	dpsub
	move	$5,$3
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	doubles
	.align	2
	.globl	floats
	.ent	floats
floats:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	li.s	$5,1.50000000000000000000e0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	fpmul
	li.s	$5,1.00000001490116119385e-1
	.set	noreorder
	.set	nomacro
	jal	fpadd
	move	$4,$2
	.set	macro
	.set	reorder

	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	floats
	.align	2
	.globl	truncated
	.ent	truncated
truncated:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	sw	$16,16($sp)
	move	$17,$5
	move	$16,$4
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	dptoli
	sw	$18,24($sp)
	.set	macro
	.set	reorder

	move	$5,$17
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	dptofp
	move	$18,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	fptosi
	move	$4,$2
	.set	macro
	.set	reorder

	addu	$18,$18,$2
	move	$2,$18
	lw	$31,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	truncated
	.align	2
	.globl	widened
	.ent	widened
widened:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x800d0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$16,16($sp)
	move	$16,$5
	sw	$31,28($sp)
	sw	$19,24($sp)
	.set	noreorder
	.set	nomacro
	jal	litodp
	sw	$18,20($sp)
	.set	macro
	.set	reorder

	move	$4,$16
	move	$18,$2
	.set	noreorder
	.set	nomacro
	jal	litodp
	move	$19,$3
	.set	macro
	.set	reorder

	move	$4,$2
	li.d	$6,4.29496729600000000000e9
	.set	noreorder
	.set	nomacro
	bltz	$16,$L11
	move	$5,$3
	.set	macro
	.set	reorder

	move	$4,$18
$L12:
	move	$5,$19
	move	$6,$2
	.set	noreorder
	.set	nomacro
	jal	dpadd
	move	$7,$3
	.set	macro
	.set	reorder

	lw	$31,28($sp)
	lw	$19,24($sp)
	lw	$18,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

$L11:
	jal	dpadd
	.set	noreorder
	.set	nomacro
	j	$L12
	move	$4,$18
	.set	macro
	.set	reorder

	.end	widened
	.align	2
	.globl	pick
	.ent	pick
pick:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	sw	$31,32($sp)
	move	$16,$4
	move	$17,$5
	move	$18,$6
	.set	noreorder
	.set	nomacro
	jal	dpcmp
	move	$19,$7
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bltz	$2,$L15
	li	$3,1			# 0x1
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$17
	move	$6,$18
	.set	noreorder
	.set	nomacro
	jal	dpcmp
	move	$7,$19
	.set	macro
	.set	reorder

	sltu	$3,$0,$2
	addu	$3,$3,2
$L15:
	lw	$31,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	move	$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,40
	.set	macro
	.set	reorder

	.end	pick
	.align	2
	.globl	bits
	.ent	bits
bits:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$5,8($4)
	li	$2,-8			# 0xfffffffffffffff8
	and	$5,$5,$2
	ori	$5,$5,0x5
	li	$2,-249			# 0xffffffffffffff07
	and	$5,$5,$2
	lh	$6,2($4)
	lb	$2,0($4)
	ori	$5,$5,0x30
	lw	$7,4($4)
	addu	$2,$2,$6
	srl	$3,$5,3
	addu	$2,$2,$7
	andi	$3,$3,0x1f
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	j	$31
	sw	$5,8($4)
	.set	macro
	.set	reorder

	.end	bits
	.align	2
	.globl	frame
	.ent	frame
frame:
	.frame	$sp,70032,$31		# vars= 70000, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	li	$12,65536			# 0x10000
	ori	$12,$12,0x1190
	li	$13,65536			# 0x10000
	subu	$sp,$sp,$12
	ori	$13,$13,0x1188
	addu	$13,$13,$sp
	sw	$31,0($13)
	.set	noreorder
	.set	nomacro
	blez	$4,$L29
	move	$5,$0
	.set	macro
	.set	reorder

	addu	$6,$sp,24
	move	$3,$6
$L26:
	sb	$5,0($3)
	addu	$5,$5,1
	slt	$2,$5,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L26
	addu	$3,$3,3
	.set	macro
	.set	reorder

$L28:
	addu	$2,$6,$4
	lb	$5,0($2)
	li.d	$6,1.50000000000000000000e0
	lw	$2,big
	lw	$3,big+4
	#nop
	sw	$2,16($sp)
	sw	$3,20($sp)
	jal	ext
	li	$12,65536			# 0x10000
	ori	$12,$12,0x1190
	addu	$13,$12,$sp
	lw	$31,-8($13)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,$12
	.set	macro
	.set	reorder

$L29:
	.set	noreorder
	.set	nomacro
	j	$L28
	addu	$6,$sp,24
	.set	macro
	.set	reorder

	.end	frame
	.align	2
	.globl	cases
	.ent	cases
cases:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,2			# 0x2
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L30
	li	$3,35			# 0x23
	.set	macro
	.set	reorder

	slt	$2,$4,3
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L40
	li	$2,4			# 0x4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L30
	li	$3,10			# 0xa
	.set	macro
	.set	reorder

	li	$3,20			# 0x14
	li	$2,1			# 0x1
$L41:
	beq	$4,$2,$L30
	subu	$3,$0,$4
$L30:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$3
	.set	macro
	.set	reorder

$L40:
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L30
	li	$3,59			# 0x3b
	.set	macro
	.set	reorder

	slt	$2,$4,4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L30
	li	$3,47			# 0x2f
	.set	macro
	.set	reorder

	li	$3,61952			# 0xf200
	.set	noreorder
	.set	nomacro
	j	$L41
	li	$2,1000			# 0x3e8
	.set	macro
	.set	reorder

	.end	cases
