`timescale 1ns / 1ps

module RC5Decoder(
    input wire clk,
    input wire rst,
    input wire[63:0] d_in,
    output reg[63:0] d_out
);
    reg[3:0] count;
    reg[31:0] a_reg;
    reg[31:0] b_reg;
    wire[31:0] ab_xor;
    wire[31:0]ba_xor;
    wire[31:0]a_rot;
    wire[31:0]b_rot;
    wire[31:0]a;
    wire[31:0]b;
    reg [31:0] rom [2:25];
    initial begin
        rom[2] = 32'h46F8E8C5;
        rom[3] = 32'h460C6085;
        rom[4] = 32'h70F83B8A;
        rom[5] = 32'h284B8303;
        rom[6] = 32'h513E1454;
        rom[7] = 32'hF621ED22;
        rom[8] = 32'h3125065D;
        rom[9] = 32'h11A83A5D;
        rom[10] = 32'hD427686B;
        rom[11] = 32'h713AD82D;
        rom[12] = 32'h4B792F99;
        rom[13] = 32'h2799A4DD;
        rom[14] = 32'hA7901C49;
        rom[15] = 32'hDEDE871A;
        rom[16] = 32'h36C03196;
        rom[17] = 32'hA7EFC249;
        rom[18] = 32'h61A78BB8;
        rom[19] = 32'h3B0A1D2B;
        rom[20] = 32'h4DBFCA76;
        rom[21] = 32'hAE162167;
        rom[22] = 32'h30D76B0A;
        rom[23] = 32'h43192304;
        rom[24] = 32'hF6CC1431;
        rom[25] = 32'h65046380;
    end
    assign b_rot = b_reg - rom[{count, 1'b1}];
    assign ba_xor = (a_reg[4:0] == 5'b00001) ? {b_rot[0], b_rot[31:1]} : 
				(a_reg[4:0] == 5'b00010) ? {b_rot[1:0], b_rot[31:2]} : 
				(a_reg[4:0] == 5'b00011) ? {b_rot[2:0], b_rot[31:3]} : 
				(a_reg[4:0] == 5'b00100) ? {b_rot[3:0], b_rot[31:4]} : 
				(a_reg[4:0] == 5'b00101) ? {b_rot[4:0], b_rot[31:5]} : 
				(a_reg[4:0] == 5'b00110) ? {b_rot[5:0], b_rot[31:6]} : 
				(a_reg[4:0] == 5'b00111) ? {b_rot[6:0], b_rot[31:7]} : 
				(a_reg[4:0] == 5'b01000) ? {b_rot[7:0], b_rot[31:8]} : 
				(a_reg[4:0] == 5'b01001) ? {b_rot[8:0], b_rot[31:9]} : 
				(a_reg[4:0] == 5'b01010) ? {b_rot[9:0], b_rot[31:10]} : 
				(a_reg[4:0] == 5'b01011) ? {b_rot[10:0], b_rot[31:11]} : 
				(a_reg[4:0] == 5'b01100) ? {b_rot[11:0], b_rot[31:12]} : 
				(a_reg[4:0] == 5'b01101) ? {b_rot[12:0], b_rot[31:13]} : 
				(a_reg[4:0] == 5'b01110) ? {b_rot[13:0], b_rot[31:14]} : 
				(a_reg[4:0] == 5'b01111) ? {b_rot[14:0], b_rot[31:15]} : 
				(a_reg[4:0] == 5'b10000) ? {b_rot[15:0], b_rot[31:16]} : 
				(a_reg[4:0] == 5'b10001) ? {b_rot[16:0], b_rot[31:17]} : 
				(a_reg[4:0] == 5'b10010) ? {b_rot[17:0], b_rot[31:18]} : 
				(a_reg[4:0] == 5'b10011) ? {b_rot[18:0], b_rot[31:19]} : 
				(a_reg[4:0] == 5'b10100) ? {b_rot[19:0], b_rot[31:20]} : 
				(a_reg[4:0] == 5'b10101) ? {b_rot[20:0], b_rot[31:21]} : 
				(a_reg[4:0] == 5'b10110) ? {b_rot[21:0], b_rot[31:22]} : 
				(a_reg[4:0] == 5'b10111) ? {b_rot[22:0], b_rot[31:23]} : 
				(a_reg[4:0] == 5'b11000) ? {b_rot[23:0], b_rot[31:24]} : 
				(a_reg[4:0] == 5'b11001) ? {b_rot[24:0], b_rot[31:25]} : 
				(a_reg[4:0] == 5'b11010) ? {b_rot[25:0], b_rot[31:26]} : 
				(a_reg[4:0] == 5'b11011) ? {b_rot[26:0], b_rot[31:27]} : 
				(a_reg[4:0] == 5'b11100) ? {b_rot[27:0], b_rot[31:28]} : 
				(a_reg[4:0] == 5'b11101) ? {b_rot[28:0], b_rot[31:29]} : 
				(a_reg[4:0] == 5'b11110) ? {b_rot[29:0], b_rot[31:30]} : 
				(a_reg[4:0] == 5'b11111) ? {b_rot[30:0], b_rot[31]} :  
				b_rot;
			assign	b=ba_xor^a_reg;
			assign a_rot = a_reg - rom[{count, 1'b0}];
			
			
    assign ab_xor = (b[4:0] == 5'b00001) ? {a_rot[0], a_rot[31:1]} : 
				(b[4:0] == 5'b00010) ? {a_rot[1:0], a_rot[31:2]} : 
				(b[4:0] == 5'b00011) ? {a_rot[2:0], a_rot[31:3]} : 
				(b[4:0] == 5'b00100) ? {a_rot[3:0], a_rot[31:4]} : 
				(b[4:0] == 5'b00101) ? {a_rot[4:0], a_rot[31:5]} : 
				(b[4:0] == 5'b00110) ? {a_rot[5:0], a_rot[31:6]} : 
				(b[4:0] == 5'b00111) ? {a_rot[6:0], a_rot[31:7]} : 
				(b[4:0] == 5'b01000) ? {a_rot[7:0], a_rot[31:8]} : 
				(b[4:0] == 5'b01001) ? {a_rot[8:0], a_rot[31:9]} : 
				(b[4:0] == 5'b01010) ? {a_rot[9:0], a_rot[31:10]} : 
				(b[4:0] == 5'b01011) ? {a_rot[10:0], a_rot[31:11]} : 
				(b[4:0] == 5'b01100) ? {a_rot[11:0], a_rot[31:12]} : 
				(b[4:0] == 5'b01101) ? {a_rot[12:0], a_rot[31:13]} : 
				(b[4:0] == 5'b01110) ? {a_rot[13:0], a_rot[31:14]} : 
				(b[4:0] == 5'b01111) ? {a_rot[14:0], a_rot[31:15]} : 
				(b[4:0] == 5'b10000) ? {a_rot[15:0], a_rot[31:16]} : 
				(b[4:0] == 5'b10001) ? {a_rot[16:0], a_rot[31:17]} : 
				(b[4:0] == 5'b10010) ? {a_rot[17:0], a_rot[31:18]} : 
				(b[4:0] == 5'b10011) ? {a_rot[18:0], a_rot[31:19]} : 
				(b[4:0] == 5'b10100) ? {a_rot[19:0], a_rot[31:20]} : 
				(b[4:0] == 5'b10101) ? {a_rot[20:0], a_rot[31:21]} : 
				(b[4:0] == 5'b10110) ? {a_rot[21:0], a_rot[31:22]} : 
				(b[4:0] == 5'b10111) ? {a_rot[22:0], a_rot[31:23]} : 
				(b[4:0] == 5'b11000) ? {a_rot[23:0], a_rot[31:24]} : 
				(b[4:0] == 5'b11001) ? {a_rot[24:0], a_rot[31:25]} : 
				(b[4:0] == 5'b11010) ? {a_rot[25:0], a_rot[31:26]} : 
				(b[4:0] == 5'b11011) ? {a_rot[26:0], a_rot[31:27]} : 
				(b[4:0] == 5'b11100) ? {a_rot[27:0], a_rot[31:28]} : 
				(b[4:0] == 5'b11101) ? {a_rot[28:0], a_rot[31:29]} : 
				(b[4:0] == 5'b11110) ? {a_rot[29:0], a_rot[31:30]} : 
				(b[4:0] == 5'b11111) ? {a_rot[30:0], a_rot[31]} :  
				a_rot;
			assign	a=ab_xor^b;
    always @(negedge rst or posedge clk) begin
        if(rst==0) b_reg<=d_in[31:0];
        else b_reg <= b;
    end
    always @(negedge rst or posedge clk) begin
        if(rst==0) a_reg <= d_in[63:32];
        else a_reg <= a;
    end
    always @(negedge rst or posedge clk)
    begin
        if (rst==0) begin
            count <= 4'b1100;
        end else begin
            if(count==4'b0001)
            begin
                count<=4'b1100;
                d_out<= {a, b};
                end
            else
                count<=count-4'b1;
        end
    end
endmodule
