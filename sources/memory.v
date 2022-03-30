`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/18 21:00:19
// Design Name: 
// Module Name: memory
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


module memory(
    input we,  //enable "1"
    input [7:0]address,  //8bits address  public for write & read
    input [31:0]dataIn,
    input clk,      //control the write operate by "negedge"
    output reg[31:0]dataOut
    );
    
reg[31:0] mem[0:255];  //256*4 bytes == 1kb
    
always @ (negedge clk)
begin
    if(we)
        mem[address] <= dataIn;
end

always @ (*)
begin
    if(mem[address])
        dataOut <= mem[address];
end

endmodule
