// Synthezizable RegisterFile
// Start Date: Aug 16, 2021 (ACR)
// Revisions
//
// Primitives are taken from RGR's library

`ifndef SYNTH_LIB_INC // if the synthesis library has not been included
   `include "./synth_prim_library.sv" // Do so
`endif  

`include "bus_definitions.sv" //Compile the package

module RegFile (
   input logic [ws-1:0] DataIn,
   input logic clk,
   input logic reset,
   input logic wr,
   input logic rd,
   input logic [as-1:0] AddrRd,
   input logic [as-1:0] AddrWr,
   inout wire [ws-1:0] DataOut
 );

//parameter ws = 4, depth=8, as=$clog2(depth); 
//ws = wordsize in bits, depth= FIFO's depth (number of words in FIFO)
//Come from the package definitions in bus_definitions.pkg

// Internal signals
// For input/output decos
// Determine the right indexing

    wire [???] InEn; // Wiring for selection of InData
    wire [???] OutEn; // Wiring for selection of OutData

// Wiring for the RF's outputs
// Determine the right indexing

   wire [???] RF_Q [???]; // Wiring for data coming out of the RF

// First we need the decos for input/output
// These decos get the address for reading and writing and generate the decoded
// control that enables the input register in the RF to be written or the
// output register to be read from the RF accordingly. 

//Input Deco
// Wire the correct control signals

generic_deco_N_M  #($clog2(depth),depth) deco_In(.En(wr), .N(AddrWr), .M(InEn));

 //Output Deco
 // Wire the correct control signals
generic_deco_N_M #($clog2(depth),depth) deco_Out(.En(??),.N(??),.M(??));

//
// RF instantiation (depth is the number of ws-bit sized FFs )
//
// InEn[depth-1:0] are the Enables for the FFs
// RF_Q[i] es la salida de cada FF individual del RF
// OutEn[depth-1:0] are the Enables for the buffers
 

genvar i,j;
generate
	for (???)
	begin:FFx_
	   assign enable_in_ =???;
  
	   prll_d_en_reg #(ws) rf_ff_bank_(.clk(clk), .reset(reset),.wr_en(??),.D_in(??), .D_out(???));
   end

endgenerate

//We generate the Ouput Mux (3-state ws-sized buffers actually)
// OutEn[depth-1:0] are the Enables for the buffers
// DataOut[i] is the ws-bit sized individual output of each buffer that generates DataOut[depth-1:0] 
 // We need to generate the ws-sized buffers in another module: tri_buf_N
// Careful here: tri_buf_N uses the same convention as the bufif primitive, i.e. (output, input, control)
//               We'd better use explicit assignment
genvar k;
generate
	for (k=0; k< depth; k=k+1)
	begin:buffer_x1
	   assign enable_out =(OutEn[k]);
		tri_buf_N #(ws) tri_buf_ws_(.Y(DataOut), .X(RF_Q[k]), .enable(enable_out));
   end

endgenerate
 




endmodule