
`define WIDTH 4
`define IMEM_SIZE 16
`define INST_INC 4'b0000
`define INST_ACC 4'b0001

`define STAGE_LEN 2
`define STAGE_FETCH    2'h0
`define STAGE_EXECUTE1 2'h1
`define STAGE_EXECUTE0 2'h2
`define STAGE_COMMIT   2'h3


module tiny_cpu (
  input clk,
  input rst,

  output commit,

  // These outputs just avoid yosys optimize away registers
  output [`WIDTH-1:0] pc,
  output [`WIDTH-1:0] R1,
  output [`WIDTH-1:0] R2
);
  // STEP: microarchitectural state
  reg [`STAGE_LEN-1:0] stage;


  // STEP: update pc
  reg [`WIDTH-1:0] pc;
  always @(posedge clk)
    if (rst) pc <= 0;
    else     pc <= (stage==`STAGE_COMMIT)? pc + 1 : pc;


  // STEP: read instruction
  reg [`WIDTH-1:0] imem [`IMEM_SIZE-1:0];
  always @(posedge clk)
    if (rst) begin
      integer i;
      for (i=0; i<`IMEM_SIZE; i=i+1) imem[i] <= 0;
    end
  wire inst = imem[pc];


  // STEP: execute the instruction
  reg [`WIDTH-1:0] R1, R2;
  always @(posedge clk)
    if (rst) begin
      stage <= `STAGE_FETCH;
      R1 <= 0;
      R2 <= 0;
    end else begin
      case (stage)
        `STAGE_FETCH: begin
          case (inst) // different inst takes different cycles to complete
            `INST_INC: stage <= `STAGE_EXECUTE0;
            `INST_ACC: stage <= `STAGE_EXECUTE1;
            default:   stage <= `STAGE_COMMIT;
          endcase
        end
        
        `STAGE_EXECUTE1: begin
          stage <= `STAGE_EXECUTE0;
        end
        
        `STAGE_EXECUTE0: begin
          stage <= `STAGE_COMMIT;
        end
        
        `STAGE_COMMIT: begin
          case (inst)
            `INST_INC: R1 <= R1 + 1;
            `INST_ACC: R2 <= R2 + R1;
          endcase
          stage <= `STAGE_FETCH;
        end
      endcase
    end


  // STEP: generate commit output
  assign commit = stage==`STAGE_COMMIT;

endmodule

