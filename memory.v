module memory ( 
    input clk,
    input [15:0]din,
    input [15:0]addr, input wr,
    input rd,
    output reg [15:0]dout, 
    output reg [15:0]out_addr );
    reg [15:0] mem [2**16-1: 0]; 
    reg [15:0] pre_addr;

    always @ (posedge clk) begin 
        if (wr) begin
            mem [addr] <= din; 
            pre_addr <= addr;
        end
        if (rd) begin
            dout<< mem [pre_addr]; 
            out_addr <= pre_addr;
        end
    end
endmodule //memory