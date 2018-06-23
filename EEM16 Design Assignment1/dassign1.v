// Code your design here
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

module dassign1_1 (pdec0,pdec3,pdec12,pdec15,nando[3:0],addr[5:0]);
   output pdec0,pdec3,pdec12,pdec15;
   output [3:0] nando;
   
   input [5:0] addr;

   //
   // vvv - Declare your wires here - vvv
   //
    wire c,d,e,f,regC,regD,regE,regF,ef,cd,regEF,regCD;
   //
   // vvv - Your structural verilog code here - vvv
   //
  
  assign regC = addr[2];//Not inverted C, D , E ,F
  assign regD = addr[3];
  assign regE = addr[4];
  assign regF = addr[5];
  
  inv initC(c,addr[2]);
  inv initD(d,addr[3]);//Inverted C,D,E,F
  inv initE(e,addr[4]);
  inv initF(f,addr[5]);
  
  /*
  cd is the nanding of c & d
  ef is the nanding of e & f
  regCD is the nanding of !c & !d
  regEF is the nanding of !e & !f
  */
  
  //pdec0
  nand2 b2pdec0(cd,c,d);
  nand2 b1pdec0(ef,e,f);
  nor2 result0(pdec0,cd,ef);
  
  //pdec3
  nand2 b2pdec3(regCD, regC,regD);
  nor2 result3(pdec3,ef,regCD);
  
  //pdec12
  nand2 b2pdec12(regEF,regE,regF);
  nor2 result12(pdec12, regEF, cd);
  
  //pdec15
  nor2 result15(pdec15, regEF,regCD);
  
  //asign nando to all the nand gates
  assign nando[0] = cd;
  assign nando[1] = ef;
  assign nando[2] = regCD;
  assign nando[3] = regEF;
    
endmodule





module dassign1_2 (y1, y2, a,b,c,d);
   output y1, y2;
   input a,b,c,d;

   //
   // vvv - Declare your wires here - vvv
   //
   wire oppA,oppB,oppC,oppD,bottom1,bottom2,mid1,oppBottom1,mid2,top1,oppMid2,top2;
   //
   // vvv - Your structural verilog code here - vvv
   //
  
  //invert all the inputs to use later on
  inv initA(oppA,a);
  inv initB(oppB,b);
  inv initC(oppC,c);
  inv initD(oppD,d);
  
  nand2 low1(bottom1,a,b);//a & b
  nor2 low2(bottom2,bottom1,oppC); //a & b & c
  
  nand2 middle(mid1,oppC,d); //!c & d
  
  
  inv middle1(oppBottom1,bottom2); 
  nand2 middle2(mid2,mid1,oppBottom1);// (a & b & c) | (!c & d)
  
  nand2 high(top1, oppB,oppD); // !d & !b
  inv Mid2(oppMid2, mid2);
  nand2 result(top2,oppMid2, top1); // (a & b & c) | (!c & d) | (!d & !b)
  
 // (a & b & c) | (!c & d) | (!d & !b)
     

  assign y1 = top2;
    
   //
   // vvv - Your declarative verilog code here - vvv
   //
  
   //most simplified version of 3a
  assign y2 = (a & b & c) | ((~c) & d) | ((~d) & (~b));
   
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
   
   
   
   //space pos[3] = 0 [3-4] = 00
   //a-g pos[3] = 0 [3-4] = 00
   //h-o pos[3] = 1 [3-4] = 10
   //p-w pos[3] = 0 [3-4] = 01
   //x-y pos[3] = 1 [3-4] = 11
   //z   pos[3] = 0 [3-4] = 01
   //, . pos[3] = 1 [3-4] = 10
   // ?  pos[3] = 1 [3-4] = 11
   
  always @(ascii) begin
    case (ascii) 
       
       7'b0100000: begin 
         pos = 5'b00000; //    space 
       end
       7'b1100001: begin 
         pos = 5'b00001;  //     a
       end
       7'b1100010: begin
         pos = 5'b00010; //    b
       end
       7'b1100011: begin
         pos = 5'b00011; //    c
       end
       7'b1100100: begin
         pos = 5'b00100; //    d
       end
       7'b1100101: begin
         pos = 5'b00101; //    e
       end
       7'b1100110: begin
         pos = 5'b00110; //    f
       end
       7'b1100111: begin
         pos = 5'b00111; //    g
       end
       7'b1101000: begin
         pos = 5'b01000; //    h
       end
       7'b1101001: begin
         pos = 5'b01001; //    i
       end
       7'b1101010: begin
         pos = 5'b01010; //    j
       end
       7'b1101011: begin
         pos = 5'b01011;//    k
       end
       7'b1101100: begin
         pos = 5'b01100; //    l
       end
       7'b1101101: begin
         pos = 5'b01101; //    m
       end
       7'b1101110: begin
         pos = 5'b01110; //    n
       end
       7'b1101111: begin 
         pos = 5'b01111; //    o
       end
       7'b1110000: begin //     p
         pos = 5'b10000;
       end
       7'b1110001: begin //   q
         pos = 5'b10001;
       end
       7'b1110010: begin //  r
         pos = 5'b10010;
       end
       7'b1110011: begin // s
         pos = 5'b10011;
       end
       7'b1110100: begin //  t
         pos = 5'b10100;
       end
       7'b1110101: begin //   u
         pos = 5'b10101;
       end       
       7'b1110110: begin //    v
         pos = 5'b10110;
       end
       7'b1110111: begin //   w
         pos = 5'b10111;
       end
       7'b1111000: begin //  x
         pos = 5'b11000;
       end
       7'b1111001: begin //   y
         pos = 5'b11001;
       end
       7'b1111010: begin //  z
         pos = 5'b11010;
       end
		//NC 
       7'b0101100: begin // ,
         pos = 5'b11101;
       end
       7'b0101110: begin // .
         pos = 5'b11110;
       end
       7'b0111111: begin // ?
         pos = 5'b11111;
       end
       default: begin
         pos = 5'b00000;
       end
     endcase
   end
   
   //
   // vvv - Your structural verilog code here for pos3 - vvv
   //
   
       
       //bits in position 3 - 4 in the ascii are 00 & 01 for pos3 = 0 and 
       //bits in position 3-4 in ascii are 11 & 10 for pos3 = 1
  mux21 result(pos3, ascii[4],ascii[3],1); // pos3 = ascii[3] 

   
endmodule // dassign1_3

