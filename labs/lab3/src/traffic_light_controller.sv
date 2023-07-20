module traffic_light_controller (

input logic  clock,
input logic  reset,
input logic  car,

output logic red, 
output logic yellow, 
output logic green)
;

typedef enum logic [1:0] {S0 = 2'b00,
                            S1 = 2'b01,
                            S2 = 2'b10,
                            S3 = 2'b11} state_vector;

//state_vector current_state
state_vector  current_state, next_state;

//logic red, yellow, green;

/*------- Sequential Logic ----*/
always_ff@(posedge clock or negedge reset)
        if (!reset)   
            current_state <= S0;
        else  
            current_state <= next_state;

// next state logic
always_comb
begin

    //What would you need to add in order to check for a emergency input signal?
    unique case (current_state) // Ensure a paralell case (no priority)
        S0: begin 
        //Stay in SO while there is no car
                if (car) 
                    next_state = S1;
                else 
                    next_state = S0;
            end
        S1: begin
                next_state = S2; //Stay on S1 for one clock
            end
        S2 : begin
                next_state = S0; // Stay on S2 for one clock
            end
        default : next_state = S0;
    endcase
end

// output state logic
always_comb
begin
    red    = 0; 
    yellow = 0; 
    green  = 0;  // defaults to prevent latches
    unique case (current_state) // Ensure a paralell case (no priority)
        S0: begin 
                red = 1; //Red light at first, while there is no car
            end
        S1: begin
                yellow     = 1;
            end
        S2 : begin
                green      = 1;
            end
        default : red = 1;
    endcase
end

//What would you add in order to make the lights stay for several clocks, with a higher speed clock?

endmodule
