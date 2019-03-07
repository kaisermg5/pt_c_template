#ifndef NARC_FS_H
#define NARC_FS_H

typedef struct {
	u8 unk[0x48];
} NarcFileHandler;

extern void FS_InitFile(NarcFileHandler * file);
extern s32 FS_OpenFile(NarcFileHandler * file, u8 * filename);
enum FILE_SEEK_MODES {
	SEEK_SET,
	SEEK_CUR,
	SEEK_END
};
extern s32 FS_SeekFile(NarcFileHandler * file, u32 offset, enum FILE_SEEK_MODES mode);
extern s32 FS_ReadFile(NarcFileHandler * file, u8 * dest, u32 size);
extern void FS_CloseFile(NarcFileHandler * file);


#ifdef VANILLA_FUNC
	extern void vanilla_FS_InitFile(NarcFileHandler * file);
	extern s32 vanilla_FS_OpenFile(NarcFileHandler * file, u8 * filename);
	extern s32 vanilla_FS_SeekFile(NarcFileHandler * file, u32 offset, enum FILE_SEEK_MODES mode);
	extern s32 vanilla_FS_ReadFile(NarcFileHandler * file, u8 * dest, u32 size);
	extern void vanilla_FS_CloseFile(NarcFileHandler * file);
#endif

#endif