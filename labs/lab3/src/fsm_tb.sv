module fsm_tb;

// Define any parameters or variables you might need here in order to connect the FSM
// Check the prior labs for examples


//Instantiate and connect the FSM serving as DUT
// Check lab 1 for examples

traffic_light_controller DUT (.clock(),
                              .reset(),
                              .car(),
                              .red(), 
                              .yellow(), 
                              .green());

//Provide initial value to input signals to DUT here 
  initial begin
    clock = 0; 
    reset = 0;
    car   = 0; 
  end 

// You will need a clock
// Place the clock generator here, using the example from lab 3
  always  
    #5 clk = !clk;


//Main test
initial begin

// Place here the testing commands
// For now something very basic to start running the existing light controller
// As soon as you get that running, proceed to modify it, 
// in a different file and with a different module name, adding the required new functionality
// Copy this tb into another one, to go from therr with the test of the new FSM
// Add some reset and termination control as used in lab 2.
// Try to see if you can add some randomness to the emergency input

end //initial

//We're going to use this very basic task to provide some random waiting

//Procedure that waits <index> clock cycles 
task wait_task (input integer index);
	//Index is the clock cycles to wait
   integer	j; //for counting variable
            //$display("Call to wait for T=\t\index,\tclk");
            //$display("\t%d, \t%b", index, clk);
            for (j=1; j<=index; j=j+1) //
              @(posedge clk);
              //#10;

endtask	

endmodule