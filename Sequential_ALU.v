Verilog
module Sequential_ALU(
    input clk,
    input rst_n,
    input [3:0] opcode,     // Operation selector
    input [7:0] A, B,       
    output reg [7:0] Result, // Output result
    output reg Zero,         // Zero flag
    output reg Overflow      // Overflow flag
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        Result <= 8'b0;
        Zero <= 1'b0;
        Overflow <= 1'b0;
    end else begin
        case(opcode)
            4'b0000: begin
                {Overflow, Result} <= A + B; 
            end
            4'b0001: begin
                {Overflow, Result} <= A - B;  
            end
            4'b0010: Result <= A & B;     
            4'b0011: Result <= A | B;         
            4'b0100: Result <= A ^ B;    
            default: Result <= 8'b0;
        endcase
        Zero <= (Result == 8'b0) ? 1'b1 : 1'b0;  
    end
end

endmodule
