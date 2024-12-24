module hazard_unit (
    input 				 clk, 
	 input 		[4:0]  rs1D, rs2D, rdE, rdM, rdW,
	 input 				 RegWriteM, RegWriteW,
	 input 		[1:0]  ResultSrcE,
    output reg 		 StallF, FlushD, StallD, StallE, FlushE, StallM, FlushM, StallW, FlushW,
	 output reg [1:0]  fd1, fd2
);
    always @(posedge clk) begin
        {StallF, FlushD, StallD, StallE, FlushE, StallM, FlushM, StallW, FlushW} = 0;
		  
		  fd1 = {(rs1D==rdM & RegWriteM), (rs1D==rdW & RegWriteW)};
		  fd2 = {(rs2D==rdM & RegWriteM), (rs2D==rdW & RegWriteW)};
		  
		  if(ResultSrcE == 2'b01 && (rs1D == rdE || rs2D == rdE)) begin
				StallF = 1;
				StallD = 1;
				FlushE = 1;
		  end
		  
		  
		  
    end
endmodule