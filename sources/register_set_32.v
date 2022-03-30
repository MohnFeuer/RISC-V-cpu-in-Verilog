`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/12/03 19:10:03
// Design Name: 
// Module Name: register_set_32
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


// "{0/1}" represent the control signal's value taking effect
module register_set_32(
    input rst_n,  //reset  {0/negedge}
    input clk,  // clock  {negedge}
    
    //write module (assign the appointed register )
    input [4:0] waddr,  //write address (appoint register)
    input [31:0] wdata,  //write data
    input we,  //write enable   {1}
    
    //read module (assign the appointed register )
    input [4:0] raddr1,  //read address 1
    //input re1,  //read enable   {1}
    output reg[31:0] rdata1,  //read data 1
    
    input [4:0] raddr2,  //read address 2
    //input re2,  //read enable   {1}
    output reg[31:0] rdata2  //read data2
    );
    
reg[31:0] mem_r[0:31];  // 32*32 register named "mem_r"

always @ (negedge clk or negedge rst_n) 
begin
    if(rst_n)  //no reset signal
       begin
            if((waddr != 5'b0) && (we))  //address is not 00000 and write enable is 1
                mem_r[waddr] <= wdata;   //write from "wdata" to "mem_r" in "waddr"
       end
end
    
always @(*)     //circularly give "rdata" port with no condition  
begin   
    if(~rst_n)  //reset signal
        rdata1 <= 32'b0;
    else
        if(raddr1 == 5'b0)  //zero register
            rdata1 <= 32'b0;
        else
            if((raddr1 == waddr) && we)  //if the writed address is equal to the readed address 
                rdata1 <= wdata;  //read the writed data directly
            else
                rdata1 <= mem_r[raddr1];

end

always @(*)
begin
    if(~rst_n)  //reset signal
        rdata2 <= 32'b0;
    else
        if(raddr1 == 5'b0)  //zero register
            rdata2 <= 32'b0;
        else
            if((raddr1 == waddr) && we)  //if the writed address is equal to the readed address 
                rdata2 <= wdata;  //read the writed data directly
            else
                rdata2 <= mem_r[raddr2];

end

endmodule
