//AI Generated Macro Blackbox Stub Code

module AMUX2_3V (
    input  wire I0,
    input  wire I1,
    input  wire select,
    output wire out
);

    // Functional behavioral model
    assign out = (select === 1'b1) ? I1 :
                 (select === 1'b0) ? I0 :
                 1'bx;

endmodule
