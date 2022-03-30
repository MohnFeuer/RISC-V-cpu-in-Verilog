`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/02 19:25:43
// Design Name: 
// Module Name: register
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

//1.# ???
module register #(parameter DW = 32)
(
    input [DW-1:0] lden,  //input port with len 32
    input [DW-1:0] dnxt,
    output [DW-1:0] qout,  //output port with len 32
    input clk,  //clock pulse port
    input rst_n  //reset signal port
    );
reg [DW-1:0] qout_r;
//if clk get a posedge(rising edge) or rst_n get a negedge(falling edge) do the "always" circle
always @(posedge clk or negedge rst_n)
begin
    if(rst_n ==1'b0)
        qout_r <= {DW{1'b0}};  //reset: give 32 bit 0 to qout_r 
    else
        if(lden == 1'b1)  //if lden == 1
            qout_r <= dnxt;
end

assign qout = qout_r;  //give register's data to output port

endmodule
