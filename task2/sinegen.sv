module sinegen #(
    parameter   A_WIDTH = 8,
                D_WIDTH = 8
)(
    // interface signals
    input logic clk,
    input logic rst,
    input logic en,
    input logic [D_WIDTH-1:0] incr, // increment for addr counter
    input logic [A_WIDTH-1:0] phase_diff,
    output logic [D_WIDTH-1:0] dout1,
    output logic [D_WIDTH-1:0] dout2
);

    logic [A_WIDTH-1:0] address1, address2; // interconnect wire
    logic [D_WIDTH-1:0] rom_data; // data from rom

counter addrCounter( // instantiate counter module
    .clk(clk),
    .rst(rst),
    .en(en),
    .incr(incr),
    .count(address1)
  //.internal_signal_name(external_signal_name)
);

assign address2 = address1 + phase_diff;

rom sineRom( // instantiate rom module
    .clk(clk),
    .addr1(address1),
    .addr2(address2),
    .dout1(dout1),
    .dout2(dout2)
);


endmodule

