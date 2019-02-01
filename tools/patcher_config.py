from patcher_utils import Rom, RomPatch

# Usage: 
# RomPatch(offset, expression)

# Expressions:
# Binary string: "00 11 22 33"
# File: "#f{filename}"
# Symbol from the compiled extension (check build/offsets.txt): #w{symbol_name}
# Thumb function (the same as the previous one, but ticks the least significant bit to the offset): #t{symbol_name}

# You can use symbols in the offset calculations by making a call to: Rom.get_symbol('symbol_name')

PATCHES = [
	# Patch ARM9 code
	RomPatch(0x4d58, '#f{build/arm9_patch.bin}'),

	# Patch fat.bin to replace "data/test.atr"
	RomPatch(0x432c00 + 0x818, '#w{__arm9_extension_rom_start}#w{__arm9_extension_rom_end}'),

	# Insert ARM9 extension
	RomPatch(Rom.get_symbol('__arm9_extension_rom_start'), '#f{build/arm9_extension.bin}'),

	# Replace script command: Nop1 
	# RomPatch(Rom.get_symbol('JumpTable_ScriptHandler') + 4, '#t{CustomScrCmd_CallSpecial}'),
]
