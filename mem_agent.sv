class mem_agent extends uvm_agent;
    uvm_sequencer# (mem_seq_item) mem_sqr; 
    mem_drv drv;
    mem_mnt mnt;

    uvm_analysis_port # (mem_seq_item) ap;
    `uvm_component_utils (mem_agent)

    function new(string name="mem_agent", uvm_component parent); 
        super.new(name, parent);
    endfunction

    virtual function void build_phase (uvm_phase phase); 
        super.build_phase (phase);
        drv mem_drv::type_id::create("drv", this); 
        mnt = mem_mnt::type_id::create("mnt", this); 
        mem_sqr = new("mem_sqr", this);
    endfunction

    virtual function void connect_phase (uvm_phase phase); 
        super.connect_phase (phase);
        drv.seq_item_port.connect(mem_sqr.seq_item_export);
    endfunction
endclass