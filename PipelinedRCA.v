module PipelinedRCA(
	input wire [3:0] A,
	input wire [3:0] B,
	input wire Cin,
	output wire[3:0] Sum,
	output wire Cout,
	input wire Clock,
	input wire Reset
  );

wire [3:0] adder_sum; 
wire C1,C2,C3;

// 1st Stage
wire Sum00, Sum01; 
FullAdder FA0(.A(A[0]), .B(B[0]), .Cin(Cin), .Sum(adder_sum[0]), .Cout(C1));
DFlipFlop FF00(.D(adder_sum[0]), .Clock(Clock), .Reset(Reset), .Q(Sum00));
DFlipFlop FF01(.D(Sum00), .Clock(Clock), .Reset(Reset), .Q(Sum01));
DFlipFlop FFS0(.D(Sum01), .Clock(Clock), .Reset(Reset), .Q(Sum[0]));

// 2nd Stage
wire A1r, B1r, C1r, Sum10; 
DFlipFlop FFa1 (.D(A[1]), .Clock(Clock), .Reset(Reset), .Q(A1r));
DFlipFlop FFb1 (.D(B[1]), .Clock(Clock), .Reset(Reset), .Q(B1r));
DFlipFlop FFc1 (.D(C1), .Clock(Clock), .Reset(Reset), .Q(C1r));
FullAdder FA1(.A(A1r), .B(B1r), .Cin(C1r), .Sum(adder_sum[1]), .Cout(C2));
DFlipFlop FF11(.D(adder_sum[1]),  .Q(Sum10), .Clock(Clock), .Reset(Reset));
DFlipFlop FF12(.D(Sum10),  .Q(Sum[1]), .Clock(Clock), .Reset(Reset));

// 3rd Stage
wire A20r, A21r, B20r, B21r, C2r; 
DFlipFlop FFa20 (.D(A[2]), .Clock(Clock), .Reset(Reset), .Q(A20r));
DFlipFlop FFa21 (.D(A20r), .Clock(Clock), .Reset(Reset), .Q(A21r));
DFlipFlop FFb20 (.D(B[2]), .Clock(Clock), .Reset(Reset), .Q(B20r));
DFlipFlop FFb21 (.D(B20r), .Clock(Clock), .Reset(Reset), .Q(B21r));
DFlipFlop FFc2 (.D(C2), .Clock(Clock), .Reset(Reset), .Q(C2r));
FullAdder FA2(.A(A21r), .B(B21r), .Cin(C2r), .Sum(adder_sum[2]), .Cout(C3));
DFlipFlop FF2(.D(adder_sum[2]),  .Q(Sum[2]), .Clock(Clock), .Reset(Reset));

// 4th Stage
wire A30r, A31r, A32r, B30r, B31r, B32r, C3r; 
DFlipFlop FFa30 (.D(A[3]), .Clock(Clock), .Reset(Reset), .Q(A30r));
DFlipFlop FFa31 (.D(A30r), .Clock(Clock), .Reset(Reset), .Q(A31r));
DFlipFlop FFa32 (.D(A31r), .Clock(Clock), .Reset(Reset), .Q(A32r));
DFlipFlop FFb30 (.D(B[3]), .Clock(Clock), .Reset(Reset), .Q(B30r));
DFlipFlop FFb31 (.D(B30r), .Clock(Clock), .Reset(Reset), .Q(B31r));
DFlipFlop FFb32 (.D(B31r), .Clock(Clock), .Reset(Reset), .Q(B32r));
DFlipFlop FFc3 (.D(C3), .Clock(Clock), .Reset(Reset), .Q(C3r));
FullAdder FA3(.A(A32r), .B(B32r), .Cin(C3r), .Sum(Sum[3]), .Cout(Cout));
endmodule

module DFlipFlop(
	input wire D,
	input wire Clock,
	input wire Reset,
	output reg Q
	);
  
  always @(posedge Clock or posedge Reset) begin
		if (Reset) begin
			Q<=1'b0;
		end else begin
			Q<=D;
		end
	end
endmodule

module FullAdder(
	input wire A,
	input wire B,
	input wire Cin,
	output wire Sum,
	output wire Cout
	);
	
	assign Sum=A^B^Cin;
	assign Cout=(A&B) | (B&Cin) |(Cin&A);
endmodule
