`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/27/2016 02:04:22 PM
// Design Name: 
// Module Name: debouncer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


//module debouncerKeyboard(
//    input clk,
//    input I,
//    output reg O
//    );
//    parameter COUNT_MAX=255, COUNT_WIDTH=8;
//    reg [COUNT_WIDTH-1:0] count;
//    reg Iv=0;
//    always@(posedge clk)
//        if (I == Iv) begin
//            if (count == COUNT_MAX)
//                O <= I;
//            else
//                count <= count + 1'b1;
//        end else begin
//            count <= 'b0;
//            Iv <= I;
//        end
    
//endmodule

module debouncerKeyboard(
    input clk,
    input I,  // Input signal (keyboard button press)
    output reg O  // Debounced output signal
    );

    // Parameterize debounce timeout and counter width
    parameter COUNT_MAX = 255, COUNT_WIDTH = 8;  // Adjust COUNT_MAX to increase debounce time
    reg [COUNT_WIDTH-1:0] count;  // Counter to track debounce time
    reg Iv = 0;  // Previous input state

    always @(posedge clk) begin
        // If the input signal is the same as the previous state
        if (I == Iv) begin
            // If the count reaches the maximum value, consider the input stable
            if (count == COUNT_MAX)
                O <= I;  // Update the output with the stable value of I
            else
                count <= count + 1'b1;  // Increment the counter if debounce period isn't complete
        end else begin
            count <= 0;  // Reset the counter if the input has changed
            Iv <= I;     // Update previous state
        end
    end

endmodule

