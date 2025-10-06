module mac_v1 #(parameter N=8)(
	input [N-1:0]a,
	input [N-1:0]b,
	output [2*N-1:0]y
	);

wire [N-1]rt[N-2:0];
assign {rt[0],y[0]} = { N-1 + 1{b[0]} & a;

genvar i;
generate
	for (i=1;i<N-1;i=i+1) begin
		assign {rt[i],y[i]} = rt[i-1] + ( { N-1 + 1{b[0]}} & a);
	end
	endgenerate
	
assign y[15:7] = rt[6] + ({N-1 +1{b[N-1]}} & a);

endmodule