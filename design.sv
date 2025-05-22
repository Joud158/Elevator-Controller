`timescale 1ns / 1ps

module above(
  input wire [1:0] current_floor,
  input wire [3:0] request,
  output wire a
);
  assign a = |(request & ~(4'b1111 >> (2'b11 - current_floor)));
endmodule

module below(
  input wire [1:0] current_floor,
  input wire [3:0] request,
  output wire b
);
  assign b = |(request & ~(4'b1111 << current_floor));
endmodule

module elevator_fsm (
    input wire clk,
    input wire rst,
    input wire [3:0] f_req,      // Floor requests
    input wire [3:0] c_req,      // Cabin requests
    output reg [3:0] request,    // Combined requests
    output reg [1:0] current_floor, // Current floor
    output reg direction,        // Direction: 1 = Up, 0 = Down
    output reg door_open         // Door open: 1 = Yes, 0 = No
);

    wire abv, bel;

    // Instantiate helper modules
    above abv1(.current_floor(current_floor), .request(request), .a(abv));
    below bel1(.current_floor(current_floor), .request(request), .b(bel));

    // Request register and state update
    always @(posedge clk or posedge rst) begin
    if (rst) begin
        current_floor <= 2'b00; // Start at GF
        request <= 4'b0000; // Default to no requested floors
        direction <= 1'b1; // Default to moving up
        door_open <= 1'b0; // Default to closed
    end else begin
        // Merge new requests into the request register
      	door_open=1'b0; //door is closed by default until explicitly opened
        request <= (request | c_req | f_req) & ~(1 << current_floor);

        if (request[current_floor]) begin
            // Open door and clear current floor request
            door_open <= 1'b1;
            request[current_floor] <= 1'b0;
        end else if (abv && (!bel || direction == 1'b1)) begin
            // Move up
            direction <= 1'b1;
            current_floor <= current_floor + 2'b01;
          
        end else if (bel && (!abv || direction == 1'b0)) begin
            // Move down
            direction <= 1'b0;
            current_floor <= current_floor - 2'b01;
          
        end else begin
            // Remain idle
          	direction <= direction;
        end
    end
end

endmodule