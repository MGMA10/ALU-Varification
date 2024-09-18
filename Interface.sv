interface inter_face (input bit clk);
    logic 		rst_n;
    logic [3:0] opcode;
    logic [7:0] A;
    logic [7:0] B;
    logic [7:0] Result;
    logic 		Overflow;
endinterface
