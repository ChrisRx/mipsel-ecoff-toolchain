	.file	1 "output.c"
gcc2_compiled.:
__gnu_compiled_c:
	.rdata
	.align	3
table:
	.word	0x00000000		# 0
	.word	0x00000000
	.word	0x00000000		# 1
	.word	0x3ff00000
	.word	0x00000000		# -2.5
	.word	0xc0040000
	.word	0x54442d11		# 3.1415926535897900074
	.word	0x400921fb
	.word	0x8800759c		# 1.0000000000000000525e+300
	.word	0x7e37e43c
	.word	0xc2f8f359		# 1.0000000000000000251e-300
	.word	0x01a56e1f
	.globl	ftable
	.align	2
ftable:
	.word	0x00000000		# 0 (float)
	.word	0x3fc00000		# 1.5 (float)
	.word	0x3dcccccd		# 0.10000000149 (float)
	.word	0xc2c88000		# -100.25 (float)
	.globl	big
	.sdata
	.align	3
big:
	.word	-1985229329
	.word	19088743
	.globl	ubig
	.align	3
ubig:
	.word	1985229328
	.word	-19088744
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
	.text
	.ent	masks
masks:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,-16			# 0xfffffff0
	and	$4,$4,$2
	li	$2,-234881024			# 0xf2000000
	.set	noreorder
	.set	nomacro
	j	$31
	or	$2,$4,$2
	.set	macro
	.set	reorder

	.end	masks
	.align	2
	.globl	compare
	.text
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
	.text
	.ent	division
division:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,-1840709632			# 0x92490000
	ori	$2,$2,0x2493
	mult	$4,$2
	mfhi	$2
	#nop
	li	$5,274857984			# 0x10620000
	ori	$5,$5,0x4dd3
	mult	$4,$5
	sra	$6,$4,31
	addu	$2,$2,$4
	sra	$2,$2,2
	subu	$2,$2,$6
	mfhi	$5
	#nop
	#nop
	sra	$5,$5,6
	subu	$5,$5,$6
	sll	$3,$5,5
	subu	$3,$3,$5
	sll	$3,$3,2
	addu	$3,$3,$5
	sll	$3,$3,3
	subu	$4,$4,$3
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,$4
	.set	macro
	.set	reorder

	.end	division
	.align	2
	.globl	wide
	.text
	.ent	wide
wide:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	multu	$4,$6
	mfhi	$3
	mflo	$2
	#nop
	#nop
	mult	$4,$7
	mflo	$8
	#nop
	#nop
	mult	$6,$5
	addu	$3,$3,$8
	srl	$4,$4,3
	mflo	$6
	#nop
	#nop
	addu	$3,$3,$6
	sll	$6,$5,29
	or	$4,$4,$6
	sra	$5,$5,3
	addu	$2,$2,$4
	sltu	$7,$2,$4
	addu	$3,$3,$5
	addu	$3,$3,$7
	li	$4,0
	li	$5,-1
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
	.text
	.ent	shifted
shifted:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	sll	$3,$4,8
	move	$2,$0
	li	$4,0
	li	$5,255
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
	.text
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
	jal	__adddf3
	move	$7,$5
	.set	macro
	.set	reorder

	move	$4,$2
	li.d	$6,5.00000000000000000000e-1
	.set	noreorder
	.set	nomacro
	jal	__adddf3
	move	$5,$3
	.set	macro
	.set	reorder

	move	$4,$2
	lw	$6,table+24
	lw	$7,table+28
	.set	noreorder
	.set	nomacro
	jal	__subdf3
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
	.text
	.ent	floats
floats:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	li.s	$5,1.50000000000000000000e0
	subu	$sp,$sp,24
	sw	$31,16($sp)
	jal	__mulsf3
	li.s	$5,1.00000001490116119385e-1
	.set	noreorder
	.set	nomacro
	jal	__addsf3
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
	.text
	.ent	truncated
truncated:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$17,20($sp)
	sw	$16,16($sp)
	move	$16,$4
	move	$17,$5
	move	$4,$16
	move	$5,$17
	sw	$31,28($sp)
	.set	noreorder
	.set	nomacro
	jal	__fixdfsi
	sw	$18,24($sp)
	.set	macro
	.set	reorder

	move	$4,$16
	move	$5,$17
	.set	noreorder
	.set	nomacro
	jal	__truncdfsf2
	move	$18,$2
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__fixsfsi
	move	$4,$2
	.set	macro
	.set	reorder

	addu	$2,$18,$2
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
	.text
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
	jal	__floatsidf
	sw	$18,20($sp)
	.set	macro
	.set	reorder

	move	$4,$16
	move	$18,$2
	.set	noreorder
	.set	nomacro
	jal	__floatsidf
	move	$19,$3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$16,$L12
	move	$4,$18
	.set	macro
	.set	reorder

	li.d	$6,4.29496729600000000000e9
	move	$4,$2
	.set	noreorder
	.set	nomacro
	jal	__adddf3
	move	$5,$3
	.set	macro
	.set	reorder

	move	$4,$18
$L12:
	move	$5,$19
	move	$6,$2
	.set	noreorder
	.set	nomacro
	jal	__adddf3
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

	.end	widened
	.align	2
	.globl	pick
	.text
	.ent	pick
pick:
	.frame	$sp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0x800f0000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$19,28($sp)
	sw	$18,24($sp)
	move	$18,$4
	move	$19,$5
	move	$4,$18
	move	$5,$19
	sw	$17,20($sp)
	sw	$16,16($sp)
	move	$16,$6
	move	$17,$7
	move	$6,$16
	sw	$31,32($sp)
	.set	noreorder
	.set	nomacro
	jal	__ltdf2
	move	$7,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bgez	$2,$L14
	move	$4,$18
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	j	$L15
	li	$3,1			# 0x1
	.set	macro
	.set	reorder

$L14:
	move	$5,$19
	move	$6,$16
	.set	noreorder
	.set	nomacro
	jal	__eqdf2
	move	$7,$17
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L15
	li	$3,3			# 0x3
	.set	macro
	.set	reorder

	li	$3,2			# 0x2
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
	.text
	.ent	bits
bits:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$3,-8			# 0xfffffff8
	lw	$2,8($4)
	lh	$5,2($4)
	lw	$6,4($4)
	and	$2,$2,$3
	ori	$2,$2,0x5
	li	$3,-249			# 0xffffff07
	and	$2,$2,$3
	ori	$2,$2,0x30
	sw	$2,8($4)
	srl	$2,$2,3
	lb	$3,0($4)
	andi	$2,$2,0x1f
	addu	$3,$3,$5
	addu	$3,$3,$6
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$3,$2
	.set	macro
	.set	reorder

	.end	bits
	.align	2
	.globl	frame
	.text
	.ent	frame
frame:
	.frame	$sp,70032,$31		# vars= 70000, regs= 1/0, args= 24, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	li	$12,65536			# 0x10000
	ori	$12,$12,0x1190
	subu	$sp,$sp,$12
	addu	$13,$12,$sp
	sw	$31,-8($13)
	move	$3,$0
	.set	noreorder
	.set	nomacro
	blez	$4,$L21
	addu	$6,$sp,24
	.set	macro
	.set	reorder

	move	$5,$6
$L23:
	sb	$3,0($5)
	addu	$3,$3,1
	slt	$2,$3,$4
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L23
	addu	$5,$5,3
	.set	macro
	.set	reorder

$L21:
	lw	$2,big
	lw	$3,big+4
	addu	$6,$6,$4
	sw	$2,16($sp)
	sw	$3,20($sp)
	lb	$5,0($6)
	li.d	$6,1.50000000000000000000e0
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

	.end	frame
	.align	2
	.globl	cases
	.text
	.ent	cases
cases:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,2			# 0x2
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L29
	slt	$2,$4,3
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L35
	li	$2,4			# 0x4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L27
	li	$2,1			# 0x1
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L28
	subu	$2,$0,$4
	.set	macro
	.set	reorder

	j	$L37
$L35:
	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L31
	slt	$2,$4,4
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L30
	li	$2,1000			# 0x3e8
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	beq	$4,$2,$L32
	subu	$2,$0,$4
	.set	macro
	.set	reorder

	j	$L37
$L27:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,10			# 0xa
	.set	macro
	.set	reorder

$L28:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,20			# 0x14
	.set	macro
	.set	reorder

$L29:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,35			# 0x23
	.set	macro
	.set	reorder

$L30:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,47			# 0x2f
	.set	macro
	.set	reorder

$L31:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,59			# 0x3b
	.set	macro
	.set	reorder

$L32:
	.set	noreorder
	.set	nomacro
	j	$31
	li	$2,61952			# 0xf200
	.set	macro
	.set	reorder

$L37:
	j	$31
	.end	cases
