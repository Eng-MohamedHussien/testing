//this for first task in co project
module Alu_Control ( ALUOp , FUNC , operation );
input [1:0] ALUOp ;
input [5:0] FUNC ;
output reg [3:0] operation ;
always@(ALUOp or FUNC)
begin
if(ALUOp == 2'b00)
	 operation <= 4'b0010;
else if(ALUOp == 2'b01)
	operation <= 4'b0110;
else if(ALUOp == 2'b10)
	begin
		case (FUNC) 
			36 :  operation <= 4'b0000;
			37 :  operation <= 4'b0001;
			32 :  operation <= 4'b0010;
			34 :  operation <= 4'b0110;
			42 :  operation <= 4'b1110;
			39 :  operation <= 4'b1100;
		endcase
	end
end
endmodule 
 
module control_unit (Op , RegDst , Jump , Branch , MemRead , MemtoReg , ALUOp , MemWrite , ALUSrc , RegWrite);
input [5:0] Op;
output reg RegDst , Jump , Branch , MemRead , MemtoReg , MemWrite , ALUSrc , RegWrite ;
output reg [1:0] ALUOp ;
always@(Op)
begin
	case (Op)
		   0 :	
			begin
				RegDst<=1; Jump<=0; Branch<=0; MemRead<=0; MemtoReg<=0; ALUOp<=2'b10; MemWrite<=0; ALUSrc<=0; RegWrite<=1;
			end
		   35 :
			begin
				RegDst<=0; Jump<=0; Branch<=0; MemRead<=1; MemtoReg<=1; ALUOp<=2'b00; MemWrite<=0; ALUSrc<=1; RegWrite<=1;
			end	
		   43 :
			begin
				RegDst<=1'bx; Jump<=0; Branch<=0; MemRead<=0; MemtoReg<=1'bx; ALUOp<=2'b00; MemWrite<=1; ALUSrc<=1; RegWrite<=0;
			end	
		   4 :
			begin
				RegDst<=1'bx; Jump<=0; Branch<=1; MemRead<=0; MemtoReg<=1'bx; ALUOp<=2'b01; MemWrite<=0; ALUSrc<=0; RegWrite<=0;
			end	
	endcase  
end
endmodule

module reg_file ( reg_read1 , reg_read2 , write_reg , write_enable , clk , reg1 , reg2 , write_data );
input write_enable , clk ;
input [4:0] reg_read1 , reg_read2 , write_reg;
output reg [31:0] reg1 , reg2 ;
input [31:0] write_data;
reg [31:0] registers [0:31] ;
always @ ( negedge clk )
begin
reg1 <= registers[reg_read1];
reg2 <= registers[reg_read2];
end
always @ ( posedge clk )
begin
if(write_enable)
begin
 registers[write_reg] <= write_data;
end
end
endmodule
