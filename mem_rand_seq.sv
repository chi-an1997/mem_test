class mem_rand_seq extends uvm_sequence #(mem_seq_item);
    `uvm_object_utils (mem_rand_seq)
    mem_seq_item req;

    //constructor
    function new(string name = "mem_rand_seq");
        super.new(name);
    endfunction: new

    //body
    virtual task body();
        repeat (200) begin
            req = new();
            start_item(req);
            assert(req.randomize()); 
            finish_item (req);
        end
    endtask body
endclass mem_rand_seq