class mem_normal_test extends uvm_test;
    `uvm_component_utils (mem_normal_test)
    virtual memory if vif; 
    mem_fixed_pattern_seq ctrl_seq; 
    mem_env ctrl_env;
    reg [4:0] flag;

    //constructor
    function new(string name="mem_normal_test", uvm_component parent);
        super.new(name, parent); 
    endfunction: new

    //build
    virtual function void build_phase (uvm_phase phase);
        super.build_phase (phase);
        ctrl_env = mem_env::type_id::create("ctrl_env", this);
        ctrl_seq= mem_fixed_pattern_seq::type_id::create("ctrl_seq", this);
        if (!uvm_config_db# (virtual memory_if) ::get(this, "", "memory_if", vif)) begin 
            'uvm_fatal ("TB", $sformatf(" cannot get mem interface from %m"))
        end
    endfunction : build_phase


    virtual task test_case(); 
        int read2_num, read6_num;
        $display("start test case...................................");
        ctrl_seq.start(ctrl_env.mem_ctr_agent.mem_sqr);|
    endtask: test_case

    virtual task reset_phase (uvm_phase phase);
    begin
        phase.raise_objection (this);
        repeat (1)@(posedge vif.clk);
        phase.drop_objection(this);
    end
    endtask : reset_phase

    virtual task extern_phase();
        // can over write.
    endtask

    virtual task main_phase (uvm_phase phase);
        phase.raise_objection(this);
        repeat (10) @(posedge vif.clk);
            vif.wr<=1'b1;
        repeat (2) @(posedge vif.clk);
            vif.rd<=1'b1;
            test_case();
        repeat (10)@(posedge vif.clk);
            $display ("Finish test case..........................................");
        phase.drop_objection(this);
    endtask : main_phase

endclass : mem_normal_test

