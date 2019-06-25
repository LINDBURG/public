// Counter, Up to 9
//
module counter
    (
        input i_clock,
        input i_reset,
	input i_pause,
        output [3:0] o_out
    );

    reg [3:0] r_COUNT;
    reg [3:0] r_TEMP = 4'b0000;

    always @(negedge i_clock, negedge i_reset) begin
	if(!i_reset)
            r_COUNT <= 4'bzzzz;
        else begin
            if(i_pause)
                r_TEMP <= r_TEMP;
            else if(r_TEMP == 'd9)
                r_TEMP <= 4'b0000;
	    else
		r_TEMP <= r_TEMP + 'd1;
	    r_COUNT <= r_TEMP;
        end
    end

    assign o_out = r_COUNT;

endmodule
