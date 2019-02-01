


from patcher_utils import Rom, RomPatch
from patcher_config import PATCHES

import shutil

BASEROM = 'baserom.nds'
PATCHED = 'build/patched.nds'

shutil.copyfile(BASEROM, PATCHED)


with open(PATCHED, 'rb+') as rom_to_patch:
	"""# patch ARM9
	f.seek(0xd58 + 0x4000)
	with open('build/arm9_patch.bin', 'rb') as f2:
		f.write(f2.read())

	# patch fat.bin: "test.atr" size
	EXTENSION_ROM_OFFSET = 120 * 1024 * 1024
	f.seek(0x432c00 + 0x818)
	f.write(EXTENSION_ROM_OFFSET.to_bytes(4, 'little'))
	with open('build/arm9_extension.bin', 'rb') as f2:
		data = f2.read()
	f.write((EXTENSION_ROM_OFFSET + len(data)).to_bytes(4, 'little'))
	f.seek(EXTENSION_ROM_OFFSET)
	f.write(data)"""

	for patch in PATCHES:
		patch.patch_rom(rom_to_patch)

print('Patched')