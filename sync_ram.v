// Define a parameterized synchronous RAM module
module sync_ram #(
    parameter DATA_WIDTH = 8,    // Width of data (default: 8 bits)
    parameter ADDRESS_WIDTH = 4, // Width of address (default: 4 bits)
    parameter DEPTH = 16         // Depth of memory (default: 16 locations)
) (
    input wire clk,              // Clock signal
    input wire we,               // Write enable signal (1 = write, 0 = read)
    input wire [ADDRESS_WIDTH-1:0] addr, // Address input
    input wire [DATA_WIDTH-1:0] din,     // Data input (for write operations)
    output reg [DATA_WIDTH-1:0] dout     // Data output (for read operations)
);

    // Declare the RAM array
    // - DEPTH: Number of memory locations (default: 16)
    // - DATA_WIDTH: Width of each memory location (default: 8 bits)
    reg [DATA_WIDTH-1:0] ram [0:DEPTH-1];

    // Synchronous read/write logic
    always @(posedge clk) begin
        if (we) begin
            // Write operation:
            // When write enable (we) is high, write data (din) to the memory location
            // specified by the address (addr) on the rising edge of the clock.
            ram[addr] <= din;
        end
        // Read operation:
        // Always read the data from the memory location specified by the address (addr)
        // and assign it to the output (dout) on the rising edge of the clock.
        dout <= ram[addr];
    end
