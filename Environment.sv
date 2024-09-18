`include "scoreboard.sv"

class env;
	sequencer g;
	driver	d;
	monitor m;
	scoreboard s;
	mailbox scb_mbx;
	mailbox drv_mbx;
	virtual inter_face vif;
	event drv_done;



	function new();
		g = new;
		d = new;
		m = new;
		s = new;
		scb_mbx = new;
		drv_mbx = new;
	endfunction

	virtual task run;
		d.vif = vif;
		m.vif = vif;

		m.scb_mbx = scb_mbx;
		s.scb_mbx = scb_mbx;

		g.drv_mbx = drv_mbx;
		d.drv_mbx = drv_mbx;

		g.drv_done = drv_done;
		d.drv_done = drv_done;

		fork
			s.run();
			m.run();
			d.run();
			g.run();
		join_any
	endtask
endclass : env
