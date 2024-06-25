`default_nettype none
`timescale 1ns/1ns
module debounce (
    input wire clk,
    input wire reset,
    input wire button,
    output reg debounced
);

reg [7:0] shift_reg;
reg eq_FF, eq_00;
wire en;
wire D;

always @(posedge clk) begin
    if (reset) begin
        shift_reg <= 8'b00000000;
    end else begin
        shift_reg = (shift_reg << 1) | button;

        if (shift_reg == 8'b11111111) begin
            eq_FF <= 1'b1;
            eq_00 <= 1'b0;
        end else if (shift_reg == 8'b00000000)begin
            eq_FF <=1'b0;
            eq_00 <=1'b1;
        end
    end
    
end
assign en = eq_FF | eq_00;
assign D = eq_FF ? 1'b1 : 1'b0;


always @(posedge clk ) begin
    if(reset)begin
        debounced <= 1'b0;
    end else if(en == 1'b1) begin
        debounced <= D;
    end 
end

endmodule