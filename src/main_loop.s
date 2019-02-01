
@ Just a copypaste of the original game loop
@ Not all .equ are necessary, I was just lazy

.thumb 

.equ RAM_21bf67c_6c,        0x6c
.equ RAM_21bf67c_VBlankCounter,             0x30
.equ RAM_2101d20_4,         0x4

.equ RAM_2101d20_Backlight,             0x0 @ Backlight status
.equ RAM_2101d20_4,         0x4
.equ RAM_2101d20_OverlayToUnload,       0x8
.equ RAM_2101d20_PtrToOverlayData,      0xc
.equ RAM_2101d20_OverlayToLoad,         0x10 @ 0xffffffff = No Overlay to load
.equ RAM_2101d20_JumpTable,             0x14
.equ RAM_2101d20_18,        0x18
.equ RAM_2101d20_1c,        0x1c
.equ RAM_2101d20_VariableAreaAdresses,  0x20 @ Pointer to VariableAreaAdresses

.equ OverlayData_Size,                  0x28
.equ OverlayData_JumpTable0,                     0x0 @ JumpTable+0x0
.equ OverlayData_JumpTable1,                     0x4 @ JumpTable+0x4
.equ OverlayData_JumpTable2,                     0x8 @ JumpTable+0x8
.equ OverlayData_JumpTable3,                     0xc @ JumpTable+0xc
.equ OverlayData_FunctionCounter,       0x10
.equ OverlayData_14,                    0x14
.equ OverlayData_14_0,                      0x0 @ StateNr
.equ OverlayData_18,                    0x18
.equ OverlayData_1c,                    0x1c
.equ OverlayData_20,                    0x20
.equ OverlayData_24,                    0x24


.equ RAM_2101d44_0,         0x0
.equ RAM_2101d44_0_1,           0x1 @ lsl #31
.equ RAM_2101d44_0_4,           0x4 @ lsl #29
.equ RAM_2101d44_0_8,           0x8 @ lsl #28
.equ RAM_2101d44_0_10,          0x10 @ lsl #27
.equ RAM_2101d44_0_20,          0x20 @ lsl #26
.equ RAM_2101d44_0_40,          0x40 @ lsl #25
.equ RAM_2101d44_0_80,          0x80 @ lsl #24
.equ RAM_2101d44_1,         0x1
.equ RAM_2101d44_2,         0x2
.equ RAM_2101d4c_84,        0x84 @ RAM_2101dd0
.equ RAM_2101d4c_94,        0x94 @ RAM_2101de0


.equ RAM_2101df0_4,         0x4

.equ RAM_2101df8_94,        0x94
.equ RAM_2101df8_98,        0x98


.equ RAM_21bf5b4_c,         0xc
.equ RAM_21bf5b4_e,         0xe
.equ RAM_21bf5b4_f,         0xf
.equ RAM_21bf5b4_10,        0x10


.equ RAM_21bf5c8_0,         0x0
.equ RAM_21bf5c8_4,         0x4
.equ RAM_21bf5c8_8,         0x8
.equ RAM_21bf5c8_c,         0xc


.equ RAM_21bf67c_FunctPtr,                  0x0
.equ RAM_21bf67c_FunctArg,                  0x4
.equ RAM_21bf67c_8,         0x8
.equ RAM_21bf67c_c,         0xc
.equ RAM_21bf67c_10,        0x10
.equ RAM_21bf67c_14,        0x14
.equ RAM_21bf67c_TaskList1,                 0x18
.equ RAM_21bf67c_TaskList1_Size,                160
.equ RAM_21bf67c_TaskList2,                 0x1c
.equ RAM_21bf67c_TaskList2_Size,                32
.equ RAM_21bf67c_TaskList3,                 0x20
.equ RAM_21bf67c_TaskList3_Size,                32
.equ RAM_21bf67c_TaskList4,                 0x24
.equ RAM_21bf67c_TaskList4_Size,                4
.equ RAM_21bf67c_2c,        0x2c
.equ RAM_21bf67c_VBlankCounter,             0x30
.equ RAM_21bf67c_34,        0x34
.equ RAM_21bf67c_38_KeyOldPressed,          0x38
.equ RAM_21bf67c_3c_KeyNewPressed,          0x3c
.equ RAM_21bf67c_40_KeyNewPressed,          0x40
.equ RAM_21bf67c_44_Key,                    0x44 @ keys that are hold?
.equ RAM_21bf67c_48_KeyNewPressed2,         0x48
.equ RAM_21bf67c_4c_Key,                    0x4c @ keys?
.equ RAM_21bf67c_50_InputDelayCounter,      0x50 @ Init with # of Frames in Input Delay, if =0 calculate new Input
.equ RAM_21bf67c_54,        0x54
.equ RAM_21bf67c_58_InputDelay,             0x58 @ # of Frames that Input is collected
.equ RAM_21bf67c_6c,        0x6c
.equ RAM_21bf67c_70,        0x70
.equ RAM_21bf6dc_8,          0x8


branch_2000d5e: @ 2000d5e :thumb
	ldr     r0, =#RAM_21bf67c
	mov     r1, #0x1
	str     r1, [r0, #RAM_21bf67c_6c]
	mov     r1, #0x0
	str     r1, [r0, #RAM_21bf67c_VBlankCounter]

	bl      InitRNG
	bl      InitBlendTables
	bl      Function_2017428

	mov     r1, #0x0
	ldr     r0, =#RAM_2101d20
	mov     r7, #0xc3
	ldr     r6, =#RAM_21bf6dc
	ldr     r4, =#RAM_21bf67c
	str     r1, [r0, #RAM_2101d20_4]
	mov     r5, r1
	lsl     r7, r7, #2          @ 0x30C = KEY_SELECT | KEY_START | KEY_R | KEY_L

mainloop: @ 2000d84 :thumb
	bl      Function_2000f30
	bl      Function_200106c
	bl      UpdateInput

	mov     r0, #0xc3
	ldr     r1, [r4, #RAM_21bf67c_38_KeyOldPressed]
	lsl     r0, r0, #2          @ 0x30C = KEY_SELECT | KEY_START | KEY_R | KEY_L
	and     r0, r1
	cmp     r0, r7
	bne     branch_2000da8

	ldrb    r0, [r6, #RAM_21bf6dc_8]
	cmp     r0, #0x0
	bne     branch_2000da8
	mov     r0, #0x0
	bl      Function_2000f60
branch_2000da8: @ 2000da8 :thumb

	bl      Function_20349ec
	cmp     r0, #0x0
	beq     branch_2000dd8

	bl      Function_2000f30
	bl      HandleOverlays

	ldr     r0, [r4, #RAM_21bf67c_TaskList1]
	bl      RunTasks

	ldr     r0, [r4, #RAM_21bf67c_TaskList4]
	bl      RunTasks

	ldr     r0, [r4, #RAM_21bf67c_VBlankCounter]
	cmp     r0, #0x0
	bne     branch_2000dd8
	@b     branch_2000dd8

	mov     r0, #0x1
	mov     r1, r0
	blx     OS_WaitIrq
	ldr     r0, [r4, #RAM_21bf67c_2c]
	.hword  0x1c40 @ add r0, r0, #0x1
	str     r0, [r4, #RAM_21bf67c_2c]
branch_2000dd8: @ 2000dd8 :thumb

	bl      Function_20137c4
	bl      Function_2017458
	bl      Function_20241cc

	ldr     r0, [r4, #RAM_21bf67c_TaskList4]
	bl      RunTasks

	mov     r0, #0x1
	mov     r1, r0
	blx     OS_WaitIrq

	ldr     r0, [r4, #RAM_21bf67c_2c]
	.hword  0x1c40 @ add r0, r0, #0x1
	str     r0, [r4, #RAM_21bf67c_2c]

	str     r5, [r4, #RAM_21bf67c_VBlankCounter]

	bl      Function_200abf0
	bl      Function_200f27c

	ldr     r1, [r4, #RAM_21bf67c_FunctPtr]
	cmp     r1, #0x0
	beq     branch_2000e0c
	ldr     r0, [r4, #RAM_21bf67c_FunctArg]
	blx     r1
branch_2000e0c: @ 2000e0c :thumb

	bl      Function_2003bd8

	ldr     r0, [r4, #RAM_21bf67c_TaskList3]
	bl      RunTasks

	b       mainloop
@ 0x2000e18

.pool

