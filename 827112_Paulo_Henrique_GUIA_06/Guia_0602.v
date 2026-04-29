// -------------------------
// Guia_0602.v  -  Simplificacao por MAXTERMOS (mapa de Veitch-Karnaugh, 3 variaveis)
// Nome: Paulo Henrique
// Matricula: 827112
// -------------------------
// Para cada item (a..e):
//   moduloA descreve a forma canonica (produto dos MAXTERMOS, Pi M)
//   moduloB descreve a forma simplificada (PoS)
// MAXTERMO M_i = soma cujos sinais negados/diretos correspondem aos bits de i.
//   Ex.: M0 = (X+Y+Z), M5 = (X'+Y+Z'), etc.
// -------------------------

// -------------------------
// a) F(x,y,z) = Pi M( 1, 4, 5 )
// Zeros: m1, m4, m5
// K-map (1=mantem, 0=zero):
//   xy\z | 0 1
//   00   | 1 0   <- m1
//   01   | 1 1
//   11   | 1 1
//   10   | 0 0   <- m4,m5
// Pares de zeros: (m4,m5)=xy' -> (X'+Y) ; (m1,m5)=y'z -> (Y+Z')
// Simplificada: F = (Y+Z')(X'+Y)
// -------------------------
module f01a ( output s, input x, input y, input z );
   assign s = ( x | y | ~z) &
              (~x | y |  z) &
              (~x | y | ~z);
endmodule // f01a

module f01b ( output s, input x, input y, input z );
   assign s = (y | ~z) & (~x | y);
endmodule // f01b

// -------------------------
// b) F(x,y,z) = Pi M( 0, 2, 3 )
// Zeros: m0, m2, m3
// K-map:
//   xy\z | 0 1
//   00   | 0 1   <- m0
//   01   | 0 0   <- m2,m3
//   11   | 1 1
//   10   | 1 1
// Pares: (m0,m2)=x'z' -> (X+Z) ; (m2,m3)=x'y -> (X+Y')
// Simplificada: F = (X+Z)(X+Y')
// -------------------------
module f02a ( output s, input x, input y, input z );
   assign s = ( x |  y |  z) &
              ( x | ~y |  z) &
              ( x | ~y | ~z);
endmodule // f02a

module f02b ( output s, input x, input y, input z );
   assign s = (x | z) & (x | ~y);
endmodule // f02b

// -------------------------
// c) F(x,y,z) = Pi M( 1, 2, 3, 6 )
// Zeros: m1, m2, m3, m6
// K-map:
//   xy\z | 0 1
//   00   | 1 0   <- m1
//   01   | 0 0   <- m2,m3
//   11   | 0 1   <- m6
//   10   | 1 1
// Cobertura economica: (X+Z')(Y'+Z)
//   (X+Z')=0  -> X=0,Z=1 -> mintermos m1, m3
//   (Y'+Z)=0  -> Y=1,Z=0 -> mintermos m2, m6
// Simplificada: F = (X+Z')(Y'+Z)
// -------------------------
module f03a ( output s, input x, input y, input z );
   assign s = ( x |  y | ~z) &
              ( x | ~y |  z) &
              ( x | ~y | ~z) &
              (~x | ~y |  z);
endmodule // f03a

module f03b ( output s, input x, input y, input z );
   assign s = (x | ~z) & (~y | z);
endmodule // f03b

// -------------------------
// d) F(x,y,z) = Pi M( 0, 1, 4, 5 )
// Zeros: m0, m1, m4, m5  (todos com y=0)
// Bloco de 4 -> y'  -> MAXTERMO unico (Y)
// Simplificada: F = Y
// -------------------------
module f04a ( output s, input x, input y, input z );
   assign s = ( x |  y |  z) &
              ( x |  y | ~z) &
              (~x |  y |  z) &
              (~x |  y | ~z);
endmodule // f04a

module f04b ( output s, input x, input y, input z );
   assign s = y;
endmodule // f04b

// -------------------------
// e) F(x,y,z) = Pi M( 0, 1, 5, 7 )
// Zeros: m0, m1, m5, m7
// Pares: (m0,m1)=x'y' -> (X+Y) ; (m5,m7)=xz -> (X'+Z')
// Simplificada: F = (X+Y)(X'+Z')
// -------------------------
module f05a ( output s, input x, input y, input z );
   assign s = ( x |  y |  z) &
              ( x |  y | ~z) &
              (~x |  y | ~z) &
              (~x | ~y | ~z);
endmodule // f05a

module f05b ( output s, input x, input y, input z );
   assign s = (x | y) & (~x | ~z);
endmodule // f05b

// -------------------------
// modulo de teste
// -------------------------
module test_f06_q02;
   reg  x, y, z;
   wire a1, b1, a2, b2, a3, b3, a4, b4, a5, b5;

   f01a A1 ( a1, x, y, z );  f01b B1 ( b1, x, y, z );
   f02a A2 ( a2, x, y, z );  f02b B2 ( b2, x, y, z );
   f03a A3 ( a3, x, y, z );  f03b B3 ( b3, x, y, z );
   f04a A4 ( a4, x, y, z );  f04b B4 ( b4, x, y, z );
   f05a A5 ( a5, x, y, z );  f05b B5 ( b5, x, y, z );

   integer i;
   initial
   begin : main
      $display("Guia_0602 - Paulo Henrique - 827112");
      $display("Test Q02 - simplificacao por MAXTERMOS (3 variaveis)");
      $display(" x y z | a1 b1 a2 b2 a3 b3 a4 b4 a5 b5");
      for ( i = 0; i < 8; i = i + 1 )
      begin
         { x, y, z } = i[2:0];
         #1 $display("%2b %2b %2b | %2b %2b %2b %2b %2b %2b %2b %2b %2b %2b",
                     x, y, z, a1, b1, a2, b2, a3, b3, a4, b4, a5, b5);
      end
   end
endmodule // test_f06_q02
