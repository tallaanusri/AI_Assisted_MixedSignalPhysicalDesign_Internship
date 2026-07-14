//Top-Level Digital Verilog Code for design_mux.v

module design_mux (
    input  wire RST,
    input  wire SCK,
    input  wire SDI,
    input  wire CSB,
    output wire SDO,
    output wire sdo_enb,
    output wire xtal_ena,
    output wire reg_ena,
    output wire pll_vco_ena,
    output wire pll_cp_ena,
    output wire pll_bias_ena,
    output wire [2:0] pll_trim,
    output wire pll_bypass,
    output wire irq,
    output wire trap,
    input  wire [31:0] mfgr_id,
    input  wire [31:0] prod_id,
    input  wire [31:0] mask_rev_in,
    output wire [31:0] mask_rev,
    output wire out
);

    // Internal signals between the digital controller and analog macro
    wire I0;
    wire I1;
    wire select;

    //----------------------------------------------------------
    // Analog Hard Macro
    //----------------------------------------------------------
    AMUX2_3V u_amux (
        //.VDD   (VDD),
        //.VSS   (VSS),
        .I0     (I0),
        .I1     (I1),
        .out    (out),
        .select (select)
    );

    //----------------------------------------------------------
    // Digital Controller
    //----------------------------------------------------------
    raven_spi u_raven_spi (
        .RST          (RST),
        .SCK          (SCK),
        .SDI          (SDI),
        .CSB          (CSB),
        .SDO          (I0),
        .sdo_enb      (sdo_enb),
        .xtal_ena     (xtal_ena),
        .reg_ena      (reg_ena),
        .pll_vco_ena  (pll_vco_ena),
        .pll_cp_ena   (pll_cp_ena),
        .pll_bias_ena (pll_bias_ena),
        .pll_trim     (pll_trim),
        .pll_bypass   (pll_bypass),
        .irq          (irq),
        .reset        (I1),
        .trap         (trap),
        .mfgr_id      (mfgr_id),
        .prod_id      (prod_id),
        .mask_rev_in  (mask_rev_in),
        .mask_rev     (mask_rev)
    );

    // Example control logic for the analog mux
    assign select = reg_ena;

endmodule
