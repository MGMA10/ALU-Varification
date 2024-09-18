`include "MONITOR.sv"

class scoreboard;
    mailbox scb_mbx;
  bit    [7:0]   Result;
    int passcounter;
    int fallcounter;

    function  new();
        passcounter =0; 
        fallcounter =0;
        Result   =0;
    endfunction 

    task run();


        forever begin
            reg_item item;
            scb_mbx.get(item);

          case(item.opcode)
                  	3'b000: Result = item.A + item.B ;
                    3'b001: Result = item.A - item.B ;
                    3'b010: Result = item.A & item.B ;               
                    3'b011: Result = item.A | item.B ;                
                    3'b100: Result = (item.A ^ item.B);                  
                    default: Result = 0 ;           
                endcase
          
          if (Result != item.Result) begin
            $display(" [Scoreboard] ERROR :( A= %0d B=%0d opcode= %0b Result= %0dAT T=%0t",$time,item.A,item.B,item.opcode,item.Result);
                fallcounter = fallcounter +1;
            end else begin
              
              $display(" [Scoreboard] PASS :) A= %0d B=%0d opcode= %0b Result= %0b At T=%0t",$time,item.A,item.B,item.opcode,item.Result);
                passcounter = passcounter+1;
            end
        end
    endtask
endclass

