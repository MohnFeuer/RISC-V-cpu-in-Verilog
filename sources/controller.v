`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/18 14:01:47
// Design Name: 
// Module Name: controller
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


module controller(
    input [6:0] op,  //opcode
    input [2:0] fun,  //funct3
    output reg[1:0] ALUBsrc,
    output reg[3:0] ALUctr,
    output reg MemtoReg,
    output reg RegWr,
    output reg MemWr,
    output reg[2:0] ExtOp
    );
    
    reg Rtype;
    reg Itype;
    reg lui;
    reg load;
    reg store;
    
always @ (*)
begin
    Rtype = ~op[6] && op[5] && op[4] && ~op[3] && ~op[2] && op[1] && op[0];
    Itype = ~op[6] && ~op[5] && op[4] && ~op[3] && ~op[2] && op[1] && op[0];
    lui = ~op[6] && op[5] && op[4] && ~op[3] && op[2] && op[1] && op[0];
    load = ~op[6] && ~op[5] && ~op[4] && ~op[3] && ~op[2] && op[1] && op[0];
    store = ~op[6] && op[5] && ~op[4] && ~op[3] && ~op[2] && op[1] && op[0];   
end

always @ (*)
begin
    RegWr <= Rtype || Itype || lui || load;
    MemWr <= store;
    MemtoReg <= load;
    ALUctr <= {{lui}, {((Rtype || Itype) && fun[2]) || lui}, {((Rtype || Itype) && fun[1]) || lui}, {((Rtype || Itype) && fun[0]) || lui}};
    ALUBsrc <= {{Itype || lui || load || store}, {1'b0}};
    ExtOp <= {{1'b0}, {store}, {lui}};
end
    
endmodule
