
// pipeline registers -> execute|memory stage

module pl_reg_em (
    input             clk, en, clr,
	 input 		[31:0] ALUresultE, PCPlus4E, lAuiPCE, ReadDataE, WriteDataE,
	 input  		[1:0]  ResultSrcE, 
	 input 				 RegWriteE, 
	 output reg [31:0] ALUResultM, PCPlus4M, lAuiPCM, ReadDataM, WriteDataM,
	 output reg [1:0]  ResultSrcM, 
	 output reg 		 RegWriteM
    
);

initial begin
    {ALUResultM, PCPlus4M, lAuiPCM, ReadDataM, WriteDataM, ResultSrcM, RegWriteM} = 0;
end

always @(posedge clk) begin
    if (clr) begin
       {ALUResultM, PCPlus4M, lAuiPCM, ReadDataM, ResultSrcM, RegWriteM} <= 0;
    end else if (!en) begin
        {ALUResultM, PCPlus4M, lAuiPCM, ReadDataM, WriteDataM, ResultSrcM, RegWriteM} <= {ALUresultE, PCPlus4E, lAuiPCE, ReadDataE, WriteDataE, ResultSrcE, RegWriteE};
    end
end

endmodule
