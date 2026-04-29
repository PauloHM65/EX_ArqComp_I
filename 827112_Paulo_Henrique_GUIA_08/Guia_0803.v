// -------------------------
// Guia_0803.v  -  Unidade logica (LU): comparador de igualdade de 6 bits
// Nome: Paulo Henrique
// Matricula: 827112
// -------------------------
// Operandos com 06 bits ( sinal=1 + amplitude=5 ).
// Igualdade bit-a-bit usando XNOR (a XNOR b = 1 quando a == b).
// Igualdade global = AND de todos os bits-igualdade.
// Apenas portas nativas.
// -------------------------

// -------------------------
// igualdade entre dois bits
// -------------------------
module bitEq ( output e, input a, input b );
   xnor XNOR1 ( e, a, b );
endmodule // bitEq

// -------------------------
// comparador de igualdade 6 bits
//   x[5:0] == y[5:0]  ->  s = 1
// -------------------------
module eq6 ( output s, input [5:0] x, input [5:0] y );
   wire [5:0] e;

   bitEq B0 ( e[0], x[0], y[0] );
   bitEq B1 ( e[1], x[1], y[1] );
   bitEq B2 ( e[2], x[2], y[2] );
   bitEq B3 ( e[3], x[3], y[3] );
   bitEq B4 ( e[4], x[4], y[4] );
   bitEq B5 ( e[5], x[5], y[5] );

   and AND1 ( s, e[0], e[1], e[2], e[3], e[4], e[5] );
endmodule // eq6

// -------------------------
// modulo de teste
// -------------------------
module test_eq6;
   reg  [5:0] x, y;
   wire s;

   eq6 EQ ( s, x, y );

   initial
   begin : main
      $display("Guia_0803 - Paulo Henrique - 827112");
      $display("LU: comparador de igualdade de 6 bits (s=1 quando iguais)");
      $display("       x        y     |  s");
      x = 6'b000000; y = 6'b000000;
      #1 $display("  %6b   %6b |  %1b", x, y, s);
      x = 6'b101010; y = 6'b101010;
      #1 $display("  %6b   %6b |  %1b", x, y, s);
      x = 6'b111111; y = 6'b111111;
      #1 $display("  %6b   %6b |  %1b", x, y, s);
      x = 6'b011110; y = 6'b011111;
      #1 $display("  %6b   %6b |  %1b", x, y, s);
      x = 6'b000001; y = 6'b100000;
      #1 $display("  %6b   %6b |  %1b", x, y, s);
      x = 6'b010101; y = 6'b010101;
      #1 $display("  %6b   %6b |  %1b", x, y, s);
   end
endmodule // test_eq6
