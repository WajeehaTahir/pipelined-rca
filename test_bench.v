module tf;

	// Inputs
	reg [3:0] A;
	reg [3:0] B;
	reg Cin;
	reg Clock;
	reg Reset;

	// Outputs
	wire [3:0] Sum;
	wire Cout;

	// Instantiate the Unit Under Test (UUT)
	PipelinedRCA uut (
		.A(A), 
		.B(B), 
		.Cin(Cin), 
		.Sum(Sum), 
		.Cout(Cout), 
		.Clock(Clock), 
		.Reset(Reset)
	);

	initial begin
		// Initialize Inputs
		Clock = 0;
		Reset = 0;
		
		
		A = 3; B = 4; Cin = 0; #10;
    A = 5; B = 7; Cin = 0; #10;
    A = 1; B = 9; Cin = 0; #10;
    A = 11; B = 2; Cin = 0; #10;
    A = 7; B = 6; Cin = 0; #10;
		A = 15; B = 0; Cin = 1; #10;
		
	end
		always #5 Clock=~Clock; 
endmodule
