`include "Driver.sv"

class monitor;
	virtual inter_face vif;
	mailbox scb_mbx;
	reg_item item;

	task run();
      $display("[Monitor] : starting *** at T=%0t",$time);
		forever begin
			reg_item item = new;
			item.A <= vif.A;
			item.B  <= vif.B;
			item.opcode <= vif.opcode;

			@(posedge vif.clk);
			item.Result = vif.Result;
			scb_mbx.put(item);
		end
	endtask
endclass