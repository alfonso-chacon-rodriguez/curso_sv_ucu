/////////////////////////////////////////////////////////////////////////
// Parameterized Mux                                                   //
/////////////////////////////////////////////////////////////////////////
module param_mux #(parameter num_slct_lns = 2, parameter pck_sz = 4) (
  input     logic   [num_slct_lns-1:0]  i_select,
  input     logic   [pck_sz-1:0]        i_input_signal[(2**num_slct_lns)-1:0],
  output    logic   [pck_sz-1:0]        o_out
);
logic [(2**num_slct_lns)-1:0] hot_bit_slct;
 
genvar j;
generate
    for(j=0; j<(2**num_slct_lns); j++)begin:_nu_
        always_comb begin
            hot_bit_slct[j] = (j == i_select)?{1'b1}:{1'b0};
        end
end    
endgenerate
 
always_comb begin
    o_out = '0;
    for (int i = 0; i<(2**num_slct_lns); i++) begin
        if (hot_bit_slct[i]) begin
            o_out = i_input_signal[i];
        end
    end
end