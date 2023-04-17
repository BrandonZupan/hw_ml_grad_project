// From https://www.itsembedded.com/dhd/verilator_2/

#include <stdlib.h>
#include <iostream>
#include <cstdlib>
#include <verilated.h>
#include <verilated_vcd_c.h>

#include "Vwb_select.h"      // Replace with the module

#define MAX_SIM_TIME 300
#define VERIF_START_TIME 7
vluint64_t sim_time = 0;
vluint64_t posedge_cnt = 0;

void dut_reset (Vwb_select *dut, vluint64_t &sim_time){
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
    Vwb_select *dut = new Vwb_select;       // Replace with the module

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("waveform.vcd");

    int clk = 0;

    for (int wb_load = 0; wb_load < 2; wb_load++) {
        dut->wb_load = wb_load;
        for (int vlmul = 0; vlmul < 4; vlmul++) {
            dut->vlmul = vlmul;
            for (int wb_sel = 0; wb_sel < 32; wb_sel++) {
                dut->wb_sel = wb_sel;

                dut->eval();
                m_trace->dump(sim_time);
                sim_time++;

                printf("load: %d, vlmul: %d, wb_sel: %d -> wb_reg_load: 0x%08X\n", wb_load, vlmul, wb_sel, dut->wb_reg_load);
            }
        }
    }

    while (sim_time < MAX_SIM_TIME) {
        dut_reset(dut, sim_time);

        clk ^= 1;
        dut->eval();

        if (clk == 1){
            posedge_cnt++;

            // Check previous outputs

            // Set new inputs
        }

        m_trace->dump(sim_time);
        sim_time++;
    }

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}
