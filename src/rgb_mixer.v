`default_nettype none
`timescale 1ns/1ns
module rgb_mixer (
    input clk,
    input reset,
    input enc0_a,
    input enc0_b,
    input enc1_a,
    input enc1_b,
    input enc2_a,
    input enc2_b,
    output pwm0_out,
    output pwm1_out,
    output pwm2_out
);

//red
wire r_d_a, r_d_b;
wire [7:0] enc0;

//green
wire g_d_a, g_d_b;
wire [7:0] enc1;

//blue
wire b_d_a, b_d_b;
wire [7:0] enc2;


//red debounce
debounce red_debounce_a (clk, reset, enc0_a, r_d_a);
debounce red_debounce_b (clk, reset, enc0_b, r_d_b);

encoder red_encoder (clk, reset, r_d_a, r_d_b, enc0);

pwm red_pwm (clk, reset, pwm0_out, enc0);

//green debounce
debounce green_debounce_a (clk, reset, enc2_a, g_d_a);
debounce green_debounce_b (clk, reset, enc2_b, g_d_b);

encoder green_encoder (clk, reset, g_d_a, g_d_b, enc2);

pwm green_pwm (clk, reset, pwm2_out, enc2);

//blue debounce
debounce blue_debounce_a (clk, reset, enc1_a, b_d_a);
debounce blue_debounce_b (clk, reset, enc1_b, b_d_b);

encoder blue_encoder (clk, reset, b_d_a, b_d_b, enc1);

pwm blue_pwm (clk, reset, pwm1_out, enc1);


endmodule
