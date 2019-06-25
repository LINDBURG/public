// Clock Divider, 50MHz to 4Hz(set to 6249999)
//
module clock_divider
    (
        input i_clock,
        input i_reset,
        output reg r_OUT
    );

    reg [24:0] r_COUNT;

    always @(posedge i_clock, negedge i_reset) begin
        if(!i_reset) begin
            r_COUNT <= 'd0;
            r_OUT <= 1'b0;
        end
        else begin
                r_COUNT <= r_COUNT + 1'b1;
            if(r_COUNT == 'd1)
                r_COUNT <= 'd0;
            else if(r_COUNT == 'd0)
                r_OUT <= !r_OUT;
        end
    end

endmodule
