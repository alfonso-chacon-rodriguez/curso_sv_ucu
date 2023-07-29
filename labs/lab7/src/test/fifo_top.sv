`include "../packages/fifo_ports.sv"

//program fifo_top (fifo_ports ports, fifo_monitor_ports mports);
module fifo_top (fifo_ports ports, fifo_monitor_ports mports);
  `include "../packages/fifo_sb.sv"
  `include "../packages/fifo_driver.sv"
   //generate the driver component here
  ???

  initial begin
    //start the driver (use the function go)
    ???;
  end

//endprogram
endmodule

