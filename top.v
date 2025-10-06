module top #(N=4) (
	input clk,
	input rst,

	input [N*8-1:0] a,
	input [N*8-1:0] b,
	output [N*17-1:0] y
	);
	
	
	
	
	
	
	// shared
	
	reg [7:0] p [1:N];
	reg [7:0] q [1:N];
	
	always @(posedge clk or posedge rst) begin
		if(rst) begin		
			p[1]<=0;
			p[2]<=0;
			p[3]<=0;
			p[4]<=0;
			q[1]<=0;
			q[2]<=0;
			q[3]<=0;
			q[4]<=0;
					
		end
		
		else begin	 
			
			p[1]<= a[7:0];
			p[2]<= a[15:8];
			p[3]<= a[23:16];
			p[4]<= a[31:24];
			
			q[1]<= b[7:0];
			q[2]<= b[15:8];
			q[3]<= b[23:16];
			q[4]<= b[31:24];
			
			
		
	end
	end
	
	wire [15:0] x [1:2*N];
	wire [16:0] z [1:N];
	
	my_mult mut_inst1(p[1],q[1],x[1]);
	my_mult mut_inst2(p[2],q[3],x[2]);
	my_mult mut_inst3(p[1],q[2],x[3]);
	my_mult mut_inst4(p[2],q[4],x[4]);
	
	my_mult mut_inst5(p[3],q[1],x[5]);
	my_mult mut_inst6(p[4],q[3],x[6]);
	my_mult mut_inst7(p[3],q[2],x[7]);
	my_mult mut_inst8(p[4],q[4],x[8]);

	(*dont_touch ="true" *)ksa16 ksa_i1(x[1],x[2],z[1]);
	(*dont_touch ="true" *)ksa16 ksa_i2(x[3],x[4],z[2]);
	(*dont_touch ="true" *)ksa16 ksa_i3(x[5],x[6],z[3]);
	(*dont_touch ="true" *)ksa16 ksa_i4(x[7],x[8],z[4]);
	
	assign y[16:0]=z[1];
	assign y[33:17]=z[2];
	assign y[50:34]=z[3];
	assign y[67:51]=z[4];
	
	
	
	
	endmodule