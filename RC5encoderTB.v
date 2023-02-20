`timescale 1ns / 1ps



module RC5encoderTB(

);
    reg  clk;
    reg rst;
    reg[63:0] d_in;
    wire[63:0] d_out;
    reg[63:0] file_din;
    reg[63:0] file_dout;
    integer file_pointer;
    RC5Encoder UUT (.clk(clk),.rst(rst),.d_in(d_in),.d_out(d_out));
    always begin : clock_generation
            clk<=0;
            #25
            clk<=1;
            #25;
    end
    //comment below always block if we want to use clr as part of data assignment process
    always begin : rst_generation
            rst<=0;
            #25
            rst<=1;
            #575;
    end
    
    always  begin
        file_pointer=$fopen("message.mem","r");
        if(file_pointer==0)begin
            $display("could not open the test case file, please check it");
            $finish;
        end
        while(!$feof(file_pointer)) begin
            $fscanf(file_pointer,"%h %h\n",file_din,file_dout);
            assign d_in=file_din;
             
            #1150
            if(d_out!=file_dout) begin
                $display("The test case didn't passs, %h!=%h",d_out,file_dout);
                $finish;
            end
        end
        $display("All test completed successfully");
        $finish;
    end

endmodule
