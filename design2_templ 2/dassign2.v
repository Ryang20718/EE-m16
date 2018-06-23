// EEM16 - Logic Design
// 2018_04_13
// Design Assignment #2
// dassign2.v

//
// modules provided for your use
//
module inv(y,a);
   output y;
   input  a;

   assign y=~(a);
endmodule

module and2(y,a,b);
   output y;
   input  a,b;

   assign y=a&b ;
endmodule

module or2(y,a,b);
   output y;
   input  a,b;

   assign y=a|b ;
endmodule

module xor2(y,a,b);
   output y;
   input  a,b;

   assign y=a^b ;
endmodule

module mux21(y, i0, i1, sel);
   output y;
   input  i0, i1,sel;

   //sel = 1 choose i1, otherwise i0)
   assign y = (sel) ? i1 : i0;
endmodule // mux21

//
// Blocks for you to design begins here
//
module sbs(d, bout, x, y, bin);
   output d, bout;
   input  x, y, bin;

   //
   // Implement the single bit subtract here
   //
endmodule 

module subtract8(d, bout, x, y);
   output [7:0] d;
   output 	bout;
   input [7:0] 	x, y;

   wire 	bin;
   wire [7:0] 	b;

   assign bin = 1'b0;
   assign bout = b[7];
   // 
   // Implement the 8-bit subtract function here
   // 

endmodule

module dassign2_1 (q, rout, rin, din);
   output q;
   output [7:0] rout;
   input [7:0] 	rin, din;
   //
   // Instantiate the subtract module
   // 
   wire 	bout;
   wire [7:0] 	dout;

   subtract8 sub8(dout, bout, rin, din);         

   //
   // Implement the rest of the SCS function here
   //

endmodule

module dassign2_2 (motor_drv, done, forw, rev, reset, drv_clk);
   output [3:0] motor_drv;
   output 	done;
   input 	forw, rev, reset, drv_clk;

   //
   // Parameters declaration for State Bits (An example)
   //
   parameter STATE_BITS = 2;
   parameter S0_ST = 2'b00;
   parameter S1_ST = 2'b01;
   parameter S2_ST = 2'b10;
   parameter S3_ST = 2'b11;

   reg [STATE_BITS-1:0] state, nx_state;
   reg 			done;
   reg [3:0] 		motor_drv;

   //
   // Storage elements for the state bits (You should not change)
   //
   always @(posedge drv_clk) begin
      state <= nx_state;
   end

   always @(state or forw or rev or reset) begin
      //
      // Your FSM logic here
      //
   end // always @ (state or forw or rev or reset)
endmodule // dassign2_2


