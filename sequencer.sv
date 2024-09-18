`include "sequence_item.sv"

class sequencer;
	int loop = 1000;
	event drv_done;
	mailbox drv_mbx;

	task run;
		for(int i=0; i<loop ;i++) begin
			reg_item item = new;
			item.randomize();
          $display("T=%0t [Generator] Loop: %0d whait to creat new item",$time,i);
			drv_mbx.put(item);
          $display("T=%0t [Generator] waiting the driver",$time);
			@(drv_done);
		end
	endtask : run
endclass
