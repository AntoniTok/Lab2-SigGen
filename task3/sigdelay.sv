module sigdelay #(
    parameter WIDTH = 8,
    parameter ADDRESS_WIDTH = 9,
    parameter DATA_WIDTH = 8
)(
    input logic clk,
    input logic rst,
    input logic en,
    input logic wr,
    input logic rd,
    input logic [ADDRESS_WIDTH-1:0] offset,
    input logic [DATA_WIDTH-1:0] mic_signal,
    output logic [DATA_WIDTH-1:0] delayed_signal
);

    // Counter signals
    logic [ADDRESS_WIDTH-1:0] wr_addr;

    // Instantiate the counter
    counter addrCounter(
        .clk(clk),
        .rst(rst),
        .en(en),
        .count(wr_addr)
    );

    logic [ADDRESS_WIDTH-1:0] rd_addr;
    assign rd_addr = wr_addr - offset;

    // Instantiate the dual-port RAM
    ram micram(
        .clk(clk),
        .wr_addr(wr_addr),
        .rd_addr(rd_addr),
        .din(mic_signal),
        .dout(delayed_signal),
        .wr_en(wr),
        .rd_en(rd)
    );


endmodule

