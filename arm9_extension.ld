OUTPUT_ARCH(arm)
MEMORY {
	arm9_patch     : ORIGIN = 0x02000d58, LENGTH = 192
  arm9_extension     : ORIGIN = 0x00380000, LENGTH = 512K
}



SECTIONS {
		.arm9_patch :
	{
    build/arm9_patch/main_patch_s.o (.text)
    build/arm9_patch/main_patch_c.o (.text)

  } >arm9_patch = 0xff


  .arm9_extension :
  {
  	__arm9_extension_start = .;
  	build/src/main_loop.o (.text)
  	*(.text)
  	*(.bss)
  	__arm9_extension_end = .;
  	__arm9_extension_size = __arm9_extension_end - __arm9_extension_start;
  } >arm9_extension = 0xff
}

__arm9_extension_rom_start = 120 * 1024 * 1024;
__arm9_extension_rom_end = __arm9_extension_rom_start + __arm9_extension_size;
