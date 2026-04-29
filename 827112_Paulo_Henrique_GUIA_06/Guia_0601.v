// -------------------------
// Guia_0601.v  -  Simplificacao por mintermos (mapa de Veitch-Karnaugh, 3 variaveis)
// Nome: Paulo Henrique
// Matricula: 827112
// -------------------------
// Para cada item (a..e):
//   moduloA descreve a forma canonica (soma dos mintermos)
//   moduloB descreve a forma simplificada
// Layout do mapa de Veitch-Karnaugh (xy versus z):
//   xy\z |  0  |  1
//   00   | m0  | m1
//   01   | m2  | m3
//   11   | m6  | m7
//   10   | m4  | m5
// -------------------------

// -------------------------
// a) f(x,y,z) = Sum m( 1, 5, 7 )
// K-map:
//   xy\z | 0 1
//   00   | 0 1   <- m1
//   01   | 0 0
//   11   | 0 1   <- m7
//   10   | 0 1   <- m5
// Pares: (m1,m5)=y'z ; (m5,m7)=xz
// Simplificada: f = y'z + xz   ( = z(x + y') )
// -------------------------
module f01a ( output s, input x, input y, input z );
   assign s = (~x & ~y &  z) |
              ( x & ~y &  z) |
              ( x &  y &  z);
endmodule // f01a

module f01b ( output s, input x, input y, input z );
   assign s = (~y & z) | (x & z);
endmodule // f01b

// -------------------------
// b) f(x,y,z) = Sum m( 0, 4, 6 )
// K-map:
//   xy\z | 0 1
//   00   | 1 0   <- m0
//   01   | 0 0
//   11   | 1 0   <- m6
//   10   | 1 0   <- m4
// Pares: (m0,m4)=y'z' ; (m4,m6)=xz'
// Simplificada: f = y'z' + xz'   ( = z'(x + y') )
// -------------------------
module f02a ( output s, input x, input y, input z );
   assign s = (~x & ~y & ~z) |
              ( x & ~y & ~z) |
              ( x &  y & ~z);
endmodule // f02a

module f02b ( output s, input x, input y, input z );
   assign s = (~y & ~z) | (x & ~z);
endmodule // f02b

// -------------------------
// c) f(x,y,z) = Sum m( 1, 4, 5, 6 )
// K-map:
//   xy\z | 0 1
//   00   | 0 1   <- m1
//   01   | 0 0
//   11   | 1 0   <- m6
//   10   | 1 1   <- m4,m5
// Pares: (m1,m5)=y'z ; (m4,m6)=xz'
// Simplificada: f = y'z + xz'
// -------------------------
module f03a ( output s, input x, input y, input z );
   assign s = (~x & ~y &  z) |
              ( x & ~y & ~z) |
              ( x & ~y &  z) |
              ( x &  y & ~z);
endmodule // f03a

module f03b ( output s, input x, input y, input z );
   assign s = (~y & z) | (x & ~z);
endmodule // f03b

// -------------------------
// d) f(x,y,z) = Sum m( 1, 2, 4, 5 )
// K-map:
//   xy\z | 0 1
//   00   | 0 1   <- m1
//   01   | 1 0   <- m2
//   11   | 0 0
//   10   | 1 1   <- m4,m5
// Pares: (m1,m5)=y'z ; (m4,m5)=xy' ; m2 isolado=x'yz'
// Simplificada: f = y'z + xy' + x'yz'
// -------------------------
module f04a ( output s, input x, input y, input z );
   assign s = (~x & ~y &  z) |
              (~x &  y & ~z) |
              ( x & ~y & ~z) |
              ( x & ~y &  z);
endmodule // f04a

module f04b ( output s, input x, input y, input z );
   assign s = (~y & z) | (x & ~y) | (~x & y & ~z);
endmodule // f04b

// -------------------------
// e) f(x,y,z) = Sum m( 0, 2, 6, 7 )
// K-map:
//   xy\z | 0 1
//   00   | 1 0   <- m0
//   01   | 1 0   <- m2
//   11   | 1 1   <- m6,m7
//   10   | 0 0
// Pares: (m0,m2)=x'z' ; (m6,m7)=xy
// Simplificada: f = x'z' + xy
// -------------------------
module f05a ( output s, input x, input y, input z );
   assign s = (~x & ~y & ~z) |
              (~x &  y & ~z) |
              ( x &  y & ~z) |
              ( x &  y &  z);
endmodule // f05a

module f05b ( output s, input x, input y, input z );
   assign s = (~x & ~z) | (x & y);
endmodule // f05b

// -------------------------
// modulo de teste
// -------------------------
module test_f06_q01;
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
      $display("Guia_0601 - Paulo Henrique - 827112");
      $display("Test Q01 - simplificacao por mintermos (3 variaveis)");
      $display(" x y z |  a  b   a) Sum(1,5,7)");
      $display("       |  a  b   b) Sum(0,4,6)");
      $display("       |  a  b   c) Sum(1,4,5,6)");
      $display("       |  a  b   d) Sum(1,2,4,5)");
      $display("       |  a  b   e) Sum(0,2,6,7)");
      $display(" x y z | a1 b1 a2 b2 a3 b3 a4 b4 a5 b5");
      for ( i = 0; i < 8; i = i + 1 )
      begin
         { x, y, z } = i[2:0];
         #1 $display("%2b %2b %2b | %2b %2b %2b %2b %2b %2b %2b %2b %2b %2b",
                     x, y, z, a1, b1, a2, b2, a3, b3, a4, b4, a5, b5);
      end
   end
endmodule // test_f06_q01
