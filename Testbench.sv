`include "Environment.sv"
`include "Interface.sv"
module Testbench_top ;
	bit clk;
	env e;

	always #10 clk=~clk;
	inter_face intr (clk);


	Sequential_ALU u0 (
		.A(intr.A),
		.B(intr.B),
		.opcode(intr.opcode),
		.clk(clk),
		.rst_n(intr.rst_n),
      	.Result(intr.Result)
      );


	initial begin
		clk = 0;
		intr.rst_n = 0;
		#20 intr.rst_n =1;

		e = new();
		e.vif = intr;
		e.run();

      #30 $display ("PASS Tests = %0d , ERROR Tests = %0d",e.s.passcounter,e.s.fallcounter);
		$stop();
	end


endmodule : Testbench_top
