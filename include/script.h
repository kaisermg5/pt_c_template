#ifndef SCRIPT_H
#define SCRIPT_H

struct ScriptHandler;

typedef u32 (*ScriptCommand)(struct ScriptHandler *);

struct ScriptHandler {
	u8 unk_00;
	u8 state;
	/*
		.equ ScriptHandler_StateOff,            0x0
		.equ ScriptHandler_StateOn,             0x1
		.equ ScriptHandler_StateExecFct,        0x2
	*/
	u16 unk_02;
	void * ptr_to_fct;
	void * unk_ptr;
	u32 stack_unk[0x50 / 4];
	ScriptCommand * commands;
	u32 nr_of_cmds;
	u32 unk_0c[(0x80 - 0x64) / 4];
	void * overworld_data;

	/*
	.equ ScriptHandler_c,               0xc     @ 0x14 * 4 Bytes
	.equ ScriptHandler_Stack_c,             0xc
	.equ ScriptHandler_MaxStackDepth,       0x14
	.equ ScriptHandler_PtrToJumpTable,  0x5c    @ =JumpTable_Scripthandler (initialised in Function_203e724)
	.equ ScriptHandler_NrOfCmds,        0x60    @ =Nr of ScriptCmds (initialised in Function_203e724)
	.equ ScriptHandler_64,              0x64
	.equ ScriptHandler_74,              0x74 @ UnknownStruct01
	.equ ScriptHandler_74_18,               0x18
	.equ ScriptHandler_7c,              0x7c
	.equ ScriptHandler_78,              0x78
	.equ ScriptHandler_78_0,                0x0 @ 0 or 1
	.equ ScriptHandler_78_2,                0x2
	.equ ScriptHandler_78_6,                0x6
	.equ ScriptHandler_78_8,                0x8 @ Ptr to Msg?
	.equ ScriptHandler_OverWorldData,              0x80    @ Ptr to OverWorldData
	.equ ScriptHandler_OverWorldData_0,            0x0
	*/
};



#endif 