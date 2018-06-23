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
  
   //declaration of wires
  wire a,b,c,e, topRes,mid1Res,mid2Res,botRes,semiTop,semiBot, bInv,xInv,yInv, bTop,bMid,bBot,bSemi;
  
  inv bNot(bInv, bin); //!b
  inv xNot(xInv, x); //!x
  inv yNot(yInv,y);//!y
    
  and2 top1(a,bInv,xInv);
  and2 top2(topRes,y,a); //y ^ ~x ^ ~b
  
  and2 midTop1(b,bInv,x);
  and2 midTop2(mid1Res,yInv,b); //~y ^ x ^ ~b
  
  and2 midBot1(c,bin,xInv);
  and2 midBot2(mid2Res,c,yInv); //~y ^ ~x ^ b
    
  and2 Bot1(e,bin,x);
  and2 Bot2(botRes,e,y); //y ^ x ^ b
  
  or2 top2Results(semiTop,topRes,mid1Res); // (y ^ ~x ^ ~b) | (~y ^ x ^ ~b)
  or2 bot2Results(semiBot,mid2Res,botRes);//(~y ^ ~x ^ b) | (y ^ x ^ b)
  
  or2 finResult(d,semiTop,semiBot);//(y ^ ~x ^ ~b) | (~y ^ x ^ ~b) | (~y ^ ~x ^ b) | (y ^ x ^ b)
  
  // finished the sbs for d
  and2 bTop1(bTop,xInv,bin); // b ^ ~x
  and2 bMid1(bMid,bin,y); // b ^ y
  and2 bBot1(bBot,xInv,y); // ~x ^ y
  
  or2 semiTop1(bSemi, bTop,bMid);//(b ^ ~x) | (b ^ y) 
  or2 finBResult(bout, bSemi,bBot);//(b ^ ~x) | (b ^ y) | (~x ^ y)
  
  
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
  sbs block1(d[0],b[0],x[0],y[0],0);
  sbs block2(d[1],b[1],x[1],y[1],b[0]);
  sbs block3(d[2],b[2],x[2],y[2],b[1]);
  sbs block4(d[3],b[3],x[3],y[3],b[2]);
  sbs block5(d[4],b[4],x[4],y[4],b[3]);
  sbs block6(d[5],b[5],x[5],y[5],b[4]);
  sbs block7(d[6],b[6],x[6],y[6],b[5]);
  sbs block8(d[7],b[7],x[7],y[7],b[6]);

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
  inv finalQ(q,bout); //inverts Q
  //if b[7] is neg, output is D, if b[7] is pos, output is R-D
  mux21 out1(rout[0], dout[0], rin[0], bout); //inputs would choose either dout(R-D) or rin(original)
  mux21 out2(rout[1], dout[1], rin[1], bout);
  mux21 out3(rout[2], dout[2], rin[2], bout);
  mux21 out4(rout[3], dout[3], rin[3], bout);
  mux21 out5(rout[4], dout[4], rin[4], bout);
  mux21 out6(rout[5], dout[5], rin[5], bout);
  mux21 out7(rout[6], dout[6], rin[6], bout);
  mux21 out8(rout[7], dout[7], rin[7], bout);
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
   
     if(reset) begin
		motor_drv = 4'b0000;
        state = S0_ST;
     end else if(forw) begin
        case(state)
          S0_ST: begin
         	nx_state = S1_ST;
          	motor_drv = 4'b0001;
          end
          S1_ST: begin
          	nx_state = S2_ST;
          	motor_drv = 4'b0010;
          end
          S2_ST: begin
            nx_state = S3_ST;
          	motor_drv = 4'b0100;
          end
          S3_ST: begin
            nx_state = S0_ST;
          	motor_drv = 4'b1000;
          end
        endcase
       
     end else if(rev) begin
        case(state)
          S0_ST: begin
            nx_state = S3_ST;
          	motor_drv = 4'b0001;
          end
          S1_ST: begin
            nx_state = S0_ST;
          	motor_drv = 4'b0010;

          end
          S2_ST: begin
            nx_state = S1_ST;
          	motor_drv = 4'b0100;
          end
          S3_ST: begin
            nx_state = S2_ST;
            motor_drv = 4'b1000;

          end
        endcase
     end else begin
       nx_state = state;
       motor_drv = 4'b0000;
     end
     assign done = (motor_drv == 4'b0001);
      //
   end // always @ (state or forw or rev or reset)
endmodule // dassign2_2


