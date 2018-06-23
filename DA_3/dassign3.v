// EEM16 - Logic Design
// 2018_05_01
// Design Assignment #3 
// dassign3.v

// Motor Controller 
// Produces the proper motor_drv pulse sequence
// Sample code from Design Assignment #2 for your reference. 
// You can choose to modify this to your design if you so choose.
module motor_ctrl (motor_drv, done, forw, rev, reset, drv_clk);
  output [3:0] motor_drv;
  output 	done;
  input 	forw, rev, reset, drv_clk;
  // Parameters declaration
  parameter P0_ST = 2'b00;
  parameter P1_ST = 2'b01;
  parameter P2_ST = 2'b10;
  parameter P3_ST = 2'b11;
  
  reg [1:0] state, nx_state;
  reg done;
  reg [3:0] motor_drv;

  always @(posedge drv_clk) begin
    state <= nx_state;
  end
  
  always @(state or forw or rev or reset) begin
    if (reset) begin
      nx_state = P0_ST;
      motor_drv = 4'b0000;
      done = 0;
    end
    else begin
      if (forw == 1'b1) begin
        case (state)
          P0_ST: begin
            nx_state = P1_ST;
            motor_drv = 4'b0001;
            done = 1'b1;
          end
          P1_ST: begin
            nx_state = P2_ST;
            motor_drv = 4'b0010;
            done = 1'b0;
          end
          P2_ST: begin
            nx_state = P3_ST;
            motor_drv = 4'b0100;
            done = 1'b0;
          end
          P3_ST: begin
            nx_state = P0_ST;
            motor_drv = 4'b1000;
            done = 1'b0;
          end
          default: begin
            nx_state = P0_ST;
            motor_drv = 4'b0000;
            done = 1'b0;
          end
        endcase // case (state)
      end // if (forw == 1'b1)
      else if (rev == 1'b1) begin
        case (state)
          P0_ST: begin
            nx_state = P3_ST;
            motor_drv = 4'b0001;
            done = 1'b1;
          end
          P1_ST: begin
            nx_state = P0_ST;
            motor_drv = 4'b0010;
            done = 1'b0;
          end
          P2_ST: begin
            nx_state = P1_ST;
            motor_drv = 4'b0100;
            done = 1'b0;
          end
          P3_ST: begin
            nx_state = P2_ST;
            motor_drv = 4'b1000;
            done = 1'b0;
          end
          default: begin
            nx_state = P0_ST;
            motor_drv = 4'b0000;
            done = 1'b0;
          end
        endcase // case (state)
      end // if (rev == 1'b1)
      else begin
        nx_state = state;
        motor_drv = 4'b0000;
        done = 1'b0;
      end
    end // else: !if(reset)
  end // always @ (state or forw or rev or reset)
endmodule
// ASCII to Letter Dial Position 
// Converts the 7-bit ASCII to the proper position location from 0-31. 
// Sample code from Design Assignment #1 for your reference. 
// You can choose to modify this to your design if you so choose.
module ascii2pos(pos, ascii);
   output [4:0] pos;
   reg [4:0] 	pos;
   input [6:0] 	ascii;
   always @(ascii) begin
      case (ascii)
        7'b010_0000: pos[4:0] = 5'b00000;
        7'b110_0001: pos[4:0] = 5'b00001;
        7'b110_0010: pos[4:0] = 5'b00010;
        7'b110_0011: pos[4:0] = 5'b00011;
        7'b110_0100: pos[4:0] = 5'b00100;
        7'b110_0101: pos[4:0] = 5'b00101;
        7'b110_0110: pos[4:0] = 5'b00110;
        7'b110_0111: pos[4:0] = 5'b00111;
        7'b110_1000: pos[4:0] = 5'b01000;
        7'b110_1001: pos[4:0] = 5'b01001;
        7'b110_1010: pos[4:0] = 5'b01010;
        7'b110_1011: pos[4:0] = 5'b01011;
        7'b110_1100: pos[4:0] = 5'b01100;
        7'b110_1101: pos[4:0] = 5'b01101;
        7'b110_1110: pos[4:0] = 5'b01110;
        7'b110_1111: pos[4:0] = 5'b01111;
        7'b111_0000: pos[4:0] = 5'b10000;
        7'b111_0001: pos[4:0] = 5'b10001;
        7'b111_0010: pos[4:0] = 5'b10010;
        7'b111_0011: pos[4:0] = 5'b10011;
        7'b111_0100: pos[4:0] = 5'b10100;
        7'b111_0101: pos[4:0] = 5'b10101;
        7'b111_0110: pos[4:0] = 5'b10110;
        7'b111_0111: pos[4:0] = 5'b10111;
        7'b111_1000: pos[4:0] = 5'b11000;
        7'b111_1001: pos[4:0] = 5'b11001;
        7'b111_1010: pos[4:0] = 5'b11010;
        7'b010_1100: pos[4:0] = 5'b11101;
        7'b010_1110: pos[4:0] = 5'b11110;
        7'b011_1111: pos[4:0] = 5'b11111;
        default: pos[4:0] = 5'b00000;
      endcase // case (ascii)
   end // always @ (ascii)
endmodule 


// vvv--- Add any modules you need below---vvv
module count(stepCT, nextST, outDir, pos, prevST, dirI,req,reset);
  output [7:0]	stepCT;
  input req;
  output [4:0]	nextST;
  output [1:0] outDir;
  input [4:0]	pos;
  input [4:0] prevST;
  input [1:0] dirI;
  input reset;
  
  reg [4:0] i;
  reg [4:0] nextST;
  reg [7:0] stepCT;
  reg [1:0] outDir;

  always @(posedge req or reset) begin
    stepCT = 8'b00000000;
    if(reset) begin
      nextST = 5'b00000;
      stepCT = 0;
      outDir = 2;
    end
    else if(req) begin

      
      if (prevST < pos) begin
        
        if((pos - prevST) < (8+8)) begin//for is shortest path
          i = prevST;
          while (i < pos) begin
          	if (i % 4 == 3) begin
          	stepCT = stepCT + 7;
            end 
            else begin
            stepCT = stepCT + 6;
            end
            i = i + 1;
          end      
        outDir =  1;
        nextST = pos;
        end
        
        else begin//backwards is shortest path
          i = pos;
          while(i != prevST) begin
          if (i % 4 == 3) begin
            stepCT = stepCT + 7;
          end
          else begin
            stepCT = stepCT + 6;
          end
            i = i+ 1;
          end
        outDir = 0;
        nextST = pos; 
          
        end
        
      end // end if
      else if(prevST == pos) begin
        stepCT = 0;
        nextST = pos;
        outDir = 2;
          
      end // end if
      else begin // it already is at the next state it wants to move to

        if((prevST - pos) < (8+8)) begin //backwards is shortest path
          i = pos;
          while(i < prevST) begin
          if (i % 4 == 3) begin
            stepCT = stepCT + 7;
          end
          else begin
            stepCT = stepCT + 6;
          end
            i = i+1;
          end

        outDir = 0;
        nextST = pos;
        end
        
        else begin//for is shortest path
          i = prevST;
          while (i!= pos) begin
          if (i % 4 == 3) begin
            stepCT = stepCT + 7;
          end
          else begin
            stepCT = stepCT + 6;
          end
            i = i + 1;
          end

        outDir =  1;
        nextST = pos;  
        end
      end

    end
  end // always @ (*)
endmodule


// Main Module
module dassign3(ready, motor_drv, req, ascii_in, sys_clk, reset);
  output 		ready;
  output [3:0]	motor_drv;
  input 		req;
  input [6:0] 	ascii_in;
  input 		sys_clk, reset;
  // Instantiate the motor clock divider
  wire			motor_clk;
  
  motor_clk_div	mclkdiv(motor_clk, sys_clk, reset);
  // assign motor_clk = sys_clk;

  // Instantiate the motor control
  wire			motor_0001;
  wire			motor_forw, motor_rev;
  motor_ctrl 	mctl(motor_drv, motor_0001, motor_forw, motor_rev, reset, motor_clk);
  
  // Instantiate the ascii-to-position mapping
  wire [4:0] 	pos;
  reg [4:0] next_pos;
  ascii2pos		a2p(pos, ascii_in);    

  always @(pos) begin
    next_pos<=pos;
  end
  // Instantiate any additional modules you need
  count	ctr(count, prvST, dir, next_pos, nextST, outDir, req, reset);
  // Declare your variables
  wire [7:0]	count;
  reg [7:0]		count2;
  wire [4:0]	prvST;
  reg [4:0]		nextST;
  wire [1:0] dir;
  reg [1:0] outDir;
  // Your code start below	
  always @(count or reset) begin
    if(reset) begin
      count2 <= count;
      nextST <= 0;
      outDir <= 2;
    end
    else if (count >= 0) begin 
      count2 <= count;
      nextST <= prvST;
      outDir <= dir;
    end
  end
  
  always @(ascii_in) begin
    count2 <= count;
  end
  
  always @(posedge sys_clk) begin
    // Storage Elements
    if (reset) begin
      nextST = 0;
      outDir = 1;
    end
    if (ready) begin
      count2 = count;
    end
  end
  
  always @(posedge motor_clk) begin
    // Combinational Logic Elements
    if ((count2 != 0) |( outDir != 2)) begin
      count2 = count2 - 1;
    end // if statement
  end
  
  assign ready = (count2 == 0);
  assign motor_rev = (outDir == 0) & (ready != 1);
  assign motor_forw = outDir & (ready != 1);
  
endmodule
