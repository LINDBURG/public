// Slot Machine
//
module slot_machine
    (
	input i_clock,
	input i_reset,
	input i_seg0_reset,
	input i_seg1_reset,
	input i_seg2_reset,
	input i_btn0,
	input i_btn1,
	input i_btn2,
	output [6:0] o_seg0,
	output [6:0] o_seg1,
	output [6:0] o_seg2,
	output [6:0] o_seg3,
	output [6:0] o_seg4,
	output [6:0] o_seg5
    );

    parameter [1:0] ready = 2'b01;
    parameter [1:0] running = 2'b10;
    parameter [1:0] pause = 2'b11;

    wire [3:0] w_out0;
    wire [3:0] w_out1;
    wire [3:0] w_out2;
    wire [3:0] w_out3;
    wire [3:0] w_out4;
    wire [3:0] w_out5;

    reg r_seg0_reset = 1'b0;
    reg r_seg1_reset = 1'b0;
    reg r_seg2_reset = 1'b0;

    reg r_pause0 = 1'b1;
    reg r_pause1 = 1'b1;
    reg r_pause2 = 1'b1;

    reg [1:0] r_state;
    reg [1:0] r_next;

    wire w_clock;

    always @(posedge w_clock, negedge i_reset) begin
	if(!i_reset)
	    r_state <= ready;
	else
	    r_state <= r_next;
    end

    always @(i_seg0_reset, i_seg1_reset, i_seg2_reset, i_btn0, i_btn1, i_btn2, r_state, w_clock) begin
	case (r_state)
	    ready: begin
		if(i_seg0_reset) begin
		    r_pause0 <= 1'b0;
			 r_seg0_reset = 1'b1;
		end
		if(i_seg1_reset) begin
		    r_pause1 <= 1'b0;
			 r_seg1_reset = 1'b1;
		end
		if(i_seg2_reset) begin
		    r_pause2 <= 1'b0;
			 r_seg2_reset = 1'b1;
		end
		if(!r_pause0 && !r_pause1 && !r_pause2)
		    r_next <= running;
		else
		    r_next <= ready;
	    end
	    running: begin
		if(!i_btn0)
		    r_pause0 <= 1'b1;
		if(!i_btn1)
		    r_pause1 <= 1'b1;
		if(!i_btn2)
		    r_pause2 <= 1'b1;
		if(r_pause0 && r_pause1 && r_pause2)
		    r_next <= pause;
		else
		    r_next <= running;
	    end
	    pause: begin
		if(!i_btn0)
		    r_pause0 <= 1'b0;
		if(!i_btn1)
		    r_pause1 <= 1'b0;
		if(!i_btn2)
		    r_pause2 <= 1'b0;
		if(!r_pause0 && !r_pause1 && !r_pause2)
		    r_next <= running;
		else
		    r_next <= pause;
	    end
	endcase
    end

    clock_divider divider0(i_clock, i_reset, w_clock);

    counter counter0(w_clock, r_seg0_reset, r_pause0, w_out0);
    counter counter1(w_clock, r_seg1_reset, r_pause1, w_out1);
    counter counter2(w_clock, r_seg2_reset, r_pause2, w_out2);

    seg7_decoder decoder0(w_out0, 7'b1110111, o_seg0);
    seg7_decoder decoder1(w_out1, 7'b1001110, o_seg1);
    seg7_decoder decoder2(w_out2, 7'b0000110, o_seg2);
    seg7_decoder decoder3(w_out3, 7'b0001000, o_seg3);
    seg7_decoder decoder4(w_out4, 7'b0100001, o_seg4);
    seg7_decoder decoder5(w_out5, 7'b0010001, o_seg5);

endmodule
