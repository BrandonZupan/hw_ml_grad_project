// From https://www.itsembedded.com/dhd/verilator_2/

#include <stdlib.h>
#include <iostream>
#include <cstdlib>
#include <verilated.h>
#include <verilated_vcd_c.h>

#include "Vdatapath.h"      // Replace with the module

#define MAX_SIM_TIME 300
#define VERIF_START_TIME 7
vluint64_t sim_time = 0;
vluint64_t posedge_cnt = 0;

void dut_reset (Vdatapath *dut, vluint64_t &sim_time){
    // dut->rst = 0;
    // if(sim_time >= 3 && sim_time < 6){
    //     dut->rst = 1;
    //     dut->a_in = 0;
    //     dut->b_in = 0;
    //     dut->op_in = 0;
    //     dut->in_valid = 0;
    // }
}

void dut_sim (Vdatapath *dut, VerilatedVcdC *m_trace, vluint64_t &sim_time) {
    dut->clk ^= 1;
    dut->eval();
    m_trace->dump(sim_time);
    sim_time++;
    dut->clk ^= 0;
    dut->eval();
    m_trace->dump(sim_time);
    sim_time++;
}

int main(int argc, char** argv, char** env) {
    srand (time(NULL));
    Verilated::commandArgs(argc, argv);
    Vdatapath *dut = new Vdatapath;       // Replace with the module

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("waveform.vcd");

    dut->reset = 1;
    dut_sim(dut, m_trace, sim_time);

    dut->reset = 0;

    // Put immediate into reg 0
    dut->vlmul = 0;
    dut->op0_sel = 0;
    dut->wb_sel = 0;
    dut->wb_load = 1;
    dut->alu_imm = 0x55;
    dut->alu_op1_sel = 1;

    dut_sim(dut, m_trace, sim_time);

    dut->wb_load = 0;

    dut_sim(dut, m_trace, sim_time);

    printf("R0: 0x%08X\n", dut->r0);

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}
