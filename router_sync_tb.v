module router_sync_tb();

reg clock, resetn, detect_add, full_0, full_1, full_2, empty_0, empty_1, empty_2, write_enb_reg, read_enb_0, read_enb_1, read_enb_2;
wire vld_out_0, vld_out_1, vld_out_2, soft_reset_0, soft_reset_1, soft_reset_2;
wire [2:0] write_enb;
wire fifo_full;
reg [1:0] data_in;

parameter cycle = 10;

router_sync DUT (
    .detect_add(detect_add), 
    .data_in(data_in), 
    .write_enb_reg(write_enb_reg), 
    .clock(clock), 
    .resetn(resetn), 
    .vld_out_0(vld_out_0), 
    .vld_out_1(vld_out_1), 
    .vld_out_2(vld_out_2), 
    .read_enb_0(read_enb_0), 
    .read_enb_1(read_enb_1), 
    .read_enb_2(read_enb_2), 
    .write_enb(write_enb), 
    .fifo_full(fifo_full), 
    .empty_0(empty_0), 
    .empty_1(empty_1), 
    .empty_2(empty_2), 
    .soft_reset_0(soft_reset_0), 
    .soft_reset_1(soft_reset_1), 
    .soft_reset_2(soft_reset_2), 
    .full_0(full_0), 
    .full_1(full_1), 
    .full_2(full_2)
);

always
begin
    #(cycle/2) clock = ~clock;
end

task resetf;
begin
    @(negedge clock);
    resetn = 1'b0;
    @(negedge clock);
    resetn = 1'b1;
end
endtask

task initialize();
begin
    data_in = 2'b0;
    detect_add = 1'b0;
    full_0 = 1'b0;
    full_1 = 1'b0;
    full_2 = 1'b0;
    empty_0 = 1'b0;
    empty_1 = 1'b0;
    empty_2 = 1'b0;
    write_enb_reg = 1'b0;
    read_enb_0 = 1'b0;
    read_enb_1 = 1'b0;
    read_enb_2 = 1'b0;
end
endtask

initial
begin
    clock = 0;
    resetf;
    initialize;
    #10
    write_enb_reg = 1'b1;
    detect_add = 1'b1;
    read_enb_0 = 1'b1;
    empty_0 = 1'b0;

    #10
    read_enb_0 = 1'b0;
    empty_0 = 1'b1;

    #10
    read_enb_0 = 1'b1;
    empty_0 = 1'b1;

    #10
    read_enb_0 = 1'b0;
    empty_0 = 1'b0;
end

initial
    $monitor("read_enb_0=%b, vld_out_0=%b, soft_reset_0=%b", read_enb_0, vld_out_0, soft_reset_0);

endmodule
