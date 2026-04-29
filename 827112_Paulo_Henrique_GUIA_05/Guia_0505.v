// -------------------------
// Guia_0505.v - apenas portas NAND
// Nome: Paulo_Henrique
// Matricula: 827112
// -------------------------
// f05 : s = ~(a ^ b)  =  a XNOR b
// m a b s
// 0 0 0 1
// 1 0 1 0
// 2 1 0 0
// 3 1 1 1
// -------------------------
// Estrategia:
//   primeiro construir XOR com 4 NAND, depois inverter (mais 1 NAND).
//   n1 = ~(a & b)
//   n2 = ~(a & n1) = ~(a & ~(a&b))
//   n3 = ~(b & n1) = ~(b & ~(a&b))
//   xor = ~(n2 & n3)        -> a XOR b
//   s   = ~(xor & xor)      -> a XNOR b
// -------------------------
module f05a ( output s,
              input  a,
              input  b );
// dados locais
   wire n1, n2, n3, xor_ab;
// descrever por portas (apenas NAND)
   nand NAND1 ( n1, a, b );
   nand NAND2 ( n2, a, n1 );
   nand NAND3 ( n3, b, n1 );
   nand NAND4 ( xor_ab, n2, n3 );        // xor_ab = a XOR b
   nand NAND5 ( s, xor_ab, xor_ab );     // s = a XNOR b
endmodule // f05a

// -------------------------
// referencia por expressao
// -------------------------
module f05b ( output s,
              input  a,
              input  b );
   assign s = ~(a ^ b);
endmodule // f05b

// -------------------------
// modulo de teste
// -------------------------
module test_f05;
   reg  x, y;
   wire a, b;
   f05a moduloA ( a, x, y );
   f05b moduloB ( b, x, y );

   initial
   begin : main
      $display("Guia_0505 - xxx yyy zzz - 999999");
      $display("Test module: s = ~(a ^ b) = a XNOR b   (somente NAND)");
      $display(" x y | a b");
      $monitor("%4b %4b | %4b %4b", x, y, a, b);
      x = 1'b0; y = 1'b0;
      #1 x = 1'b0; y = 1'b1;
      #1 x = 1'b1; y = 1'b0;
      #1 x = 1'b1; y = 1'b1;
   end
endmodule // test_f05

/* Saida esperada:
Guia_0505 - xxx yyy zzz - 999999
Test module: s = ~(a ^ b) = a XNOR b   (somente NAND)
 x y | a b
   0    0 |    1    1
   0    1 |    0    0
   1    0 |    0    0
   1    1 |    1    1
*/
