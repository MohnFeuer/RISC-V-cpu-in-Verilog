`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/12 15:36:26
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] in_A,
    input [31:0] in_B,
    input [3:0] ALUctr,
    output reg ZERO,  //if Result == 0 then ZERO ==1 
    output reg[31:0]Result
    );
    
reg [32:0] temp_add;
reg [32:0] temp_sub;
reg AltB;   //if A less than B than 1 else 0
reg overflow;
reg AltuB;  //unsigned less than

always @ (*)
begin

    temp_sub <= in_A + ((~in_B)+1'b1);
    temp_add <= in_A + in_B;
    
    //signed
    overflow <= (temp_sub[32]^((in_A[31]^in_B[31]) != temp_sub[31]));  //Cn^Cn-1
    AltB <= (overflow^temp_sub[31]);  //  
    //unsigned
    AltuB <= (in_A < in_B);  
     
    if(ALUctr == 4'b0000)  //op add
        Result <= temp_add[31:0];
    else 
        if(ALUctr == 4'b0010)  //op slt
            Result <= {31'b0, {AltB}};
        else
            if(ALUctr == 4'b0011)  //op sltu
                Result <= {31'b0, {AltuB}};
            else
                if(ALUctr == 4'b0110)  //op or
                    Result <= in_A | in_B;
                else
                    if(ALUctr == 4'b1000)  //op sub
                        Result <= temp_sub[31:0];
                    else
                        if(ALUctr == 4'b1111)  //op srcB
                            Result <= in_B;
    
    if(Result == 32'h00000000)
        ZERO <= 1;
    else
        ZERO <= 0;
end

endmodule
