// Synthezizable RegisterFile
// Start Date: Aug 16, 2021 (ACR)
// Revisions: 0.1 Library is created from RGR's library. Syntax updated to SV
//         
//
// Primitives are based on RGR's library
// RGR's  library was created by Ronny Garcia-Ramirez. Is an RTL (structured) synthesizable primitives library (2021)
//

////////////////////////////////////////////////////////////////////////
// Definition of an in order counter from 0 to a parametrized number //
////////////////////////////////////////////////////////////////////////
  

module Counter#(parameter mx_cnt = 32) (
  output logic [$clog2(mx_cnt)-1:0] count,
  input  logic clk,
  input  logic rst);
 
     

  always_ff @(posedge clk, posedge rst)
       if (rst)
           count <= 0;
       else
         count <= count +1;
endmodule


//////////////////////////////////////////////////////////
// Definition of a third state buffer  //
/////////////////////////////////////////////////////////

module tri_buf (
    input  logic a,
    output logic cb,
    input  logic en);
 
    
   assign b = (en) ? a : 1'bz;
     	  	 
endmodule


//////////////////////////////////////////////////////////////////////
// Definition of a D flip flop with asyncronous reset, writing enable  //
/////////////////////////////////////////////////////////////////////

module dff_async_rst_en (
  input  logic data,
  input  logic clk,
  input  logic reset,
  input  logic wr_en,
  output logic q);

  always_ff @ ( posedge clk, posedge reset)    
    if (reset) begin
      q <= 1'b0;
    end  
      else if (wr_en) begin
            q <= data;
            end

endmodule

//////////////////////////////////////////////////////////
// Definition of a D flip flop with asyncronous reset  //
/////////////////////////////////////////////////////////

module dff_async_rst (
  input  logic data,
  input  logic clk,
  input  logic reset,
  output reg q);

  always_ff @ ( posedge clk, posedge reset)    
    if (reset) begin
      q <= 1'b0;
    end  else begin
      q <= data;
    end

endmodule

//////////////////////////////////////////////////////////
// Definition of a D Latch  with asyncronous reset  //
/////////////////////////////////////////////////////////

module dltch_async_rst (
  input  logic data,
  input  logic clk,
  input  logic reset,
  output logic q);

  always_latch   
    if (reset) begin
      q <= 1'b0;
    end  else if (clk) begin
      q <= data;
    end

endmodule

//////////////////////////////////////////////////////////
// Definition of a D Latch  without  reset  //
/////////////////////////////////////////////////////////

module dltch (
  input data,
  input clk,
  output reg q);

  always_latch    
    if (clk) begin
      q <= data;
    end

endmodule

///////////////////////////////////////////////////////////////////////
// Definition of the prll D register with flops
///////////////////////////////////////////////////////////////////////

module prll_d_reg #(parameter bits = 32)(
  input  logic clk,
  input  logic reset,
  input  logic [bits-1:0] D_in,
  output logic [bits-1:0] D_out
);
  genvar i;
  generate
    for(i = 0; i < bits; i=i+1) begin:bit_
      dff_async_rst prll_regstr_(.data(D_in[i]),.clk(clk),.reset(reset),.q(D_out[i]));
    end
  endgenerate

endmodule

///////////////////////////////////////////////////////////////////////
// Definition of the prll D register with flops (enabled writing)
///////////////////////////////////////////////////////////////////////

module prll_d_en_reg #(parameter bits = 32)(
  input  logic clk,
  input  logic reset,
  input  logic wr_en,
  input  logic [bits-1:0] D_in,
  output logic [bits-1:0] D_out
);
  genvar i;
  generate
    for(i = 0; i < bits; i=i+1) begin:bit_
      dff_async_rst_en prll_regstr_en_(.data(D_in[i]),.clk(clk),.reset(reset),.q(D_out[i]),.wr_en(wr_en));
    end
  endgenerate

endmodule

///////////////////////////////////////////////////////////////////////
// Definition of the prll D register with latches 
///////////////////////////////////////////////////////////////////////

module prll_d_ltch_no_rst #(parameter bits = 32)(
  input  logic clk,
  input  logic [bits-1:0] D_in,
  output logic [bits-1:0] D_out
);
  genvar i;
  generate
    for(i = 0; i < bits; i=i+1) begin:bit_
      dltch prll_regstr_(.data(D_in[i]),.clk(clk),.q(D_out[i]));
    end
  endgenerate

endmodule

///////////////////////////////////////////////////////////////////////
// Definition of the prll D register with latches 
///////////////////////////////////////////////////////////////////////

module prll_d_ltch #(parameter bits = 32)(
  input  logic clk,
  input  logic reset,
  input  logic [bits-1:0] D_in,
  output logic [bits-1:0] D_out
);
  genvar i;
  generate
    for(i = 0; i < bits; i=i+1) begin:bit_
      dltch_async_rst prll_regstr_(.data(D_in[i]),.clk(clk),.reset(reset),.q(D_out[i]));
    end
  endgenerate

endmodule


