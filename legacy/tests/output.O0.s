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
	.ent	masks
masks:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
	sw	$fp,0($sp)
	move	$fp,$sp
	sw	$4,8($fp)
	lw	$2,8($fp)
	li	$4,-16			# 0xfffffff0
	and	$3,$2,$4
	li	$2,-234881024			# 0xf2000000
	or	$3,$3,$2
	move	$2,$3
	j	$L2
$L2:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	masks
	.align	2
	.globl	compare
	.ent	compare
compare:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
	sw	$fp,0($sp)
	move	$fp,$sp
	sw	$4,8($fp)
	lw	$2,8($fp)
	srl	$3,$2,31
	move	$2,$3
	j	$L3
$L3:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	compare
	.align	2
	.globl	division
	.ent	division
division:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
	sw	$fp,0($sp)
	move	$fp,$sp
	sw	$4,8($fp)
	lw	$2,8($fp)
	li	$4,-1840709632			# 0x92490000
	ori	$4,$4,0x2493
	mult	$2,$4
	mfhi	$3
	addu	$4,$3,$2
	sra	$3,$4,2
	sra	$2,$2,31
	subu	$3,$3,$2
	lw	$2,8($fp)
	li	$5,274857984			# 0x10620000
	ori	$5,$5,0x4dd3
	mult	$2,$5
	mfhi	$4
	sra	$5,$4,6
	sra	$6,$2,31
	subu	$4,$5,$6
	move	$6,$4
	sll	$5,$6,5
	subu	$5,$5,$4
	sll	$6,$5,2
	addu	$6,$6,$4
	sll	$4,$6,3
	subu	$2,$2,$4
	addu	$3,$3,$2
	move	$2,$3
	j	$L4
$L4:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	division
	.align	2
	.globl	wide
	.ent	wide
wide:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
	sw	$fp,0($sp)
	move	$fp,$sp
	sw	$4,8($fp)
	sw	$5,12($fp)
	sw	$6,16($fp)
	sw	$7,20($fp)
	lw	$2,8($fp)
	lw	$3,16($fp)
	multu	$2,$3
	mfhi	$5
	mflo	$4
	lw	$2,8($fp)
	lw	$3,20($fp)
	mult	$2,$3
	mflo	$2
	addu	$5,$5,$2
	lw	$2,16($fp)
	lw	$3,12($fp)
	mult	$2,$3
	mflo	$2
	addu	$5,$5,$2
	lw	$8,8($fp)
	lw	$9,12($fp)
	srl	$6,$8,3
	sll	$2,$9,29
	or	$6,$6,$2
	sra	$7,$9,3
	addu	$4,$4,$6
	sltu	$3,$4,$6
	addu	$5,$5,$7
	addu	$5,$5,$3
	li	$6,0
	li	$7,-1
	addu	$4,$4,$6
	sltu	$2,$4,$6
	addu	$5,$5,$7
	addu	$5,$5,$2
	move	$2,$4
	move	$3,$5
	j	$L5
$L5:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	wide
	.align	2
	.globl	shifted
	.ent	shifted
shifted:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
	sw	$fp,0($sp)
	move	$fp,$sp
	sw	$4,8($fp)
	sw	$5,12($fp)
	lw	$6,8($fp)
	lw	$7,12($fp)
	sll	$5,$6,8
	move	$4,$0
	li	$2,0
	li	$3,255
	or	$4,$4,$2
	or	$5,$5,$3
	move	$2,$4
	move	$3,$5
	j	$L6
$L6:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	shifted
	.align	2
	.globl	doubles
	.ent	doubles
doubles:
	.frame	$fp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0xc0030000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	move	$fp,$sp
	sw	$4,32($fp)
	sw	$5,36($fp)
	lw	$16,32($fp)
	lw	$17,36($fp)
	move	$4,$16
	move	$5,$17
	move	$6,$16
	move	$7,$17
	jal	__adddf3
	move	$4,$2
	move	$5,$3
	li.d	$6,5.00000000000000000000e-1
	jal	__adddf3
	move	$4,$2
	move	$5,$3
	lw	$6,table+24
	lw	$7,table+28
	jal	__subdf3
	move	$4,$2
	move	$5,$3
	move	$2,$4
	move	$3,$5
	j	$L7
$L7:
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	doubles
	.align	2
	.globl	floats
	.ent	floats
floats:
	.frame	$fp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,20($sp)
	sw	$fp,16($sp)
	move	$fp,$sp
	sw	$4,24($fp)
	lw	$4,24($fp)
	li.s	$5,1.50000000000000000000e0
	jal	__mulsf3
	move	$4,$2
	li.s	$5,1.00000001490116119385e-1
	jal	__addsf3
	move	$3,$2
	move	$2,$3
	j	$L8
$L8:
	move	$sp,$fp
	lw	$31,20($sp)
	lw	$fp,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	floats
	.align	2
	.globl	truncated
	.ent	truncated
truncated:
	.frame	$fp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0xc0010000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,24($sp)
	sw	$fp,20($sp)
	sw	$16,16($sp)
	move	$fp,$sp
	sw	$4,32($fp)
	sw	$5,36($fp)
	lw	$4,32($fp)
	lw	$5,36($fp)
	jal	__fixdfsi
	move	$16,$2
	lw	$4,32($fp)
	lw	$5,36($fp)
	jal	__truncdfsf2
	move	$4,$2
	jal	__fixsfsi
	addu	$16,$16,$2
	move	$2,$16
	j	$L9
$L9:
	move	$sp,$fp
	lw	$31,24($sp)
	lw	$fp,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	truncated
	.align	2
	.globl	widened
	.ent	widened
widened:
	.frame	$fp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0xc00f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	sw	$19,28($sp)
	sw	$18,24($sp)
	sw	$17,20($sp)
	sw	$16,16($sp)
	move	$fp,$sp
	sw	$4,40($fp)
	sw	$5,44($fp)
	lw	$4,40($fp)
	jal	__floatsidf
	move	$16,$2
	move	$17,$3
	lw	$4,44($fp)
	jal	__floatsidf
	move	$18,$2
	move	$19,$3
	lw	$2,44($fp)
	bgez	$2,$L11
	move	$4,$18
	move	$5,$19
	li.d	$6,4.29496729600000000000e9
	jal	__adddf3
	move	$18,$2
	move	$19,$3
$L11:
	move	$4,$16
	move	$5,$17
	move	$6,$18
	move	$7,$19
	jal	__adddf3
	move	$4,$2
	move	$5,$3
	move	$2,$4
	move	$3,$5
	j	$L10
$L10:
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,40
	j	$31
	.end	widened
	.align	2
	.globl	pick
	.ent	pick
pick:
	.frame	$fp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0xc0010000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,24($sp)
	sw	$fp,20($sp)
	sw	$16,16($sp)
	move	$fp,$sp
	sw	$4,32($fp)
	sw	$5,36($fp)
	sw	$6,40($fp)
	sw	$7,44($fp)
	lw	$4,32($fp)
	lw	$5,36($fp)
	lw	$6,40($fp)
	lw	$7,44($fp)
	jal	__ltdf2
	bgez	$2,$L13
	li	$16,1			# 0x1
	j	$L14
$L13:
	lw	$4,32($fp)
	lw	$5,36($fp)
	lw	$6,40($fp)
	lw	$7,44($fp)
	jal	__eqdf2
	bne	$2,$0,$L15
	li	$16,2			# 0x2
	j	$L14
$L15:
	li	$16,3			# 0x3
$L16:
$L14:
	move	$2,$16
	j	$L12
$L12:
	move	$sp,$fp
	lw	$31,24($sp)
	lw	$fp,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	pick
	.align	2
	.globl	bits
	.ent	bits
bits:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
	sw	$fp,0($sp)
	move	$fp,$sp
	sw	$4,8($fp)
	lw	$2,8($fp)
	lw	$3,8($2)
	li	$4,-8			# 0xfffffff8
	and	$3,$3,$4
	ori	$3,$3,0x5
	sw	$3,8($2)
	lw	$2,8($fp)
	lw	$3,8($fp)
	lw	$4,8($3)
	andi	$3,$4,0x7
	addu	$4,$3,1
	andi	$5,$4,0x1f
	sll	$3,$5,3
	lw	$4,8($2)
	li	$5,-249			# 0xffffff07
	and	$4,$4,$5
	or	$4,$4,$3
	sw	$4,8($2)
	lw	$2,8($fp)
	lb	$3,0($2)
	lw	$2,8($fp)
	lh	$4,2($2)
	addu	$3,$3,$4
	lw	$2,8($fp)
	lw	$4,4($2)
	addu	$3,$3,$4
	lw	$2,8($fp)
	lw	$4,8($2)
	srl	$2,$4,3
	andi	$4,$2,0x1f
	addu	$3,$3,$4
	move	$2,$3
	j	$L17
$L17:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	bits
	.align	2
	.globl	frame
	.ent	frame
frame:
	.frame	$fp,70040,$31		# vars= 70008, regs= 2/0, args= 24, extra= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	li	$12,65536			# 0x10000
	ori	$12,$12,0x1198
	subu	$sp,$sp,$12
	addu	$13,$12,$sp
	sw	$31,-4($13)
	sw	$fp,-8($13)
	move	$fp,$sp
	sw	$4,70040($fp)
	sw	$0,70024($fp)
$L19:
	lw	$2,70024($fp)
	lw	$3,70040($fp)
	slt	$2,$2,$3
	bne	$2,$0,$L22
	j	$L20
$L22:
	lw	$2,70024($fp)
	move	$4,$2
	sll	$3,$4,1
	addu	$3,$3,$2
	addu	$4,$fp,24
	addu	$2,$4,$3
	lbu	$3,70024($fp)
	sb	$3,0($2)
$L21:
	lw	$2,70024($fp)
	addu	$3,$2,1
	sw	$3,70024($fp)
	j	$L19
$L20:
	lw	$2,70040($fp)
	addu	$4,$fp,24
	addu	$3,$4,$2
	lb	$2,0($3)
	lw	$4,big
	lw	$5,big+4
	sw	$4,16($sp)
	sw	$5,20($sp)
	lw	$4,70040($fp)
	move	$5,$2
	li.d	$6,1.50000000000000000000e0
	jal	ext
	move	$3,$2
	move	$2,$3
	j	$L18
$L18:
	li	$12,65536			# 0x10000
	ori	$12,$12,0x1198
	move	$sp,$fp
	addu	$13,$12,$sp
	lw	$31,-4($13)
	lw	$fp,-8($13)
	addu	$sp,$sp,$12
	j	$31
	.end	frame
	.align	2
	.globl	cases
	.ent	cases
cases:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
	sw	$fp,0($sp)
	move	$fp,$sp
	sw	$4,8($fp)
	lw	$2,8($fp)
	li	$3,2			# 0x2
	beq	$2,$3,$L27
	slt	$3,$2,3
	beq	$3,$0,$L33
	beq	$2,$0,$L25
	li	$3,1			# 0x1
	beq	$2,$3,$L26
	j	$L31
$L33:
	li	$3,4			# 0x4
	beq	$2,$3,$L29
	slt	$3,$2,4
	bne	$3,$0,$L28
	li	$3,1000			# 0x3e8
	beq	$2,$3,$L30
	j	$L31
$L25:
	li	$2,10			# 0xa
	j	$L23
$L26:
	li	$2,20			# 0x14
	j	$L23
$L27:
	li	$2,35			# 0x23
	j	$L23
$L28:
	li	$2,47			# 0x2f
	j	$L23
$L29:
	li	$2,59			# 0x3b
	j	$L23
$L30:
	li	$2,61952			# 0xf200
	j	$L23
$L31:
	lw	$2,8($fp)
	subu	$3,$0,$2
	move	$2,$3
	j	$L23
$L24:
$L23:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	cases
