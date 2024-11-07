
// Created tb for the Synchronous Single port RAM
module tb;
  parameter ADDR_WIDTH = 4;
  parameter DATA_WIDTH = 32;
  parameter DEPTH = 16;
  reg clk;
  reg [ADDR_WIDTH-1:0] addr;
  reg cs, we, oe;
  wire [DATA_WIDTH-1:0] data;
  reg [DATA_WIDTH-1:0] data_out;
  integer i;
 
  single_port_sync_ram  #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH), .DEPTH(DEPTH)) dut (.clk(clk), .addr(addr), .data(data), .cs(cs), .we(we), .oe(oe));
  
  assign data = (we) ? data_out: 'hz;
   initial begin
     clk = 0 ;
     forever #5 clk = ~clk;
   end
  
  initial begin
    cs = 0;
    oe = 0;
    we = 0;
    data_out = 0;
    

    #10;
    $display("The initial data = %0d ", data);
    // Write operation
    cs = 1;
    we = 1;
    addr = 4'h2;           
    data_out = 32'd52; 
    #10;               
    $display("Write Data to addr 2: %0d", data_out);
    // Writing  another value
    addr = 4'h3;         
    data_out = 32'd20;   
    #10;         
    $display("Write Data to addr 3: %0d", data_out);
    
    // Read operation
    we = 0;
    oe = 1;
    
    addr = 4'h2;  
    #10;         
    $display("Read Data from addr %d: %0d" , addr, data);

    addr = 4'h3; 
    #10;          
    $display("Read Data from addr %d: %0d", addr, data);
    /*
    #10;
    cs = 1;
    we = 1;
    #10;
    //WRITE OPEARTION
    for( i = 0; i < DEPTH ; i = i+1 ) begin
      addr = i ;
      data_out = $random;
      $display(" Write data to address %d : %d ", addr, data_out);
      #10;
    end
    
    we = 0;
    oe = 1;
    //READ OPERATION
    for( i = 0; i < DEPTH; i = i+1 ) begin
      addr = i ;
      #10;
      $display("Read data from address %d : %d ", addr, data);
      
    end
    $stop; */
    
    #500;$finish;
  end
endmodule
