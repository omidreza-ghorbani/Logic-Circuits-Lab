module Register_4bit (
    input clk,   
    input enable,     
    input [3:0] din,    
    output reg [3:0] dout 
);

always @(posedge clk) begin
    if (enable) begin
        dout <= din;    
    end
end

endmodule




module Odd_Register(
    input clk,
    input reset,
    input enable,
    input [3:0] data_in,
    output reg [3:0] data_out
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        data_out <= 4'b0000;
    end else if (enable) begin
        data_out <= data_in;
    end
end

endmodule





module Even_Register(
    input clk,
    input reset,
    input enable,
    input [3:0] data_in,
    output reg [3:0] data_out
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        data_out <= 4'b0000;
    end else if (enable) begin
        data_out <= data_in;
    end
end

endmodule




module System_Controller(
    input clk,
    input reset,
    input [3:0] pass_data,
    input confirm,
    input enable,
    output [3:0] reg_odd,
    output [3:0] reg_even,
    output [2:0] current_state
);

wire odd_reg_enable;
wire even_reg_enable;
wire pass_correct;
reg [3:0] data_to_store;

parameter IDLE     = 3'b000;
parameter ACTIVE   = 3'b001;
parameter REQUEST  = 3'b101;
parameter STORE    = 3'b110;
parameter ERROR    = 3'b111;

reg [2:0] state;


assign pass_correct = (pass_data == 4'b1101);


assign odd_reg_enable = (state == STORE) && data_to_store[0];
assign even_reg_enable = (state == STORE) && !data_to_store[0];


always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        data_to_store <= 4'b0000;
    end else begin
        case (state)
            IDLE: begin
                if (enable) state <= ACTIVE;
            end
            
            ACTIVE: begin
                if (!enable) begin
                    state <= IDLE;
                end else if (confirm) begin
                    if (pass_correct) begin
                        state <= REQUEST;
                    end else begin
                        state <= ERROR;
                    end
                end
            end
            
            REQUEST: begin
                if (!enable) begin
                    state <= IDLE;
                end else if (confirm) begin
                    data_to_store <= pass_data;
                    state <= STORE;
                end
            end
            
            STORE: begin
                state <= IDLE;
            end
            
            ERROR: begin
                if (!enable) state <= IDLE;
            end
        endcase
    end
end

assign current_state = state;


Odd_Register odd_reg (
    .clk(clk),
    .reset(reset),
    .enable(odd_reg_enable),
    .data_in(data_to_store),
    .data_out(reg_odd)
);


Even_Register even_reg (
    .clk(clk),
    .reset(reset),
    .enable(even_reg_enable),
    .data_in(data_to_store),
    .data_out(reg_even)
);

endmodule




module DigitalSystem_Top(
    input clk,
    input reset,
    input [3:0] pass_data,
    input confirm,
    input enable,
    output [3:0] reg_odd,
    output [3:0] reg_even,
    output [2:0] current_state
);

System_Controller controller (
    .clk(clk),
    .reset(reset),
    .pass_data(pass_data),
    .confirm(confirm),
    .enable(enable),
    .reg_odd(reg_odd),
    .reg_even(reg_even),
    .current_state(current_state)
);

endmodule