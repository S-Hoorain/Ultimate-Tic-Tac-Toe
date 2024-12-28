`timescale 1ns / 1ps

module board_renderer(
    input [9:0] x,
    input [8:0] y,
    input [17:0] data,
    input is_ended,
    input enable,
    output [3:0] r,
    output [3:0] g,
    output [3:0] b
    );
    
    // Wires for grid lines
    wire h0,h1, h2, v1, v2, v3, v4, v1_mask, v2_mask, v3_mask, v4_mask, game_table;
    
    // Game state for valid cells
    wire [8:0] w_is_checked = data[17:9];
    wire [8:0] w_sign = data[8:0];        
    
    // Cross and nought signals for valid cells
    wire w_cross, w_nought;
    wire w_cross_0, w_nought_0, w_cross_1, w_nought_1, w_cross_2, w_nought_2;
    wire w_cross_3, w_nought_3, w_cross_4, w_nought_4, w_cross_5, w_nought_5;
    wire w_cross_6, w_nought_6, w_cross_7, w_nought_7, w_cross_8, w_nought_8;
    
    // Grid line positions for a 3x5 grid
    square HORZ_LINE_0 (x, y, 250, 00, 132, 10, h0); // Horizontal line 1
    square HORZ_LINE_1 (x, y, 120, 150, 400, 10, h1); // Horizontal line 1
    square HORZ_LINE_2 (x, y, 0, 316, 640, 10, h2); // Horizontal line 2
    square VERT_LINE_1 (x, y, 120, 150, 10, 480, v1); // Vertical line 1
    square VERT_LINE_2 (x, y, 250, 0, 10, 480, v2); // Vertical line 2
    square VERT_LINE_3 (x, y, 380, 0, 10, 480, v3); // Vertical line 3
    square VERT_LINE_4 (x, y, 510, 150, 10, 480, v4); // Vertical line 4
    
    // Optional masking for grid (unused in this case)
    square VERT_LINE_1_MASK (x,y,120,300,10,480,v1_mask);
    assign v1_mask = 0;
    assign v2_mask = 0;
    assign v3_mask = 0;
    assign v4_mask = 0;
    
    // Combine lines to form the grid
    assign game_table =h0| h1 | h2 |  (v1^(v1_mask&is_ended)) | v2 | v3 | v4;
    
    // Rendering crosses and noughts for valid cells
    cross CROSS_0 (x, y, 250, 20, w_cross_0);  // Valid cell 0 (mapped to grid position 2)
    nought NOUGHT_0 (x, y, 250, 20, w_nought_0);
    
    cross CROSS_1 (x, y, 120, 170, w_cross_1);  // Valid cell 1 (mapped to grid position 6)
    nought NOUGHT_1 (x, y, 120, 170, w_nought_1);
    
    cross CROSS_2 (x, y, 250, 170, w_cross_2); // Valid cell 2 (mapped to grid position 7)
    nought NOUGHT_2 (x, y, 250, 170, w_nought_2);
    
    cross CROSS_3 (x, y, 380, 170, w_cross_3); // Valid cell 3 (mapped to grid position 8)
    nought NOUGHT_3 (x, y, 380, 170, w_nought_3);
    
    cross CROSS_4 (x, y, 0, 341, w_cross_4); // Valid cell 4 (mapped to grid position 10)
    nought NOUGHT_4 (x, y, 0, 341, w_nought_4);
    
    cross CROSS_5 (x, y, 120, 341, w_cross_5);  // Valid cell 5 (mapped to grid position 11)
    nought NOUGHT_5 (x, y, 120, 341, w_nought_5);
    
    cross CROSS_6 (x, y, 250, 341, w_cross_6); // Valid cell 6 (mapped to grid position 12)
    nought NOUGHT_6 (x, y, 250, 341, w_nought_6);
    
    cross CROSS_7 (x, y, 380, 341, w_cross_7); // Valid cell 7 (mapped to grid position 13)
    nought NOUGHT_7 (x, y, 380, 341, w_nought_7);
    
    cross CROSS_8 (x, y, 510, 341, w_cross_8); // Valid cell 8 (mapped to grid position 14)
    nought NOUGHT_8 (x, y, 510, 341, w_nought_8);
    
    // Combine cross signals
    assign w_cross =
        (w_cross_0 & w_is_checked[0] & ~w_sign[0]) |
        (w_cross_1 & w_is_checked[1] & ~w_sign[1]) |
        (w_cross_2 & w_is_checked[2] & ~w_sign[2]) |
        (w_cross_3 & w_is_checked[3] & ~w_sign[3]) |
        (w_cross_4 & w_is_checked[4] & ~w_sign[4]) |
        (w_cross_5 & w_is_checked[5] & ~w_sign[5]) |
        (w_cross_6 & w_is_checked[6] & ~w_sign[6]) |
        (w_cross_7 & w_is_checked[7] & ~w_sign[7]) |
        (w_cross_8 & w_is_checked[8] & ~w_sign[8]);
    
    // Combine nought signals
    assign w_nought =
        (w_nought_0 & w_is_checked[0] & w_sign[0]) |
        (w_nought_1 & w_is_checked[1] & w_sign[1]) |
        (w_nought_2 & w_is_checked[2] & w_sign[2]) |
        (w_nought_3 & w_is_checked[3] & w_sign[3]) |
        (w_nought_4 & w_is_checked[4] & w_sign[4]) |
        (w_nought_5 & w_is_checked[5] & w_sign[5]) |
        (w_nought_6 & w_is_checked[6] & w_sign[6]) |
        (w_nought_7 & w_is_checked[7] & w_sign[7]) |
        (w_nought_8 & w_is_checked[8] & w_sign[8]);
    
    // Output color signals
    assign r = {4{game_table}} | {4{w_cross}};
    assign g = {4{game_table}};
    assign b = {4{game_table}} | {4{w_nought}};
endmodule
