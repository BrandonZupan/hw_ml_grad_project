#include <stdlib.h>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>

#include "Valu.h"

#define MAX_SIM_TIME 20
vluint64_t sim_time = 0;

int main(int argc, char** argv, char** env) {
    Valu *dut = new Valu;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("waveform.vcd");

    dut->mode = 0;

    VlWide<8> in;

    while (sim_time < MAX_SIM_TIME) {
        // dut->clk ^= 1;
        in[0] = sim_time;
        dut->op0_value = in;
        dut->op1_value = in;
        dut->eval();
        std::cout << dut->alu_out[0] << std::endl;
        m_trace->dump(sim_time);
        // m_trace->dump(dut->alu_out);
        sim_time++;
    }

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}