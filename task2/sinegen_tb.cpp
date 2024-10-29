#include "verilated.h"
#include "verilated_vcd_c.h"
#include "Vsinegen.h"
#include "vbuddy.cpp"     // include vbuddy code


int main(int argc, char **argv, char **env){
    int i;  // simulation cycle counter
    int tick;    // each clk cycle has two ticks for two edges

    Verilated::commandArgs(argc, argv);

    // init top verilog instance
    Vsinegen* top = new Vsinegen;

    // init trace dump
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("sinegen.vcd");


    // init Vbuddy
    if (vbdOpen()!=1) return(-1);
    vbdHeader("Lab 2: SigGen");

    // initialize simulation inputs
    top->clk = 1;
    top->rst = 0;
    top->en = 1;
    top->incr = 1; // I don't think you need both en and incr for this, since they are only used to increment the counter

    // run simulation for 1000000 clock cycles
    for(i=0; i<1000000; i++){
        // dump variables into VCD file and toggle clock
        for(tick=0; tick<2; tick++){
            tfp->dump(2*i+tick);
            top->clk = !top->clk;
            top->eval();
        }

    top->phase_diff = vbdValue();

    vbdPlot(int (top->dout1), 0, 255);
    vbdPlot(int (top->dout2), 0, 255);
    vbdCycle(i);

    // either simulation finished, or 'q' is pressed
    if((Verilated::gotFinish()) || (vbdGetkey()=='q'))
        exit(0);
    }

    vbdClose();
    tfp->close();
    exit(0);
}