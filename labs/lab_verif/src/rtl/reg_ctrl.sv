// This exammple is mainly taken from ChipVerify
// https://www.chipverify.com/systemverilog/systemverilog-testbench-example-1
// June 7, 2023
// Please respect ownership of this code, as kindly provided by ChipVerify for educative purposes

// Design: A simple memory module

// Additonal notes and minor modifications: Alfonso Chacon Rodriguez, June 7, 2023

// Note that in this protocol, write data is provided
// in a single clock along with the address while read
// data is received on the next clock, and no transactions
// can be started during that time indicated by "ready"
// signal.

module reg_ctrl
  # (
     parameter ADDR_WIDTH 	= 8,
     parameter DATA_WIDTH 	= 16,
     parameter DEPTH 		= 256,
     parameter RESET_VAL  	= 16'h1234
  )
  ( input logic                     clk,
  	input logic					    rstn,
    input logic [ ADDR_WIDTH-1:0] 	addr,
    input logic					    sel,
  	input logic					     wr,
    input logic [DATA_WIDTH-1:0] 	wdata,
    output logic [DATA_WIDTH-1:0] 	rdata,
    output logic        			ready);

  	// Some memory element to store data for each addr
  logic [DATA_WIDTH-1:0] ctrl [DEPTH];

  logic  ready_dly;
  wire   ready_pe;

  // If reset is asserted, clear the memory element
  // Else store data to addr for valid writes
  // For reads, provide read data back
  always_ff @ (posedge clk) begin
    if (!rstn) begin
      for (int i = 0; i < DEPTH; i += 1) begin
        ctrl[i] <= RESET_VAL;
      end
    end else begin
    	if (sel & ready & wr) begin
      		ctrl[addr] <= wdata;
    	end

    	if (sel & ready & !wr) begin
          rdata <= ctrl[addr];
  		end else begin
          rdata <= 0;
        end
    end
  end

  // Ready is driven using this always block
  // During reset, drive ready as 1
  // Else drive ready low for a clock low
  // for a read until the data is given back
  always_ff @ (posedge clk) begin
    if (!rstn) begin
      ready <= 1;
    end else begin
      if (sel & ready_pe) begin
      	ready <= 1;
      end
	 if (sel & ready & !wr) begin
       ready <= 0;
     end
    end
  end

  // Drive internal signal accordingly
  // This creates a one-clock delayed ready (pipeline)
  // in order to provide a one-clock window in which the register may not be writter
  // as a read is taking place
  
  always_ff @ (posedge clk) begin
    if (!rstn) ready_dly <= 1;
   		else ready_dly <= ready;
  end

   assign ready_pe = ~ready & ready_dly;
endmodule