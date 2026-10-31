class mem_fixed_pattern_seq extends mem_rand_seq # (mem_seq_item);
    virtual memory if vif; 
    `uvm_object_utils (mem_fixed_pattern_seq)
    mem_seq_item req;

    //constructor
    function new (string name = "mem_rand_seq");
        super.new(name);
    endfunction new

    //body
    virtual task body();
        if(!uvm_config_db# (virtual memory_if) ::get(null, "", "memory_if",vif)) begin 
            `uvm_fatal ("TB", $sformatf(" cannot get memory interface from %m"))
        end
        
        req = new();
        start_item (req); 
        req.addr = 16'h0000; 
        req.din = 16'h0000;
        finish_item(req);

        req = new(); 
        start_item(req); 
        req.addr = 16'h0001; 
        req.din = 16'hFFFF; 
        finish_item(req);

        req = new(); 
        start_item(req); 
        req.addr = 16'h7FFF; 
        req.din = 16'hAAAA;
        finish_item (req);

        req = new(); 
        start_item(req); 
        req.addr = 16'h8000; 
        req.din = 16'h5555;
        finish_item (req);

        req = new(); 
        start_item(req); 
        req.addr = 16'hFFFE; 
        req.din = 16'hAAAA;
        finish_item (req);

        req = new(); 
        start_item(req); 
        req.addr = 16'hFFFF; 
        req.din = 16'h5555;
        finish_item (req);

    endtask body
endclass mem_fixed_pattern_seq