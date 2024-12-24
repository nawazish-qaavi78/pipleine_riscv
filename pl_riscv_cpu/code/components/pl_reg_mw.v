
// pipeline registers -> memory|writeback stage

module pl_reg_mw (
    input             clk, en, clr,
	 input 		[31:0] ALUResultM, ReadDataM, PCM, PCPlus4M, lAuiPCM, 
	 input 		[1:0]  ResultSrcM, 
	 input 				 RegWriteM, 
	 output reg [31:0] ALUResultW, ReadDataW, PCW, PCPlus4W, lAuiPCW, 
	 output reg [1:0]  ResultSrcW, 
	 output reg			 RegWriteW
);					

initial begin
    {ALUResultW, ReadDataW, PCW, PCPlus4W, lAuiPCW, ResultSrcW, RegWriteW} = 0;
end

always @(posedge clk) begin
    if (clr) begin
       {ALUResultW, ReadDataW, PCW, PCPlus4W, lAuiPCW, ResultSrcW, RegWriteW} <= 0;
    end else if (!en) begin
        {ALUResultW, ReadDataW, PCW, PCPlus4W, lAuiPCW, ResultSrcW, RegWriteW} <= {ALUResultM, ReadDataM, PCM, PCPlus4M, lAuiPCM, ResultSrcM, RegWriteM};
    end
end

endmodule
