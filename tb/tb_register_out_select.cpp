// From https://www.itsembedded.com/dhd/verilator_2/

#include <stdlib.h>
#include <iostream>
#include <cstdlib>
#include <verilated.h>
#include <verilated_vcd_c.h>

#include "Vregister_out_select.h"      // Replace with the module

#define MAX_SIM_TIME 300
#define VERIF_START_TIME 7
vluint64_t sim_time = 0;
vluint64_t posedge_cnt = 0;

void dut_reset (Vregister_out_select *dut, vluint64_t &sim_time){
    // dut->rst = 0;
    // if(sim_time >= 3 && sim_time < 6){
    //     dut->rst = 1;
    //     dut->a_in = 0;
    //     dut->b_in = 0;
    //     dut->op_in = 0;
    //     dut->in_valid = 0;
    // }
}

int main(int argc, char** argv, char** env) {
    srand (time(NULL));
    Verilated::commandArgs(argc, argv);
    Vregister_out_select *dut = new Vregister_out_select;       // Replace with the module

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("waveform.vcd");

    int clk = 0;

    // set initial inputs
    for (int i = 0; i < 32; i++) {
        dut->registers[i] = rand();
    }

    // test each input selection
    for (int vlmul = 0; vlmul < 4; vlmul++) {
        dut->vlmul = vlmul;
        for (int sel = 0; sel < 32; sel++) {
            dut->op0_sel = sel;

            dut->eval();

            // check output
            printf("\n VLMUL: %d, SEL: %d\n", vlmul, sel);
            for (int out_reg = 0; out_reg < 8; out_reg++) {
                printf("\t%d: 0x%08X\n", out_reg, dut->op0_out[out_reg]);
            }


            m_trace->dump(sim_time);
            sim_time++;
        }
    }

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}
