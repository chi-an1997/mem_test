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
        vif.mem_mp.wr = 0;
        vif.mem_mp.rd = 0;
        vif.mem_mp.addr = 0;
        vif.mem_mp.din = 0;
        
        seq_item_port.get_next_item(req);
        vif.mem_mp.wr = 1;
        vif.mem_mp.rd = 0;
        vif.mem_mp.din <= req.din; 
        vif.mem mp.addr <= req.addr; 
        drv_port.write(req);
        seq_item_port.item_done();

        @(posedge vif.clk);

        forever begin
            seq_item_port.get_next_item(req); 
            vif.mem_mp.wr <= 1;
            vif.mem_mp.rd <= 1; 
            vif.mem_mp.din <= req.din; 
            vif.mem_mp.addr <= req.addr; 
            drv_port.write(req);

            @(posedge vif.clk);
            seq_item_port.item_done();
            
            if (req.last) begin
                vif.mem_mp.wr <= 0; 
                vif.mem_mp.rd <= 0; 
                break;
            end
        end

        vif.mem_mp.wr = 0;
        vif.mem_mp.rd = 0;
        vif.mem_mp.addr = 0;
        vif.mem_mp.din = 0; 
        drv_port.write(req);
    endtask
endclass

task mem_drv::drive_start(mem_seq_item mem_tr);
    repeat (1)@(posedge vif.clk); 
    vif.mem_mp.din <<= req.din; 
    vif.mem_mp.addr<= req.addr; 
    vif.mem_mp. rd <= req.rd;
    vif.mem_mp.wr <= req.wr;
    drv_port.write(mem_tr);
endtask