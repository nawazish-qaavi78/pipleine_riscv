
// pipeline registers -> decode|execute stage

module pl_reg_de (
    input             clk, en, clr,
    input      [31:0] SrcAD, writedataD, ImmExtD, PCD, InstrD, PCPlus4D, ReadDataD,
	 input 		[1:0]  Result_src, 
	 input 				 alu_src, regwrite, branch, jalr, jump,
	 input 		[3:0]  Alu_control,
    output reg [31:0] SrcAE, writedataE, ImmExtE, PCE, InstrE, PCPlus4E, ReadDataE,
	 output reg [1:0]  Result_srcE,
	 output reg [3:0]  Alu_controlE,
	 output reg 		 alu_srcE, regwriteE, branchE, jalrE, jumpE
);

initial begin
    {SrcAE, writedataE, ImmExtE, PCE, InstrE, Result_srcE, Alu_controlE, alu_srcE, regwriteE, branchE, jalrE, jumpE} = 0;
end

always @(posedge clk) begin
    if (clr) begin
       {SrcAE, writedataE, ImmExtE, PCE, InstrE, ReadDataE, Result_srcE, Alu_controlE, alu_srcE, regwriteE, branchE, jalrE, jumpE} <= 0;
    end else if (!en) begin
		 {SrcAE, writedataE, ImmExtE, PCE, InstrE, PCPlus4E, ReadDataE} 	 <= {SrcAD, writedataD, ImmExtD, PCD, InstrD, PCPlus4D, ReadDataD};
       {alu_srcE, regwriteE, branchE, jalrE, jumpE} <= {alu_src, regwrite, branch, jalr, jump,};
		  Result_srcE											 <= Result_src;
		  Alu_controlE											 <= Alu_control;
    end
end

endmodule
