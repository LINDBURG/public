// 7-Segment Decoder
//
module seg7_decoder
    (
        input [3:0] i_digit,
	input [6:0] i_default,
        output reg [6:0] r_OUT
    );

    always @(i_digit) begin
        case (i_digit)
            4'b0000: r_OUT <= 7'b1000000;
            4'b0001: r_OUT <= 7'b1111001;
            4'b0010: r_OUT <= 7'b0100100;
            4'b0011: r_OUT <= 7'b0110000;
            4'b0100: r_OUT <= 7'b0011001;
            4'b0101: r_OUT <= 7'b0010010;
            4'b0110: r_OUT <= 7'b0000010;
            4'b0111: r_OUT <= 7'b1111000;
            4'b1000: r_OUT <= 7'b0000000;
            4'b1001: r_OUT <= 7'b0010000;
	    4'b1010: r_OUT <= 7'b0010001;	// Y(10)
	    4'b1011: r_OUT <= 7'b0100001;	// d(11)
	    4'b1100: r_OUT <= 7'b0001000;	// A(12)
	    4'b1101: r_OUT <= 7'b0000110;	// E(13)
	    4'b1110: r_OUT <= 7'b1001110;	// r(14)
	    4'b1111: r_OUT <= 7'b1110111;	// _(15)
	    default: r_OUT <= i_default;
	endcase 
    end

endmodule
