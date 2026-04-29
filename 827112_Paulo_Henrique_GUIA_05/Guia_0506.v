// -------------------------
// Guia_0506.v - apenas portas NOR
// Nome: Paulo_Henrique
// Matricula: 827112
// -------------------------
// f06 : s = a ^ b  =  a XOR b
// m a b s
// 0 0 0 0
// 1 0 1 1
// 2 1 0 1
// 3 1 1 0
// -------------------------
// Estrategia (dual da do XNOR com NAND):
//   primeiro construir XNOR com 4 NOR, depois inverter (mais 1 NOR).
//   n1 = ~(a | b)
//   n2 = ~(a | n1)
//   n3 = ~(b | n1)
//   xnor = ~(n2 | n3)        -> a XNOR b
//   s    = ~(xnor | xnor)    -> a XOR b
// -------------------------
module f06a ( output s,
              input  a,
              input  b );
// dados locais
   wire n1, n2, n3, xnor_ab;
// descrever por portas (apenas NOR)
   nor NOR1 ( n1, a, b );
   nor NOR2 ( n2, a, n1 );
   nor NOR3 ( n3, b, n1 );
   nor NOR4 ( xnor_ab, n2, n3 );        // xnor_ab = a XNOR b
   nor NOR5 ( s, xnor_ab, xnor_ab );    // s = a XOR b
endmodule // f06a

// -------------------------
// referencia por expressao
// -------------------------
module f06b ( output s,
              input  a,
              input  b );
   assign s = a ^ b;
endmodule // f06b

// -------------------------
// modulo de teste
// -------------------------
module test_f06;
   reg  x, y;
   wire a, b;
   f06a moduloA ( a, x, y );
   f06b moduloB ( b, x, y );

   initial
   begin : main
      $display("Guia_0506 - Paulo Henrique - 827112");
      $display("Test module: s = a ^ b = a XOR b   (somente NOR)");
      $display(" x y | a b");
      $monitor("%4b %4b | %4b %4b", x, y, a, b);
      x = 1'b0; y = 1'b0;
      #1 x = 1'b0; y = 1'b1;
      #1 x = 1'b1; y = 1'b0;
      #1 x = 1'b1; y = 1'b1;
   end
endmodule // test_f06


