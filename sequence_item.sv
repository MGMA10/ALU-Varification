class reg_item;

    rand bit  	[7:0]   A;
    rand bit  	[7:0]   B;
    rand bit    [3:0]   opcode;
    bit  	  	[7:0]   Result;    

constraint op {opcode inside {[0:4]}; }

      function void print(string tag="");
        $display("T=%0t [%s] A= %0d B=%0d opcode= %0b Result= %0d ",$time,tag,A,B,opcode,Result);
      endfunction
  endclass
