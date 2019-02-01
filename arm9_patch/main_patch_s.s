.thumb

_patch_start:
	b branch_2000d5e 
branch_2000d5a: @ 2000d5a :thumb
	.word 0xFE0BF021 @ bl ErrorHandling
	@ it changes to arm mode if called via bl. I'd rather hardcode it than find a workaround :)

branch_2000d5e:
	push {r2-r3}
	bl load_arm9_extension
	pop {r2-r3}
	
	ldr r0, =#arm9_extension_start + 1
	bx r0

.pool

