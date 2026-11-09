	.file	1 "output.cc"
gcc2_compiled.:
__gnu_compiled_cplusplus:
	.sdata
	.align	2
$LC0:
	.ascii	"shape\000"
	.align	2
$LC1:
	.ascii	"rect\000"
	.align	2
$LC2:
	.ascii	"square\000"
	.align	2
$LC3:
	.ascii	"labeled\000"
	.globl	first
	.align	2
first:
	.space	4
	.globl	second
	.align	2
second:
	.space	4
	.text
	.align	2
	.text
$LFB1:
	.ent	swap_sum__FRiT0
swap_sum__FRiT0:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$2,0($5)
	lw	$3,0($4)
	sw	$2,0($4)
	sw	$3,0($5)
	lw	$2,0($4)
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$2,$2,$3
	.set	macro
	.set	reorder

	.end	swap_sum__FRiT0
$LFE1:
	.align	2
	.globl	total__FRCQ28geometry5Shape
	.text
$LFB2:
	.ent	total__FRCQ28geometry5Shape
total__FRCQ28geometry5Shape:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
$LCFI0:
	sw	$31,16($sp)
$LCFI1:
	lw	$3,0($4)
	#nop
	lh	$5,16($3)
	lw	$2,20($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$4,$5
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

	.end	total__FRCQ28geometry5Shape
$LFE2:
	.sdata
	.align	2
$LC4:
	.ascii	"%s %d\n\000"
	.align	2
$LC5:
	.ascii	"%s\n\000"
	.align	2
$LC6:
	.ascii	"%d\n\000"
	.text
	.align	2
	.globl	main
	.text
$LFB3:
	.ent	main
main:
	.frame	$sp,160,$31		# vars= 96, regs= 10/0, args= 24, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,160
$LCFI2:
	sw	$31,156($sp)
$LCFI3:
	sw	$fp,152($sp)
$LCFI4:
	sw	$23,148($sp)
$LCFI5:
	sw	$22,144($sp)
$LCFI6:
	sw	$21,140($sp)
$LCFI7:
	sw	$20,136($sp)
$LCFI8:
	sw	$19,132($sp)
$LCFI9:
	sw	$18,128($sp)
$LCFI10:
	sw	$17,124($sp)
$LCFI11:
	.set	noreorder
	.set	nomacro
	jal	__main
	sw	$16,120($sp)
$LCFI12:
	.set	macro
	.set	reorder

	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	li	$4,12			# 0xc
	.set	macro
	.set	reorder

	li	$4,12			# 0xc
	lui	$3,%hi(_vt$Q28geometry4Rect) # high
	addiu	$3,$3,%lo(_vt$Q28geometry4Rect) # low
	li	$5,2			# 0x2
	sw	$3,0($2)
	li	$3,3			# 0x3
	sw	$5,4($2)
	sw	$3,8($2)
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	sw	$2,24($sp)
	.set	macro
	.set	reorder

	li	$4,16			# 0x10
	li	$5,4			# 0x4
	lui	$3,%hi(_vt$Q28geometry6Square) # high
	addiu	$3,$3,%lo(_vt$Q28geometry6Square) # low
	sw	$5,4($2)
	sw	$5,8($2)
	sw	$3,0($2)
	.set	noreorder
	.set	nomacro
	jal	__builtin_new
	sw	$2,28($sp)
	.set	macro
	.set	reorder

	move	$19,$0
	lui	$23,%hi($LC4) # high
	addu	$21,$sp,40
	addu	$20,$sp,80
	addu	$fp,$sp,96
	addu	$3,$sp,100
	sw	$3,112($sp)
	addu	$3,$sp,104
	addu	$22,$sp,24
	move	$17,$22
	li	$18,2			# 0x2
	sw	$3,108($sp)
	li	$3,5			# 0x5
	li	$4,6			# 0x6
	sw	$3,4($2)
	lui	$3,%hi(_vt$7Labeled$5Named) # high
	addiu	$3,$3,%lo(_vt$7Labeled$5Named) # low
	sw	$4,8($2)
	lui	$4,%hi(_vt$7Labeled) # high
	addiu	$4,$4,%lo(_vt$7Labeled) # low
	sw	$3,12($2)
	sw	$4,0($2)
	sw	$2,32($sp)
$L232:
	lw	$4,0($17)
	.set	noreorder
	.set	nomacro
	jal	total__FRCQ28geometry5Shape
	addu	$18,$18,-1
	.set	macro
	.set	reorder

	lw	$5,0($17)
	#nop
	lw	$3,0($5)
	addu	$19,$19,$2
	lh	$4,24($3)
	lw	$2,28($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$5,$4
	.set	macro
	.set	reorder

	lw	$5,0($17)
	addu	$17,$17,4
	lw	$6,0($5)
	move	$16,$2
	lh	$4,16($6)
	lw	$3,20($6)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$5,$4
	.set	macro
	.set	reorder

	addiu	$4,$23,%lo($LC4) # low
	move	$5,$16
	.set	noreorder
	.set	nomacro
	jal	printf
	move	$6,$2
	.set	macro
	.set	reorder

	bgez	$18,$L232
	lw	$8,32($sp)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$8,$0,$L235
	move	$5,$0
	.set	macro
	.set	reorder

	lui	$5,%hi(__tf5Named) # high
	addiu	$5,$5,%lo(__tf5Named) # low
	li	$6,1			# 0x1
	lw	$3,0($8)
	lui	$2,%hi(__tfQ28geometry5Shape) # high
	lh	$7,0($3)
	addiu	$2,$2,%lo(__tfQ28geometry5Shape) # low
	sw	$2,16($sp)
	sw	$8,20($sp)
	lw	$4,4($3)
	.set	noreorder
	.set	nomacro
	jal	__dynamic_cast
	addu	$7,$8,$7
	.set	macro
	.set	reorder

	move	$5,$2
$L235:
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L336
	move	$16,$22
	.set	macro
	.set	reorder

	lw	$3,0($5)
	#nop
	lh	$4,16($3)
	lw	$2,20($3)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$2
	addu	$4,$5,$4
	.set	macro
	.set	reorder

	lui	$4,%hi($LC5) # high
	addiu	$4,$4,%lo($LC5) # low
	.set	noreorder
	.set	nomacro
	jal	printf
	move	$5,$2
	.set	macro
	.set	reorder

	move	$16,$22
$L336:
	li	$17,2			# 0x2
$L240:
	lw	$6,0($16)
	#nop
	.set	noreorder
	.set	nomacro
	beq	$6,$0,$L239
	li	$5,3			# 0x3
	.set	macro
	.set	reorder

	lw	$2,0($6)
	#nop
	lh	$4,8($2)
	lw	$3,12($2)
	#nop
	.set	noreorder
	.set	nomacro
	jal	$31,$3
	addu	$4,$6,$4
	.set	macro
	.set	reorder

$L239:
	addu	$17,$17,-1
	.set	noreorder
	.set	nomacro
	bgez	$17,$L240
	addu	$16,$16,4
	.set	macro
	.set	reorder

	sw	$0,72($sp)
	move	$5,$0
	mult	$5,$5
$L337:
	lw	$3,72($sp)
	#nop
	slt	$2,$3,8
	mflo	$4
	#nop
	.set	noreorder
	.set	nomacro
	beq	$2,$0,$L250
	sll	$2,$3,2
	.set	macro
	.set	reorder

	addu	$2,$21,$2
	addu	$3,$3,1
	sw	$4,0($2)
	sw	$3,72($sp)
$L250:
	addu	$5,$5,1
	slt	$2,$5,10
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L337
	mult	$5,$5
	.set	macro
	.set	reorder

	move	$2,$20
	li	$3,1			# 0x1
	li	$4,-1			# 0xffffffff
$L268:
	sw	$0,0($2)
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bne	$3,$4,$L268
	addu	$2,$2,4
	.set	macro
	.set	reorder

	move	$4,$fp
	li	$2,768			# 0x300
	lw	$5,112($sp)
	li	$6,1			# 0x1
	sw	$0,88($sp)
	sw	$2,0($20)
	li	$2,2560			# 0xa00
	li	$3,2			# 0x2
	sw	$6,88($sp)
	sw	$2,4($20)
	sw	$3,88($sp)
	sw	$6,96($sp)
	.set	noreorder
	.set	nomacro
	jal	swap_sum__FRiT0
	sw	$3,100($sp)
	.set	macro
	.set	reorder

	lw	$3,72($sp)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$3,$L294
	move	$6,$2
	.set	macro
	.set	reorder

	addu	$2,$3,-1
	sw	$2,72($sp)
	sll	$2,$2,2
	addu	$2,$21,$2
	lw	$2,0($2)
	.set	noreorder
	.set	nomacro
	j	$L335
	addu	$2,$6,$2
	.set	macro
	.set	reorder

$L294:
	move	$2,$0
	addu	$2,$6,$2
$L335:
	lw	$4,96($sp)
	lw	$3,72($sp)
	lw	$5,100($sp)
	addu	$2,$2,$3
	.set	noreorder
	.set	nomacro
	jal	largest__H1Zi_X01X01_X01
	addu	$19,$19,$2
	.set	macro
	.set	reorder

	li	$5,256			# 0x100
	li	$6,768			# 0x300
	lw	$4,108($sp)
	.set	noreorder
	.set	nomacro
	jal	largest__H1Z5Fixed_X01X01_X01
	move	$16,$2
	.set	macro
	.set	reorder

	lw	$2,104($sp)
	#nop
	addu	$16,$16,$2
	lw	$2,88($sp)
	#nop
	.set	noreorder
	.set	nomacro
	blez	$2,$L312
	addu	$19,$19,$16
	.set	macro
	.set	reorder

	addu	$2,$2,-1
	sw	$2,88($sp)
	sll	$2,$2,2
	addu	$2,$2,$20
	lw	$3,0($2)
	j	$L313
$L312:
	move	$3,$0
$L313:
	lw	$2,first
	li	$4,64			# 0x40
	addu	$2,$3,$2
	lw	$3,second
	lw	$5,counter
	addu	$2,$2,$3
	addu	$2,$2,$5
	.set	noreorder
	.set	nomacro
	jal	__builtin_vec_new
	addu	$19,$19,$2
	.set	macro
	.set	reorder

	li	$3,15			# 0xf
	move	$4,$2
	addu	$2,$4,60
$L320:
	sw	$3,0($2)
	addu	$3,$3,-1
	.set	noreorder
	.set	nomacro
	bgez	$3,$L320
	addu	$2,$2,-4
	.set	macro
	.set	reorder

	lw	$2,60($4)
	.set	noreorder
	.set	nomacro
	beq	$4,$0,$L323
	addu	$19,$19,$2
	.set	macro
	.set	reorder

	jal	__builtin_vec_delete
$L323:
	lui	$4,%hi($LC6) # high
	addiu	$4,$4,%lo($LC6) # low
	.set	noreorder
	.set	nomacro
	jal	printf
	move	$5,$19
	.set	macro
	.set	reorder

	move	$2,$19
	lw	$31,156($sp)
	lw	$fp,152($sp)
	lw	$23,148($sp)
	lw	$22,144($sp)
	lw	$21,140($sp)
	lw	$20,136($sp)
	lw	$19,132($sp)
	lw	$18,128($sp)
	lw	$17,124($sp)
	lw	$16,120($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,160
	.set	macro
	.set	reorder

	.end	main
$LFE3:
	.align	2
	.text
$LFB4:
	.ent	largest__H1Zi_X01X01_X01
largest__H1Zi_X01X01_X01:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	slt	$2,$4,$5
	beq	$2,$0,$L339
	move	$4,$5
$L339:
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$4
	.set	macro
	.set	reorder

	.end	largest__H1Zi_X01X01_X01
$LFE4:
	.align	2
	.text
$LFB5:
	.ent	largest__H1Z5Fixed_X01X01_X01
largest__H1Z5Fixed_X01X01_X01:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	addu	$2,$sp,4
	addu	$3,$sp,8
	sw	$5,4($sp)
	slt	$5,$5,$6
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L341
	sw	$6,8($sp)
	.set	macro
	.set	reorder

	move	$2,$3
$L341:
	lw	$2,0($2)
	#nop
	sw	$2,0($4)
	.set	noreorder
	.set	nomacro
	j	$31
	move	$2,$4
	.set	macro
	.set	reorder

	.end	largest__H1Z5Fixed_X01X01_X01
$LFE5:
	.rdata
	.align	3
_vt$7Labeled$5Named:
	.half	-12
	.half	0
	.word	__tf7Labeled
	.half	-12
	.half	0
	.word	_$_7Labeled
	.half	-12
	.half	0
	.word	label__C7Labeled
	.space	8
	.align	3
_vt$7Labeled:
	.half	0
	.half	0
	.word	__tf7Labeled
	.half	0
	.half	0
	.word	_$_7Labeled
	.half	0
	.half	0
	.word	area__CQ28geometry4Rect
	.half	0
	.half	0
	.word	name__CQ28geometry4Rect
	.space	8
	.align	3
_vt$Q28geometry6Square:
	.half	0
	.half	0
	.word	__tfQ28geometry6Square
	.half	0
	.half	0
	.word	_$_Q28geometry6Square
	.half	0
	.half	0
	.word	area__CQ28geometry4Rect
	.half	0
	.half	0
	.word	name__CQ28geometry6Square
	.space	8
	.align	3
_vt$Q28geometry4Rect:
	.half	0
	.half	0
	.word	__tfQ28geometry4Rect
	.half	0
	.half	0
	.word	_$_Q28geometry4Rect
	.half	0
	.half	0
	.word	area__CQ28geometry4Rect
	.half	0
	.half	0
	.word	name__CQ28geometry4Rect
	.space	8
	.text
	.align	2
	.text
$LFB6:
	.ent	__static_initialization_and_destruction_0
__static_initialization_and_destruction_0:
	.frame	$sp,16,$31		# vars= 0, regs= 0/0, args= 16, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	li	$2,65535			# 0xffff
	.set	noreorder
	.set	nomacro
	bne	$5,$2,$L357
	subu	$sp,$sp,16
$LCFI13:
	.set	macro
	.set	reorder

	beq	$4,$0,$L358
	lw	$2,counter
	#nop
	addu	$3,$2,1
	addu	$2,$2,2
	sw	$3,first
	sw	$2,counter
	sw	$2,second
	j	$L357
$L358:
	lw	$2,counter
	#nop
	addu	$2,$2,-2
	sw	$2,counter
$L357:
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,16
	.set	macro
	.set	reorder

	.end	__static_initialization_and_destruction_0
$LFE6:

	.comm	__tiQ28geometry5Shape,8
	.rdata
	.align	2
$LC7:
	.ascii	"Q28geometry5Shape\000"

	.comm	__tiQ28geometry4Rect,12
	.align	2
$LC8:
	.ascii	"Q28geometry4Rect\000"

	.comm	__tiQ28geometry6Square,12
	.align	2
$LC9:
	.ascii	"Q28geometry6Square\000"

	.comm	__ti5Named,8
	.sdata
	.align	2
$LC10:
	.ascii	"5Named\000"

	.comm	__ti7Labeled,16
	.rdata
	.align	2
$LC11:
	.ascii	"7Labeled\000"
	.align	2
$LC12:
	.word	__tiQ28geometry4Rect
	.byte	0x0
	.byte	0x0
	.byte	0x0
	.byte	0x40
	.word	__ti5Named
	.byte	0xc
	.byte	0x0
	.byte	0x0
	.byte	0x40
	.text
	.align	2
	.text
$LFB7:
	.ent	__tfQ28geometry5Shape
__tfQ28geometry5Shape:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lw	$2,__tiQ28geometry5Shape
	subu	$sp,$sp,24
$LCFI14:
	sw	$16,16($sp)
$LCFI15:
	la	$16,__tiQ28geometry5Shape
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L361
	sw	$31,20($sp)
$LCFI16:
	.set	macro
	.set	reorder

	lui	$5,%hi($LC7) # high
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	__rtti_user
	addiu	$5,$5,%lo($LC7) # low
	.set	macro
	.set	reorder

$L361:
	move	$2,$16
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__tfQ28geometry5Shape
$LFE7:
	.align	2
	.text
$LFB8:
	.ent	_$_Q28geometry4Rect
_$_Q28geometry4Rect:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
$LCFI17:
	lui	$2,%hi(_vt$Q28geometry5Shape) # high
	addiu	$2,$2,%lo(_vt$Q28geometry5Shape) # low
	andi	$5,$5,0x1
	sw	$31,16($sp)
$LCFI18:
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L48
	sw	$2,0($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L48:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_$_Q28geometry4Rect
$LFE8:
	.align	2
	.text
$LFB9:
	.ent	__tfQ28geometry4Rect
__tfQ28geometry4Rect:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(__tiQ28geometry4Rect) # high
	lw	$3,%lo(__tiQ28geometry4Rect)($2)
	subu	$sp,$sp,32
$LCFI19:
	sw	$16,16($sp)
$LCFI20:
	addiu	$16,$2,%lo(__tiQ28geometry4Rect) # low
	sw	$17,20($sp)
$LCFI21:
	move	$17,$2
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L363
	sw	$31,24($sp)
$LCFI22:
	.set	macro
	.set	reorder

	lw	$2,__tiQ28geometry5Shape
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L402
	move	$4,$16
	.set	macro
	.set	reorder

	la	$4,__tiQ28geometry5Shape
	lui	$5,%hi($LC7) # high
	.set	noreorder
	.set	nomacro
	jal	__rtti_user
	addiu	$5,$5,%lo($LC7) # low
	.set	macro
	.set	reorder

	move	$4,$16
$L402:
	lui	$5,%hi($LC8) # high
	la	$6,__tiQ28geometry5Shape
	.set	noreorder
	.set	nomacro
	jal	__rtti_si
	addiu	$5,$5,%lo($LC8) # low
	.set	macro
	.set	reorder

$L363:
	addiu	$2,$17,%lo(__tiQ28geometry4Rect) # low
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	__tfQ28geometry4Rect
$LFE9:
	.align	2
	.text
$LFB10:
	.ent	area__CQ28geometry4Rect
area__CQ28geometry4Rect:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lw	$3,4($4)
	lw	$2,8($4)
	#nop
	mult	$3,$2
	mflo	$2
	#nop
	j	$31
	.end	area__CQ28geometry4Rect
$LFE10:
	.align	2
	.text
$LFB11:
	.ent	name__CQ28geometry4Rect
name__CQ28geometry4Rect:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi($LC1) # high
	.set	noreorder
	.set	nomacro
	j	$31
	addiu	$2,$2,%lo($LC1) # low
	.set	macro
	.set	reorder

	.end	name__CQ28geometry4Rect
$LFE11:
	.align	2
	.text
$LFB12:
	.ent	_$_Q28geometry6Square
_$_Q28geometry6Square:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
$LCFI23:
	lui	$2,%hi(_vt$Q28geometry5Shape) # high
	addiu	$2,$2,%lo(_vt$Q28geometry5Shape) # low
	andi	$5,$5,0x1
	sw	$31,16($sp)
$LCFI24:
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L373
	sw	$2,0($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L373:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_$_Q28geometry6Square
$LFE12:
	.align	2
	.text
$LFB13:
	.ent	__tfQ28geometry6Square
__tfQ28geometry6Square:
	.frame	$sp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0x80070000,-4
	.fmask	0x00000000,0
	lui	$2,%hi(__tiQ28geometry6Square) # high
	lw	$3,%lo(__tiQ28geometry6Square)($2)
	subu	$sp,$sp,32
$LCFI25:
	sw	$17,20($sp)
$LCFI26:
	move	$17,$2
	sw	$31,28($sp)
$LCFI27:
	sw	$18,24($sp)
$LCFI28:
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L375
	sw	$16,16($sp)
$LCFI29:
	.set	macro
	.set	reorder

	lui	$2,%hi(__tiQ28geometry4Rect) # high
	addiu	$16,$2,%lo(__tiQ28geometry4Rect) # low
	lw	$3,%lo(__tiQ28geometry4Rect)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L376
	move	$18,$2
	.set	macro
	.set	reorder

	lw	$2,__tiQ28geometry5Shape
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L403
	move	$4,$16
	.set	macro
	.set	reorder

	la	$4,__tiQ28geometry5Shape
	lui	$5,%hi($LC7) # high
	.set	noreorder
	.set	nomacro
	jal	__rtti_user
	addiu	$5,$5,%lo($LC7) # low
	.set	macro
	.set	reorder

	move	$4,$16
$L403:
	lui	$5,%hi($LC8) # high
	la	$6,__tiQ28geometry5Shape
	.set	noreorder
	.set	nomacro
	jal	__rtti_si
	addiu	$5,$5,%lo($LC8) # low
	.set	macro
	.set	reorder

$L376:
	addiu	$4,$17,%lo(__tiQ28geometry6Square) # low
	lui	$5,%hi($LC9) # high
	addiu	$5,$5,%lo($LC9) # low
	.set	noreorder
	.set	nomacro
	jal	__rtti_si
	addiu	$6,$18,%lo(__tiQ28geometry4Rect) # low
	.set	macro
	.set	reorder

$L375:
	addiu	$2,$17,%lo(__tiQ28geometry6Square) # low
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

	.end	__tfQ28geometry6Square
$LFE13:
	.align	2
	.text
$LFB14:
	.ent	name__CQ28geometry6Square
name__CQ28geometry6Square:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi($LC2) # high
	.set	noreorder
	.set	nomacro
	j	$31
	addiu	$2,$2,%lo($LC2) # low
	.set	macro
	.set	reorder

	.end	name__CQ28geometry6Square
$LFE14:
	.align	2
	.text
$LFB15:
	.ent	__tf5Named
__tf5Named:
	.frame	$sp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0x80010000,-4
	.fmask	0x00000000,0
	lw	$2,__ti5Named
	subu	$sp,$sp,24
$LCFI30:
	sw	$16,16($sp)
$LCFI31:
	la	$16,__ti5Named
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L381
	sw	$31,20($sp)
$LCFI32:
	.set	macro
	.set	reorder

	lui	$5,%hi($LC10) # high
	move	$4,$16
	.set	noreorder
	.set	nomacro
	jal	__rtti_user
	addiu	$5,$5,%lo($LC10) # low
	.set	macro
	.set	reorder

$L381:
	move	$2,$16
	lw	$31,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	__tf5Named
$LFE15:
	.align	2
	.text
$LFB16:
	.ent	_$_7Labeled
_$_7Labeled:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
$LCFI33:
	lui	$2,%hi(_vt$5Named) # high
	addiu	$2,$2,%lo(_vt$5Named) # low
	lui	$3,%hi(_vt$Q28geometry5Shape) # high
	addiu	$3,$3,%lo(_vt$Q28geometry5Shape) # low
	andi	$5,$5,0x1
	sw	$31,16($sp)
$LCFI34:
	sw	$2,12($4)
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L393
	sw	$3,0($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L393:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_$_7Labeled
$LFE16:
	.align	2
	.text
$LFB17:
	.ent	__tf7Labeled
__tf7Labeled:
	.frame	$sp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0x80030000,-8
	.fmask	0x00000000,0
	lui	$2,%hi(__ti7Labeled) # high
	lw	$3,%lo(__ti7Labeled)($2)
	subu	$sp,$sp,32
$LCFI35:
	sw	$17,20($sp)
$LCFI36:
	move	$17,$2
	sw	$31,24($sp)
$LCFI37:
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L395
	sw	$16,16($sp)
$LCFI38:
	.set	macro
	.set	reorder

	lw	$2,__ti5Named
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L404
	lui	$2,%hi(__tiQ28geometry4Rect) # high
	.set	macro
	.set	reorder

	la	$4,__ti5Named
	lui	$5,%hi($LC10) # high
	.set	noreorder
	.set	nomacro
	jal	__rtti_user
	addiu	$5,$5,%lo($LC10) # low
	.set	macro
	.set	reorder

	lui	$2,%hi(__tiQ28geometry4Rect) # high
$L404:
	lw	$3,%lo(__tiQ28geometry4Rect)($2)
	#nop
	.set	noreorder
	.set	nomacro
	bne	$3,$0,$L398
	addiu	$16,$2,%lo(__tiQ28geometry4Rect) # low
	.set	macro
	.set	reorder

	lw	$2,__tiQ28geometry5Shape
	#nop
	.set	noreorder
	.set	nomacro
	bne	$2,$0,$L405
	move	$4,$16
	.set	macro
	.set	reorder

	la	$4,__tiQ28geometry5Shape
	lui	$5,%hi($LC7) # high
	.set	noreorder
	.set	nomacro
	jal	__rtti_user
	addiu	$5,$5,%lo($LC7) # low
	.set	macro
	.set	reorder

	move	$4,$16
$L405:
	lui	$5,%hi($LC8) # high
	la	$6,__tiQ28geometry5Shape
	.set	noreorder
	.set	nomacro
	jal	__rtti_si
	addiu	$5,$5,%lo($LC8) # low
	.set	macro
	.set	reorder

$L398:
	addiu	$4,$17,%lo(__ti7Labeled) # low
	lui	$5,%hi($LC11) # high
	addiu	$5,$5,%lo($LC11) # low
	lui	$6,%hi($LC12) # high
	addiu	$6,$6,%lo($LC12) # low
	.set	noreorder
	.set	nomacro
	jal	__rtti_class
	li	$7,2			# 0x2
	.set	macro
	.set	reorder

$L395:
	addiu	$2,$17,%lo(__ti7Labeled) # low
	lw	$31,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,32
	.set	macro
	.set	reorder

	.end	__tf7Labeled
$LFE17:
	.align	2
	.text
$LFB18:
	.ent	label__C7Labeled
label__C7Labeled:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi($LC3) # high
	.set	noreorder
	.set	nomacro
	j	$31
	addiu	$2,$2,%lo($LC3) # low
	.set	macro
	.set	reorder

	.end	label__C7Labeled
$LFE18:
	.globl	counter
	.sdata
	.align	2
counter:
	.space	4
	.rdata
	.align	3
_vt$5Named:
	.half	0
	.half	0
	.word	__tf5Named
	.half	0
	.half	0
	.word	_$_5Named
	.half	0
	.half	0
	.word	__pure_virtual
	.space	8
	.align	3
_vt$Q28geometry5Shape:
	.half	0
	.half	0
	.word	__tfQ28geometry5Shape
	.half	0
	.half	0
	.word	_$_Q28geometry5Shape
	.half	0
	.half	0
	.word	__pure_virtual
	.half	0
	.half	0
	.word	name__CQ28geometry5Shape
	.space	8
	.text
	.align	2
	.text
$LFB19:
	.ent	_$_Q28geometry5Shape
_$_Q28geometry5Shape:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
$LCFI39:
	lui	$2,%hi(_vt$Q28geometry5Shape) # high
	addiu	$2,$2,%lo(_vt$Q28geometry5Shape) # low
	andi	$5,$5,0x1
	sw	$31,16($sp)
$LCFI40:
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L5
	sw	$2,0($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L5:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_$_Q28geometry5Shape
$LFE19:
	.align	2
	.text
$LFB20:
	.ent	name__CQ28geometry5Shape
name__CQ28geometry5Shape:
	.frame	$sp,0,$31		# vars= 0, regs= 0/0, args= 0, extra= 0
	.mask	0x00000000,0
	.fmask	0x00000000,0
	lui	$2,%hi($LC0) # high
	.set	noreorder
	.set	nomacro
	j	$31
	addiu	$2,$2,%lo($LC0) # low
	.set	macro
	.set	reorder

	.end	name__CQ28geometry5Shape
$LFE20:
	.align	2
	.text
$LFB21:
	.ent	_$_5Named
_$_5Named:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
$LCFI41:
	lui	$2,%hi(_vt$5Named) # high
	addiu	$2,$2,%lo(_vt$5Named) # low
	andi	$5,$5,0x1
	sw	$31,16($sp)
$LCFI42:
	.set	noreorder
	.set	nomacro
	beq	$5,$0,$L67
	sw	$2,0($4)
	.set	macro
	.set	reorder

	jal	__builtin_delete
$L67:
	lw	$31,16($sp)
	#nop
	.set	noreorder
	.set	nomacro
	j	$31
	addu	$sp,$sp,24
	.set	macro
	.set	reorder

	.end	_$_5Named
$LFE21:
	.align	2
	.globl	_GLOBAL_$I$first
	.text
$LFB22:
	.ent	_GLOBAL_$I$first
_GLOBAL_$I$first:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
$LCFI43:
	li	$4,1			# 0x1
	sw	$31,16($sp)
$LCFI44:
	.set	noreorder
	.set	nomacro
	jal	__static_initialization_and_destruction_0
	li	$5,65535			# 0xffff
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

	.end	_GLOBAL_$I$first
$LFE22:
	.align	2
	.globl	_GLOBAL_$D$first
	.text
$LFB23:
	.ent	_GLOBAL_$D$first
_GLOBAL_$D$first:
	.frame	$sp,24,$31		# vars= 0, regs= 1/0, args= 16, extra= 0
	.mask	0x80000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,24
$LCFI45:
	move	$4,$0
	sw	$31,16($sp)
$LCFI46:
	.set	noreorder
	.set	nomacro
	jal	__static_initialization_and_destruction_0
	li	$5,65535			# 0xffff
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

	.end	_GLOBAL_$D$first
$LFE23:

	.data
	.align	2
	.globl	_GLOBAL_$F$first
_GLOBAL_$F$first:
__FRAME_BEGIN__:
	.word	$LECIE1-$LSCIE1

$LSCIE1:
	.word	0

	.byte	0x1
	.byte	0x0
	.byte	0x1
	.byte	0x7c
	.byte	0x40
	.byte	0xc
	.byte	0x1d
	.byte	0x0
	.byte	0x9
	.byte	0x40
	.byte	0x1f
	.align	2
$LECIE1:
	.word	$LEFDE1-$LSFDE1

$LSFDE1:
	.word	$LSFDE1-__FRAME_BEGIN__

	.word	$LFB1

	.word	$LFE1-$LFB1

	.align	2
$LEFDE1:
	.word	$LEFDE3-$LSFDE3

$LSFDE3:
	.word	$LSFDE3-__FRAME_BEGIN__

	.word	$LFB2

	.word	$LFE2-$LFB2

	.byte	0x4
	.word	$LCFI0-$LFB2

	.byte	0xe
	.byte	0x18
	.byte	0x4
	.word	$LCFI1-$LCFI0

	.byte	0x5
	.byte	0x40
	.byte	0x2
	.align	2
$LEFDE3:
	.word	$LEFDE5-$LSFDE5

$LSFDE5:
	.word	$LSFDE5-__FRAME_BEGIN__

	.word	$LFB3

	.word	$LFE3-$LFB3

	.byte	0x4
	.word	$LCFI2-$LFB3

	.byte	0xe
	.byte	0xa0,0x1
	.byte	0x4
	.word	$LCFI3-$LCFI2

	.byte	0x5
	.byte	0x40
	.byte	0x1
	.byte	0x4
	.word	$LCFI4-$LCFI3

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI5-$LCFI4

	.byte	0x97
	.byte	0x3
	.byte	0x4
	.word	$LCFI6-$LCFI5

	.byte	0x96
	.byte	0x4
	.byte	0x4
	.word	$LCFI7-$LCFI6

	.byte	0x95
	.byte	0x5
	.byte	0x4
	.word	$LCFI8-$LCFI7

	.byte	0x94
	.byte	0x6
	.byte	0x4
	.word	$LCFI9-$LCFI8

	.byte	0x93
	.byte	0x7
	.byte	0x4
	.word	$LCFI10-$LCFI9

	.byte	0x92
	.byte	0x8
	.byte	0x4
	.word	$LCFI11-$LCFI10

	.byte	0x91
	.byte	0x9
	.byte	0x4
	.word	$LCFI12-$LCFI11

	.byte	0x90
	.byte	0xa
	.align	2
$LEFDE5:
	.word	$LEFDE7-$LSFDE7

$LSFDE7:
	.word	$LSFDE7-__FRAME_BEGIN__

	.word	$LFB4

	.word	$LFE4-$LFB4

	.align	2
$LEFDE7:
	.word	$LEFDE9-$LSFDE9

$LSFDE9:
	.word	$LSFDE9-__FRAME_BEGIN__

	.word	$LFB5

	.word	$LFE5-$LFB5

	.align	2
$LEFDE9:
	.word	$LEFDE11-$LSFDE11

$LSFDE11:
	.word	$LSFDE11-__FRAME_BEGIN__

	.word	$LFB6

	.word	$LFE6-$LFB6

	.byte	0x4
	.word	$LCFI13-$LFB6

	.byte	0xe
	.byte	0x10
	.align	2
$LEFDE11:
	.word	$LEFDE13-$LSFDE13

$LSFDE13:
	.word	$LSFDE13-__FRAME_BEGIN__

	.word	$LFB7

	.word	$LFE7-$LFB7

	.byte	0x4
	.word	$LCFI14-$LFB7

	.byte	0xe
	.byte	0x18
	.byte	0x4
	.word	$LCFI15-$LCFI14

	.byte	0x90
	.byte	0x2
	.byte	0x4
	.word	$LCFI16-$LCFI15

	.byte	0x5
	.byte	0x40
	.byte	0x1
	.align	2
$LEFDE13:
	.word	$LEFDE15-$LSFDE15

$LSFDE15:
	.word	$LSFDE15-__FRAME_BEGIN__

	.word	$LFB8

	.word	$LFE8-$LFB8

	.byte	0x4
	.word	$LCFI17-$LFB8

	.byte	0xe
	.byte	0x18
	.byte	0x4
	.word	$LCFI18-$LCFI17

	.byte	0x5
	.byte	0x40
	.byte	0x2
	.align	2
$LEFDE15:
	.word	$LEFDE17-$LSFDE17

$LSFDE17:
	.word	$LSFDE17-__FRAME_BEGIN__

	.word	$LFB9

	.word	$LFE9-$LFB9

	.byte	0x4
	.word	$LCFI19-$LFB9

	.byte	0xe
	.byte	0x20
	.byte	0x4
	.word	$LCFI20-$LCFI19

	.byte	0x90
	.byte	0x4
	.byte	0x4
	.word	$LCFI21-$LCFI20

	.byte	0x91
	.byte	0x3
	.byte	0x4
	.word	$LCFI22-$LCFI21

	.byte	0x5
	.byte	0x40
	.byte	0x2
	.align	2
$LEFDE17:
	.word	$LEFDE19-$LSFDE19

$LSFDE19:
	.word	$LSFDE19-__FRAME_BEGIN__

	.word	$LFB10

	.word	$LFE10-$LFB10

	.align	2
$LEFDE19:
	.word	$LEFDE21-$LSFDE21

$LSFDE21:
	.word	$LSFDE21-__FRAME_BEGIN__

	.word	$LFB11

	.word	$LFE11-$LFB11

	.align	2
$LEFDE21:
	.word	$LEFDE23-$LSFDE23

$LSFDE23:
	.word	$LSFDE23-__FRAME_BEGIN__

	.word	$LFB12

	.word	$LFE12-$LFB12

	.byte	0x4
	.word	$LCFI23-$LFB12

	.byte	0xe
	.byte	0x18
	.byte	0x4
	.word	$LCFI24-$LCFI23

	.byte	0x5
	.byte	0x40
	.byte	0x2
	.align	2
$LEFDE23:
	.word	$LEFDE25-$LSFDE25

$LSFDE25:
	.word	$LSFDE25-__FRAME_BEGIN__

	.word	$LFB13

	.word	$LFE13-$LFB13

	.byte	0x4
	.word	$LCFI25-$LFB13

	.byte	0xe
	.byte	0x20
	.byte	0x4
	.word	$LCFI26-$LCFI25

	.byte	0x91
	.byte	0x3
	.byte	0x4
	.word	$LCFI27-$LCFI26

	.byte	0x5
	.byte	0x40
	.byte	0x1
	.byte	0x4
	.word	$LCFI28-$LCFI27

	.byte	0x92
	.byte	0x2
	.byte	0x4
	.word	$LCFI29-$LCFI28

	.byte	0x90
	.byte	0x4
	.align	2
$LEFDE25:
	.word	$LEFDE27-$LSFDE27

$LSFDE27:
	.word	$LSFDE27-__FRAME_BEGIN__

	.word	$LFB14

	.word	$LFE14-$LFB14

	.align	2
$LEFDE27:
	.word	$LEFDE29-$LSFDE29

$LSFDE29:
	.word	$LSFDE29-__FRAME_BEGIN__

	.word	$LFB15

	.word	$LFE15-$LFB15

	.byte	0x4
	.word	$LCFI30-$LFB15

	.byte	0xe
	.byte	0x18
	.byte	0x4
	.word	$LCFI31-$LCFI30

	.byte	0x90
	.byte	0x2
	.byte	0x4
	.word	$LCFI32-$LCFI31

	.byte	0x5
	.byte	0x40
	.byte	0x1
	.align	2
$LEFDE29:
	.word	$LEFDE31-$LSFDE31

$LSFDE31:
	.word	$LSFDE31-__FRAME_BEGIN__

	.word	$LFB16

	.word	$LFE16-$LFB16

	.byte	0x4
	.word	$LCFI33-$LFB16

	.byte	0xe
	.byte	0x18
	.byte	0x4
	.word	$LCFI34-$LCFI33

	.byte	0x5
	.byte	0x40
	.byte	0x2
	.align	2
$LEFDE31:
	.word	$LEFDE33-$LSFDE33

$LSFDE33:
	.word	$LSFDE33-__FRAME_BEGIN__

	.word	$LFB17

	.word	$LFE17-$LFB17

	.byte	0x4
	.word	$LCFI35-$LFB17

	.byte	0xe
	.byte	0x20
	.byte	0x4
	.word	$LCFI36-$LCFI35

	.byte	0x91
	.byte	0x3
	.byte	0x4
	.word	$LCFI37-$LCFI36

	.byte	0x5
	.byte	0x40
	.byte	0x2
	.byte	0x4
	.word	$LCFI38-$LCFI37

	.byte	0x90
	.byte	0x4
	.align	2
$LEFDE33:
	.word	$LEFDE35-$LSFDE35

$LSFDE35:
	.word	$LSFDE35-__FRAME_BEGIN__

	.word	$LFB18

	.word	$LFE18-$LFB18

	.align	2
$LEFDE35:
	.word	$LEFDE37-$LSFDE37

$LSFDE37:
	.word	$LSFDE37-__FRAME_BEGIN__

	.word	$LFB19

	.word	$LFE19-$LFB19

	.byte	0x4
	.word	$LCFI39-$LFB19

	.byte	0xe
	.byte	0x18
	.byte	0x4
	.word	$LCFI40-$LCFI39

	.byte	0x5
	.byte	0x40
	.byte	0x2
	.align	2
$LEFDE37:
	.word	$LEFDE39-$LSFDE39

$LSFDE39:
	.word	$LSFDE39-__FRAME_BEGIN__

	.word	$LFB20

	.word	$LFE20-$LFB20

	.align	2
$LEFDE39:
	.word	$LEFDE41-$LSFDE41

$LSFDE41:
	.word	$LSFDE41-__FRAME_BEGIN__

	.word	$LFB21

	.word	$LFE21-$LFB21

	.byte	0x4
	.word	$LCFI41-$LFB21

	.byte	0xe
	.byte	0x18
	.byte	0x4
	.word	$LCFI42-$LCFI41

	.byte	0x5
	.byte	0x40
	.byte	0x2
	.align	2
$LEFDE41:
	.word	$LEFDE43-$LSFDE43

$LSFDE43:
	.word	$LSFDE43-__FRAME_BEGIN__

	.word	$LFB22

	.word	$LFE22-$LFB22

	.byte	0x4
	.word	$LCFI43-$LFB22

	.byte	0xe
	.byte	0x18
	.byte	0x4
	.word	$LCFI44-$LCFI43

	.byte	0x5
	.byte	0x40
	.byte	0x2
	.align	2
$LEFDE43:
	.word	$LEFDE45-$LSFDE45

$LSFDE45:
	.word	$LSFDE45-__FRAME_BEGIN__

	.word	$LFB23

	.word	$LFE23-$LFB23

	.byte	0x4
	.word	$LCFI45-$LFB23

	.byte	0xe
	.byte	0x18
	.byte	0x4
	.word	$LCFI46-$LCFI45

	.byte	0x5
	.byte	0x40
	.byte	0x2
	.align	2
$LEFDE45:
	.word	0

	.align	0
