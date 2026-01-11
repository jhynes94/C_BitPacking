# Compiler
CC = gcc

# Compiler flags
CFLAGS = -Wall -Wextra -g

# Build directory
BUILD_DIR = build

# Source files
SRC = bitPacking.c

# Output binary
TARGET = $(BUILD_DIR)/bitPacking

# Default target
all: $(BUILD_DIR) $(TARGET)

# Create build directory if it doesn't exist
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

# Build target
$(TARGET): $(SRC)
	$(CC) $(CFLAGS) $(SRC) -o $(TARGET)

# Clean build artifacts
clean:
	rm -rf $(BUILD_DIR)

# Run the program
run: $(TARGET)
	./$(TARGET)

.PHONY: all clean run
