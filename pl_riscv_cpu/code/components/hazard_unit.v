module hazard_unit (
    input 				 clk, 
	 input 		[4:0]  rs1D, rs2D, rs1E, rs2E, rdE, rdM, rdW,
	 input 				 RegWriteM, RegWriteW, PCSrcE, JalrE,
	 input 		[1:0]  ResultSrcE,
    output reg 		 StallF, FlushD, StallD, StallE, FlushE, StallM, FlushM, StallW, FlushW,
	 output 	   [1:0]  fd1, fd2
);

	 assign fd1 = {(rs1E==rdM & RegWriteM), (rs1E==rdW & RegWriteW)};
	 assign fd2 = {(rs2E==rdM & RegWriteM), (rs2E==rdW & RegWriteW)};
	 
    always @(*) begin
        {StallF, FlushD, StallD, StallE, FlushE, StallM, FlushM, StallW, FlushW} = 0;
		  
		  if(JalrE | PCSrcE) begin
				FlushD = 1;
				FlushE = 1;
		  end else if(ResultSrcE == 2'b01 && (rs1D == rdE || rs2D == rdE)) begin
				StallF = 1;
				StallD = 1;
				FlushE = 1;
		  end 
    end
	 
	 
endmodule