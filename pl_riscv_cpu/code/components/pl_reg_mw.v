
// pipeline registers -> memory|writeback stage

module pl_reg_mw (
    input             clk, en, clr,
	 input 		[31:0] ALUResultM, ReadDataM, WriteDataM, PCM, PCPlus4M, lAuiPCM, InstrM,
	 input 		[1:0]  ResultSrcM, 
	 input 				 RegWriteM, 
	 output reg [31:0] ALUResultW, ReadDataW, WriteDataW, PCW, PCPlus4W, lAuiPCW, InstrW,
	 output reg [1:0]  ResultSrcW, 
	 output reg			 RegWriteW
);					

initial begin
    {ALUResultW, ReadDataW, WriteDataW, PCW, PCPlus4W, lAuiPCW, ResultSrcW, RegWriteW, InstrW} = 0;
end

always @(posedge clk) begin
    if (clr) begin
       {ALUResultW, ReadDataW, WriteDataW, PCW, PCPlus4W, lAuiPCW, ResultSrcW, RegWriteW} <= 0;
    end else if (!en) begin
        {ALUResultW, ReadDataW, WriteDataW, PCW, PCPlus4W, lAuiPCW, ResultSrcW, RegWriteW} <= {ALUResultM, ReadDataM, WriteDataM, PCM, PCPlus4M, lAuiPCM, ResultSrcM, RegWriteM};
		  InstrW <= InstrM;
    end
end

endmodule
