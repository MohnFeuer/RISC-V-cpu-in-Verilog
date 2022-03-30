`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/04 20:56:07
// Design Name: 
// Module Name: MUX
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


module MUX(
    
    input [1:0] select,  //control signal, select the input to be outputed
    
    input [31:0] in0,
    input [31:0] in1,
    input [31:0] in2,
    input [31:0] in3,
    
    output reg[31:0] out
    );
    
always @(*) begin
    if(select == 2'b00)
        out <= in0;
    else
        if(select == 2'b01)
            out <= in1;
        else
            if(select == 2'b10)
                out <= in2;
            else
                if(select == 2'b11)
                    out <= in3;
end

endmodule

