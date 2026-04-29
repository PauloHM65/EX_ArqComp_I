// -------------------------
// Guia_0804.v  -  Unidade logica (LU): comparador de desigualdade de 6 bits
// Nome: Paulo Henrique
// Matricula: 827112
// -------------------------
// Operandos com 06 bits ( sinal=1 + amplitude=5 ).
// Desigualdade bit-a-bit usando XOR (a XOR b = 1 quando a != b).
// Desigualdade global = OR de todos os bits-desigualdade.
// Apenas portas nativas.
// -------------------------

// -------------------------
// desigualdade entre dois bits
// -------------------------
module bitNeq ( output d, input a, input b );
   xor XOR1 ( d, a, b );
endmodule // bitNeq

// -------------------------
// comparador de desigualdade 6 bits
//   x[5:0] != y[5:0]  ->  s = 1
// -------------------------
module neq6 ( output s, input [5:0] x, input [5:0] y );
   wire [5:0] d;

   bitNeq B0 ( d[0], x[0], y[0] );
   bitNeq B1 ( d[1], x[1], y[1] );
   bitNeq B2 ( d[2], x[2], y[2] );
   bitNeq B3 ( d[3], x[3], y[3] );
   bitNeq B4 ( d[4], x[4], y[4] );
   bitNeq B5 ( d[5], x[5], y[5] );

   or OR1 ( s, d[0], d[1], d[2], d[3], d[4], d[5] );
endmodule // neq6

// -------------------------
// modulo de teste
// -------------------------
module test_neq6;
   reg  [5:0] x, y;
   wire s;

   neq6 NQ ( s, x, y );

   initial
   begin : main
      $display("Guia_0804 - Paulo Henrique - 827112");
      $display("LU: comparador de desigualdade de 6 bits (s=1 quando diferentes)");
      $display("       x        y     |  s");
      x = 6'b000000; y = 6'b000000;
      #1 $display("  %6b   %6b |  %1b", x, y, s);
      x = 6'b101010; y = 6'b101010;
      #1 $display("  %6b   %6b |  %1b", x, y, s);
      x = 6'b111111; y = 6'b111110;
      #1 $display("  %6b   %6b |  %1b", x, y, s);
      x = 6'b011110; y = 6'b011111;
      #1 $display("  %6b   %6b |  %1b", x, y, s);
      x = 6'b000001; y = 6'b100000;
      #1 $display("  %6b   %6b |  %1b", x, y, s);
      x = 6'b010101; y = 6'b010101;
      #1 $display("  %6b   %6b |  %1b", x, y, s);
   end
endmodule // test_neq6
