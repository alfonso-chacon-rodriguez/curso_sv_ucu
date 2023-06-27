module counter_tb; 

  parameter WIDTH = 5;
  logic clk, reset, enable; 
  logic [WIDTH-1:0] count; 
    
  counter #(.N(WIDTH)) DUT // Testing a 5-bits Up counter
          (
  .clk    (clk), 
  .reset  (reset),
  .enable (enable),
  .q      (count) 
  ); 

//Providing initial value to signals   
  initial begin
    clk   = 0; 
    reset = 0;
    enable= 0; 
  end 

//Clock generator
  always  
    #5 clk = !clk; 
    
  //initial  begin
  //  $dumpfile ("counter.vcd"); 
  //  $dumpvars; 
  //end 

// Monitor for signals 
  initial  begin
    $display("\t\ttime,\tclk,\treset,\tenable,\tcount"); 
    $monitor("%d,\t%b,\t%b,\t%b,\t%d",$time, clk,reset,enable,count); 
  end 

// Event used to terminate simulation
  event terminate_sim;  
  initial begin  
  @ (terminate_sim); 
    #5 $finish; 
  end 

//  Event used to reset trigger
  event reset_trigger; 
    event  reset_done_trigger; 
    
    initial
        forever begin 
            @ (reset_trigger); 
            @ (negedge clk); 
            reset = 1; 
            @ (negedge clk); 
            reset = 0; 
            -> reset_done_trigger; 
        end 

// Main testing procedure (TEST_CASE)
  initial

    begin: TEST_CASE 
    #10 -> reset_trigger;
    @ (reset_done_trigger); 
    @ (negedge clk); 
    enable = 1; 
    repeat (10) begin  //Counter advances 10 clocks
        @ (negedge clk); 
      end 
    enable = 0;
    #5 -> terminate_sim; 
    end 

endmodule //Of the whole Testbench modile