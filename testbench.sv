`timescale 1ns / 1ps

module elevator_fsm_tb;

    // Inputs
    reg clk;
    reg rst;
    reg [3:0] f_req;
    reg [3:0] c_req;

    // Outputs
    wire [3:0] request;
    wire [1:0] current_floor;
    wire direction;
    wire door_open;

    // Instantiate the Unit Under Test (UUT)
    elevator_fsm uut (
        .clk(clk),
        .rst(rst),
        .f_req(f_req),
        .c_req(c_req),
        .request(request),
        .current_floor(current_floor),
        .direction(direction),
        .door_open(door_open)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

   // Reduce unnecessary idle delays
initial begin
    // Reset and initialize
    clk = 0;
    rst = 1;
    f_req = 4'b0000;
    c_req = 4'b0000;
    #10 rst = 0;

    // Test Case 1: Single floor request
    f_req = 4'b0100;
    #50; 
    f_req = 4'b0000;
    #10;

    // Test Case 2: Multiple requests
    f_req = 4'b1010;
    #50;
    f_req = 4'b0000;
    #10;

    // Test Case 3: Requests in both directions
    f_req = 4'b0010;
    #30;
    f_req = 4'b0001;
    #50;
    f_req = 4'b0000;
    #10;

    // Test Case 4: Cabin request while idle
    c_req = 4'b1000;
    #50;
    c_req = 4'b0000;
    #10;

    // Test Case 5: Idle state
    #50; 

    $display("Testbench completed successfully.");
    $finish;
end




    // Monitor outputs for debugging
    initial begin
      $dumpfile("dump.vcd"); $dumpvars;
        $monitor($time, " | Floor: %b | Requests: %b | Direction: %b | Door Open: %b", 
                 current_floor, request, direction, door_open);
    end

endmodule
