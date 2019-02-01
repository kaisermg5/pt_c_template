
#include <types.h>
#include <narc_fs.h>

extern u8 arm9_extension_start;
//extern u32 arm9_extension_size;

// Called in main_patch_s.s
// Loads the extension
void load_arm9_extension() {
	NarcFileHandler file;
	FS_InitFile(&file);
	FS_OpenFile(&file, "data/test.atr");
	FS_SeekFile(&file, 0, SEEK_SET);
	FS_ReadFile(&file, &arm9_extension_start, 512 * 1024);//arm9_extension_size);
	FS_CloseFile(&file);
}
