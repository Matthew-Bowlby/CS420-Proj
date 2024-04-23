`timescale 1ns/10ps
module gol_tb ();
    logic clk;
    logic rst;
    logic[50*50-1:0] init_cells;
    logic[50*50-1:0] cells;
    logic thing;
    int i;

    gol dut (.clk (clk), .rst (rst), .init_cells (init_cells), .cells (cells));

    initial begin
        clk = 0;
        rst = 0;
        //init_cells = $random;
        for (i = 0; i < 100 * 100; i++) begin
	    thing = $random;
	    init_cells[i] = thing;
	end 
        forever #5 clk = !clk;
    end

    initial begin
        @(posedge clk);
        @(posedge clk);
        rst = 1;
    end

endmodule
