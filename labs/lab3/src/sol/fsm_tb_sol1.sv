`include "./traffic_light_controller.sv"

module fsm_tb;

logic  clock;
logic  reset;
logic  car;

logic red; 
logic yellow;
logic green;
// Define any parameters or variables you might need here in order to connect the FSM
// Check the prior labs for examples


//Instantiate and connect the FSM serving as DUT
// Check lab 1 for examples

traffic_light_controller DUT (.clock(clock),
                              .reset(reset),
                              .car(car),
                              .red(red), 
                              .yellow(yellow), 
                              .green(green));

//Provide initial value to input signals to DUT here 
  initial begin
    clock = 0; 
    reset = 0;
    car   = 0; 
  end 

// You will need a clock
// Place the clock generator here, using the example from lab 3
  always  
    #5 clock = !clock;


//You need something to monitor the inputs and outputs 

  initial  begin
    $display("\t\ttime,\tclock,\treset,\tcar,\tred,\tyellow,\tgreen"); 
    $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b",$time, clock,reset,car,red,yellow,green); 
  end 


//Main test
initial begin
  reset =0;
  wait_task(5); //keeps the reset for 5 clocks
  @(negedge clock) reset= 1; //See how stimulus signals are changed on the opposite clk edge
  // This avoids race conditions
  // Place here the testing sequence
  // For now something very basic to start running the existing traffic light controller FSM
  wait_task(2); //keeps the reset for 5 clocks
  @(negedge clock) car= 1; //This should start the sequence on the next clock posedge
  @(negedge clock) car= 0;
  wait_task(4); //Wait 4 clocks, FSM should return to normal sate

$finish;


// As soon as you get the traffic_light_controller FSM running, proceed to modify it, 
// in a different file and with a different module name, adding the required new functionality
// Copy this tb into another one, to go from there with the test of the new FSM
// Add some reset and termination control as used in lab 2.
// Try to see if you can add some randomness to the emergency input

end //initial

//We're going to use this very basic task to provide some  waiting
// How can you make this waiting random?

//Procedure that waits <index> clock cycles 
task wait_task (input integer index);
	//Index is the clock cycles to wait
   integer	j; //for counting variable
            //$display("Call to wait for T=\t\index,\tclk");
            //$display("\t%d, \t%b", index, clk);
            for (j=1; j<=index; j=j+1) //
              @(posedge clock);
              //#10;

endtask	

endmodule