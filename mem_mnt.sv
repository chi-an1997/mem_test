class mem_mnt extends uvm_monitor# (mem_seq_item);
    virtual memory if vif;
    uvm_analysis_port # (mem_seq_item) ap;
    `uvm_component_utils (mem_mnt)

    function new(string name = "mem_mnt", uvm_component parent);
        super.new(name, parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase (phase);
        if (!uvm_config_db# (virtual memory_if): :get(this, "", "memory_if", vif)) begin 
            `uvm_fatal ("TB", $sformatf(" cannot get mem interface from %m"))
        end

        ap = new("ap", this);
    endfunction

    extern task main_phase (uvm_phase phase);
    extern task collect_one_pkt (mem_seq_item tr); 
endclass

task mem_mnt::main_phase (uvm_phase phase); 
    mem_seq_item tr;
    forever begin
    @(posedge vif.clk);
        if (vif.rd) begin
            tr = new("tr");
            tr.addr= vif.out_addr; 
            tr.dout= vif.dout;

            `uvm_info("MONITOR", "Monitor received transaction", UVM_LOW)
            ap.write(tr);
        end
    end    
endtask

        
