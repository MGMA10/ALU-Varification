module Sequential_ALU(
    input clk,
    input rst_n,
    input [3:0] opcode,     // Operation selector
    input [7:0] A, B,       
  	output reg [8:0] Result // Output result
);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        Result <= 8'b0;
    end else begin
        case(opcode)
            4'b0000: begin
                 Result <= A + B; 
            end
            4'b0001: begin
                 Result <= A - B;  
            end
            4'b0010: Result <= A & B;     
            4'b0011: Result <= A | B;         
            4'b0100: Result <= A ^ B;    
            default: Result <= 8'b0;
        endcase

    end
end

endmodule
