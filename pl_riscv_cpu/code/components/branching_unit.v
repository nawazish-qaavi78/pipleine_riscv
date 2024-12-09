
// branching_unit.v - logic for branching in execute stage

module branching_unit (
    input [2:0] funct3,
    input       Zero, ALUR31, carry, overflow,
    output reg  Branch
);

initial begin
    Branch = 1'b0;
end

always @(*) begin
    case (funct3)
        3'b000: Branch =  Zero; // beq
        3'b001: Branch = ~Zero; // bne
		  3'b100: Branch = ALUR31 != overflow;
        3'b101: Branch = ALUR31 == overflow; // bge
		  3'b110: Branch = carry;
		  3'b111: Branch = ~carry;
        default: Branch = 1'b0;
    endcase
end

endmodule