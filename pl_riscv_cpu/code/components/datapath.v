
// datapath.v
module datapath (
    input         clk, reset,
    input [1:0]   ResultSrc,
    input         MemWrite, ALUSrc, RegWrite,
    input [1:0]   ImmSrc,
    input [3:0]   ALUControl,
    input         Branch, Jump, Jalr,
    output [31:0] PC,
    input  [31:0] Instr,
    output [31:0] Mem_WrAddr, Mem_WrData,
    input  [31:0] ReadData,
    output [31:0] Result,
    output [31:0] PCW, ALUResultW, WriteDataW,
	 output 			MemWriteM,
	 output [2:0]  funct3M,
	 output [31:0] InstrD
);

wire [31:0] PCJalr, PCPlus4, PCNext;
wire [31:0] SrcA, WriteData;


wire FlushD = 0; // remove it after adding hazard unit
wire StallD = 1;
wire [31:0] PCD, PCPlus4D, ImmExtD;


wire StallE = 1, FlushE = 0;
wire [31:0] SrcAE, WriteDataE, ImmExtE, PCE, InstrE, PCPlus4E, PCTargetE;
wire [1:0]  ResultSrcE;
wire [3:0]  ALUControlE;
wire		   MemWriteE, ALUSrcE, RegWriteE, BranchE, JalrE, JumpE;
wire [31:0] AuiPCE, lAuiPCE, SrcBE, ALUResultE;
wire 			ZeroE, carryE, overflowE, TakeBranchE;
wire 			PCSrcE;

wire StallM = 1, FlushM = 0;
wire [31:0] ALUResultM, PCPlus4M, lAuiPCM, WriteDataM, PCM;
wire [1:0]  ResultSrcM;
wire RegWriteM;


wire StallW = 1, FlushW = 0;
wire [31:0] ReadDataW, PCPlus4W, lAuiPCW, ResultW;
wire [1:0]  ResultSrcW;
wire 			RegWriteW;


assign PCSrcE = ((BranchE & TakeBranchE) | JumpE | JalrE);

// next PC logic
mux2 #(32)     pcmux(PCPlus4E, PCTargetE, PCSrcE, PCNext);
mux2 #(32)     jalrmux (PCNext, ALUResultE, JalrE, PCJalr);

// stallF - should be wired from hazard unit
wire StallF = 0; // remove it after adding hazard unit.
reset_ff #(32) pcreg(clk, reset, StallF, PCJalr, PC);
adder          pcadd4(PC, 32'd4, PCPlus4);

// Pipeline Register 1 -> Fetch | Decode

pl_reg_fd 		plfd (clk, StallD, FlushD, Instr, PC, PCPlus4, InstrD, PCD, PCPlus4D);

// register file logic
reg_file       rf (clk, RegWriteW, InstrD[19:15], InstrD[24:20], InstrD[11:7], ResultW, SrcA, WriteData);
imm_extend     ext (InstrD[31:7], ImmSrc, ImmExtD);

// Pipeline Register 2 -> Decode | Execute

pl_reg_de		plde (clk, StallE, FlushE, 
							SrcA, WriteData, ImmExtD, PCD, InstrD, PCPlus4D,
							ResultSrc, MemWrite, ALUSrc, RegWrite, Branch, Jalr, Jump, ALUControl, 
							SrcAE, WriteDataE, ImmExtE, PCE, InstrE, PCPlus4E,
							ResultSrcE, ALUControlE, MemWriteE, ALUSrcE, RegWriteE, BranchE, JalrE, JumpE);
							

// ALU logic

mux2 #(32)     srcbmux(WriteDataE, ImmExtE, ALUSrcE, SrcBE);
alu            alu (SrcAE, SrcBE, ALUControlE, ALUResultE, ZeroE, carryE, overflowE);
adder #(32)    auipcadder ({InstrE[31:12], 12'b0}, PCE, AuiPCE);
mux2 #(32)     lauipcmux (AuiPCE, {InstrE[31:12], 12'b0}, InstrE[5], lAuiPCE);

adder          pcaddbranch(PCE, ImmExtE, PCTargetE);

branching_unit bu (InstrE[14:12], ZeroE, ALUResultE[31], carryE, overflowE, TakeBranchE);

// Pipeline Register 3 -> Execute | Memory

pl_reg_em		plem (clk, StallM, FlushM, 
							ALUResultE, PCE, PCPlus4E, lAuiPCE, WriteDataE, ResultSrcE, RegWriteE, MemWriteE, InstrE[14:12],
							ALUResultM, PCM, PCPlus4M, lAuiPCM, WriteDataM, ResultSrcM, RegWriteM, MemWriteM, funct3M);

// Pipeline Register 4 -> Memory | Writeback

pl_reg_mw 		plmw (clk, StallW, FlushW,
							ALUResultM, ReadData, WriteDataM, PCM, PCPlus4M, lAuiPCM, ResultSrcM, RegWriteM, 
							ALUResultW, ReadDataW, WriteDataW, PCW, PCPlus4W, lAuiPCW, ResultSrcW, RegWriteW);

// Result Source
mux4 #(32)     resultmux(ALUResultW, ReadDataW, PCPlus4W, lAuiPCW, ResultSrcW, ResultW);

assign Result = ResultW;
// hazard unit

assign Mem_WrData = WriteDataM;
assign Mem_WrAddr = ALUResultM;

endmodule
