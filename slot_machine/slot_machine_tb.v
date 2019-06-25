// Testbench for Slot Machine
//
module slot_machine_tb;

    reg r_clock;
    reg r_reset;
    reg r_seg0_reset;
    reg r_seg1_reset;
    reg r_seg2_reset;
    reg r_btn0;
    reg r_btn1;
    reg r_btn2;

    wire [6:0] w_seg0;
    wire [6:0] w_seg1;
    wire [6:0] w_seg2;
    wire [6:0] w_seg3;
    wire [6:0] w_seg4;
    wire [6:0] w_seg5;

    slot_machine machine0
    (r_clock, r_reset, r_seg0_reset, r_seg1_reset, r_seg2_reset,
	r_btn0, r_btn1, r_btn2, w_seg0, w_seg1, w_seg2, w_seg3, w_seg4, w_seg5);

    initial begin
	r_clock <= 1'b0;
	forever #10 r_clock <= !r_clock;
    end

    initial begin
	$dumpfile("output.lxt2");
	$dumpvars(0, slot_machine_tb);

	r_reset = 1'b0;

	#200;
	r_reset = 1'b1;

	#35;
	r_seg0_reset = 1'b1;

	#30;
	r_seg1_reset = 1'b1;

	#25;
	r_seg2_reset = 1'b1;

	#1000;
	r_btn0 = 1'b0;
	#30;
	r_btn0 = 1'b1;

	#130;
	r_btn1 = 1'b0;
	#30;
	r_btn1 = 1'b1;

	#120;
	r_btn2 = 1'b0;
	#30;
	r_btn2 = 1'b1;

	#200;
	$finish;
    end
    
endmodule
