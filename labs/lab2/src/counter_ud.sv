module counter_ud #(parameter N = 8)
                (input  logic clk,
                 input  logic reset,
                 input  logic enable,
                 output logic [N-1:0] q); //You'd need a new input for controlling the counter direction

  always_ff @(posedge clk, posedge reset)
    if (reset) 
        q <= '0;
    else  
        if (enable) //From here, add the necessary code to make this an up_down counter

             q <= q + 1'b1;
endmodule 