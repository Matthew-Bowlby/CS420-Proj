module gol ();


    
endmodule //gol

module gol_cell (neighbors, clk, rst, init_state, state);
    input [7:0] neighbors;
    input clk;
    input rst;
    input init_state;
    output state;
    genvar i;

    wire [3:0] count;
    wire next_state;


    for (i = 0; i < 8; i++) begin
        count += neighbors[i];
    end

    assign next_state = count == 3 | ((count == 2) & state);


    always @(posedge clk or negedge rst) begin
        if (!rst)
            state <= init_state;
        else
            state <= next_state;
    end

endmodule //gol_cell module
