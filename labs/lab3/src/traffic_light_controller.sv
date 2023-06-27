module traffic_light_controller (

input logic  clock,
input logic  reset,
input logic  car,

output logic red, 
output logic yellow, 
output logic green)
;

parameter enum logic [1:0] {S0 = 2'b00,
                            S1 = 2'b01,
                            S2 = 2'b10,
                            S3 = 2'b11;}

//state_vector current_state
logic [1:0]  current_state, next_state;

logoc red, yellow, green;

/*------- Sequential Logic ----*/
always_ff@(posedge clock or negedge reset)
        if (!reset)   
            current_state <= S0;
        else  
            current_state <= next_state;

/* next state logic and output logic */
always_comb
begin
    red    = 0; 
    yellow = 0; 
    green  = 0;  // defaults to prevent latches
    unique case (current_state) // Ensure a paralell case (no priority)
        S0: begin 
                red = 1; //Red light at first, while there is no car
                if (car) 
                    next_state = S1
                else 
                    next_state = S0;
            end
        S1: begin
                yellow     = 1;
                next_state = S2; //Yellow stays on for one clock
            end
        S2 : begin
                green      = 1;
                next_state = S0; // Green stays for one clock
            end
        default : next_state = S0;
    endcase
end

endmodule
