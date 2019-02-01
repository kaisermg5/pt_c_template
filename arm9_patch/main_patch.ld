OUTPUT_ARCH(arm)
MEMORY {
  arm9_patch     : ORIGIN = 0x02000d58, LENGTH = 192
}

arm9_extension_start = 0x02380000; 		/* Should also be modified in arm9_extension.ld */
arm9_extension_size = 512 * 1024;			/* Should also be modified in arm9_extension.ld */

SECTIONS {
	.arm9_patch :
	{
    build/arm9_patch/main_patch_s.o (.text)
    build/arm9_patch/main_patch_c.o (.text)

  } >arm9_patch = 0xff
}
