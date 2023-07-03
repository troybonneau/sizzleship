BUILD_DIR=build
SOURCE_DIR=.
include $(N64_INST)/include/n64.mk

assets_png = $(wildcard assets/*.png)

assets_conv = $(addprefix filesystem/,$(notdir $(assets_png:%.png=%.sprite)))

MKSPRITE_FLAGS ?=

N64_CXXFLAGS += -std=c++14

all: sizzleship.z64

filesystem/%.sprite: assets/%.png
	@mkdir -p $(dir $@)
	@echo "    [SPRITE] $@"
	@$(N64_MKSPRITE) -f RGBA16 --compress -o "$(dir $@)" "$<"

$(BUILD_DIR)/sizzleship.dfs: $(assets_conv)


OBJS = $(BUILD_DIR)/sizzleship.o

$(BUILD_DIR)/sizzleship.elf: $(OBJS)

sizzleship.z64: N64_ROM_TITLE="Sizzleship"
sizzleship.z64: $(BUILD_DIR)/sizzleship.dfs

clean:
	rm -rf $(BUILD_DIR) sizzleship.z64

-include $(wildcard $(BUILD_DIR)/*.d)

.PHONY: all clean
