// Copyright 2021 The CFU-Playground Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.



module Cfu (
  input               cmd_valid,
  output              cmd_ready,
  input      [9:0]    cmd_payload_function_id,
  input      [31:0]   cmd_payload_inputs_0,
  input      [31:0]   cmd_payload_inputs_1,
  output              rsp_valid,
  input               rsp_ready,
  output     [31:0]   rsp_payload_outputs_0,
  input               reset,
  input               clk
);

  // Wires
  wire [255:0]  BUS;
  wire [1:0]    bus_sel;    // selects what is put onto bus

  // General
  wire [2:0]    vlmul;
  wire [31:0]   vtype;
  wire [5:0]    vlen;

  // Register File
  wire [4:0]    reg_op0_sel;
  wire [4:0]    reg_op1_sel;


  wire [4:0]    reg_wb_sel;
  wire          reg_load;

  wire [255:0]  reg_op0_value;
  wire [255:0]  reg_op1_value;

  // ALU
  wire [7:0]    alu_imm;
  wire          alu_op1_sel;    // Select signal for MUX that goes into OP1 of ALU
  wire [255:0]  alu_op1_in;     // Output of ALU op1 mux
  wire [1:0]    alu_mode;
  wire [255:0]  alu_out;

  // Multiply
  wire [255:0]  mul_out;

  // Byte accumulator
  wire [7:0]    acc_out;

  // bus mux
  // 00 : disconnected
  // 01 : alu
  // 10 : multiply
  // 11 : byte accumulator
  assign BUS = bus_sel[1] ? (bus_sel[0] ? {248'b0, acc_out} : mul_out) : (bus_sel[0] ? alu_out : 256'bZ);

  // Blocks
  register_file register_file0 (
    clk, 
    reset,

    reg_op0_sel,
    reg_op1_sel,
    vlmul,

    reg_wb_sel,
    BUS,
    reg_load,

    reg_op0_value,
    reg_op1_value
  );

  // mux for determining op1 of mux
  assign alu_imm = cmd_payload_inputs_1[7:0];
  wire [255:0] alu_imm_padded;

  genvar i;
  generate 
    for (i = 0; i < 32; i = i + 1) begin
      assign alu_imm_padded[(i*8)+7 : i*8] = alu_imm;
    end
  endgenerate
  
  assign alu_op1_in = alu_op1_sel ? alu_imm_padded : reg_op1_value;

  alu alu0 (
    reg_op0_value,
    alu_op1_in,

    alu_mode,

    alu_out
  );

  multiply multiply0 (
    reg_op0_value,
    reg_op1_value,

    vlmul,

    mul_out
  );

  byte_accumulator byte_accumulator0 (
    reg_op0_value[31:0],
    acc_out
  );


  // Trivial handshaking for a combinational CFU
  assign rsp_valid = cmd_valid;
  assign cmd_ready = rsp_ready;

  //
  // select output -- note that we're not fully decoding the 3 function_id bits
  //
  assign rsp_payload_outputs_0 = cmd_payload_function_id[0] ? 
                                           cmd_payload_inputs_1 :
                                           cmd_payload_inputs_0 ;


endmodule
