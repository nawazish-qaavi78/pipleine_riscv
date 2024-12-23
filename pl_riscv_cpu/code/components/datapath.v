
// datapath.v
module datapath (
    input         clk, reset,
    input [1:0]   ResultSrc,
    input         ALUSrc, RegWrite,
    input [1:0]   ImmSrc,
    input [3:0]   ALUControl,
    input         Branch, Jump, Jalr,
    output [31:0] PC,
    input  [31:0] Instr,
    output [31:0] Mem_WrAddr, Mem_WrData,
    input  [31:0] ReadData,
    output [31:0] Result,
    output [31:0] PCW, ALUResultW, WriteDataW
);

wire [31:0] PCJalr, PCPlus4, PCTarget, AuiPC, lAuiPC;
wire [31:0] ImmExt, SrcA, SrcB, WriteData, ALUResult;
wire Zero, TakeBranch;


wire FlushD = 0; // remove it after adding hazard unit
wire StallD = 1;
wire [31:0] ReadDataD;
wire [31:0] InstrD, PCD, PCPlus4D;


wire StallE = 1, FlushE = 0;
wire [31:0] SrcAE, WriteDataE, ImmExtE, PCE, InstrE, ReadDataE;
wire [1:0] ResultSrcE;
wire [3:0] ALUControlE;
wire ALUSrcE, RegWriteE, BranchE, JalrE, JumpE;
wire [31:0] AuiPCE, lAuiPCE, SrcBE, ALUResultE;
wire 			ZeroE, carryE, overflowE, TakeBranchE;
wire PCSrcE;

wire StallM = 1, FlushM = 0;
wire [31:0] ALUResultM, PCPlus4M, lAuiPCM, ReadDataM, WriteDataM;
wire [1:0]  ResultSrcM;
wire RegWriteM;


wire StallW = 1, FlushW = 0;
wire [31:0] ReadDataW, PCPlus4W, lAuiPCW, ResultSrcW, RegWriteW;


assign PCSrcE = ((BranchE & TakeBranchE) | JumpE | JalrE);

// next PC logic
mux2 #(32)     pcmux(PCPlus4E, PCTargetE, PCSrcE, PCNextE);
mux2 #(32)     jalrmux (PCNextE, ALUResultE, JalrE, PCJalrE);

// stallF - should be wired from hazard unit
wire StallF = 0; // remove it after adding hazard unit.
reset_ff #(32) pcreg(clk, reset, StallF, PCJalrE, PC);
adder          pcadd4(PC, 32'd4, PCPlus4);

// Pipeline Register 1 -> Fetch | Decode

pl_reg_fd 		plfd (clk, StallD, FlushD, Instr, PC, PCPlus4, ReadData, InstrD, PCD, PCPlus4D, ReadDataD);

adder          pcaddbranch(PCE, ImmExtE, PCTargetE);

// register file logic
reg_file       rf (clk, RegWriteW, InstrD[19:15], InstrD[24:20], InstrD[11:7], Result, SrcA, WriteData);
imm_extend     ext (InstrD[31:7], ImmSrc, ImmExtD);

// Pipeline Register 2 -> Decode | Execute

pl_reg_de		plde (clk, StallE, FlushE, 
							SrcA, WriteData, ImmExtD, PCD, InstrD, PCPlus4D, ReadDataD,
							ResultSrc, ALUSrc, RegWrite, Branch, Jalr, Jump, ALUControl, 
							SrcAE, WriteDataE, ImmExtE, PCE, InstrE, PCPlus4E, ReadDataE,
							ResultSrcE, ALUControlE, ALUSrcE, RegWriteE, BranchE, JalrE, JumpE);
							

// ALU logic

mux2 #(32)     srcbmux(WriteDataE, ImmExtE, ALUSrcE, SrcBE);
alu            alu (SrcAE, SrcBE, ALUControlE, ALUResultE, ZeroE, carryE, overflowE);
adder #(32)    auipcadder ({InstrE[31:12], 12'b0}, PCE, AuiPCE);
mux2 #(32)     lauipcmux (AuiPCE, {InstrE[31:12], 12'b0}, InstrE[5], lAuiPCE);

branching_unit bu (InstrE[14:12], ZeroE, ALUResultE[31], carryE, overflowE, TakeBranchE);

// Pipeline Register 3 -> Execute | Memory

pl_reg_em		plem (clk, StallM, FlushM, 
							ALUResultE, PCPlus4E, lAuiPCE, ReadDataE, WriteDataE, ResultSrcE, RegWriteE,
							ALUResultM, PCPlus4M, lAuiPCM, ReadDataM, WriteDataM, ResultSrcM, RegWriteM);

// Pipeline Register 4 -> Memory | Writeback

pl_reg_mw 		plmw (clk, StallW, FlushW,
							ALUResultM, ReadDataM, WriteDataM, PCPlus4M, lAuiPCM, ResultSrcM, RegWriteM, 
							ALUResultW, ReadDataW, WriteDataW, PCPlus4W, lAuiPCW, ResultSrcW, RegWriteW);

// Result Source
mux4 #(32)     resultmux(ALUResultW, ReadDataW, PCPlus4W, lAuiPCW, ResultSrcW, ResultW);

assign Result = ResultW;
// hazard unit

assign Mem_WrData = WriteData;
assign Mem_WrAddr = ALUResult;

// eventually this statements will be removed while adding pipeline registers
assign PCW = PC;

endmodule
