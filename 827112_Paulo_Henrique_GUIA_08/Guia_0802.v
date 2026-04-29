// -------------------------
// Guia_0802.v  -  Unidade aritmetica (AU): subtrator completo de 6 bits
// Nome: Paulo Henrique
// Matricula: 827112
// -------------------------
// Operandos com 06 bits ( sinal=1 + amplitude=5 ).
// Modelo compacto: meia-diferenca para o bit 0 (vem-um inicial = 0)
// e diferenca-completa para os demais bits, encadeadas (ripple-borrow).
// Apenas portas nativas.
// -------------------------

// -------------------------
// half difference  (meia-diferenca)
//   d  = a XOR b
//   v  = a' . b   (vem-um)
// -------------------------
module halfDiff ( output v, output d, input a, input b );
   wire na;
   xor XOR1 ( d, a, b );
   not NOT1 ( na, a );
   and AND1 ( v, na, b );
endmodule // halfDiff

// -------------------------
// full difference  (diferenca-completa)
//   x - y - vemUm  ->  d (diferenca) , vOut (vem-um saida)
// Modelo compacto a partir de duas meias-diferencas:
//   (t_v, t_d) = halfDiff( a, b )
//   (u_v, d  ) = halfDiff( t_d, vemUm )
//   vOut = t_v OR u_v
// -------------------------
module fullDiff ( output vOut, output d,
                  input  a, input b, input vemUm );
   wire t_d, t_v, u_v;
   halfDiff HD1 ( t_v, t_d, a, b );
   halfDiff HD2 ( u_v, d,   t_d, vemUm );
   or OR1 ( vOut, t_v, u_v );
endmodule // fullDiff

// -------------------------
// subtrator 6 bits (ripple-borrow)
//   x[5:0] - y[5:0] = dif[5:0] , vemUmFinal
// -------------------------
module sub6 ( output       vemUmFinal,
              output [5:0] dif,
              input  [5:0] x,
              input  [5:0] y );
   wire [5:0] v;  // vem-uns intermediarios

   halfDiff HD0 ( v[0], dif[0], x[0], y[0]       );
   fullDiff FD1 ( v[1], dif[1], x[1], y[1], v[0] );
   fullDiff FD2 ( v[2], dif[2], x[2], y[2], v[1] );
   fullDiff FD3 ( v[3], dif[3], x[3], y[3], v[2] );
   fullDiff FD4 ( v[4], dif[4], x[4], y[4], v[3] );
   fullDiff FD5 ( v[5], dif[5], x[5], y[5], v[4] );
   assign vemUmFinal = v[5];
endmodule // sub6

// -------------------------
// modulo de teste
// -------------------------
module test_sub6;
   reg  [5:0] x, y;
   wire [5:0] dif;
   wire       vemUmFinal;

   sub6 SU ( vemUmFinal, dif, x, y );

   initial
   begin : main
      $display("Guia_0802 - Paulo Henrique - 827112");
      $display("AU: subtrator completo de 6 bits (ripple-borrow)");
      $display("       x        y     | vemUm    dif");
      x = 6'b000000; y = 6'b000000;
      #1 $display("  %6b   %6b |   %1b    %6b", x, y, vemUmFinal, dif);
      x = 6'b000101; y = 6'b000010;       //  5 - 2 = 3
      #1 $display("  %6b   %6b |   %1b    %6b", x, y, vemUmFinal, dif);
      x = 6'b001010; y = 6'b000111;       // 10 - 7 = 3
      #1 $display("  %6b   %6b |   %1b    %6b", x, y, vemUmFinal, dif);
      x = 6'b000001; y = 6'b000010;       //  1 - 2 (empresta)
      #1 $display("  %6b   %6b |   %1b    %6b", x, y, vemUmFinal, dif);
      x = 6'b011111; y = 6'b011110;       // 31 - 30 = 1
      #1 $display("  %6b   %6b |   %1b    %6b", x, y, vemUmFinal, dif);
      x = 6'b101010; y = 6'b010101;       // teste com bit de sinal
      #1 $display("  %6b   %6b |   %1b    %6b", x, y, vemUmFinal, dif);
   end
endmodule // test_sub6
