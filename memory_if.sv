interface memory if(input logic clk);

    Logic [15:0] din;
    wire [15:0] dout;
    logic [15:0] addr;
    logic [15:0] out_addr;
    bit clk;
    bit rd;
    bit wr;|
    modport mem_mp (
        output din,
        output addr,
        output rd,
        output wr,
        input dout, 
        input out_addr
    );
endinterface: memory if