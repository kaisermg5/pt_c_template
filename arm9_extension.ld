OUTPUT_ARCH(arm)
MEMORY {
        arm9_extension     : ORIGIN = 0x02380000, LENGTH = 512K
}



SECTIONS {
        .arm9_extension :
        {
        	__arm9_extension_start = .;
        	build/src/main_loop.o (.text)
        	*(.text)
        	*(.bss)
        	__arm9_extension_size = .;
        } >arm9_extension = 0xff
}

__arm9_extension_rom_start = 120 * 1024 * 1024;
__arm9_extension_rom_end = __arm9_extension_rom_start + __arm9_extension_size - __arm9_extension_start;
