
#include <types.h>
#define VANILLA_FUNC
#include <narc_fs.h>

extern u8 * arm9_extension_allocated_offset;
extern void * vanilla_alloc(u8, u32);
extern u8 * __arm9_extension_start;
extern u8 * __arm9_extension_end;
//extern u32 arm9_extension_size;

// Called in main_patch_s.s
// Loads the extension
void load_arm9_extension() {
	u32 arm9_extension_size = (u32) (__arm9_extension_end - __arm9_extension_start);

	arm9_extension_allocated_offset = vanilla_alloc(0, arm9_extension_size);

	NarcFileHandler file;
	vanilla_FS_InitFile(&file);
	vanilla_FS_OpenFile(&file, "data/test.atr");
	vanilla_FS_SeekFile(&file, 0, SEEK_SET);
	vanilla_FS_ReadFile(&file, arm9_extension_allocated_offset, arm9_extension_size);
	vanilla_FS_CloseFile(&file);
}
