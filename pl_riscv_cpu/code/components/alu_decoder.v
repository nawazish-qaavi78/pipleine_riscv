
// alu_decoder.v - logic for ALU decoder

module alu_decoder (
    input            opb5,
    input [2:0]      funct3,
    input            funct7b5,
    input [1:0]      ALUOp,
    output reg [3:0] ALUControl
);

always @(*) begin
    case (ALUOp)
        2'b00: ALUControl = 4'b0000;             // addition
        2'b01: ALUControl = 4'b0001;             // subtraction
        default:
            case (funct3) // R-type or I-type ALU
                3'b000: ALUControl = (funct7b5 & opb5) ? 4'b0001 : 4'b0000;
					 3'b001:  ALUControl = 4'b1000; 
                3'b010:  ALUControl = 4'b0101; // slt, slti
					 
					 3'b011:  ALUControl = 4'b1001; // less than
					 3'b100:  ALUControl = 4'b0100; // xor 
					 3'b101:  ALUControl = funct7b5 ? 4'b0111 : 4'b0110;
					 
                3'b110:  ALUControl = 4'b0011; // or, ori
                3'b111:  ALUControl = 4'b0010; // and, andi
                default: ALUControl = 4'bx; // ???
            endcase
    endcase
end

endmodule

