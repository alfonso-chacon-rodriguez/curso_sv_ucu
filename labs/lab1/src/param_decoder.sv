module param_decoder #(parameter DEPTH = 8) (
    input  logic [$clog2(DEPTH)-1:0]  deco_in,    //  N-bit select input
    output logic [DEPTH-1:0]          deco_out,  //  M-bit out 
    input  logic                      enable        //  Enable for the decoder
    );
//--------------Code Starts Here----------------------- 
assign deco_out = (enable) ? ({{(DEPTH-1){1'b0}},1'b1}  << deco_in) : {DEPTH{1'b0}} ;
//assign deco_out = (enable) ? (1  << deco_in) : {DEPTH{1'b0}} ;
endmodule