module gol #(parameter WIDTH = 10, HEIGHT = 10) (clk, rst, init_cells);
    input logic clk;
    input logic rst;
    input logic [WIDTH*HEIGHT-1:0] init_cells;
    output logic [WIDTH*HEIGHT-1:0] cells;
    generate
        genvar i;
        for (i = 0; i < WIDTH * HEIGHT; i++) begin
            logic [7:0] neighbors;
            /* Top Left Corner */
            if (i == 0) begin
                assign neighbors[0] = cells[WIDTH * HEIGHT - 1];
                assign neighbors[1] = cells[WIDTH * HEIGHT - WIDTH];
                assign neighbors[2] = cells[WIDTH * HEIGHT - WIDTH + 1];
                assign neighbors[3] = cells[i + WIDTH - 1];
                assign neighbors[4] = cells[i + 1];
                assign neighbors[5] = cells[WIDTH + WIDTH - 1];
                assign neighbors[6] = cells[WIDTH];
                assign neighbors[7] = cells[WIDTH + 1];
            end
            /* Top Right Corner */
            else if (i == WIDTH - 1) begin
                assign neighbors[0] = cells[WIDTH * HEIGHT - 2];
                assign neighbors[1] = cells[WIDTH * HEIGHT - 1];
                assign neighbors[2] = cells[WIDTH * HEIGHT - WIDTH];
                assign neighbors[3] = cells[i - 1];
                assign neighbors[4] = cells[0];
                assign neighbors[5] = cells[WIDTH + WIDTH - 2];
                assign neighbors[6] = cells[WIDTH + WIDTH - 1];
                assign neighbors[7] = cells[WIDTH];
            end
            /* Bottom Left Corner */
            else if (i == WIDTH * HEIGHT - WIDTH) begin
                assign neighbors[0] = cells[i - 1];
                assign neighbors[1] = cells[i - WIDTH];
                assign neighbors[2] = cells[i - WIDTH + 1];
                assign neighbors[3] = cells[i + WIDTH - 1];
                assign neighbors[4] = cells[i + 1];
                assign neighbors[5] = cells[WIDTH - 1];
                assign neighbors[6] = cells[0];
                assign neighbors[7] = cells[1];
            end
            /* Bottom Right Corner */
            else if (i == WIDTH * HEIGHT - 1) begin
                assign neighbors[0] = cells[i - WIDTH - 1];
                assign neighbors[1] = cells[i - WIDTH];
                assign neighbors[2] = cells[i - WIDTH - WIDTH + 1];
                assign neighbors[3] = cells[i - 1];
                assign neighbors[4] = cells[i - WIDTH + 1];
                assign neighbors[5] = cells[WIDTH - 2];
                assign neighbors[6] = cells[WIDTH - 1];
                assign neighbors[7] = cells[0];
            end
            /* Top Row */
            else if (i < WIDTH) begin
                assign neighbors[0] = cells[i + HEIGHT * (WIDTH - 1) - 1];
                assign neighbors[1] = cells[i + HEIGHT * (WIDTH - 1)];
                assign neighbors[2] = cells[i + HEIGHT * (WIDTH - 1) + 1];
                assign neighbors[3] = cells[i - 1];
                assign neighbors[4] = cells[i + 1];
                assign neighbors[5] = cells[i + WIDTH - 1];
                assign neighbors[6] = cells[i + WIDTH];
                assign neighbors[7] = cells[i + WIDTH + 1];
            end
            /* Bottom Row */
            else if (i > WIDTH * HEIGHT - WIDTH) begin
                assign neighbors[0] = cells[i - WIDTH - 1];
                assign neighbors[1] = cells[i - WIDTH];
                assign neighbors[2] = cells[i - WIDTH + 1];
                assign neighbors[3] = cells[i - 1];
                assign neighbors[4] = cells[i + 1];
                assign neighbors[5] = cells[i - HEIGHT * (WIDTH - 1) - 1];
                assign neighbors[6] = cells[i - HEIGHT * (WIDTH - 1)];
                assign neighbors[7] = cells[i - HEIGHT * (WIDTH - 1) + 1];
            end
            /* Left Column */
            else if (i % WIDTH == 0) begin
                assign neighbors[0] = cells[i - 1];
                assign neighbors[1] = cells[i - WIDTH];
                assign neighbors[2] = cells[i - WIDTH + 1];
                assign neighbors[3] = cells[i + WIDTH - 1];
                assign neighbors[4] = cells[i + 1];
                assign neighbors[5] = cells[i + WIDTH + WIDTH - 1];
                assign neighbors[6] = cells[i + WIDTH];
                assign neighbors[7] = cells[i + WIDTH + 1];
            end
            /* Right Column */
            else if ((i + 1) % WIDTH == 0) begin
                assign neighbors[0] = cells[i - WIDTH - 1];
                assign neighbors[1] = cells[i - WIDTH];
                assign neighbors[2] = cells[i - WIDTH - WIDTH + 1];
                assign neighbors[3] = cells[i - 1];
                assign neighbors[4] = cells[i - WIDTH + 1];
                assign neighbors[5] = cells[i + WIDTH - 1];
                assign neighbors[6] = cells[i + WIDTH];
                assign neighbors[7] = cells[i + 1];
            end
            /* Middle Cells */
            else begin
                assign neighbors[0] = cells[i - WIDTH - 1];
                assign neighbors[1] = cells[i - WIDTH];
                assign neighbors[2] = cells[i - WIDTH + 1];
                assign neighbors[3] = cells[i - 1];
                assign neighbors[4] = cells[i + 1];
                assign neighbors[5] = cells[i + WIDTH - 1];
                assign neighbors[6] = cells[i + WIDTH];
                assign neighbors[7] = cells[i + WIDTH + 1];
            end


            gol_cell cell_inst (.neighbors (neighbors), .clk (clk), .rst (rst), .init_state (init_cells[i]), .state (cells[i]));
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

    
    assign count = neighbors[0] + neighbors[1] + neighbors[2] + neighbors[3] + neighbors[4] + neighbors[5] + neighbors[6] + neighbors[7];

    assign next_state = (count == 3 | ((count == 2) & state));


    always_ff @(posedge clk or negedge rst) begin
        if (!rst)
            state = init_state;
        else
            state = next_state;
    end

endmodule //gol_cell module