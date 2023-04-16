// From https://www.itsembedded.com/dhd/verilator_2/

#include <stdlib.h>
#include <iostream>
#include <cstdlib>
#include <verilated.h>
#include <verilated_vcd_c.h>

#include "Vmultiply_8_bit.h"      // Replace with the module

#define MAX_SIM_TIME 300
#define VERIF_START_TIME 7
vluint64_t sim_time = 0;
vluint64_t posedge_cnt = 0;

void dut_reset (Vmultiply_8_bit *dut, vluint64_t &sim_time){
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
    Vmultiply_8_bit *dut = new Vmultiply_8_bit;       // Replace with the module

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("waveform.vcd");

    uint8_t clk = 0;
    while (sim_time < MAX_SIM_TIME) {
        dut_reset(dut, sim_time);

        // dut->clk ^= 1;
        clk ^= 1;
        dut->eval();

        // if (dut->clk == 1){
            if (clk == 1){
            posedge_cnt++;

            // Check previous outputs
            // printf("DEBUG: %d * %d = %d\n", dut->a, dut->b, dut->out);
            uint8_t expected = dut->a * dut->b;
            if (dut->out != expected) {
                printf("Error:\n\ta: %d\n\tb: %d\n\texpected: %d\n\tout: %d", dut->a, dut->b, expected, dut->out);
            }

            // Set new inputs
            dut->a = rand() % 8;
            dut->b = rand() % 8;
        }

        m_trace->dump(sim_time);
        sim_time++;
    }

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}
