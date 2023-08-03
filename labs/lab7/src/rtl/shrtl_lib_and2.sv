module  shrtl_lib_and2 (
    input  logic A,
    input  logic B,
    output logic Q
  );

  `ifdef SHRTL_LIB_MODEL
    always_comb Q = A & B;

  `else
    ip_std_and2 shrtl_and2_dtm ( .Y(Q), .A(A), .B(B) );

  `endif
endmodule   // shrtl_lib_and2