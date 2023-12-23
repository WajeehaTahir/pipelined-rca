# Pipelined Ripple Carry Adder

## Overview
This Verilog project implements a Pipelined Ripple Carry Adder (PRCA) using behavioral modeling. The PRCA is a type of adder that utilizes pipeline registers to improve performance by breaking down the addition process into stages. Each stage consists of a full adder and a flip-flop, forming a pipeline to enable parallel processing of input bits.

## Module Description

### PipelinedRCA Module
The `PipelinedRCA` module is the main component of the design, implementing a four-stage pipelined structure for adding two 4-bit numbers. Each stage includes a full adder and a D flip-flop, allowing for parallel computation of the sum. The module takes input signals A and B, a carry-in signal Cin, clock and reset signals, and produces the sum (Sum) and carry-out (Cout).

```verilog
module PipelinedRCA(
	input wire [3:0] A,
	input wire [3:0] B,
	input wire Cin,
	output wire[3:0] Sum,
	output wire Cout,
	input wire Clock,
	input wire Reset
    );
    
    // Internal signals
    wire [3:0] adder_sum; 
    wire C1, C2, C3;
    
    // Stage 0
    FullAdder FA0(.A(A[0]), .B(B[0]), .Cin(Cin), .Sum(adder_sum[0]), .Cout(C1));
    DFlipFlop FF00(.D(adder_sum[0]), .Clock(Clock), .Reset(Reset), .Q(Sum00));
    DFlipFlop FF01(.D(Sum00), .Clock(Clock), .Reset(Reset), .Q(Sum01));
    DFlipFlop FFS0(.D(Sum01), .Clock(Clock), .Reset(Reset), .Q(Sum[0]));

    // Stage 1
    // ... (similar structure for other stages)
    
    // Stage 2
    // ...

    // Stage 3
    // ...

endmodule
```

### DFlipFlop Module
The `DFlipFlop` module represents a simple D flip-flop with an asynchronous reset. It is used in each pipeline stage to store intermediate results between stages.

### FullAdder Module
The `FullAdder` module is a standard 1-bit full adder, calculating the sum and carry-out based on the input bits A, B, and the carry-in Cin.

## Circuit Diagram

![image](https://github.com/WajeehaTahir/pipelined-rca/assets/88159584/92c3e198-2aa9-447c-80bd-e284a805b053)


## Testbench
The testbench (`tf`) includes test vectors to simulate the operation of the PipelinedRCA. The clock signal is toggled every 5 time units, and the results are displayed to observe the behavior of the adder under different inputs.

## Waveform

![image](https://github.com/WajeehaTahir/pipelined-rca/assets/88159584/0dc40f7e-87aa-4e48-b0f4-768089db7621)
#
_Documented by ChatGPT_
