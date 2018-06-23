// EEM16 - Logic Design
// 2018_04_04
// Design Assignment #1
// dassign1.v

module inv(y,a);
   output y;
   input a;

   assign y=~(a);
endmodule

module nand2(y,a,b);
   output y;
   input a,b;
   wire d;
   assign d=a&b ;
   assign y=~(d);
endmodule

module nor2(y,a,b);
   output y;
   input a,b;
   wire d;
   assign d=a|b ;
   assign y=~(d);
endmodule

module dassign1_1 (pdec0,pdec3,pdec12,pdec15,nando,addr);
   output pdec0,pdec3,pdec12,pdec15;
   output [3:0] nando; //the output of the 4 nand gates that you should be using
   
   input [5:0] addr;

   //
   // vvv - Declare your wires here - vvv
   //

   //
   // vvv - Your structural verilog code here - vvv
   //
endmodule

module dassign1_2 (y1, y2, a,b,c,d);
   output y1, y2;
   input a,b,c,d;

   //
   // vvv - Declare your wires here - vvv
   //

   //
   // vvv - Your structural verilog code here - vvv
   //

   //
   // vvv - Your declarative verilog code here - vvv
   //
   
   assign y2 = ;
   
endmodule // dassign1_2


module mux21(y, i0, i1, sel);
   output y;
   input  i0, i1,sel;

   //sel = 1 choose a, otherwise b)
   assign y = (sel) ? i1 : i0;
endmodule // mux21

module dassign1_3 (pos, pos3, ascii);
   input [6:0] ascii;
   
   output [4:0] pos;
   output 	pos3;


   //
   // vvv - Declare your reg and wires here - vvv
   //
   reg [4:0] 	pos;
   wire 	pos3;
   
   //
   // vvv - Your procedural verilog (case) code here - vvv
   //
   always @(ascii) begin

   end
   
   //
   // vvv - Your structural verilog code here for pos3 - vvv
   //
   
endmodule // dassign1_3

