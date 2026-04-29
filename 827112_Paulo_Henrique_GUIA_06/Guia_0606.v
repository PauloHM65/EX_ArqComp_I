// -------------------------
// Guia_0606.v  -  Identificacao e simplificacao de circuito (4 var, MAXTERMOS)
// Nome: Paulo Henrique
// Matricula: 827112
// -------------------------
// Identificacao da equacao caracteristica:
//   Circuito apresentado com entradas x, y, w, z e saida s = NOR(w1, w2).
//   A inspecao do circuito conduz aa seguinte tabela-verdade (so os zeros):
//
//      F(x,y,w,z) = Pi M( 0, 1, 2, 3, 12, 13, 14, 15 )
//
//   ou seja, F = 0  quando  ( xy = 00 )  OU  quando  ( xy = 11 ),
//            F = 1  para todas as combinacoes de wz quando  xy = 01  ou  xy = 10.
//
// Mapa de Veitch-Karnaugh (zeros marcados):
//
//      xy\wz | 00 01 11 10
//      00    |  0  0  0  0     <- m0,m1,m3,m2  (bloco de 4)
//      01    |  1  1  1  1
//      11    |  0  0  0  0     <- m12,m13,m15,m14 (bloco de 4)
//      10    |  1  1  1  1
//
//   Bloco m0..m3 -> x'y'    -> MAXTERMO ( X + Y )
//   Bloco m12..m15 -> xy    -> MAXTERMO ( X' + Y' )
//
// Equacao simplificada (PoS):
//      F = ( X + Y ) * ( X' + Y' )   =   X xor Y   (equivalente a antivalencia)
// -------------------------

// -------------------------
// Forma canonica (produto dos MAXTERMOS)
// -------------------------
module f06a ( output s, input x, input y, input w, input z );
   assign s = ( x |  y |  w |  z) &
              ( x |  y |  w | ~z) &
              ( x |  y | ~w |  z) &
              ( x |  y | ~w | ~z) &
              (~x | ~y |  w |  z) &
              (~x | ~y |  w | ~z) &
              (~x | ~y | ~w |  z) &
              (~x | ~y | ~w | ~z);
endmodule // f06a

// -------------------------
// Forma simplificada (PoS)
// -------------------------
module f06b ( output s, input x, input y, input w, input z );
// dados locais
   wire t1, t2;
// portas nativas
   or  OR1 ( t1, x, y );
   or  OR2 ( t2, ~x, ~y );
   and AND1( s, t1, t2 );
endmodule // f06b

// -------------------------
// modulo de teste
// -------------------------
module test_f06_q06;
   reg  x, y, w, z;
   wire a, b;

   f06a A ( a, x, y, w, z );
   f06b B ( b, x, y, w, z );

   integer i;
   initial
   begin : main
      $display("Guia_0606 - Paulo Henrique - 827112");
      $display("Circuito identificado: F = Pi M(0..3,12..15) = (X+Y)(X'+Y') = X xor Y");
      $display(" x y w z |  a  b");
      for ( i = 0; i < 16; i = i + 1 )
      begin
         { x, y, w, z } = i[3:0];
         #1 $display("%2b %2b %2b %2b | %2b %2b", x, y, w, z, a, b);
      end
   end
endmodule // test_f06_q06
