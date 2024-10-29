module sinegen #(
    parameter   A_WIDTH = 8,
                D_WIDTH = 8
)(
    // interface signals
    input logic clk,
    input logic rst,
    input logic en,
    input logic [D_WIDTH-1:0] incr, // increment for addr counter
    output logic [D_WIDTH-1:0] dout
);

    logic [A_WIDTH-1:0] address; // interconnect wire

counter addrCounter( // instantiate counter module
    .clk(clk),
    .rst(rst),
    .en(en),
    .incr(incr),
    .count(address)
  //.internal_signal_name(external_signal_name)
);

rom sineRom( // instantiate rom module
    .clk(clk),
    .addr(address),
    .dout(dout)
);

endmodule

