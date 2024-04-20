module gol (clk, rst, init_cells);
    input logic clk;
    input logic rst;
    input logic [99:0] init_cells
    logic [99:0] cells;
    generate
        genvar i;
        for (i = 0; i < 10 * 10; i++) begin
            logic [7:0] neighbors;
            /* Will only work for middle cells */
            assign neighbors[0] = cells[i - 10 - 1];
            assign neighbors[1] = cells[i - 10];
            assign neighbors[2] = cells[i - 10 + 1];
            assign neighbors[3] = cells[i - 1];
            assign neighbors[4] = cells[i + 1];
            assign neighbors[5] = cells[i + 10 - 1];
            assign neighbors[6] = cells[i + 10];
            assign neighbors[7] = cells[i + 10 + 1];


            gol_cell(.neighbors (neighbors), .clk (clk), .rst (rst), .init_state (init_cells[i]), .state (cells[i]));
        end
    endgenerate

    
endmodule //gol

module gol_cell (neighbors, clk, rst, init_state, state);
    input logic [7:0] neighbors;
    input logic clk;
    input logic rst;
    input logic init_state;
    output logic state;
    genvar i;

    logic [3:0] count;
    logic next_state;


    for (i = 0; i < 8; i++) begin
        count += neighbors[i];
    end

    assign next_state = count == 3 | ((count == 2) & state);


    always_ff @(posedge clk or negedge rst) begin
        if (!rst)
            state = init_state;
        else
            state = next_state;
    end

endmodule //gol_cell module
