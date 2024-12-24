
// pipeline registers -> decode|execute stage

module pl_reg_de (
    input             clk, en, clr,
    input      [31:0] SrcAD, writedataD, ImmExtD, PCD, InstrD, PCPlus4D,
	 input 		[1:0]  Result_src, 
	 input 				 MemWrite, alu_src, regwrite, branch, jalr, jump,
	 input 		[3:0]  Alu_control,
    output reg [31:0] SrcAE, writedataE, ImmExtE, PCE, InstrE, PCPlus4E,
	 output reg [1:0]  Result_srcE,
	 output reg [3:0]  Alu_controlE,
	 output reg 		 MemWriteE, alu_srcE, regwriteE, branchE, jalrE, jumpE
);

initial begin
    {SrcAE, writedataE, ImmExtE, PCE, InstrE, PCPlus4E, Result_srcE, Alu_controlE, MemWriteE, alu_srcE, regwriteE, branchE, jalrE, jumpE} = 0;
end

always @(posedge clk) begin
    if (clr) begin
       {SrcAE, writedataE, ImmExtE, PCE, InstrE, Result_srcE, Alu_controlE, MemWriteE, alu_srcE, regwriteE, branchE, jalrE, jumpE} <= 0;
    end else if (!en) begin
		 SrcAE 			<= SrcAD;
		 writedataE 	<= writedataD;
		 ImmExtE 		<= ImmExtD;
		 PCE 				<= PCD;
		 InstrE 			<= InstrD;
		 PCPlus4E 		<= PCPlus4D;
		 MemWriteE 		<= MemWrite;
		 alu_srcE 		<= alu_src;
		 regwriteE 		<= regwrite;
		 branchE		   <= branch;
		 jalrE 			<= jalr;
		 jumpE 			<= jump;
		 Result_srcE   <= Result_src;
		 Alu_controlE  <= Alu_control;
    end
end

endmodule
