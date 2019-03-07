
ifndef DEVKITARM
$(error DEVKITARM variable is blank)
else
PATH := $(DEVKITARM)/bin:$(PATH)
endif

PYTHON := python3
PATCHER := $(PYTHON) tools/rom_patcher.py

CC := arm-none-eabi-gcc
C_OPTIONS := -Os -mthumb -mthumb-interwork -mcpu=arm946e-s -mtune=arm946e-s -march=armv5te -I include
AS := arm-none-eabi-as
AS_OPTIONS := -mthumb -march=armv5te
OBJCOPY := arm-none-eabi-objcopy
LD := arm-none-eabi-ld
LD_OPTIONS :=  -T CPUE.ld


BUILD := build
BASEROM := baserom.nds
PATCHED_ROM := $(BUILD)/patched.nds

all: $(PATCHED_ROM)


# ARM9 patch
ARM9_PATCH_DIR := arm9_patch
ARM9_PATCH_SRC := $(BUILD)/arm9_patch/main_patch_s.o $(BUILD)/arm9_patch/main_patch_c.o
ARM9_PATCH_OBJ := $(BUILD)/arm9_patch.o
ARM9_PATCH_BIN := $(BUILD)/arm9_patch.bin

# ARM9 extension
SRC_DIR := src
EXTENSION_SRC := $(patsubst %.c,$(BUILD)/%.o,$(wildcard $(SRC_DIR)/*.c)) $(patsubst %.s,$(BUILD)/%.o,$(wildcard $(SRC_DIR)/*.s))
EXTENSION_OBJ := $(BUILD)/arm9_extension.o
EXTENSION_BIN := $(BUILD)/arm9_extension.bin
OFFSETS_FILE := $(BUILD)/offsets.txt


$(BUILD)/$(ARM9_PATCH_DIR)/%.o: $(ARM9_PATCH_DIR)/%.s
	@mkdir -p $(@D)
	$(AS) $(AS_OPTIONS) $< -o $@


$(BUILD)/$(ARM9_PATCH_DIR)/%.o: $(ARM9_PATCH_DIR)/%.c
	@mkdir -p $(@D)
	$(CC) $(C_OPTIONS) -c -o $@ $<

$(ARM9_PATCH_BIN): $(EXTENSION_OBJ)
	$(OBJCOPY) --only-section=arm9_patch -O binary $<  $@



$(BUILD)/$(SRC_DIR)/%.o: $(SRC_DIR)/%.s
	@mkdir -p $(@D)
	$(AS) $(AS_OPTIONS) $< -o $@


$(BUILD)/$(SRC_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(@D)
	$(CC) $(C_OPTIONS) -c -o $@ $<


$(EXTENSION_OBJ): $(EXTENSION_SRC) $(ARM9_PATCH_SRC) arm9_extension.ld
	@mkdir -p $(@D)
	$(LD) $(LD_OPTIONS) -T arm9_extension.ld -o $@ $(EXTENSION_SRC) $(ARM9_PATCH_SRC)

$(EXTENSION_BIN): $(EXTENSION_OBJ)
	$(OBJCOPY) --only-section=arm9_extension -O binary $< $@

# -------------------------

$(OFFSETS_FILE): $(EXTENSION_OBJ)
	@echo Generationg offsets file...
	@arm-none-eabi-nm $< > $@


$(PATCHED_ROM): $(ARM9_PATCH_BIN) $(EXTENSION_BIN) $(OFFSETS_FILE)
	@mkdir -p $(@D)
	@echo Patching...
	@$(PATCHER)

clean: 
	@rm -rf $(BUILD)


.PHONY: $(PATCHED_ROM)