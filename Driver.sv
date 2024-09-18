`include "sequencer.sv"

class driver;
	virtual inter_face vif;
	event drv_done;
	mailbox drv_mbx;

	task run();
      $display("[Driver] : starting ... at T=%0t ",$time);
		forever begin
			reg_item item;

          $display("[Driver] : waiting for iten ... at T=%0t ",$time);
			drv_mbx.get(item);
			vif.A <= item.A;
			vif.B  <= item.B;
			vif.opcode <= item.opcode;
          @(negedge vif.clk);
			->drv_done;
		end
	endtask : run
endclass
