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
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
	sw	$fp,0($sp)
	move	$fp,$sp
	sw	$4,8($fp)
	lw	$3,8($fp)
	li	$2,-16			# 0xfffffffffffffff0
	and	$2,$3,$2
	li	$3,-234881024			# 0xfffffffff2000000
	or	$2,$2,$3
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
	srl	$2,$2,31
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
	lw	$3,8($fp)
	li	$2,-1840709632			# 0xffffffff92490000
	ori	$2,$2,0x2493
	mult	$3,$2
	mfhi	$2
	addu	$2,$2,$3
	sra	$4,$2,2
	sra	$2,$3,31
	subu	$5,$4,$2
	lw	$4,8($fp)
	li	$2,274857984			# 0x10620000
	ori	$2,$2,0x4dd3
	mult	$4,$2
	mfhi	$2
	sra	$3,$2,6
	sra	$2,$4,31
	subu	$3,$3,$2
	move	$2,$3
	sll	$2,$2,5
	subu	$2,$2,$3
	sll	$2,$2,2
	addu	$2,$2,$3
	sll	$2,$2,3
	subu	$2,$4,$2
	addu	$5,$5,$2
	move	$2,$5
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
	lw	$3,8($fp)
	lw	$2,16($fp)
	multu	$3,$2
	mfhi	$5
	mflo	$4
	lw	$3,8($fp)
	lw	$2,20($fp)
	mult	$3,$2
	mflo	$3
	move	$2,$5
	addu	$2,$2,$3
	lw	$6,16($fp)
	lw	$3,12($fp)
	mult	$6,$3
	mflo	$3
	addu	$2,$2,$3
	move	$5,$2
	lw	$2,8($fp)
	lw	$3,12($fp)
	srl	$2,$2,3
	sll	$6,$3,29
	or	$2,$2,$6
	sra	$3,$3,3
	addu	$4,$4,$2
	sltu	$6,$4,$2
	addu	$5,$5,$3
	addu	$5,$5,$6
	li	$3,-1
	li	$2,0
	addu	$4,$4,$2
	sltu	$6,$4,$2
	addu	$5,$5,$3
	addu	$5,$5,$6
	move	$2,$4
	move	$3,$5
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
	lw	$2,8($fp)
	lw	$3,12($fp)
	sll	$3,$2,8
	move	$2,$0
	li	$5,255
	li	$4,0
	or	$2,$2,$4
	or	$3,$3,$5
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	shifted
	.align	2
	.globl	doubles
	.ent	doubles
doubles:
	.frame	$fp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
	sw	$31,20($sp)
	sw	$fp,16($sp)
	move	$fp,$sp
	sw	$4,24($fp)
	sw	$5,28($fp)
	lw	$2,24($fp)
	lw	$3,28($fp)
	move	$4,$2
	move	$5,$3
	move	$6,$2
	move	$7,$3
	jal	dpadd
	move	$4,$2
	move	$5,$3
	li.d	$6,5.00000000000000000000e-1
	jal	dpadd
	move	$4,$2
	move	$5,$3
	lw	$6,table+24
	lw	$7,table+28
	jal	dpsub
	move	$sp,$fp
	lw	$31,20($sp)
	lw	$fp,16($sp)
	addu	$sp,$sp,24
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
	jal	fpmul
	move	$4,$2
	li.s	$5,1.00000001490116119385e-1
	jal	fpadd
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
	jal	dptoli
	move	$16,$2
	lw	$4,32($fp)
	lw	$5,36($fp)
	jal	dptofp
	move	$4,$2
	jal	fptosi
	addu	$16,$16,$2
	move	$2,$16
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
	.frame	$fp,40,$31		# vars= 16, regs= 2/0, args= 16, extra= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	sw	$4,40($fp)
	sw	$5,44($fp)
	lw	$4,40($fp)
	jal	litodp
	sw	$2,16($fp)
	sw	$3,20($fp)
	lw	$4,44($fp)
	jal	litodp
	sw	$2,24($fp)
	sw	$3,28($fp)
	lw	$2,44($fp)
	bgez	$2,$L10
	lw	$4,24($fp)
	lw	$5,28($fp)
	li.d	$6,4.29496729600000000000e9
	jal	dpadd
	sw	$2,24($fp)
	sw	$3,28($fp)
$L10:
	lw	$4,16($fp)
	lw	$5,20($fp)
	lw	$6,24($fp)
	lw	$7,28($fp)
	jal	dpadd
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addu	$sp,$sp,40
	j	$31
	.end	widened
	.align	2
	.globl	pick
	.ent	pick
pick:
	.frame	$fp,32,$31		# vars= 8, regs= 2/0, args= 16, extra= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	sw	$4,32($fp)
	sw	$5,36($fp)
	sw	$6,40($fp)
	sw	$7,44($fp)
	lw	$4,32($fp)
	lw	$5,36($fp)
	lw	$6,40($fp)
	lw	$7,44($fp)
	jal	dpcmp
	bltz	$2,$L14
	j	$L12
$L14:
	li	$2,1			# 0x1
	sw	$2,16($fp)
	j	$L13
$L12:
	lw	$4,32($fp)
	lw	$5,36($fp)
	lw	$6,40($fp)
	lw	$7,44($fp)
	jal	dpcmp
	beq	$2,$0,$L17
	j	$L15
$L17:
	li	$2,2			# 0x2
	sw	$2,16($fp)
	j	$L13
$L15:
	li	$2,3			# 0x3
	sw	$2,16($fp)
$L13:
	lw	$2,16($fp)
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
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
	lw	$4,8($fp)
	lw	$3,8($4)
	li	$2,-8			# 0xfffffffffffffff8
	and	$2,$3,$2
	ori	$2,$2,0x5
	sw	$2,8($4)
	lw	$5,8($fp)
	lw	$2,8($fp)
	lw	$2,8($2)
	andi	$2,$2,0x7
	addu	$2,$2,1
	andi	$2,$2,0x1f
	sll	$4,$2,3
	lw	$3,8($5)
	li	$2,-249			# 0xffffffffffffff07
	and	$2,$3,$2
	or	$2,$2,$4
	sw	$2,8($5)
	lw	$2,8($fp)
	lb	$2,0($2)
	lw	$3,8($fp)
	lh	$3,2($3)
	addu	$2,$2,$3
	lw	$3,8($fp)
	lw	$3,4($3)
	addu	$2,$2,$3
	lw	$3,8($fp)
	lw	$3,8($3)
	srl	$3,$3,3
	andi	$3,$3,0x1f
	addu	$2,$2,$3
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
	li	$13,65536			# 0x10000
	ori	$13,$13,0x1194
	addu	$13,$13,$sp
	sw	$31,0($13)
	sw	$fp,-4($13)
	move	$fp,$sp
	sw	$4,70040($fp)
	sw	$0,70024($fp)
$L20:
	lw	$2,70024($fp)
	lw	$3,70040($fp)
	slt	$2,$2,$3
	bne	$2,$0,$L23
	j	$L21
$L23:
	lw	$3,70024($fp)
	move	$2,$3
	sll	$2,$2,1
	addu	$2,$2,$3
	addu	$3,$fp,24
	addu	$3,$2,$3
	lbu	$2,70024($fp)
	sb	$2,0($3)
	lw	$2,70024($fp)
	addu	$2,$2,1
	sw	$2,70024($fp)
	j	$L20
$L21:
	lw	$3,70040($fp)
	addu	$2,$fp,24
	addu	$2,$2,$3
	lb	$5,0($2)
	lw	$2,big
	lw	$3,big+4
	sw	$2,16($sp)
	sw	$3,20($sp)
	lw	$4,70040($fp)
	li.d	$6,1.50000000000000000000e0
	jal	ext
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
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,16
	sw	$fp,8($sp)
	move	$fp,$sp
	sw	$4,16($fp)
	lw	$2,16($fp)
	sw	$2,4($fp)
	li	$2,2			# 0x2
	lw	$3,4($fp)
	beq	$3,$2,$L28
	lw	$3,4($fp)
	slt	$2,$3,3
	beq	$2,$0,$L34
	lw	$2,4($fp)
	beq	$2,$0,$L26
	li	$2,1			# 0x1
	lw	$3,4($fp)
	beq	$3,$2,$L27
	j	$L32
$L34:
	li	$2,4			# 0x4
	lw	$3,4($fp)
	beq	$3,$2,$L30
	lw	$3,4($fp)
	slt	$2,$3,4
	bne	$2,$0,$L29
	li	$2,1000			# 0x3e8
	lw	$3,4($fp)
	beq	$3,$2,$L31
	j	$L32
$L26:
	li	$2,10			# 0xa
	sw	$2,0($fp)
	j	$L24
$L27:
	li	$3,20			# 0x14
	sw	$3,0($fp)
	j	$L24
$L28:
	li	$2,35			# 0x23
	sw	$2,0($fp)
	j	$L24
$L29:
	li	$3,47			# 0x2f
	sw	$3,0($fp)
	j	$L24
$L30:
	li	$2,59			# 0x3b
	sw	$2,0($fp)
	j	$L24
$L31:
	li	$3,61952			# 0xf200
	sw	$3,0($fp)
	j	$L24
$L32:
	lw	$2,16($fp)
	subu	$2,$0,$2
	sw	$2,0($fp)
$L24:
	lw	$2,0($fp)
	move	$sp,$fp
	lw	$fp,8($sp)
	addu	$sp,$sp,16
	j	$31
	.end	cases
