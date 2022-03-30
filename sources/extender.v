`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/08 18:09:42
// Design Name: 
// Module Name: extender
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module extender(

    input [31:0] instr,
    input [2:0] ExtOp,
    output reg[31:0] imm
    );
    
reg[31:0] imms[0:4];  //i u s b j
    
always @ (*)
begin
    imms[0] <= {{20{instr[31]}}, instr[31:20]};  //I type instrument, extend by signal for 20 times
    imms[1] <= {instr[31:12], 12'b0};  //U
    imms[2] <= {{20{instr[31]}}, instr[31:25], instr[11:7]};  //S
    imms[3] <= {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};  //B
    imms[4] <= {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};  //J
end

always @ (*)
begin
    if(ExtOp >= 0 && ExtOp <= 4 )
        imm <= imms[ExtOp]; 
end

endmodule
