// -------------------------
// Guia_0603.v  -  Simplificacao por mintermos (4 variaveis x,y,w,z)
// Nome: Paulo Henrique
// Matricula: 827112
// -------------------------
// Layout do mapa (xy linhas, wz colunas; ordem 00,01,11,10):
//   xy\wz | 00 01 11 10
//   00    | 0  1  3  2
//   01    | 4  5  7  6
//   11    | 12 13 15 14
//   10    | 8  9  11 10
// -------------------------

// -------------------------
// a) f(x,y,w,z) = Sum m( 1, 2, 5, 6, 13, 14 )
// Pares (sem bloco de 4 disponivel pois colunas 01 e 10 nao sao adjacentes):
//   (m1,m5)=x'w'z ; (m5,m13)=yw'z ; (m2,m6)=x'wz' ; (m6,m14)=ywz'
// Simplificada: f = x'w'z + yw'z + x'wz' + ywz'
//             ( = (x' + y) (w'z + wz') )
// -------------------------
module f01a ( output s, input x, input y, input w, input z );
   assign s = (~x & ~y & ~w &  z) | (~x & ~y &  w & ~z) |
              (~x &  y & ~w &  z) | (~x &  y &  w & ~z) |
              ( x &  y & ~w &  z) | ( x &  y &  w & ~z);
endmodule // f01a

module f01b ( output s, input x, input y, input w, input z );
   assign s = (~x & ~w & z) | (y & ~w & z) |
              (~x &  w & ~z) | (y &  w & ~z);
endmodule // f01b

// -------------------------
// b) f(x,y,w,z) = Sum m( 0, 1, 3, 7, 9, 13, 15 )
// Cobertura:
//   (m0,m1) = x'y'w'
//   (m3,m7) = x'wz
//   (m9,m13)= xw'z
//   (m7,m15) -> redundante; ywz cobre m7,m15 mas m7 ja em x'wz
// Pares essenciais: x'y'w' , x'wz , xw'z , ywz
// Simplificada: f = x'y'w' + x'wz + xw'z + ywz
// -------------------------
module f02a ( output s, input x, input y, input w, input z );
   assign s = (~x & ~y & ~w & ~z) | (~x & ~y & ~w &  z) |
              (~x & ~y &  w &  z) | (~x &  y &  w &  z) |
              ( x & ~y & ~w &  z) | ( x &  y & ~w &  z) |
              ( x &  y &  w &  z);
endmodule // f02a

module f02b ( output s, input x, input y, input w, input z );
   assign s = (~x & ~y & ~w) | (~x & w & z) |
              ( x & ~w &  z) | ( y & w & z);
endmodule // f02b

// -------------------------
// c) f(x,y,w,z) = Sum m( 0, 1, 2, 7, 10, 12, 13, 15 )
// Implicantes essenciais:
//   m0,m1   -> x'y'w'
//   m2,m10  -> y'wz'        (linhas 00 e 10 sao adjacentes por wrap)
//   m12,m13 -> xyw'
//   m7,m15  -> ywz
// Simplificada: f = x'y'w' + y'wz' + xyw' + ywz
// -------------------------
module f03a ( output s, input x, input y, input w, input z );
   assign s = (~x & ~y & ~w & ~z) | (~x & ~y & ~w &  z) |
              (~x & ~y &  w & ~z) | (~x &  y &  w &  z) |
              ( x & ~y &  w & ~z) | ( x &  y & ~w & ~z) |
              ( x &  y & ~w &  z) | ( x &  y &  w &  z);
endmodule // f03a

module f03b ( output s, input x, input y, input w, input z );
   assign s = (~x & ~y & ~w) | (~y & w & ~z) |
              ( x &  y & ~w) | ( y & w &  z);
endmodule // f03b

// -------------------------
// d) f(x,y,w,z) = Sum m( 2, 3, 5, 7, 11, 12, 14 )
// Pares essenciais:
//   m2,m3  -> x'y'w
//   m5,m7  -> x'yz
//   m3,m11 -> y'wz   (linhas 00 e 10 sao adjacentes por wrap)
//   m12,m14-> xyz'   (colunas 00 e 10 sao adjacentes por wrap)
// Simplificada: f = x'y'w + x'yz + y'wz + xyz'
// -------------------------
module f04a ( output s, input x, input y, input w, input z );
   assign s = (~x & ~y &  w & ~z) | (~x & ~y &  w &  z) |
              (~x &  y & ~w &  z) | (~x &  y &  w &  z) |
              ( x & ~y &  w &  z) |
              ( x &  y & ~w & ~z) | ( x &  y &  w & ~z);
endmodule // f04a

module f04b ( output s, input x, input y, input w, input z );
   assign s = (~x & ~y &  w) | (~x & y & z) |
              (~y &  w &  z) | ( x & y & ~z);
endmodule // f04b

// -------------------------
// e) f(x,y,w,z) = Sum m( 0, 1, 3, 6, 7, 9, 11, 13 )
// Bloco de 4: m1,m3,m9,m11 -> y'z   (linhas 00 e 10 adjacentes por wrap)
// Pares restantes:
//   m0,m1  -> x'y'w'
//   m6,m7  -> x'yw
//   m9,m13 -> xw'z
// Simplificada: f = y'z + x'y'w' + x'yw + xw'z
// -------------------------
module f05a ( output s, input x, input y, input w, input z );
   assign s = (~x & ~y & ~w & ~z) | (~x & ~y & ~w &  z) |
              (~x & ~y &  w &  z) | (~x &  y &  w & ~z) |
              (~x &  y &  w &  z) | ( x & ~y & ~w &  z) |
              ( x & ~y &  w &  z) | ( x &  y & ~w &  z);
endmodule // f05a

module f05b ( output s, input x, input y, input w, input z );
   assign s = (~y & z) | (~x & ~y & ~w) |
              (~x &  y &  w) | ( x & ~w & z);
endmodule // f05b

// -------------------------
// modulo de teste
// -------------------------
module test_f06_q03;
   reg  x, y, w, z;
   wire a1, b1, a2, b2, a3, b3, a4, b4, a5, b5;

   f01a A1 ( a1, x, y, w, z );  f01b B1 ( b1, x, y, w, z );
   f02a A2 ( a2, x, y, w, z );  f02b B2 ( b2, x, y, w, z );
   f03a A3 ( a3, x, y, w, z );  f03b B3 ( b3, x, y, w, z );
   f04a A4 ( a4, x, y, w, z );  f04b B4 ( b4, x, y, w, z );
   f05a A5 ( a5, x, y, w, z );  f05b B5 ( b5, x, y, w, z );

   integer i;
   initial
   begin : main
      $display("Guia_0603 - Paulo Henrique - 827112");
      $display("Test Q03 - simplificacao por mintermos (4 variaveis)");
      $display(" x y w z | a1 b1 a2 b2 a3 b3 a4 b4 a5 b5");
      for ( i = 0; i < 16; i = i + 1 )
      begin
         { x, y, w, z } = i[3:0];
         #1 $display("%2b %2b %2b %2b | %2b %2b %2b %2b %2b %2b %2b %2b %2b %2b",
                     x, y, w, z, a1, b1, a2, b2, a3, b3, a4, b4, a5, b5);
      end
   end
endmodule // test_f06_q03
