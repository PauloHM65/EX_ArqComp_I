// -------------------------
// Guia_0605.v  -  Identificacao e simplificacao de circuito (3 var, mintermos)
// Nome: Paulo Henrique
// Matricula: 827112
// -------------------------
// Identificacao da equacao caracteristica:
//   A partir do circuito apresentado no enunciado, com entradas x, y, z e
//   saida s = NOR(w1, w2), foi identificada a tabela-verdade abaixo:
//
//      x y z |  s
//      0 0 0 |  0
//      0 0 1 |  0
//      0 1 0 |  0
//      0 1 1 |  1   <- m3
//      1 0 0 |  0
//      1 0 1 |  1   <- m5
//      1 1 0 |  0
//      1 1 1 |  1   <- m7
//
//   Logo: s = Sum m( 3, 5, 7 )
//
// Mapa de Veitch-Karnaugh:
//
//      xy\z | 0 1
//      00   | 0 0
//      01   | 0 1   <- m3
//      11   | 0 1   <- m7
//      10   | 0 1   <- m5
//
//   Pares: (m3,m7) = yz   ;   (m5,m7) = xz
//
// Equacao simplificada:  s = yz + xz  =  z( x + y )
// -------------------------

// -------------------------
// Forma canonica (soma dos mintermos)
// -------------------------
module f05a ( output s, input x, input y, input z );
   assign s = (~x &  y &  z) | ( x & ~y &  z) | ( x &  y &  z);
endmodule // f05a

// -------------------------
// Forma simplificada
// -------------------------
module f05b ( output s, input x, input y, input z );
// dados locais
   wire xy, yz, xz;
// portas nativas
   and AND1 ( yz, y, z );
   and AND2 ( xz, x, z );
   or  OR1  ( s, yz, xz );
endmodule // f05b

// -------------------------
// modulo de teste
// -------------------------
module test_f06_q05;
   reg  x, y, z;
   wire a, b;

   f05a A ( a, x, y, z );
   f05b B ( b, x, y, z );

   integer i;
   initial
   begin : main
      $display("Guia_0605 - Paulo Henrique - 827112");
      $display("Circuito identificado: s = Sum m(3,5,7) = z(x+y)");
      $display(" x y z |  a  b");
      for ( i = 0; i < 8; i = i + 1 )
      begin
         { x, y, z } = i[2:0];
         #1 $display("%2b %2b %2b | %2b %2b", x, y, z, a, b);
      end
   end
endmodule // test_f06_q05
