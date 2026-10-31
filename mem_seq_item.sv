ifndef C_ESPI_C_SEQ_ITEM 
define C_ESPI_C_SEQ_ITEM

class mem_seq_item extends uvm_sequence_item;
    rand bit [15:0] din;
    rand bit [15:0] addr;
    bit wr;
    bit rd;
    bit [15:0] dout;
    bit [15:0] out_addr;
    bit last;
    
    constraint mem_c{
        din < 65535;
        addr < 65535;
    }

    `uvm_object_utils_begin (mem_seq_item)
    `uvm_field_int (din, UVM_DEFAULT)
    `uvm_field_int (addr, UVM_DEFAULT)
    `uvm_field_int (wr, UVM_DEFAULT)
    `uvm_field_int (rd, UVM_DEFAULT) 
    `uvm_field_int (dout, UVM_DEFAULT) 
    `uvm_field_int (out_addr, UVM_DEFAULT)
    `uvm_object_utils_end

    function new(string name="mem_seq_item"); 
        super.new(name);
    endfunction

endclass
`endif