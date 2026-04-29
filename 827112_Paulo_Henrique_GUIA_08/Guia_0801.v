// -------------------------
// Guia_0801.v  -  Unidade aritmetica (AU): somador completo de 6 bits
// Nome: Paulo Henrique
// Matricula: 827112
// -------------------------
// Operandos com 06 bits  ( sinal=1 + amplitude=5 ).
// Modelo compacto: meia-soma para o bit 0 (vai-um inicial = 0) e
// soma-completa para os demais bits, encadeadas (ripple-carry).
// Apenas portas nativas.
// -------------------------

// -------------------------
// half adder
//   s1 = vai-um, s0 = soma
// -------------------------
module halfAdder ( output s1, output s0, input a, input b );
   xor XOR1 ( s0, a, b );
   and AND1 ( s1, a, b );
endmodule // halfAdder

// -------------------------
// full adder (a partir de duas meias-somas + OR)
// -------------------------
module fullAdder ( output s1, output s0,
                   input  a, input b, input carryIn );
   wire t0, t1, t2;
   halfAdder HA1 ( t1, t0,   a, b      );  // soma parcial
   halfAdder HA2 ( t2, s0,   t0, carryIn ); // soma com carry
   or  OR1 ( s1, t1, t2 );                  // vai-um final
endmodule // fullAdder

// -------------------------
// somador 6 bits (ripple-carry)
//   x[5:0] + y[5:0] = soma[5:0] , vaiUmFinal
// -------------------------
module adder6 ( output       vaiUmFinal,
                output [5:0] soma,
                input  [5:0] x,
                input  [5:0] y );
   wire [5:0] c;  // carries entre estagios

   halfAdder HA0 ( c[0], soma[0], x[0], y[0]       );
   fullAdder FA1 ( c[1], soma[1], x[1], y[1], c[0] );
   fullAdder FA2 ( c[2], soma[2], x[2], y[2], c[1] );
   fullAdder FA3 ( c[3], soma[3], x[3], y[3], c[2] );
   fullAdder FA4 ( c[4], soma[4], x[4], y[4], c[3] );
   fullAdder FA5 ( c[5], soma[5], x[5], y[5], c[4] );
   assign vaiUmFinal = c[5];
endmodule // adder6

// -------------------------
// modulo de teste
// -------------------------
module test_adder6;
   reg  [5:0] x, y;
   wire [5:0] soma;
   wire       vaiUmFinal;

   adder6 AD ( vaiUmFinal, soma, x, y );

   initial
   begin : main
      $display("Guia_0801 - Paulo Henrique - 827112");
      $display("AU: somador completo de 6 bits (ripple-carry)");
      $display("       x        y     | vaiUm    soma");
      x = 6'b000000; y = 6'b000000;
      #1 $display("  %6b   %6b |   %1b    %6b", x, y, vaiUmFinal, soma);
      x = 6'b000001; y = 6'b000001;
      #1 $display("  %6b   %6b |   %1b    %6b", x, y, vaiUmFinal, soma);
      x = 6'b001010; y = 6'b000101;
      #1 $display("  %6b   %6b |   %1b    %6b", x, y, vaiUmFinal, soma);
      x = 6'b011111; y = 6'b000001;
      #1 $display("  %6b   %6b |   %1b    %6b", x, y, vaiUmFinal, soma);
      x = 6'b011111; y = 6'b011111;
      #1 $display("  %6b   %6b |   %1b    %6b", x, y, vaiUmFinal, soma);
      x = 6'b111111; y = 6'b000001;
      #1 $display("  %6b   %6b |   %1b    %6b", x, y, vaiUmFinal, soma);
      x = 6'b101010; y = 6'b010101;
      #1 $display("  %6b   %6b |   %1b    %6b", x, y, vaiUmFinal, soma);
   end
endmodule // test_adder6
