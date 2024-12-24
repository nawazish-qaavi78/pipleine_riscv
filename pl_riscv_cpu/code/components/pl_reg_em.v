
// pipeline registers -> execute|memory stage

module pl_reg_em (
    input             clk, en, clr,
	 input 		[31:0] ALUresultE, PCPlus4E, lAuiPCE, WriteDataE,
	 input  		[1:0]  ResultSrcE, 
	 input 				 RegWriteE, MemWriteE,
	 input 		[2:0]  funct3E,
	 output reg [31:0] ALUResultM, PCPlus4M, lAuiPCM, WriteDataM,
	 output reg [1:0]  ResultSrcM, 
	 output reg 		 RegWriteM, MemWriteM,
	 output reg [2:0]  funct3M
    
);

initial begin
    {ALUResultM, PCPlus4M, lAuiPCM, WriteDataM, ResultSrcM, RegWriteM, MemWriteM, funct3M} = 0;
end

always @(posedge clk) begin
    if (clr) begin
       {ALUResultM, PCPlus4M, lAuiPCM, ResultSrcM, RegWriteM, MemWriteM, funct3M} <= 0;
    end else if (!en) begin
        {ALUResultM, PCPlus4M, lAuiPCM, WriteDataM, ResultSrcM, RegWriteM, MemWriteM, funct3M} <= {ALUresultE, PCPlus4E, lAuiPCE, WriteDataE, ResultSrcE, RegWriteE, MemWriteE, funct3E};
    end
end

endmodule
