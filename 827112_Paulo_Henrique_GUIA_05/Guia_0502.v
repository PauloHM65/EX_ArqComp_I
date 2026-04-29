// -------------------------
// Guia_0502.v - apenas portas NOR
// Nome: Paulo_Henrique
// Matricula: 827112
// -------------------------
// f02 : s = ~a | ~b   (equivalente a ~(a & b) - De Morgan)
// m a b s
// 0 0 0 1
// 1 0 1 1
// 2 1 0 1
// 3 1 1 0
// -------------------------
module f02a ( output s,
              input  a,
              input  b );
// dados locais
   wire na, nb, t;
// descrever por portas (apenas NOR)
   nor NOR1 ( na, a, a );        // na = ~a
   nor NOR2 ( nb, b, b );        // nb = ~b
   nor NOR3 ( t,  na, nb );      // t  = ~(~a | ~b) = a & b
   nor NOR4 ( s,  t,  t  );      // s  =  ~a | ~b
endmodule // f02a

// -------------------------
// referencia por expressao
// -------------------------
module f02b ( output s,
              input  a,
              input  b );
   assign s = ~a | ~b;
endmodule // f02b

// -------------------------
// modulo de teste
// -------------------------
module test_f02;
   reg  x, y;
   wire a, b;
   f02a moduloA ( a, x, y );
   f02b moduloB ( b, x, y );

   initial
   begin : main
      $display("Guia_0502 - xxx yyy zzz - 999999");
      $display("Test module: s = ~a | ~b   (somente NOR)");
      $display(" x y | a b");
      $monitor("%4b %4b | %4b %4b", x, y, a, b);
      x = 1'b0; y = 1'b0;
      #1 x = 1'b0; y = 1'b1;
      #1 x = 1'b1; y = 1'b0;
      #1 x = 1'b1; y = 1'b1;
   end
endmodule // test_f02

/* Saida esperada:
Guia_0502 - xxx yyy zzz - 999999
Test module: s = ~a | ~b   (somente NOR)
 x y | a b
   0    0 |    1    1
   0    1 |    1    1
   1    0 |    1    1
   1    1 |    0    0
*/
