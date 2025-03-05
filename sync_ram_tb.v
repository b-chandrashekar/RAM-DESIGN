module sync_ram_tb;
    parameter DATA_WIDTH = 8;
    parameter ADDRESS_WIDTH = 4;
    parameter DEPTH = 16;

    reg clk;
    reg we;
    reg [ADDRESS_WIDTH-1:0] addr;
    reg [DATA_WIDTH-1:0] din;
    wire [DATA_WIDTH-1:0] dout;

    // Instantiate the RAM module
    sync_ram #(DATA_WIDTH, ADDRESS_WIDTH, DEPTH) uut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .din(din),
        .dout(dout)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        we = 0;
        addr = 0;
        din = 0;

        // Write operation
        #10 we = 1; addr = 4'hA; din = 8'h55;
        #10 we = 0;

        // Read operation
        #10 addr = 4'hA;
        #10 $display("Read data: %h", dout);

        // Another write operation
        #10 we = 1; addr = 4'hB; din = 8'hAA;
        #10 we = 0;

        // Read back the new data
        #10 addr = 4'hB;
        #10 $display("Read data: %h", dout);

        #20 $finish;
    end
endmodule
