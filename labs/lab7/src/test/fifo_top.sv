`include "../packages/fifo_ports.sv"

//program fifo_top (fifo_ports ports, fifo_monitor_ports mports);
module fifo_top (fifo_ports ports, fifo_monitor_ports mports);
  `include "../packages/fifo_sb.sv"
  `include "../packages/fifo_driver.sv"

  fifo_driver driver = new(ports, mports);

  initial begin
    driver.go();
  end

//endprogram
endmodule

