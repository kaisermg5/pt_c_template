

// This is hack that prevents the linker from changing to arm mode before calling functions already in the binary
// Types don't really matter since no file sees this prototypes

__attribute__((naked)) void vanilla_alloc(){}
__attribute__((naked)) void vanilla_FS_InitFile(){}
__attribute__((naked)) void vanilla_FS_OpenFile(){}
__attribute__((naked)) void vanilla_FS_SeekFile(){}
__attribute__((naked)) void vanilla_FS_ReadFile(){}
__attribute__((naked)) void vanilla_FS_CloseFile(){}
