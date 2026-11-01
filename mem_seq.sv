class mem_seq extends uvm_sequence # (mem_seq_item);
    `uvm_object_utils (mem_seq)
    mem_seq_item req;

    //constructor
    function new (string name = "mem_seq");
        super.new(name);
    endfunction: new

    //body
    virtual task body();
        for (int i = 0; i < 200; i++) begin
            req = new(); 
            start_item (req);
            req.addr = i;
            req.din = i;
            finish_item (req);
        end
    endtask body
endclass mem_seq
