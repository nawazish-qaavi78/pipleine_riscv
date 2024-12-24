
// pipeline registers -> execute|memory stage

module pl_reg_em (
    input             clk, en, clr,
	 input 		[31:0] ALUresultE, PCE, PCPlus4E, lAuiPCE, WriteDataE,
	 input  		[1:0]  ResultSrcE, 
	 input 				 RegWriteE, MemWriteE,
	 input 		[31:0] InstrE,
	 output reg [31:0] ALUResultM, PCM, PCPlus4M, lAuiPCM, WriteDataM,
	 output reg [1:0]  ResultSrcM, 
	 output reg 		 RegWriteM, MemWriteM,
	 output reg [2:0]  funct3M,
	 output reg [31:0] InstrM
    
);

initial begin
    {ALUResultM, PCM, PCPlus4M, lAuiPCM, WriteDataM, ResultSrcM, RegWriteM, MemWriteM, funct3M} = 0;
end

always @(posedge clk) begin
    if (clr) begin
       {ALUResultM, PCM, PCPlus4M, lAuiPCM, ResultSrcM, RegWriteM, MemWriteM, funct3M} <= 0;
    end else if (!en) begin
        {ALUResultM, PCM, PCPlus4M, lAuiPCM, WriteDataM, ResultSrcM, RegWriteM, MemWriteM, InstrM} <= {ALUresultE, PCE, PCPlus4E, lAuiPCE, WriteDataE, ResultSrcE, RegWriteE, MemWriteE, InstrE};
		  funct3M <= InstrE[14:12];
    end
end

endmodule
