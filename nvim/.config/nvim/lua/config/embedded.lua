-- Embedded Systems Development Configuration for Neovim
-- Save to: ~/.config/nvim/lua/config/embedded.lua

-- Helper function to detect if we're in an embedded project
local function is_embedded_project()
    local path = vim.fn.expand("%:p")
    local has_makefile = vim.fn.filereadable("Makefile") == 1
    local has_avr = path:match("avr") or path:match("arduino") or path:match("embedded")
    return has_makefile or has_avr
end

-- Arduino/AVR specific settings
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp", "h" },
    callback = function()
	if not is_embedded_project() then return end

	-- Set up proper syntax for AVR registers
	vim.opt_local.syntax = "c"

	-- Key mappings for embedded workflow
	local opts = { buffer = true, silent = true }

	-- Compile
	vim.keymap.set("n", "<leader>ec", function()
	    vim.cmd("write")  -- Save first
	    vim.cmd("!make")
	    vim.notify("Compilation complete!", vim.log.levels.INFO)
	end, vim.tbl_extend("force", opts, { desc = "Embedded: Compile" }))

	-- Flash to device
	vim.keymap.set("n", "<leader>ef", function()
	    vim.cmd("!make flash")
	    vim.notify("Flashed to device!", vim.log.levels.INFO)
	end, vim.tbl_extend("force", opts, { desc = "Embedded: Flash" }))

	-- Build + Flash
	vim.keymap.set("n", "<leader>eb", function()
	    vim.cmd("write")
	    vim.cmd("!make && make flash")
	end, vim.tbl_extend("force", opts, { desc = "Embedded: Build + Flash" }))

	-- Clean
	vim.keymap.set("n", "<leader>ex", function()
	    vim.cmd("!make clean")
	    vim.notify("Cleaned build files", vim.log.levels.INFO)
	end, vim.tbl_extend("force", opts, { desc = "Embedded: Clean" }))

	-- Open serial monitor
	vim.keymap.set("n", "<leader>es", function()
	    local port = vim.fn.input("Serial port (/dev/ttyACM0): ", "/dev/ttyACM0")
	    local baud = vim.fn.input("Baud rate (9600): ", "9600")
	    vim.cmd("terminal picocom -b " .. baud .. " " .. port)
	end, vim.tbl_extend("force", opts, { desc = "Embedded: Serial Monitor" }))

	-- View disassembly
	vim.keymap.set("n", "<leader>ed", function()
	    vim.cmd("!avr-objdump -d main.elf > disassembly.txt && cat disassembly.txt")
	end, vim.tbl_extend("force", opts, { desc = "Embedded: View Disassembly" }))

	-- View size/memory usage
	vim.keymap.set("n", "<leader>em", function()
	    vim.cmd("!avr-size -C --mcu=atmega328p main.elf")
	end, vim.tbl_extend("force", opts, { desc = "Embedded: Memory Usage" }))
    end,
})

-- Auto-create Makefile template for new embedded projects
vim.api.nvim_create_user_command("EmbeddedInit", function()
    local makefile_content = [[
# AVR Makefile for ATmega328P (Arduino Uno)

# Microcontroller settings
MCU = atmega328p
F_CPU = 16000000UL

# Programmer settings
PROGRAMMER = arduino
PORT = /dev/ttyACM0
BAUD = 115200

# Compiler settings
CC = avr-gcc
OBJCOPY = avr-objcopy
SIZE = avr-size
AVRDUDE = avrdude

# Compiler flags
CFLAGS = -mmcu=$(MCU) -DF_CPU=$(F_CPU) -Os -Wall -Wextra
LDFLAGS = -mmcu=$(MCU)

# Source files
SRC = main.c
OBJ = $(SRC:.c=.o)
TARGET = main

# Build
all: $(TARGET).hex
	@$(SIZE) -C --mcu=$(MCU) $(TARGET).elf

$(TARGET).elf: $(OBJ)
	$(CC) $(LDFLAGS) -o $@ $^

$(TARGET).hex: $(TARGET).elf
	$(OBJCOPY) -O ihex $< $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Flash to device
flash: $(TARGET).hex
	$(AVRDUDE) -p $(MCU) -c $(PROGRAMMER) -P $(PORT) -b $(BAUD) -U flash:w:$<:i

# Clean
clean:
	rm -f $(OBJ) $(TARGET).elf $(TARGET).hex

# Phony targets
.PHONY: all flash clean
]]

    local main_c_content = [[
#include <avr/io.h>
#include <util/delay.h>

int main(void) {
    // Setup
    DDRB |= (1 << PB5);  // Set PB5 (pin 13) as output

    // Main loop
    while(1) {
	PORTB ^= (1 << PB5);  // Toggle LED
	_delay_ms(1000);
    }

    return 0;
}
]]

    -- Create Makefile
    local makefile = io.open("Makefile", "w")
    if makefile then
	makefile:write(makefile_content)
	makefile:close()
	vim.notify("Created Makefile", vim.log.levels.INFO)
    end

    -- Create main.c if it doesn't exist
    if vim.fn.filereadable("main.c") == 0 then
	local mainc = io.open("main.c", "w")
	if mainc then
	    mainc:write(main_c_content)
	    mainc:close()
	    vim.notify("Created main.c", vim.log.levels.INFO)
	end
    end

    vim.cmd("edit main.c")
end, { desc = "Initialize embedded project with Makefile and main.c" })

-- Quick reference command
vim.api.nvim_create_user_command("EmbeddedRef", function()
    local help_text = [[
╔════════════════════════════════════════════════════════════════╗
║          AVR/EMBEDDED SYSTEMS QUICK REFERENCE                  ║
╚════════════════════════════════════════════════════════════════╝

KEYBINDINGS:
  <leader>ec  - Compile project
  <leader>ef  - Flash to device
  <leader>eb  - Build + Flash
  <leader>es  - Open serial monitor
  <leader>ex  - Clean build files
  <leader>ed  - View disassembly
  <leader>em  - View memory usage

COMMANDS:
  :EmbeddedInit  - Create Makefile and main.c template
  :EmbeddedRef   - Show this reference

PORT REGISTERS (ATmega328P):
  DDRx   - Data Direction (1=output, 0=input)
  PORTx  - Write output / Enable pull-up
  PINx   - Read input state

  Example: DDRB |= (1 << PB5);   // Set PB5 as output
	   PORTB ^= (1 << PB5);  // Toggle PB5

BITWISE OPERATIONS:
  |=   - Set bit(s)      Example: PORTB |= (1 << PB5);
  &= ~ - Clear bit(s)    Example: PORTB &= ~(1 << PB5);
  ^=   - Toggle bit(s)   Example: PORTB ^= (1 << PB5);
  &    - Check bit       Example: if (PINB & (1 << PB5))

INTERRUPTS:
  sei()  - Enable global interrupts
  cli()  - Disable global interrupts

  ISR(VECTOR_NAME) { }  - Define interrupt handler

  Example:
    ISR(TIMER0_OVF_vect) {
	// Handle timer overflow
    }

TIMERS (Timer0 example):
  TCCR0B - Timer control (prescaler, mode)
  TCNT0  - Current count value
  OCR0A  - Compare value A
  TIMSK0 - Interrupt enable

  Prescalers: CS02, CS01, CS00
    001 = No prescaling
    010 = /8
    011 = /64
    100 = /256
    101 = /1024

UART:
  UBRRn  - Baud rate register
  UDRn   - Data register
  UCSRnA - Status register
  UCSRnB - Control register (enable TX/RX)
  UCSRnC - Config (data bits, parity, stop bits)

USEFUL FORMULAS:
  UBRR = (F_CPU / (16 * BAUD)) - 1
  Timer frequency = F_CPU / (prescaler * (1 + OCRnx))

Press 'q' to close
  ]]

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(help_text, "\n"))
    vim.api.nvim_buf_set_option(buf, "modifiable", false)

    local width = 70
    local height = 50
    local win = vim.api.nvim_open_win(buf, true, {
	relative = "editor",
	width = width,
	height = height,
	col = (vim.o.columns - width) / 2,
	row = (vim.o.lines - height) / 2,
	style = "minimal",
	border = "rounded",
    })

    vim.api.nvim_buf_set_keymap(buf, "n", "q", ":q<CR>", { noremap = true, silent = true })
end, { desc = "Show embedded systems reference" })

-- Highlight AVR-specific keywords
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "c", "cpp" },
    callback = function()
	if is_embedded_project() then
	    vim.cmd([[
	syntax keyword avrRegister DDRB DDRC DDRD PORTB PORTC PORTD PINB PINC PIND
	syntax keyword avrRegister TCCR0A TCCR0B TCCR1A TCCR1B TCCR2A TCCR2B
	syntax keyword avrRegister TCNT0 TCNT1 TCNT2 OCR0A OCR0B OCR1A OCR1B OCR2A OCR2B
	syntax keyword avrRegister TIMSK0 TIMSK1 TIMSK2 TIFR0 TIFR1 TIFR2
	syntax keyword avrRegister UDR0 UBRR0 UCSR0A UCSR0B UCSR0C
	syntax keyword avrRegister ADMUX ADCSRA ADCL ADCH
	syntax keyword avrRegister EIMSK EICRA PCICR PCMSK0 PCMSK1 PCMSK2
	syntax keyword avrMacro sei cli _delay_ms _delay_us ISR
	highlight link avrRegister Special
	highlight link avrMacro Macro
	]])
	end
    end,
})
