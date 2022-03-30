`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/22 16:02:03
// Design Name: 
// Module Name: ID
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


// instruction decoder
module ID(
    input [31:0] instr,
    
    output reg [6:0] op,
    output reg [2:0] fun,
    output reg [4:0] rs2,
    output reg [4:0] rs1,
    output reg [4:0] rd,
    output reg [31:0] outIns  
    );
    
always @(*)
begin
    op <= {instr[6:0]};
    fun <= {instr[14:12]};
    rs2 <= {instr[24:20]};
    rs1 <= {instr[19:15]};
    rd <= {instr[11:7]};
    outIns <= instr;
end
    
endmodule
