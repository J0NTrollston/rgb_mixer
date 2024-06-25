`default_nettype none
`timescale 1ns/1ns

module encoder (
    input clk,
    input reset,
    input a,
    input b,
    output reg [7:0] value
);

//Signals here
wire [3:0] d_bus; //A,OA,B,OB
reg en;
reg OA, OB; //Previous clk input for A and B
reg [3:0] case_out; //inc 1, 2  dec 3, 4



always @(posedge clk) begin
    if(reset) begin
        // set output to 0
        value <= 0;
    end else begin
        //clock in data
        OA <= a;
        OB <= b;

        //case statement
        case(d_bus)
            //inc
            4'b1000: case_out = 4'b1000;
            4'b0111: case_out = 4'b0100;
            //dec
            4'b0010: case_out = 4'b0010;
            4'b1101: case_out = 4'b0001;

            default: case_out = 4'b0000;
        endcase

        // if(en) begin
        //     if ((case_out == 4'b1000) || (case_out == 4'b0100)) begin
        //         value <= value + 1'b1;
        //     end else if((case_out == 4'b0010) || (case_out == 4'b0001)) begin
        //         value <= value - 1'b1;
        //     end
        // end
        
        if(case_out != 4'b0000) begin
            en <= 1'b1;
        end else begin
            en <= 1'b0;
        end

        // if(en) begin
        //     if (case_out == 4'b1000) begin
        //         value <= value + 1'b1;
        //     end else if(case_out == 4'b0100) begin
        //         value <= value + 2'b10;
        //     end else if(case_out == 4'b0010) begin
        //         value <= value + 2'b11;
        //     end else if(case_out == 4'b0001) begin
        //         value <= value + 3'b100;
        //     end else
        //         value <= value + 3'b101;
        // end

        
        
            
        

    end
end

always @(posedge en) begin
    // if(en) begin
    //         if (case_out == 4'b1000) begin
    //             value <= value + 1'b1;
    //         end else if(case_out == 4'b0100) begin
    //             value <= value + 2'b10;
    //         end else if(case_out == 4'b0010) begin
    //             value <= value + 2'b11;
    //         end else if(case_out == 4'b0001) begin
    //             value <= value + 3'b100;
    //         end else
    //             value <= value + 3'b101;
    //     end
    if(en) begin
        if ((case_out == 4'b1000) || (case_out == 4'b0100)) begin
            value <= value + 1'b1;
        end else if((case_out == 4'b0010) || (case_out == 4'b0001)) begin
            value <= value - 1'b1;
        end
    end
end


assign d_bus[3] = a; 
assign d_bus[2] = OA; 
assign d_bus[1] = b; 
assign d_bus[0] = OB; 


endmodule
