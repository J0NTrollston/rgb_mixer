`default_nettype none // do not optimize
`timescale 1ns/1ns // simulation 

module pwm (
    input wire clk,
    input wire reset,
    output wire out,
    input wire [7:0] level
    );

    reg [7:0] count;
    reg out_reg;
    localparam MAX_COUNT = 255; //8 bit

    always @(posedge clk) begin
        if(reset) 
        begin // reset active high
            count <= 8'b00000000;
            out_reg <= 1'b0;
        end
        else
        begin
            if(count == MAX_COUNT) 
            begin
                count <= 8'b00000000; // reset count when reached max
            end
            else 
            begin
                count <= count + 1'b1; // increment counter

                if((level == 8'b00000000) || (level == 8'b11111111)) begin
                     if (count < level) //minus 1 as out_reg is a register and will have update delay of 1 clock cycle
                        out_reg <= 1'b1;
                    else
                        out_reg <= 1'b0;
                end else begin
                    if (count < level-1'b1) //minus 1 as out_reg is a register and will have update delay of 1 clock cycle
                        out_reg <= 1'b1;
                    else
                        out_reg <= 1'b0;
                end
                
                
               
                // if (count < level-1'b1) //minus 1 as out_reg is a register and will have update delay of 1 clock cycle
                // if (count < level-1'b1) //minus 1 as out_reg is a register and will have update delay of 1 clock cycle
                //     out_reg <= 1'b1;
                // else
                //     out_reg <= 1'b0;
            end
        end
    end

    assign out = out_reg;

endmodule