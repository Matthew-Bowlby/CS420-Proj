module gol_tb ();
    logic clk;
    logic rst;
    logic [24:0] init_cells;

    gol #(5,5) dut (.clk (clk), .rst (rst), .init_cells (init_cells));

    initial begin
        clk = 0;
        rst = 0;
        init_cells = $random;
        forever #5 clk = !clk;
    end

    initial begin
        @(posedge clk);
        @(posedge clk);
        rst = 1;
    end

endmodule