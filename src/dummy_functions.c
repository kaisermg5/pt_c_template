

// This is hack that prevents the linker from changing to arm mode before calling functions already in the binary
// Types don't really matter since no file sees this prototypes

__attribute__((naked)) void InitRNG(){}
__attribute__((naked)) void InitBlendTables(){}
__attribute__((naked)) void Function_2017428(){}
__attribute__((naked)) void Function_2000f30(){}
__attribute__((naked)) void Function_200106c(){}
__attribute__((naked)) void UpdateInput(){}
__attribute__((naked)) void Function_2000f60(){}
__attribute__((naked)) void Function_20349ec(){}
__attribute__((naked)) void Function_20137c4(){}
__attribute__((naked)) void HandleOverlays(){}
__attribute__((naked)) void RunTasks(){}
__attribute__((naked)) void Function_2017458(){}
__attribute__((naked)) void Function_20241cc(){}
__attribute__((naked)) void OS_WaitIrq(){}
__attribute__((naked)) void Function_200abf0(){}
__attribute__((naked)) void Function_200f27c(){}
__attribute__((naked)) void Function_2003bd8(){}
