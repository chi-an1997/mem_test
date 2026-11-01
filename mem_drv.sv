class mem_drv extends uvm_driver# (mem_seq_item);
    
    virtual memory if vif;

    uvm_analysis_port# (mem_seq_item) drv_port;
    `uvm_component_utils (mem_drv)

    function new(string name = "mem_drv", uvm_component parent); 
        super.new(name, parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase (phase);
        if(!uvm_config_db# (virtual memory_if) ::get(this, "", "memory_if", vif)) begin 
            `uvm_fatal ("TB", $sformatf(" cannot get memory interface from %m"))
        end

        drv_port = new("drv_port", this);
    endfunction

    extern task drive_start(mem_seq_item mem_tr);

    virtual task run_phase (uvm_phase phase);
    mem_seq_item exp;

        @(posedge vif.clk);

        forever begin
            seq_item_port.get_next_item(req); 
            drive_start(req);
            $cast(exp, req.clone());
            drv_port.write(req);
            seq_item_port.item_done();
        end
    endtask
endclass

task mem_drv::drive_start(mem_seq_item mem_tr);
    repeat (1)@(posedge vif.clk); 
    vif.mem_mp.din <<= req.din; 
    vif.mem_mp.addr<= req.addr; 
endtask
