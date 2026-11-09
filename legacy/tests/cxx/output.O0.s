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
$LFB1:
	.ent	swap_sum__FRiT0
swap_sum__FRiT0:
	.frame	$fp,16,$31		# vars= 8, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,16
$LCFI0:
	sw	$fp,8($sp)
$LCFI1:
	move	$fp,$sp
$LCFI2:
	sw	$4,16($fp)
	sw	$5,20($fp)
	lw	$2,16($fp)
	lw	$3,0($2)
	sw	$3,0($fp)
	lw	$2,16($fp)
	lw	$3,20($fp)
	lw	$4,0($3)
	sw	$4,0($2)
	lw	$2,20($fp)
	lw	$3,0($fp)
	sw	$3,0($2)
	lw	$2,16($fp)
	lw	$3,20($fp)
	lw	$2,0($2)
	lw	$4,0($3)
	addu	$3,$2,$4
	move	$2,$3
	j	$L65
$L65:
	move	$sp,$fp
	lw	$fp,8($sp)
	addu	$sp,$sp,16
	j	$31
	.end	swap_sum__FRiT0
$LFE1:
	.align	2
	.globl	total__FRCQ28geometry5Shape
$LFB2:
	.ent	total__FRCQ28geometry5Shape
total__FRCQ28geometry5Shape:
	.frame	$fp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0xc0010000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
$LCFI3:
	sw	$31,24($sp)
$LCFI4:
	sw	$fp,20($sp)
$LCFI5:
	sw	$16,16($sp)
$LCFI6:
	move	$fp,$sp
$LCFI7:
	sw	$4,32($fp)
	lw	$2,32($fp)
	lw	$3,0($2)
	addu	$16,$3,16
	lh	$2,0($16)
	lw	$3,32($fp)
	addu	$2,$2,$3
	lw	$3,4($16)
	move	$4,$2
	jal	$31,$3
	move	$3,$2
	move	$2,$3
	j	$L66
$L66:
	move	$sp,$fp
	lw	$31,24($sp)
	lw	$fp,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
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
$LFB3:
	.ent	main
main:
	.frame	$fp,272,$31		# vars= 208, regs= 10/0, args= 24, extra= 0
	.mask	0xc0ff0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,272
$LCFI8:
	sw	$31,268($sp)
$LCFI9:
	sw	$fp,264($sp)
$LCFI10:
	sw	$23,260($sp)
$LCFI11:
	sw	$22,256($sp)
$LCFI12:
	sw	$21,252($sp)
$LCFI13:
	sw	$20,248($sp)
$LCFI14:
	sw	$19,244($sp)
$LCFI15:
	sw	$18,240($sp)
$LCFI16:
	sw	$17,236($sp)
$LCFI17:
	sw	$16,232($sp)
$LCFI18:
	move	$fp,$sp
$LCFI19:
	jal	__main
	li	$4,12			# 0xc
	jal	__builtin_new
	move	$21,$2
	li	$22,1			# 0x1
$LEHB68:
	move	$4,$21
	li	$5,2			# 0x2
	li	$6,3			# 0x3
	jal	__Q28geometry4Rectii
	move	$22,$0
	sw	$2,24($fp)
$LEHE68:
	j	$L70
$L69:
	jal	__throw
$L70:
	beq	$22,$0,$L72
	move	$4,$21
	jal	__builtin_delete
	j	$L72
$L71:
$L72:
	li	$4,12			# 0xc
	jal	__builtin_new
	move	$23,$2
	li	$2,1			# 0x1
	sw	$2,176($fp)
$LEHB73:
	move	$4,$23
	li	$5,4			# 0x4
	jal	__Q28geometry6Squarei
	sw	$0,176($fp)
	sw	$2,28($fp)
$LEHE73:
	j	$L75
$L74:
	jal	__throw
$L75:
	lw	$4,176($fp)
	beq	$4,$0,$L77
	move	$4,$23
	jal	__builtin_delete
	j	$L77
$L76:
$L77:
	li	$4,16			# 0x10
	jal	__builtin_new
	sw	$2,180($fp)
	li	$5,1			# 0x1
	sw	$5,184($fp)
$LEHB78:
	lw	$4,180($fp)
	li	$5,5			# 0x5
	li	$6,6			# 0x6
	jal	__7Labeledii
	sw	$0,184($fp)
	sw	$2,32($fp)
$LEHE78:
	j	$L80
$L79:
	jal	__throw
$L80:
	lw	$2,184($fp)
	beq	$2,$0,$L82
	lw	$4,180($fp)
	jal	__builtin_delete
	j	$L82
$L81:
$L82:
	sw	$0,40($fp)
	sw	$0,44($fp)
$L83:
	lw	$2,44($fp)
	slt	$3,$2,3
	bne	$3,$0,$L86
	j	$L84
$L86:
	lw	$2,44($fp)
	move	$3,$2
	sll	$2,$3,2
	addu	$3,$fp,24
	addu	$2,$3,$2
	lw	$4,0($2)
	jal	total__FRCQ28geometry5Shape
	lw	$3,40($fp)
	addu	$2,$3,$2
	sw	$2,40($fp)
	lw	$2,44($fp)
	move	$3,$2
	sll	$2,$3,2
	addu	$3,$fp,24
	addu	$2,$3,$2
	lw	$3,0($2)
	lw	$2,0($3)
	addu	$16,$2,24
	lw	$2,44($fp)
	move	$3,$2
	sll	$2,$3,2
	addu	$3,$fp,24
	addu	$2,$3,$2
	lh	$3,0($16)
	lw	$4,0($2)
	addu	$2,$3,$4
	lw	$3,4($16)
	move	$4,$2
	jal	$31,$3
	sw	$2,188($fp)
	lw	$2,44($fp)
	move	$3,$2
	sll	$2,$3,2
	addu	$3,$fp,24
	addu	$2,$3,$2
	lw	$3,0($2)
	lw	$2,0($3)
	addu	$17,$2,16
	lw	$2,44($fp)
	move	$3,$2
	sll	$2,$3,2
	addu	$3,$fp,24
	addu	$2,$3,$2
	lh	$3,0($17)
	lw	$4,0($2)
	addu	$2,$3,$4
	lw	$3,4($17)
	move	$4,$2
	jal	$31,$3
	la	$4,$LC4
	lw	$5,188($fp)
	move	$6,$2
	jal	printf
$L85:
	lw	$2,44($fp)
	addu	$3,$2,1
	sw	$3,44($fp)
	j	$L83
$L84:
	lw	$18,32($fp)
	bne	$18,$0,$L87
	sw	$0,192($fp)
	j	$L88
$L87:
	lw	$2,0($18)
	lw	$3,0($18)
	lh	$4,0($3)
	addu	$3,$18,$4
	la	$4,__tfQ28geometry5Shape
	sw	$4,16($sp)
	sw	$18,20($sp)
	lw	$4,4($2)
	la	$5,__tf5Named
	li	$6,1			# 0x1
	move	$7,$3
	jal	__dynamic_cast
	sw	$2,192($fp)
$L88:
	lw	$4,192($fp)
	sw	$4,48($fp)
	lw	$2,48($fp)
	beq	$2,$0,$L89
	lw	$2,48($fp)
	lw	$3,0($2)
	addu	$19,$3,16
	lh	$2,0($19)
	lw	$3,48($fp)
	addu	$2,$2,$3
	lw	$3,4($19)
	move	$4,$2
	jal	$31,$3
	la	$4,$LC5
	move	$5,$2
	jal	printf
$L89:
	sw	$0,52($fp)
$L90:
	lw	$2,52($fp)
	slt	$3,$2,3
	bne	$3,$0,$L93
	j	$L91
$L93:
	lw	$2,52($fp)
	move	$3,$2
	sll	$2,$3,2
	addu	$3,$fp,24
	addu	$2,$3,$2
	lw	$3,0($2)
	beq	$3,$0,$L92
	lw	$2,52($fp)
	move	$3,$2
	sll	$2,$3,2
	addu	$3,$fp,24
	addu	$2,$3,$2
	lw	$3,0($2)
	lw	$2,0($3)
	addu	$20,$2,8
	lw	$2,52($fp)
	move	$3,$2
	sll	$2,$3,2
	addu	$3,$fp,24
	addu	$2,$3,$2
	lh	$3,0($20)
	lw	$2,0($2)
	addu	$3,$3,$2
	lw	$2,4($20)
	move	$4,$3
	li	$5,3			# 0x3
	jal	$31,$2
	j	$L92
$L94:
$L95:
$L92:
	lw	$2,52($fp)
	addu	$3,$2,1
	sw	$3,52($fp)
	j	$L90
$L91:
	addu	$2,$fp,56
	move	$4,$2
	jal	__t5Stack2Zii8
	sw	$0,96($fp)
$L98:
	lw	$2,96($fp)
	slt	$3,$2,10
	bne	$3,$0,$L101
	j	$L99
$L101:
	addu	$2,$fp,56
	lw	$3,96($fp)
	lw	$4,96($fp)
	mult	$3,$4
	mflo	$3
	sw	$3,100($fp)
	addu	$3,$fp,100
	move	$4,$2
	move	$5,$3
	jal	push__t5Stack2Zii8RCi
$L100:
	lw	$2,96($fp)
	addu	$3,$2,1
	sw	$3,96($fp)
	j	$L98
$L99:
	addu	$2,$fp,104
	move	$4,$2
	jal	__t5Stack2Z5Fixedi2
	addu	$2,$fp,120
	move	$4,$2
	li	$5,3			# 0x3
	jal	__5Fixedi
	move	$3,$2
	addu	$2,$fp,120
	addu	$3,$fp,104
	move	$4,$3
	move	$5,$2
	jal	push__t5Stack2Z5Fixedi2RC5Fixed
	addu	$2,$fp,124
	sw	$2,196($fp)
	addu	$2,$fp,128
	move	$4,$2
	li	$5,2			# 0x2
	jal	__5Fixedi
	addu	$4,$fp,128
	sw	$4,200($fp)
	addu	$2,$fp,132
	move	$4,$2
	li	$5,5			# 0x5
	jal	__5Fixedi
	move	$3,$2
	addu	$2,$fp,132
	lw	$4,196($fp)
	lw	$5,200($fp)
	move	$6,$2
	jal	__ml__C5FixedRC5Fixed
	addu	$2,$fp,124
	addu	$3,$fp,104
	move	$4,$3
	move	$5,$2
	jal	push__t5Stack2Z5Fixedi2RC5Fixed
	li	$2,1			# 0x1
	sw	$2,136($fp)
	li	$2,2			# 0x2
	sw	$2,140($fp)
	addu	$2,$fp,136
	addu	$3,$fp,140
	move	$4,$2
	move	$5,$3
	jal	swap_sum__FRiT0
	sw	$2,204($fp)
	addu	$2,$fp,56
	move	$4,$2
	jal	pop__t5Stack2Zii8
	sw	$2,208($fp)
	addu	$2,$fp,56
	move	$4,$2
	jal	size__Ct5Stack2Zii8
	lw	$5,204($fp)
	lw	$4,208($fp)
	addu	$3,$5,$4
	addu	$2,$3,$2
	lw	$3,40($fp)
	addu	$2,$3,$2
	sw	$2,40($fp)
	lw	$4,136($fp)
	lw	$5,140($fp)
	jal	largest__H1Zi_X01X01_X01
	sw	$2,212($fp)
	addu	$5,$fp,144
	sw	$5,216($fp)
	addu	$2,$fp,148
	move	$4,$2
	li	$5,1			# 0x1
	jal	__5Fixedi
	addu	$2,$fp,152
	sw	$2,220($fp)
	addu	$2,$fp,156
	move	$4,$2
	li	$5,2			# 0x2
	jal	__5Fixedi
	addu	$4,$fp,156
	sw	$4,224($fp)
	addu	$2,$fp,160
	move	$4,$2
	li	$5,1			# 0x1
	jal	__5Fixedi
	move	$3,$2
	addu	$2,$fp,160
	lw	$4,220($fp)
	lw	$5,224($fp)
	move	$6,$2
	jal	__pl__C5FixedRC5Fixed
	lw	$2,152($fp)
	lw	$4,216($fp)
	lw	$5,148($fp)
	move	$6,$2
	jal	largest__H1Z5Fixed_X01X01_X01
	lw	$2,144($fp)
	lw	$5,212($fp)
	addu	$3,$5,$2
	lw	$2,40($fp)
	addu	$3,$2,$3
	sw	$3,40($fp)
	addu	$2,$fp,164
	addu	$3,$fp,104
	move	$4,$2
	move	$5,$3
	jal	pop__t5Stack2Z5Fixedi2
	lw	$2,164($fp)
	lw	$3,first
	addu	$2,$2,$3
	lw	$3,second
	addu	$2,$2,$3
	lw	$3,counter
	addu	$2,$2,$3
	lw	$3,40($fp)
	addu	$2,$3,$2
	sw	$2,40($fp)
	li	$4,64			# 0x40
	jal	__builtin_vec_new
	sw	$2,168($fp)
	sw	$0,172($fp)
$L120:
	lw	$2,172($fp)
	slt	$3,$2,16
	bne	$3,$0,$L123
	j	$L121
$L123:
	lw	$2,172($fp)
	move	$3,$2
	sll	$2,$3,2
	lw	$3,168($fp)
	addu	$2,$2,$3
	lw	$3,172($fp)
	sw	$3,0($2)
$L122:
	lw	$2,172($fp)
	addu	$3,$2,1
	sw	$3,172($fp)
	j	$L120
$L121:
	lw	$3,168($fp)
	addu	$2,$3,60
	lw	$3,40($fp)
	lw	$2,0($2)
	addu	$3,$3,$2
	sw	$3,40($fp)
	lw	$2,168($fp)
	beq	$2,$0,$L125
	lw	$4,168($fp)
	jal	__builtin_vec_delete
	j	$L125
$L124:
$L125:
	la	$4,$LC6
	lw	$5,40($fp)
	jal	printf
	lw	$3,40($fp)
	move	$2,$3
	j	$L67
	move	$2,$0
	j	$L67
	j	$L132
$LEHB133:
$L68:
	beq	$22,$0,$L127
	move	$4,$21
	jal	__builtin_delete
	j	$L127
$L126:
$L127:
	j	$L69
$L73:
	lw	$2,176($fp)
	beq	$2,$0,$L129
	move	$4,$23
	jal	__builtin_delete
	j	$L129
$L128:
$L129:
	j	$L74
$L78:
	lw	$4,184($fp)
	beq	$4,$0,$L131
	lw	$4,180($fp)
	jal	__builtin_delete
	j	$L131
$L130:
$L131:
	j	$L79
$LEHE133:
	j	$L133
$L134:
	jal	__throw
$L135:
$L133:
	jal	terminate__Fv
$L132:
$L67:
	move	$sp,$fp
	lw	$31,268($sp)
	lw	$fp,264($sp)
	lw	$23,260($sp)
	lw	$22,256($sp)
	lw	$21,252($sp)
	lw	$20,248($sp)
	lw	$19,244($sp)
	lw	$18,240($sp)
	lw	$17,236($sp)
	lw	$16,232($sp)
	addu	$sp,$sp,272
	j	$31
	.end	main
$LFE3:
	.align	2
$LFB4:
	.ent	largest__H1Zi_X01X01_X01
largest__H1Zi_X01X01_X01:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
$LCFI20:
	sw	$fp,0($sp)
$LCFI21:
	move	$fp,$sp
$LCFI22:
	sw	$4,8($fp)
	sw	$5,12($fp)
	lw	$2,8($fp)
	lw	$3,12($fp)
	slt	$4,$2,$3
	beq	$4,$0,$L137
	lw	$2,12($fp)
$L137:
	j	$L136
$L136:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	largest__H1Zi_X01X01_X01
$LFE4:
	.align	2
$LFB5:
	.ent	largest__H1Z5Fixed_X01X01_X01
largest__H1Z5Fixed_X01X01_X01:
	.frame	$fp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0xc0010000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
$LCFI23:
	sw	$31,24($sp)
$LCFI24:
	sw	$fp,20($sp)
$LCFI25:
	sw	$16,16($sp)
$LCFI26:
	move	$fp,$sp
$LCFI27:
	move	$16,$4
	sw	$5,36($fp)
	sw	$6,40($fp)
	addu	$2,$fp,36
	addu	$3,$fp,40
	move	$4,$2
	move	$5,$3
	jal	__lt__C5FixedRC5Fixed
	beq	$2,$0,$L139
	addu	$2,$fp,40
	j	$L140
$L139:
	addu	$2,$fp,36
$L140:
	lw	$2,0($2)
	sw	$2,0($16)
	j	$L138
$L138:
	move	$2,$16
	move	$sp,$fp
	lw	$31,24($sp)
	lw	$fp,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	largest__H1Z5Fixed_X01X01_X01
$LFE5:
	.align	2
$LFB6:
	.ent	__static_initialization_and_destruction_0
__static_initialization_and_destruction_0:
	.frame	$fp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
$LCFI28:
	sw	$31,20($sp)
$LCFI29:
	sw	$fp,16($sp)
$LCFI30:
	move	$fp,$sp
$LCFI31:
	sw	$4,24($fp)
	sw	$5,28($fp)
	lw	$2,28($fp)
	li	$3,65535			# 0xffff
	bne	$2,$3,$L142
	lw	$2,24($fp)
	beq	$2,$0,$L143
	la	$4,first
	jal	__7Counted
	la	$4,second
	jal	__7Counted
	j	$L142
$L143:
	la	$4,second
	li	$5,2			# 0x2
	jal	_$_7Counted
	la	$4,first
	li	$5,2			# 0x2
	jal	_$_7Counted
$L144:
$L142:
$L141:
	move	$sp,$fp
	lw	$31,20($sp)
	lw	$fp,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	__static_initialization_and_destruction_0
$LFE6:

	.comm	__tiQ28geometry5Shape,8
	.rdata
	.align	2
$LC7:
	.ascii	"Q28geometry5Shape\000"
	.text
	.align	2
$LFB7:
	.ent	__tfQ28geometry5Shape
__tfQ28geometry5Shape:
	.frame	$fp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
$LCFI32:
	sw	$31,20($sp)
$LCFI33:
	sw	$fp,16($sp)
$LCFI34:
	move	$fp,$sp
$LCFI35:
	lw	$2,__tiQ28geometry5Shape
	bne	$2,$0,$L146
	la	$4,__tiQ28geometry5Shape
	la	$5,$LC7
	jal	__rtti_user
$L146:
	la	$2,__tiQ28geometry5Shape
	j	$L145
$L145:
	move	$sp,$fp
	lw	$31,20($sp)
	lw	$fp,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	__tfQ28geometry5Shape
$LFE7:

	.comm	__ti5Named,8
	.sdata
	.align	2
$LC8:
	.ascii	"5Named\000"
	.text
	.align	2
$LFB8:
	.ent	__tf5Named
__tf5Named:
	.frame	$fp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
$LCFI36:
	sw	$31,20($sp)
$LCFI37:
	sw	$fp,16($sp)
$LCFI38:
	move	$fp,$sp
$LCFI39:
	lw	$2,__ti5Named
	bne	$2,$0,$L148
	la	$4,__ti5Named
	la	$5,$LC8
	jal	__rtti_user
$L148:
	la	$2,__ti5Named
	j	$L147
$L147:
	move	$sp,$fp
	lw	$31,20($sp)
	lw	$fp,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	__tf5Named
$LFE8:
	.align	2
$LFB9:
	.ent	__Q28geometry4Rectii
__Q28geometry4Rectii:
	.frame	$fp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0xc0070000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
$LCFI40:
	sw	$31,32($sp)
$LCFI41:
	sw	$fp,28($sp)
$LCFI42:
	sw	$18,24($sp)
$LCFI43:
	sw	$17,20($sp)
$LCFI44:
	sw	$16,16($sp)
$LCFI45:
	move	$fp,$sp
$LCFI46:
	move	$18,$4
	move	$16,$5
	move	$17,$6
	move	$4,$18
	jal	__Q28geometry5Shape
$LEHB11:
	la	$2,_vt$Q28geometry4Rect
	sw	$2,0($18)
	sw	$16,4($18)
	sw	$17,8($18)
$LEHE11:
	j	$L14
$L12:
	jal	__throw
$L13:
$L14:
	move	$2,$18
	j	$L8
	j	$L15
$LEHB16:
$L11:
	move	$4,$18
	move	$5,$0
	jal	_$_Q28geometry5Shape
	j	$L12
$LEHE16:
	j	$L16
$L17:
	jal	__throw
$L18:
$L16:
	jal	terminate__Fv
$L15:
$L8:
	move	$sp,$fp
	lw	$31,32($sp)
	lw	$fp,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,40
	j	$31
	.end	__Q28geometry4Rectii
$LFE9:
	.align	2
$LFB10:
	.ent	__Q28geometry6Squarei
__Q28geometry6Squarei:
	.frame	$fp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0xc0030000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
$LCFI47:
	sw	$31,28($sp)
$LCFI48:
	sw	$fp,24($sp)
$LCFI49:
	sw	$17,20($sp)
$LCFI50:
	sw	$16,16($sp)
$LCFI51:
	move	$fp,$sp
$LCFI52:
	move	$17,$4
	move	$16,$5
	move	$4,$17
	move	$5,$16
	move	$6,$16
	jal	__Q28geometry4Rectii
$LEHB24:
	la	$2,_vt$Q28geometry6Square
	sw	$2,0($17)
$LEHE24:
	j	$L27
$L25:
	jal	__throw
$L26:
$L27:
	move	$2,$17
	j	$L21
	j	$L28
$LEHB29:
$L24:
	move	$4,$17
	move	$5,$0
	jal	_$_Q28geometry4Rect
	j	$L25
$LEHE29:
	j	$L29
$L30:
	jal	__throw
$L31:
$L29:
	jal	terminate__Fv
$L28:
$L21:
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	__Q28geometry6Squarei
$LFE10:
	.align	2
$LFB11:
	.ent	__7Labeledii
__7Labeledii:
	.frame	$fp,40,$31		# vars= 0, regs= 5/0, args= 16, extra= 0
	.mask	0xc0070000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,40
$LCFI53:
	sw	$31,32($sp)
$LCFI54:
	sw	$fp,28($sp)
$LCFI55:
	sw	$18,24($sp)
$LCFI56:
	sw	$17,20($sp)
$LCFI57:
	sw	$16,16($sp)
$LCFI58:
	move	$fp,$sp
$LCFI59:
	move	$18,$4
	move	$16,$5
	move	$17,$6
	move	$4,$18
	move	$5,$16
	move	$6,$17
	jal	__Q28geometry4Rectii
$LEHB38:
	addu	$2,$18,12
	move	$4,$2
	jal	__5Named
$LEHB42:
	la	$2,_vt$7Labeled$5Named
	sw	$2,12($18)
	la	$2,_vt$7Labeled
	sw	$2,0($18)
$LEHE42:
	j	$L44
$L43:
	jal	__throw
$L44:
$LEHE38:
	j	$L46
$L39:
	jal	__throw
$L45:
$L46:
	move	$2,$18
	j	$L37
	j	$L47
$LEHB48:
$L42:
	addu	$2,$18,12
	move	$4,$2
	move	$5,$0
	jal	_$_5Named
	j	$L43
$L38:
	move	$4,$18
	move	$5,$0
	jal	_$_Q28geometry4Rect
	j	$L39
$LEHE48:
	j	$L48
$L49:
	jal	__throw
$L50:
$L48:
	jal	terminate__Fv
$L47:
$L37:
	move	$sp,$fp
	lw	$31,32($sp)
	lw	$fp,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,40
	j	$31
	.end	__7Labeledii
$LFE11:
	.align	2
$LFB12:
	.ent	__5Fixedi
__5Fixedi:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
$LCFI60:
	sw	$fp,0($sp)
$LCFI61:
	move	$fp,$sp
$LCFI62:
	move	$3,$5
	sll	$2,$3,8
	sw	$2,0($4)
$L55:
	move	$2,$4
	j	$L54
$L54:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	__5Fixedi
$LFE12:
	.align	2
$LFB13:
	.ent	__pl__C5FixedRC5Fixed
__pl__C5FixedRC5Fixed:
	.frame	$fp,48,$31		# vars= 8, regs= 5/0, args= 16, extra= 0
	.mask	0xc0070000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
$LCFI63:
	sw	$31,40($sp)
$LCFI64:
	sw	$fp,36($sp)
$LCFI65:
	sw	$18,32($sp)
$LCFI66:
	sw	$17,28($sp)
$LCFI67:
	sw	$16,24($sp)
$LCFI68:
	move	$fp,$sp
$LCFI69:
	move	$16,$4
	move	$17,$5
	move	$18,$6
	addu	$4,$fp,16
	move	$5,$0
	jal	__5Fixedi
	lw	$2,0($17)
	lw	$3,0($18)
	addu	$2,$2,$3
	sw	$2,16($fp)
	lw	$2,16($fp)
	sw	$2,0($16)
	j	$L56
$L56:
	move	$2,$16
	move	$sp,$fp
	lw	$31,40($sp)
	lw	$fp,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	addu	$sp,$sp,48
	j	$31
	.end	__pl__C5FixedRC5Fixed
$LFE13:
	.align	2
$LFB14:
	.ent	__ml__C5FixedRC5Fixed
__ml__C5FixedRC5Fixed:
	.frame	$fp,48,$31		# vars= 8, regs= 5/0, args= 16, extra= 0
	.mask	0xc0070000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
$LCFI70:
	sw	$31,40($sp)
$LCFI71:
	sw	$fp,36($sp)
$LCFI72:
	sw	$18,32($sp)
$LCFI73:
	sw	$17,28($sp)
$LCFI74:
	sw	$16,24($sp)
$LCFI75:
	move	$fp,$sp
$LCFI76:
	move	$16,$4
	move	$17,$5
	move	$18,$6
	addu	$4,$fp,16
	move	$5,$0
	jal	__5Fixedi
	lw	$2,0($17)
	lw	$3,0($18)
	mult	$2,$3
	mflo	$2
	sra	$3,$2,8
	sw	$3,16($fp)
	lw	$2,16($fp)
	sw	$2,0($16)
	j	$L57
$L57:
	move	$2,$16
	move	$sp,$fp
	lw	$31,40($sp)
	lw	$fp,36($sp)
	lw	$18,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	addu	$sp,$sp,48
	j	$31
	.end	__ml__C5FixedRC5Fixed
$LFE14:
	.align	2
$LFB15:
	.ent	__lt__C5FixedRC5Fixed
__lt__C5FixedRC5Fixed:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
$LCFI77:
	sw	$fp,0($sp)
$LCFI78:
	move	$fp,$sp
$LCFI79:
	move	$3,$4
	move	$4,$5
	lw	$2,0($3)
	lw	$6,0($4)
	slt	$5,$2,$6
	move	$2,$5
	j	$L58
$L58:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	__lt__C5FixedRC5Fixed
$LFE15:
	.align	2
$LFB16:
	.ent	__7Counted
__7Counted:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
$LCFI80:
	sw	$fp,0($sp)
$LCFI81:
	move	$fp,$sp
$LCFI82:
	move	$3,$4
	lw	$4,counter
	addu	$2,$4,1
	move	$4,$2
	sw	$4,counter
	sw	$4,0($3)
$L60:
	move	$2,$3
	j	$L59
$L59:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	__7Counted
$LFE16:
	.align	2
$LFB17:
	.ent	_$_7Counted
_$_7Counted:
	.frame	$fp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0xc0030000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
$LCFI83:
	sw	$31,28($sp)
$LCFI84:
	sw	$fp,24($sp)
$LCFI85:
	sw	$17,20($sp)
$LCFI86:
	sw	$16,16($sp)
$LCFI87:
	move	$fp,$sp
$LCFI88:
	move	$16,$4
	move	$17,$5
	lw	$2,counter
	addu	$3,$2,-1
	sw	$3,counter
$L62:
	andi	$2,$17,0x1
	beq	$2,$0,$L64
	move	$4,$16
	jal	__builtin_delete
	j	$L64
$L63:
$L64:
$L61:
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	_$_7Counted
$LFE17:
	.align	2
$LFB18:
	.ent	__t5Stack2Zii8
__t5Stack2Zii8:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
$LCFI89:
	sw	$fp,0($sp)
$LCFI90:
	move	$fp,$sp
$LCFI91:
	move	$3,$4
	sw	$0,32($3)
$L97:
	move	$2,$3
	j	$L96
$L96:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	__t5Stack2Zii8
$LFE18:
	.align	2
$LFB19:
	.ent	push__t5Stack2Zii8RCi
push__t5Stack2Zii8RCi:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
$LCFI92:
	sw	$fp,0($sp)
$LCFI93:
	move	$fp,$sp
$LCFI94:
	move	$3,$4
	move	$2,$5
	lw	$5,32($3)
	slt	$6,$5,8
	beq	$6,$0,$L103
	addu	$5,$3,32
	lw	$6,0($5)
	move	$4,$6
	move	$7,$4
	sll	$8,$7,2
	addu	$7,$3,$8
	lw	$8,0($2)
	sw	$8,0($7)
	addu	$6,$6,1
	sw	$6,0($5)
$L103:
$L102:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	push__t5Stack2Zii8RCi
$LFE19:
	.align	2
$LFB20:
	.ent	__t5Stack2Z5Fixedi2
__t5Stack2Z5Fixedi2:
	.frame	$fp,40,$31		# vars= 0, regs= 6/0, args= 16, extra= 0
	.mask	0xc00f0000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
$LCFI95:
	sw	$31,36($sp)
$LCFI96:
	sw	$fp,32($sp)
$LCFI97:
	sw	$19,28($sp)
$LCFI98:
	sw	$18,24($sp)
$LCFI99:
	sw	$17,20($sp)
$LCFI100:
	sw	$16,16($sp)
$LCFI101:
	move	$fp,$sp
$LCFI102:
	move	$16,$4
	move	$17,$16
	move	$19,$16
	li	$18,1			# 0x1
	li	$2,-1			# 0xffffffff
	beq	$18,$2,$L105
$L106:
	move	$4,$19
	jal	__5Fixed
	addu	$19,$19,4
$L108:
	addu	$18,$18,-1
	li	$2,-1			# 0xffffffff
	bne	$18,$2,$L109
	j	$L105
$L109:
	j	$L106
$L107:
$L105:
	sw	$0,8($16)
$L110:
	move	$2,$16
	j	$L104
$L104:
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	lw	$19,28($sp)
	lw	$18,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,40
	j	$31
	.end	__t5Stack2Z5Fixedi2
$LFE20:
	.align	2
$LFB21:
	.ent	push__t5Stack2Z5Fixedi2RC5Fixed
push__t5Stack2Z5Fixedi2RC5Fixed:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
$LCFI103:
	sw	$fp,0($sp)
$LCFI104:
	move	$fp,$sp
$LCFI105:
	move	$3,$4
	move	$2,$5
	lw	$5,8($3)
	slt	$6,$5,2
	beq	$6,$0,$L112
	addu	$5,$3,8
	lw	$6,0($5)
	move	$4,$6
	move	$7,$4
	sll	$8,$7,2
	addu	$7,$8,$3
	lw	$8,0($2)
	sw	$8,0($7)
	addu	$6,$6,1
	sw	$6,0($5)
$L112:
$L111:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	push__t5Stack2Z5Fixedi2RC5Fixed
$LFE21:
	.align	2
$LFB22:
	.ent	pop__t5Stack2Zii8
pop__t5Stack2Zii8:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
$LCFI106:
	sw	$fp,0($sp)
$LCFI107:
	move	$fp,$sp
$LCFI108:
	move	$3,$4
	lw	$2,32($3)
	blez	$2,$L114
	lw	$4,32($3)
	addu	$2,$4,-1
	move	$4,$2
	sw	$4,32($3)
	move	$2,$4
	sll	$4,$2,2
	addu	$5,$3,$4
	lw	$2,0($5)
	j	$L115
$L114:
	move	$2,$0
$L115:
	j	$L113
$L113:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	pop__t5Stack2Zii8
$LFE22:
	.align	2
$LFB23:
	.ent	size__Ct5Stack2Zii8
size__Ct5Stack2Zii8:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
$LCFI109:
	sw	$fp,0($sp)
$LCFI110:
	move	$fp,$sp
$LCFI111:
	move	$3,$4
	lw	$4,32($3)
	move	$2,$4
	j	$L116
$L116:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	size__Ct5Stack2Zii8
$LFE23:
	.align	2
$LFB24:
	.ent	pop__t5Stack2Z5Fixedi2
pop__t5Stack2Z5Fixedi2:
	.frame	$fp,40,$31		# vars= 8, regs= 4/0, args= 16, extra= 0
	.mask	0xc0030000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,40
$LCFI112:
	sw	$31,36($sp)
$LCFI113:
	sw	$fp,32($sp)
$LCFI114:
	sw	$17,28($sp)
$LCFI115:
	sw	$16,24($sp)
$LCFI116:
	move	$fp,$sp
$LCFI117:
	move	$16,$4
	move	$17,$5
	lw	$2,8($17)
	blez	$2,$L118
	lw	$3,8($17)
	addu	$2,$3,-1
	move	$3,$2
	sw	$3,8($17)
	move	$2,$3
	sll	$3,$2,2
	addu	$2,$3,$17
	lw	$3,0($2)
	sw	$3,16($fp)
	j	$L119
$L118:
	addu	$4,$fp,16
	jal	__5Fixed
$L119:
	lw	$2,16($fp)
	sw	$2,0($16)
	j	$L117
$L117:
	move	$2,$16
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	lw	$17,28($sp)
	lw	$16,24($sp)
	addu	$sp,$sp,40
	j	$31
	.end	pop__t5Stack2Z5Fixedi2
$LFE24:
	.globl	counter
	.sdata
	.align	2
counter:
	.space	4
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

	.comm	__tiQ28geometry4Rect,12
	.align	2
$LC9:
	.ascii	"Q28geometry4Rect\000"
	.text
	.align	2
$LFB25:
	.ent	__tfQ28geometry4Rect
__tfQ28geometry4Rect:
	.frame	$fp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
$LCFI118:
	sw	$31,20($sp)
$LCFI119:
	sw	$fp,16($sp)
$LCFI120:
	move	$fp,$sp
$LCFI121:
	lw	$2,__tiQ28geometry4Rect
	bne	$2,$0,$L150
	jal	__tfQ28geometry5Shape
	la	$4,__tiQ28geometry4Rect
	la	$5,$LC9
	la	$6,__tiQ28geometry5Shape
	jal	__rtti_si
$L150:
	la	$2,__tiQ28geometry4Rect
	j	$L149
$L149:
	move	$sp,$fp
	lw	$31,20($sp)
	lw	$fp,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	__tfQ28geometry4Rect
$LFE25:
	.align	2
$LFB26:
	.ent	_$_Q28geometry6Square
_$_Q28geometry6Square:
	.frame	$fp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0xc0030000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
$LCFI122:
	sw	$31,28($sp)
$LCFI123:
	sw	$fp,24($sp)
$LCFI124:
	sw	$17,20($sp)
$LCFI125:
	sw	$16,16($sp)
$LCFI126:
	move	$fp,$sp
$LCFI127:
	move	$16,$4
	move	$17,$5
$L152:
	move	$4,$16
	move	$5,$17
	jal	_$_Q28geometry4Rect
$L151:
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	_$_Q28geometry6Square
$LFE26:

	.comm	__tiQ28geometry6Square,12
	.rdata
	.align	2
$LC10:
	.ascii	"Q28geometry6Square\000"
	.text
	.align	2
$LFB27:
	.ent	__tfQ28geometry6Square
__tfQ28geometry6Square:
	.frame	$fp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
$LCFI128:
	sw	$31,20($sp)
$LCFI129:
	sw	$fp,16($sp)
$LCFI130:
	move	$fp,$sp
$LCFI131:
	lw	$2,__tiQ28geometry6Square
	bne	$2,$0,$L154
	jal	__tfQ28geometry4Rect
	la	$4,__tiQ28geometry6Square
	la	$5,$LC10
	la	$6,__tiQ28geometry4Rect
	jal	__rtti_si
$L154:
	la	$2,__tiQ28geometry6Square
	j	$L153
$L153:
	move	$sp,$fp
	lw	$31,20($sp)
	lw	$fp,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	__tfQ28geometry6Square
$LFE27:
	.align	2
$LFB28:
	.ent	_$_7Labeled
_$_7Labeled:
	.frame	$fp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0xc0030000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
$LCFI132:
	sw	$31,28($sp)
$LCFI133:
	sw	$fp,24($sp)
$LCFI134:
	sw	$17,20($sp)
$LCFI135:
	sw	$16,16($sp)
$LCFI136:
	move	$fp,$sp
$LCFI137:
	move	$17,$4
	move	$16,$5
	la	$2,_vt$7Labeled$5Named
	sw	$2,12($17)
	la	$2,_vt$7Labeled
	sw	$2,0($17)
$L156:
	addu	$2,$17,12
	move	$4,$2
	move	$5,$0
	jal	_$_5Named
	move	$4,$17
	move	$5,$16
	jal	_$_Q28geometry4Rect
$L155:
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	_$_7Labeled
$LFE28:

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
$LFB29:
	.ent	__tf7Labeled
__tf7Labeled:
	.frame	$fp,32,$31		# vars= 0, regs= 3/0, args= 16, extra= 0
	.mask	0xc0010000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,32
$LCFI138:
	sw	$31,24($sp)
$LCFI139:
	sw	$fp,20($sp)
$LCFI140:
	sw	$16,16($sp)
$LCFI141:
	move	$fp,$sp
$LCFI142:
	lw	$2,__ti7Labeled
	bne	$2,$0,$L158
	jal	__tf5Named
	move	$16,$2
	jal	__tfQ28geometry4Rect
	la	$4,__ti7Labeled
	la	$5,$LC11
	la	$6,$LC12
	li	$7,2			# 0x2
	jal	__rtti_class
$L158:
	la	$2,__ti7Labeled
	j	$L157
$L157:
	move	$sp,$fp
	lw	$31,24($sp)
	lw	$fp,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	__tf7Labeled
$LFE29:
	.align	2
$LFB30:
	.ent	__Q28geometry5Shape
__Q28geometry5Shape:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
$LCFI143:
	sw	$fp,0($sp)
$LCFI144:
	move	$fp,$sp
$LCFI145:
	move	$3,$4
	la	$2,_vt$Q28geometry5Shape
	sw	$2,0($3)
$L10:
	move	$2,$3
	j	$L9
$L9:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	__Q28geometry5Shape
$LFE30:
	.align	2
$LFB31:
	.ent	_$_Q28geometry5Shape
_$_Q28geometry5Shape:
	.frame	$fp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0xc0030000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
$LCFI146:
	sw	$31,28($sp)
$LCFI147:
	sw	$fp,24($sp)
$LCFI148:
	sw	$17,20($sp)
$LCFI149:
	sw	$16,16($sp)
$LCFI150:
	move	$fp,$sp
$LCFI151:
	move	$17,$4
	move	$16,$5
	la	$2,_vt$Q28geometry5Shape
	sw	$2,0($17)
$L3:
	andi	$2,$16,0x1
	beq	$2,$0,$L5
	move	$4,$17
	jal	__builtin_delete
	j	$L5
$L4:
$L5:
$L2:
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	_$_Q28geometry5Shape
$LFE31:
	.align	2
$LFB32:
	.ent	_$_Q28geometry4Rect
_$_Q28geometry4Rect:
	.frame	$fp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0xc0030000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
$LCFI152:
	sw	$31,28($sp)
$LCFI153:
	sw	$fp,24($sp)
$LCFI154:
	sw	$17,20($sp)
$LCFI155:
	sw	$16,16($sp)
$LCFI156:
	move	$fp,$sp
$LCFI157:
	move	$16,$4
	move	$17,$5
$L23:
	move	$4,$16
	move	$5,$17
	jal	_$_Q28geometry5Shape
$L22:
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	_$_Q28geometry4Rect
$LFE32:
	.align	2
$LFB33:
	.ent	area__CQ28geometry4Rect
area__CQ28geometry4Rect:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
$LCFI158:
	sw	$fp,0($sp)
$LCFI159:
	move	$fp,$sp
$LCFI160:
	move	$3,$4
	lw	$2,4($3)
	lw	$5,8($3)
	mult	$2,$5
	mflo	$4
	move	$2,$4
	j	$L19
$L19:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	area__CQ28geometry4Rect
$LFE33:
	.align	2
$LFB34:
	.ent	name__CQ28geometry4Rect
name__CQ28geometry4Rect:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
$LCFI161:
	sw	$fp,0($sp)
$LCFI162:
	move	$fp,$sp
$LCFI163:
	move	$3,$4
	la	$2,$LC1
	j	$L20
$L20:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	name__CQ28geometry4Rect
$LFE34:
	.align	2
$LFB35:
	.ent	name__CQ28geometry6Square
name__CQ28geometry6Square:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
$LCFI164:
	sw	$fp,0($sp)
$LCFI165:
	move	$fp,$sp
$LCFI166:
	move	$3,$4
	la	$2,$LC2
	j	$L32
$L32:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	name__CQ28geometry6Square
$LFE35:
	.align	2
$LFB36:
	.ent	__5Named
__5Named:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
$LCFI167:
	sw	$fp,0($sp)
$LCFI168:
	move	$fp,$sp
$LCFI169:
	move	$3,$4
	la	$2,_vt$5Named
	sw	$2,0($3)
$L41:
	move	$2,$3
	j	$L40
$L40:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	__5Named
$LFE36:
	.align	2
$LFB37:
	.ent	_$_5Named
_$_5Named:
	.frame	$fp,32,$31		# vars= 0, regs= 4/0, args= 16, extra= 0
	.mask	0xc0030000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,32
$LCFI170:
	sw	$31,28($sp)
$LCFI171:
	sw	$fp,24($sp)
$LCFI172:
	sw	$17,20($sp)
$LCFI173:
	sw	$16,16($sp)
$LCFI174:
	move	$fp,$sp
$LCFI175:
	move	$17,$4
	move	$16,$5
	la	$2,_vt$5Named
	sw	$2,0($17)
$L34:
	andi	$2,$16,0x1
	beq	$2,$0,$L36
	move	$4,$17
	jal	__builtin_delete
	j	$L36
$L35:
$L36:
$L33:
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	lw	$17,20($sp)
	lw	$16,16($sp)
	addu	$sp,$sp,32
	j	$31
	.end	_$_5Named
$LFE37:
	.align	2
$LFB38:
	.ent	label__C7Labeled
label__C7Labeled:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
$LCFI176:
	sw	$fp,0($sp)
$LCFI177:
	move	$fp,$sp
$LCFI178:
	move	$3,$4
	la	$2,$LC3
	j	$L51
$L51:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	label__C7Labeled
$LFE38:
	.align	2
$LFB39:
	.ent	__5Fixed
__5Fixed:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
$LCFI179:
	sw	$fp,0($sp)
$LCFI180:
	move	$fp,$sp
$LCFI181:
	move	$3,$4
	sw	$0,0($3)
$L53:
	move	$2,$3
	j	$L52
$L52:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	__5Fixed
$LFE39:
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
$LFB40:
	.ent	name__CQ28geometry5Shape
name__CQ28geometry5Shape:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, extra= 0
	.mask	0x40000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,8
$LCFI182:
	sw	$fp,0($sp)
$LCFI183:
	move	$fp,$sp
$LCFI184:
	move	$3,$4
	la	$2,$LC0
	j	$L6
	j	$L7
	j	$L6
$L7:
$L6:
	move	$sp,$fp
	lw	$fp,0($sp)
	addu	$sp,$sp,8
	j	$31
	.end	name__CQ28geometry5Shape
$LFE40:
	.align	2
	.globl	_GLOBAL_$I$first
$LFB41:
	.ent	_GLOBAL_$I$first
_GLOBAL_$I$first:
	.frame	$fp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
$LCFI185:
	sw	$31,20($sp)
$LCFI186:
	sw	$fp,16($sp)
$LCFI187:
	move	$fp,$sp
$LCFI188:
	li	$4,1			# 0x1
	li	$5,65535			# 0xffff
	jal	__static_initialization_and_destruction_0
$L159:
	move	$sp,$fp
	lw	$31,20($sp)
	lw	$fp,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_GLOBAL_$I$first
$LFE41:
	.align	2
	.globl	_GLOBAL_$D$first
$LFB42:
	.ent	_GLOBAL_$D$first
_GLOBAL_$D$first:
	.frame	$fp,24,$31		# vars= 0, regs= 2/0, args= 16, extra= 0
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	subu	$sp,$sp,24
$LCFI189:
	sw	$31,20($sp)
$LCFI190:
	sw	$fp,16($sp)
$LCFI191:
	move	$fp,$sp
$LCFI192:
	move	$4,$0
	li	$5,65535			# 0xffff
	jal	__static_initialization_and_destruction_0
$L160:
	move	$sp,$fp
	lw	$31,20($sp)
	lw	$fp,16($sp)
	addu	$sp,$sp,24
	j	$31
	.end	_GLOBAL_$D$first
$LFE42:
	.rdata
	.align	2
__EXCEPTION_TABLE__:
	.word	$LEHB68
	.word	$LEHE68
	.word	$L68

	.word	$LEHB73
	.word	$LEHE73
	.word	$L73

	.word	$LEHB78
	.word	$LEHE78
	.word	$L78

	.word	$LEHB133
	.word	$LEHE133
	.word	$L133

	.word	$LEHB11
	.word	$LEHE11
	.word	$L11

	.word	$LEHB16
	.word	$LEHE16
	.word	$L16

	.word	$LEHB24
	.word	$LEHE24
	.word	$L24

	.word	$LEHB29
	.word	$LEHE29
	.word	$L29

	.word	$LEHB38
	.word	$LEHE38
	.word	$L38

	.word	$LEHB42
	.word	$LEHE42
	.word	$L42

	.word	$LEHB48
	.word	$LEHE48
	.word	$L48

$LRTH1:
	.word	-1
	.word	-1


	.data
	.align	2
	.globl	_GLOBAL_$F$first
_GLOBAL_$F$first:
__FRAME_BEGIN__:
	.word	$LECIE1-$LSCIE1

$LSCIE1:
	.word	0

	.byte	0x1
	.ascii	"eh\000"

	.word	__EXCEPTION_TABLE__

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

	.byte	0x4
	.word	$LCFI0-$LFB1

	.byte	0xe
	.byte	0x10
	.byte	0x4
	.word	$LCFI1-$LCFI0

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI2-$LCFI1

	.byte	0xc
	.byte	0x1e
	.byte	0x10
	.align	2
$LEFDE1:
	.word	$LEFDE3-$LSFDE3

$LSFDE3:
	.word	$LSFDE3-__FRAME_BEGIN__

	.word	$LFB2

	.word	$LFE2-$LFB2

	.byte	0x4
	.word	$LCFI3-$LFB2

	.byte	0xe
	.byte	0x20
	.byte	0x4
	.word	$LCFI4-$LCFI3

	.byte	0x5
	.byte	0x40
	.byte	0x2
	.byte	0x4
	.word	$LCFI5-$LCFI4

	.byte	0x9e
	.byte	0x3
	.byte	0x4
	.word	$LCFI6-$LCFI5

	.byte	0x90
	.byte	0x4
	.byte	0x4
	.word	$LCFI7-$LCFI6

	.byte	0xc
	.byte	0x1e
	.byte	0x20
	.align	2
$LEFDE3:
	.word	$LEFDE5-$LSFDE5

$LSFDE5:
	.word	$LSFDE5-__FRAME_BEGIN__

	.word	$LFB3

	.word	$LFE3-$LFB3

	.byte	0x4
	.word	$LCFI8-$LFB3

	.byte	0xe
	.byte	0x90,0x2
	.byte	0x4
	.word	$LCFI9-$LCFI8

	.byte	0x5
	.byte	0x40
	.byte	0x1
	.byte	0x4
	.word	$LCFI10-$LCFI9

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI11-$LCFI10

	.byte	0x97
	.byte	0x3
	.byte	0x4
	.word	$LCFI12-$LCFI11

	.byte	0x96
	.byte	0x4
	.byte	0x4
	.word	$LCFI13-$LCFI12

	.byte	0x95
	.byte	0x5
	.byte	0x4
	.word	$LCFI14-$LCFI13

	.byte	0x94
	.byte	0x6
	.byte	0x4
	.word	$LCFI15-$LCFI14

	.byte	0x93
	.byte	0x7
	.byte	0x4
	.word	$LCFI16-$LCFI15

	.byte	0x92
	.byte	0x8
	.byte	0x4
	.word	$LCFI17-$LCFI16

	.byte	0x91
	.byte	0x9
	.byte	0x4
	.word	$LCFI18-$LCFI17

	.byte	0x90
	.byte	0xa
	.byte	0x4
	.word	$LCFI19-$LCFI18

	.byte	0xc
	.byte	0x1e
	.byte	0x90,0x2
	.align	2
$LEFDE5:
	.word	$LEFDE7-$LSFDE7

$LSFDE7:
	.word	$LSFDE7-__FRAME_BEGIN__

	.word	$LFB4

	.word	$LFE4-$LFB4

	.byte	0x4
	.word	$LCFI20-$LFB4

	.byte	0xe
	.byte	0x8
	.byte	0x4
	.word	$LCFI21-$LCFI20

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI22-$LCFI21

	.byte	0xc
	.byte	0x1e
	.byte	0x8
	.align	2
$LEFDE7:
	.word	$LEFDE9-$LSFDE9

$LSFDE9:
	.word	$LSFDE9-__FRAME_BEGIN__

	.word	$LFB5

	.word	$LFE5-$LFB5

	.byte	0x4
	.word	$LCFI23-$LFB5

	.byte	0xe
	.byte	0x20
	.byte	0x4
	.word	$LCFI24-$LCFI23

	.byte	0x5
	.byte	0x40
	.byte	0x2
	.byte	0x4
	.word	$LCFI25-$LCFI24

	.byte	0x9e
	.byte	0x3
	.byte	0x4
	.word	$LCFI26-$LCFI25

	.byte	0x90
	.byte	0x4
	.byte	0x4
	.word	$LCFI27-$LCFI26

	.byte	0xc
	.byte	0x1e
	.byte	0x20
	.align	2
$LEFDE9:
	.word	$LEFDE11-$LSFDE11

$LSFDE11:
	.word	$LSFDE11-__FRAME_BEGIN__

	.word	$LFB6

	.word	$LFE6-$LFB6

	.byte	0x4
	.word	$LCFI28-$LFB6

	.byte	0xe
	.byte	0x18
	.byte	0x4
	.word	$LCFI29-$LCFI28

	.byte	0x5
	.byte	0x40
	.byte	0x1
	.byte	0x4
	.word	$LCFI30-$LCFI29

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI31-$LCFI30

	.byte	0xc
	.byte	0x1e
	.byte	0x18
	.align	2
$LEFDE11:
	.word	$LEFDE13-$LSFDE13

$LSFDE13:
	.word	$LSFDE13-__FRAME_BEGIN__

	.word	$LFB7

	.word	$LFE7-$LFB7

	.byte	0x4
	.word	$LCFI32-$LFB7

	.byte	0xe
	.byte	0x18
	.byte	0x4
	.word	$LCFI33-$LCFI32

	.byte	0x5
	.byte	0x40
	.byte	0x1
	.byte	0x4
	.word	$LCFI34-$LCFI33

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI35-$LCFI34

	.byte	0xc
	.byte	0x1e
	.byte	0x18
	.align	2
$LEFDE13:
	.word	$LEFDE15-$LSFDE15

$LSFDE15:
	.word	$LSFDE15-__FRAME_BEGIN__

	.word	$LFB8

	.word	$LFE8-$LFB8

	.byte	0x4
	.word	$LCFI36-$LFB8

	.byte	0xe
	.byte	0x18
	.byte	0x4
	.word	$LCFI37-$LCFI36

	.byte	0x5
	.byte	0x40
	.byte	0x1
	.byte	0x4
	.word	$LCFI38-$LCFI37

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI39-$LCFI38

	.byte	0xc
	.byte	0x1e
	.byte	0x18
	.align	2
$LEFDE15:
	.word	$LEFDE17-$LSFDE17

$LSFDE17:
	.word	$LSFDE17-__FRAME_BEGIN__

	.word	$LFB9

	.word	$LFE9-$LFB9

	.byte	0x4
	.word	$LCFI40-$LFB9

	.byte	0xe
	.byte	0x28
	.byte	0x4
	.word	$LCFI41-$LCFI40

	.byte	0x5
	.byte	0x40
	.byte	0x2
	.byte	0x4
	.word	$LCFI42-$LCFI41

	.byte	0x9e
	.byte	0x3
	.byte	0x4
	.word	$LCFI43-$LCFI42

	.byte	0x92
	.byte	0x4
	.byte	0x4
	.word	$LCFI44-$LCFI43

	.byte	0x91
	.byte	0x5
	.byte	0x4
	.word	$LCFI45-$LCFI44

	.byte	0x90
	.byte	0x6
	.byte	0x4
	.word	$LCFI46-$LCFI45

	.byte	0xc
	.byte	0x1e
	.byte	0x28
	.align	2
$LEFDE17:
	.word	$LEFDE19-$LSFDE19

$LSFDE19:
	.word	$LSFDE19-__FRAME_BEGIN__

	.word	$LFB10

	.word	$LFE10-$LFB10

	.byte	0x4
	.word	$LCFI47-$LFB10

	.byte	0xe
	.byte	0x20
	.byte	0x4
	.word	$LCFI48-$LCFI47

	.byte	0x5
	.byte	0x40
	.byte	0x1
	.byte	0x4
	.word	$LCFI49-$LCFI48

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI50-$LCFI49

	.byte	0x91
	.byte	0x3
	.byte	0x4
	.word	$LCFI51-$LCFI50

	.byte	0x90
	.byte	0x4
	.byte	0x4
	.word	$LCFI52-$LCFI51

	.byte	0xc
	.byte	0x1e
	.byte	0x20
	.align	2
$LEFDE19:
	.word	$LEFDE21-$LSFDE21

$LSFDE21:
	.word	$LSFDE21-__FRAME_BEGIN__

	.word	$LFB11

	.word	$LFE11-$LFB11

	.byte	0x4
	.word	$LCFI53-$LFB11

	.byte	0xe
	.byte	0x28
	.byte	0x4
	.word	$LCFI54-$LCFI53

	.byte	0x5
	.byte	0x40
	.byte	0x2
	.byte	0x4
	.word	$LCFI55-$LCFI54

	.byte	0x9e
	.byte	0x3
	.byte	0x4
	.word	$LCFI56-$LCFI55

	.byte	0x92
	.byte	0x4
	.byte	0x4
	.word	$LCFI57-$LCFI56

	.byte	0x91
	.byte	0x5
	.byte	0x4
	.word	$LCFI58-$LCFI57

	.byte	0x90
	.byte	0x6
	.byte	0x4
	.word	$LCFI59-$LCFI58

	.byte	0xc
	.byte	0x1e
	.byte	0x28
	.align	2
$LEFDE21:
	.word	$LEFDE23-$LSFDE23

$LSFDE23:
	.word	$LSFDE23-__FRAME_BEGIN__

	.word	$LFB12

	.word	$LFE12-$LFB12

	.byte	0x4
	.word	$LCFI60-$LFB12

	.byte	0xe
	.byte	0x8
	.byte	0x4
	.word	$LCFI61-$LCFI60

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI62-$LCFI61

	.byte	0xc
	.byte	0x1e
	.byte	0x8
	.align	2
$LEFDE23:
	.word	$LEFDE25-$LSFDE25

$LSFDE25:
	.word	$LSFDE25-__FRAME_BEGIN__

	.word	$LFB13

	.word	$LFE13-$LFB13

	.byte	0x4
	.word	$LCFI63-$LFB13

	.byte	0xe
	.byte	0x30
	.byte	0x4
	.word	$LCFI64-$LCFI63

	.byte	0x5
	.byte	0x40
	.byte	0x2
	.byte	0x4
	.word	$LCFI65-$LCFI64

	.byte	0x9e
	.byte	0x3
	.byte	0x4
	.word	$LCFI66-$LCFI65

	.byte	0x92
	.byte	0x4
	.byte	0x4
	.word	$LCFI67-$LCFI66

	.byte	0x91
	.byte	0x5
	.byte	0x4
	.word	$LCFI68-$LCFI67

	.byte	0x90
	.byte	0x6
	.byte	0x4
	.word	$LCFI69-$LCFI68

	.byte	0xc
	.byte	0x1e
	.byte	0x30
	.align	2
$LEFDE25:
	.word	$LEFDE27-$LSFDE27

$LSFDE27:
	.word	$LSFDE27-__FRAME_BEGIN__

	.word	$LFB14

	.word	$LFE14-$LFB14

	.byte	0x4
	.word	$LCFI70-$LFB14

	.byte	0xe
	.byte	0x30
	.byte	0x4
	.word	$LCFI71-$LCFI70

	.byte	0x5
	.byte	0x40
	.byte	0x2
	.byte	0x4
	.word	$LCFI72-$LCFI71

	.byte	0x9e
	.byte	0x3
	.byte	0x4
	.word	$LCFI73-$LCFI72

	.byte	0x92
	.byte	0x4
	.byte	0x4
	.word	$LCFI74-$LCFI73

	.byte	0x91
	.byte	0x5
	.byte	0x4
	.word	$LCFI75-$LCFI74

	.byte	0x90
	.byte	0x6
	.byte	0x4
	.word	$LCFI76-$LCFI75

	.byte	0xc
	.byte	0x1e
	.byte	0x30
	.align	2
$LEFDE27:
	.word	$LEFDE29-$LSFDE29

$LSFDE29:
	.word	$LSFDE29-__FRAME_BEGIN__

	.word	$LFB15

	.word	$LFE15-$LFB15

	.byte	0x4
	.word	$LCFI77-$LFB15

	.byte	0xe
	.byte	0x8
	.byte	0x4
	.word	$LCFI78-$LCFI77

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI79-$LCFI78

	.byte	0xc
	.byte	0x1e
	.byte	0x8
	.align	2
$LEFDE29:
	.word	$LEFDE31-$LSFDE31

$LSFDE31:
	.word	$LSFDE31-__FRAME_BEGIN__

	.word	$LFB16

	.word	$LFE16-$LFB16

	.byte	0x4
	.word	$LCFI80-$LFB16

	.byte	0xe
	.byte	0x8
	.byte	0x4
	.word	$LCFI81-$LCFI80

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI82-$LCFI81

	.byte	0xc
	.byte	0x1e
	.byte	0x8
	.align	2
$LEFDE31:
	.word	$LEFDE33-$LSFDE33

$LSFDE33:
	.word	$LSFDE33-__FRAME_BEGIN__

	.word	$LFB17

	.word	$LFE17-$LFB17

	.byte	0x4
	.word	$LCFI83-$LFB17

	.byte	0xe
	.byte	0x20
	.byte	0x4
	.word	$LCFI84-$LCFI83

	.byte	0x5
	.byte	0x40
	.byte	0x1
	.byte	0x4
	.word	$LCFI85-$LCFI84

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI86-$LCFI85

	.byte	0x91
	.byte	0x3
	.byte	0x4
	.word	$LCFI87-$LCFI86

	.byte	0x90
	.byte	0x4
	.byte	0x4
	.word	$LCFI88-$LCFI87

	.byte	0xc
	.byte	0x1e
	.byte	0x20
	.align	2
$LEFDE33:
	.word	$LEFDE35-$LSFDE35

$LSFDE35:
	.word	$LSFDE35-__FRAME_BEGIN__

	.word	$LFB18

	.word	$LFE18-$LFB18

	.byte	0x4
	.word	$LCFI89-$LFB18

	.byte	0xe
	.byte	0x8
	.byte	0x4
	.word	$LCFI90-$LCFI89

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI91-$LCFI90

	.byte	0xc
	.byte	0x1e
	.byte	0x8
	.align	2
$LEFDE35:
	.word	$LEFDE37-$LSFDE37

$LSFDE37:
	.word	$LSFDE37-__FRAME_BEGIN__

	.word	$LFB19

	.word	$LFE19-$LFB19

	.byte	0x4
	.word	$LCFI92-$LFB19

	.byte	0xe
	.byte	0x8
	.byte	0x4
	.word	$LCFI93-$LCFI92

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI94-$LCFI93

	.byte	0xc
	.byte	0x1e
	.byte	0x8
	.align	2
$LEFDE37:
	.word	$LEFDE39-$LSFDE39

$LSFDE39:
	.word	$LSFDE39-__FRAME_BEGIN__

	.word	$LFB20

	.word	$LFE20-$LFB20

	.byte	0x4
	.word	$LCFI95-$LFB20

	.byte	0xe
	.byte	0x28
	.byte	0x4
	.word	$LCFI96-$LCFI95

	.byte	0x5
	.byte	0x40
	.byte	0x1
	.byte	0x4
	.word	$LCFI97-$LCFI96

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI98-$LCFI97

	.byte	0x93
	.byte	0x3
	.byte	0x4
	.word	$LCFI99-$LCFI98

	.byte	0x92
	.byte	0x4
	.byte	0x4
	.word	$LCFI100-$LCFI99

	.byte	0x91
	.byte	0x5
	.byte	0x4
	.word	$LCFI101-$LCFI100

	.byte	0x90
	.byte	0x6
	.byte	0x4
	.word	$LCFI102-$LCFI101

	.byte	0xc
	.byte	0x1e
	.byte	0x28
	.align	2
$LEFDE39:
	.word	$LEFDE41-$LSFDE41

$LSFDE41:
	.word	$LSFDE41-__FRAME_BEGIN__

	.word	$LFB21

	.word	$LFE21-$LFB21

	.byte	0x4
	.word	$LCFI103-$LFB21

	.byte	0xe
	.byte	0x8
	.byte	0x4
	.word	$LCFI104-$LCFI103

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI105-$LCFI104

	.byte	0xc
	.byte	0x1e
	.byte	0x8
	.align	2
$LEFDE41:
	.word	$LEFDE43-$LSFDE43

$LSFDE43:
	.word	$LSFDE43-__FRAME_BEGIN__

	.word	$LFB22

	.word	$LFE22-$LFB22

	.byte	0x4
	.word	$LCFI106-$LFB22

	.byte	0xe
	.byte	0x8
	.byte	0x4
	.word	$LCFI107-$LCFI106

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI108-$LCFI107

	.byte	0xc
	.byte	0x1e
	.byte	0x8
	.align	2
$LEFDE43:
	.word	$LEFDE45-$LSFDE45

$LSFDE45:
	.word	$LSFDE45-__FRAME_BEGIN__

	.word	$LFB23

	.word	$LFE23-$LFB23

	.byte	0x4
	.word	$LCFI109-$LFB23

	.byte	0xe
	.byte	0x8
	.byte	0x4
	.word	$LCFI110-$LCFI109

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI111-$LCFI110

	.byte	0xc
	.byte	0x1e
	.byte	0x8
	.align	2
$LEFDE45:
	.word	$LEFDE47-$LSFDE47

$LSFDE47:
	.word	$LSFDE47-__FRAME_BEGIN__

	.word	$LFB24

	.word	$LFE24-$LFB24

	.byte	0x4
	.word	$LCFI112-$LFB24

	.byte	0xe
	.byte	0x28
	.byte	0x4
	.word	$LCFI113-$LCFI112

	.byte	0x5
	.byte	0x40
	.byte	0x1
	.byte	0x4
	.word	$LCFI114-$LCFI113

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI115-$LCFI114

	.byte	0x91
	.byte	0x3
	.byte	0x4
	.word	$LCFI116-$LCFI115

	.byte	0x90
	.byte	0x4
	.byte	0x4
	.word	$LCFI117-$LCFI116

	.byte	0xc
	.byte	0x1e
	.byte	0x28
	.align	2
$LEFDE47:
	.word	$LEFDE49-$LSFDE49

$LSFDE49:
	.word	$LSFDE49-__FRAME_BEGIN__

	.word	$LFB25

	.word	$LFE25-$LFB25

	.byte	0x4
	.word	$LCFI118-$LFB25

	.byte	0xe
	.byte	0x18
	.byte	0x4
	.word	$LCFI119-$LCFI118

	.byte	0x5
	.byte	0x40
	.byte	0x1
	.byte	0x4
	.word	$LCFI120-$LCFI119

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI121-$LCFI120

	.byte	0xc
	.byte	0x1e
	.byte	0x18
	.align	2
$LEFDE49:
	.word	$LEFDE51-$LSFDE51

$LSFDE51:
	.word	$LSFDE51-__FRAME_BEGIN__

	.word	$LFB26

	.word	$LFE26-$LFB26

	.byte	0x4
	.word	$LCFI122-$LFB26

	.byte	0xe
	.byte	0x20
	.byte	0x4
	.word	$LCFI123-$LCFI122

	.byte	0x5
	.byte	0x40
	.byte	0x1
	.byte	0x4
	.word	$LCFI124-$LCFI123

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI125-$LCFI124

	.byte	0x91
	.byte	0x3
	.byte	0x4
	.word	$LCFI126-$LCFI125

	.byte	0x90
	.byte	0x4
	.byte	0x4
	.word	$LCFI127-$LCFI126

	.byte	0xc
	.byte	0x1e
	.byte	0x20
	.align	2
$LEFDE51:
	.word	$LEFDE53-$LSFDE53

$LSFDE53:
	.word	$LSFDE53-__FRAME_BEGIN__

	.word	$LFB27

	.word	$LFE27-$LFB27

	.byte	0x4
	.word	$LCFI128-$LFB27

	.byte	0xe
	.byte	0x18
	.byte	0x4
	.word	$LCFI129-$LCFI128

	.byte	0x5
	.byte	0x40
	.byte	0x1
	.byte	0x4
	.word	$LCFI130-$LCFI129

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI131-$LCFI130

	.byte	0xc
	.byte	0x1e
	.byte	0x18
	.align	2
$LEFDE53:
	.word	$LEFDE55-$LSFDE55

$LSFDE55:
	.word	$LSFDE55-__FRAME_BEGIN__

	.word	$LFB28

	.word	$LFE28-$LFB28

	.byte	0x4
	.word	$LCFI132-$LFB28

	.byte	0xe
	.byte	0x20
	.byte	0x4
	.word	$LCFI133-$LCFI132

	.byte	0x5
	.byte	0x40
	.byte	0x1
	.byte	0x4
	.word	$LCFI134-$LCFI133

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI135-$LCFI134

	.byte	0x91
	.byte	0x3
	.byte	0x4
	.word	$LCFI136-$LCFI135

	.byte	0x90
	.byte	0x4
	.byte	0x4
	.word	$LCFI137-$LCFI136

	.byte	0xc
	.byte	0x1e
	.byte	0x20
	.align	2
$LEFDE55:
	.word	$LEFDE57-$LSFDE57

$LSFDE57:
	.word	$LSFDE57-__FRAME_BEGIN__

	.word	$LFB29

	.word	$LFE29-$LFB29

	.byte	0x4
	.word	$LCFI138-$LFB29

	.byte	0xe
	.byte	0x20
	.byte	0x4
	.word	$LCFI139-$LCFI138

	.byte	0x5
	.byte	0x40
	.byte	0x2
	.byte	0x4
	.word	$LCFI140-$LCFI139

	.byte	0x9e
	.byte	0x3
	.byte	0x4
	.word	$LCFI141-$LCFI140

	.byte	0x90
	.byte	0x4
	.byte	0x4
	.word	$LCFI142-$LCFI141

	.byte	0xc
	.byte	0x1e
	.byte	0x20
	.align	2
$LEFDE57:
	.word	$LEFDE59-$LSFDE59

$LSFDE59:
	.word	$LSFDE59-__FRAME_BEGIN__

	.word	$LFB30

	.word	$LFE30-$LFB30

	.byte	0x4
	.word	$LCFI143-$LFB30

	.byte	0xe
	.byte	0x8
	.byte	0x4
	.word	$LCFI144-$LCFI143

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI145-$LCFI144

	.byte	0xc
	.byte	0x1e
	.byte	0x8
	.align	2
$LEFDE59:
	.word	$LEFDE61-$LSFDE61

$LSFDE61:
	.word	$LSFDE61-__FRAME_BEGIN__

	.word	$LFB31

	.word	$LFE31-$LFB31

	.byte	0x4
	.word	$LCFI146-$LFB31

	.byte	0xe
	.byte	0x20
	.byte	0x4
	.word	$LCFI147-$LCFI146

	.byte	0x5
	.byte	0x40
	.byte	0x1
	.byte	0x4
	.word	$LCFI148-$LCFI147

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI149-$LCFI148

	.byte	0x91
	.byte	0x3
	.byte	0x4
	.word	$LCFI150-$LCFI149

	.byte	0x90
	.byte	0x4
	.byte	0x4
	.word	$LCFI151-$LCFI150

	.byte	0xc
	.byte	0x1e
	.byte	0x20
	.align	2
$LEFDE61:
	.word	$LEFDE63-$LSFDE63

$LSFDE63:
	.word	$LSFDE63-__FRAME_BEGIN__

	.word	$LFB32

	.word	$LFE32-$LFB32

	.byte	0x4
	.word	$LCFI152-$LFB32

	.byte	0xe
	.byte	0x20
	.byte	0x4
	.word	$LCFI153-$LCFI152

	.byte	0x5
	.byte	0x40
	.byte	0x1
	.byte	0x4
	.word	$LCFI154-$LCFI153

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI155-$LCFI154

	.byte	0x91
	.byte	0x3
	.byte	0x4
	.word	$LCFI156-$LCFI155

	.byte	0x90
	.byte	0x4
	.byte	0x4
	.word	$LCFI157-$LCFI156

	.byte	0xc
	.byte	0x1e
	.byte	0x20
	.align	2
$LEFDE63:
	.word	$LEFDE65-$LSFDE65

$LSFDE65:
	.word	$LSFDE65-__FRAME_BEGIN__

	.word	$LFB33

	.word	$LFE33-$LFB33

	.byte	0x4
	.word	$LCFI158-$LFB33

	.byte	0xe
	.byte	0x8
	.byte	0x4
	.word	$LCFI159-$LCFI158

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI160-$LCFI159

	.byte	0xc
	.byte	0x1e
	.byte	0x8
	.align	2
$LEFDE65:
	.word	$LEFDE67-$LSFDE67

$LSFDE67:
	.word	$LSFDE67-__FRAME_BEGIN__

	.word	$LFB34

	.word	$LFE34-$LFB34

	.byte	0x4
	.word	$LCFI161-$LFB34

	.byte	0xe
	.byte	0x8
	.byte	0x4
	.word	$LCFI162-$LCFI161

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI163-$LCFI162

	.byte	0xc
	.byte	0x1e
	.byte	0x8
	.align	2
$LEFDE67:
	.word	$LEFDE69-$LSFDE69

$LSFDE69:
	.word	$LSFDE69-__FRAME_BEGIN__

	.word	$LFB35

	.word	$LFE35-$LFB35

	.byte	0x4
	.word	$LCFI164-$LFB35

	.byte	0xe
	.byte	0x8
	.byte	0x4
	.word	$LCFI165-$LCFI164

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI166-$LCFI165

	.byte	0xc
	.byte	0x1e
	.byte	0x8
	.align	2
$LEFDE69:
	.word	$LEFDE71-$LSFDE71

$LSFDE71:
	.word	$LSFDE71-__FRAME_BEGIN__

	.word	$LFB36

	.word	$LFE36-$LFB36

	.byte	0x4
	.word	$LCFI167-$LFB36

	.byte	0xe
	.byte	0x8
	.byte	0x4
	.word	$LCFI168-$LCFI167

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI169-$LCFI168

	.byte	0xc
	.byte	0x1e
	.byte	0x8
	.align	2
$LEFDE71:
	.word	$LEFDE73-$LSFDE73

$LSFDE73:
	.word	$LSFDE73-__FRAME_BEGIN__

	.word	$LFB37

	.word	$LFE37-$LFB37

	.byte	0x4
	.word	$LCFI170-$LFB37

	.byte	0xe
	.byte	0x20
	.byte	0x4
	.word	$LCFI171-$LCFI170

	.byte	0x5
	.byte	0x40
	.byte	0x1
	.byte	0x4
	.word	$LCFI172-$LCFI171

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI173-$LCFI172

	.byte	0x91
	.byte	0x3
	.byte	0x4
	.word	$LCFI174-$LCFI173

	.byte	0x90
	.byte	0x4
	.byte	0x4
	.word	$LCFI175-$LCFI174

	.byte	0xc
	.byte	0x1e
	.byte	0x20
	.align	2
$LEFDE73:
	.word	$LEFDE75-$LSFDE75

$LSFDE75:
	.word	$LSFDE75-__FRAME_BEGIN__

	.word	$LFB38

	.word	$LFE38-$LFB38

	.byte	0x4
	.word	$LCFI176-$LFB38

	.byte	0xe
	.byte	0x8
	.byte	0x4
	.word	$LCFI177-$LCFI176

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI178-$LCFI177

	.byte	0xc
	.byte	0x1e
	.byte	0x8
	.align	2
$LEFDE75:
	.word	$LEFDE77-$LSFDE77

$LSFDE77:
	.word	$LSFDE77-__FRAME_BEGIN__

	.word	$LFB39

	.word	$LFE39-$LFB39

	.byte	0x4
	.word	$LCFI179-$LFB39

	.byte	0xe
	.byte	0x8
	.byte	0x4
	.word	$LCFI180-$LCFI179

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI181-$LCFI180

	.byte	0xc
	.byte	0x1e
	.byte	0x8
	.align	2
$LEFDE77:
	.word	$LEFDE79-$LSFDE79

$LSFDE79:
	.word	$LSFDE79-__FRAME_BEGIN__

	.word	$LFB40

	.word	$LFE40-$LFB40

	.byte	0x4
	.word	$LCFI182-$LFB40

	.byte	0xe
	.byte	0x8
	.byte	0x4
	.word	$LCFI183-$LCFI182

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI184-$LCFI183

	.byte	0xc
	.byte	0x1e
	.byte	0x8
	.align	2
$LEFDE79:
	.word	$LEFDE81-$LSFDE81

$LSFDE81:
	.word	$LSFDE81-__FRAME_BEGIN__

	.word	$LFB41

	.word	$LFE41-$LFB41

	.byte	0x4
	.word	$LCFI185-$LFB41

	.byte	0xe
	.byte	0x18
	.byte	0x4
	.word	$LCFI186-$LCFI185

	.byte	0x5
	.byte	0x40
	.byte	0x1
	.byte	0x4
	.word	$LCFI187-$LCFI186

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI188-$LCFI187

	.byte	0xc
	.byte	0x1e
	.byte	0x18
	.align	2
$LEFDE81:
	.word	$LEFDE83-$LSFDE83

$LSFDE83:
	.word	$LSFDE83-__FRAME_BEGIN__

	.word	$LFB42

	.word	$LFE42-$LFB42

	.byte	0x4
	.word	$LCFI189-$LFB42

	.byte	0xe
	.byte	0x18
	.byte	0x4
	.word	$LCFI190-$LCFI189

	.byte	0x5
	.byte	0x40
	.byte	0x1
	.byte	0x4
	.word	$LCFI191-$LCFI190

	.byte	0x9e
	.byte	0x2
	.byte	0x4
	.word	$LCFI192-$LCFI191

	.byte	0xc
	.byte	0x1e
	.byte	0x18
	.align	2
$LEFDE83:
	.word	0

	.align	0
