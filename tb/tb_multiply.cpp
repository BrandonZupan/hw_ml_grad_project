// From https://www.itsembedded.com/dhd/verilator_2/

#include <stdlib.h>
#include <iostream>
#include <cstdlib>
#include <verilated.h>
#include <verilated_vcd_c.h>

#include "Vmultiply.h"      // Replace with the module

#define MAX_SIM_TIME 100
#define VERIF_START_TIME 7
vluint64_t sim_time = 0;
vluint64_t posedge_cnt = 0;

void dut_reset (Vmultiply *dut, vluint64_t &sim_time){
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
    Vmultiply *dut = new Vmultiply;       // Replace with the module

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("waveform.vcd");

    int clk = 0;
    while (sim_time < MAX_SIM_TIME) {
        dut_reset(dut, sim_time);

        dut->vlmul = 3;     // vlmul = 8

        clk ^= 1;
        dut->eval();

        if (clk == 1){
            posedge_cnt++;

            // Check previous outputs
            // printf("DEBUG: %d * %d = %d\n", dut->op0_value[0], dut->op1_value[0], dut->mul_out[0]);
            for (int i = 0; i < 8; i++) {
                vluint8_t expected = dut->op0_value[i] * dut->op1_value[i];
                if (expected != dut->mul_out[i]) {
                    printf("ERROR: cycle %llu \n\treg %d \n\ta: %d \n\tb: %d, expected: %d, out: %d\n", posedge_cnt, i, dut->op0_value[i], dut->op1_value[i], expected, dut->mul_out[i]);
                }
            }

            // Set new inputs
            for (int i = 0; i < 8; i++) {
                dut->op0_value[i] = rand() % 255;
                dut->op1_value[i] = rand() % 255;
            }
        }

        m_trace->dump(sim_time);
        sim_time++;
    }

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}
