class mem_sb extends uvm_scoreboard; 
    mem_seq_item expect_queue[$], act_queue[$]; 
    `uvm_analysis_imp_decl (_exp) 
    `uvm_analysis_imp_decl (_act)
    `uvm_component_utils (mem_sb)
    
    uvm_analysis_imp_exp #(mem_seq_item, mem_sb) exp_port; 
    uvm_analysis_imp_act #(mem_seq_item, mem_sb) act_port;

    extern function new(string name, uvm_component parent); 
    extern virtual function void write_exp (mem_seq_item mem); 
    extern virtual function void write_act (mem_seq_item mem); 
    extern virtual function void build_phase (uvm_phase phase); 
    extern virtual task main_phase (uvm_phase phase);

endclass

function mem_sb::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction

function void mem_sb::build_phase (uvm_phase phase);
    super.build_phase (phase);
    exp_port = new("exp_port", this); 
    act_port = new("act_port", this);
endfunction

function void mem_sb: :write_exp (mem_seq_item mem);
    mem_seq_item exp_tran; 
    exp_tran = new();
    exp_tran.dout = exp_tran.din; 
    exp_tran.out_addr = exp_tran.addr; 
    expect queue.push_back(exp_tran);

    `uvm_info("my_scoreboard", "Received expect transaction", UVM_LOW)
endfunction

function void mem_sb: :write_act (mem_seq_item mem);
    mem_seq_item act_tran; 
    act_tran = new();
    act_tran.copy (mem);
    act_queue.push_back(act_tran);
    
    `uvm_info("my_scoreboard", "Received actual transaction", UVM_LOW)
endfunction

task mem_sb::main_phase (uvm_phase phase); 
    mem_seq_item exp_tran, act_tran;
    bit result;
    super.main_phase (phase);
    
    forever begin
    wait((expect queue.size()>0) && (act_queue.size()>0));
    exp_tran = expect_queue.pop_front();
    act_tran = act_queue.pop_front();
    result = act_tran.compare (exp_tran);
    if (result) begin
        `uvm_info("my_scoreboard", "Compare SUCCESSFULLY", UVM LOW);
    end
    else begin
        `uvm_error("my_scoreboard", "Compare FAILED"); 
        $display("the expect pkt is"); 
        exp_tran.print();
        $display("the actual pkt is"); 
        act_tran.print();
    end
end

endtask
