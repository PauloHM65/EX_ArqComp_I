// -------------------------
// Guia_0604.v  -  Simplificacao por MAXTERMOS (4 variaveis x,y,w,z)
// Nome: Paulo Henrique
// Matricula: 827112
// -------------------------
// Em cada item:
//   moduloA -> forma canonica  Pi M (produto apenas dos MAXTERMOS listados)
//   moduloB -> forma simplificada (PoS apos mapa de Veitch-Karnaugh)
// MAXTERMO M_i a partir do mintermo m_i: cada bit 0 -> literal direto,
//   cada bit 1 -> literal complementado.
//   (Ex.: m5 = xywz=0101  ->  M5 = (X + Y' + W + Z'))
// -------------------------

// -------------------------
// a) F(x,y,w,z) = Pi M( 2, 5, 7, 10 )
//   M2  = (X + Y  + W' + Z )
//   M5  = (X + Y' + W  + Z')
//   M7  = (X + Y' + W' + Z')
//   M10 = (X'+ Y  + W' + Z )
// Pares: (m5,m7)=x'yz -> (X+Y'+Z') ; (m2,m10)=y'wz' -> (Y+W'+Z)
// Simplificada: F = (X+Y'+Z')(Y+W'+Z)
// -------------------------
module f01a ( output s, input x, input y, input w, input z );
   assign s = ( x |  y | ~w |  z) &
              ( x | ~y |  w | ~z) &
              ( x | ~y | ~w | ~z) &
              (~x |  y | ~w |  z);
endmodule // f01a

module f01b ( output s, input x, input y, input w, input z );
   assign s = ( x | ~y | ~z) & ( y | ~w | z );
endmodule // f01b

// -------------------------
// b) F(x,y,w,z) = Pi M( 4, 6, 9, 13, 14 )
//   M4  = (X + Y' + W  + Z )
//   M6  = (X + Y' + W' + Z )
//   M9  = (X'+ Y  + W  + Z')
//   M13 = (X'+ Y' + W  + Z')
//   M14 = (X'+ Y' + W' + Z )
// Pares: (m4,m6)=x'yz' -> (X+Y'+Z) ; (m9,m13)=xw'z -> (X'+W+Z') ; (m6,m14)=ywz' -> (Y'+W'+Z)
// Simplificada: F = (X+Y'+Z)(X'+W+Z')(Y'+W'+Z)
// -------------------------
module f02a ( output s, input x, input y, input w, input z );
   assign s = ( x | ~y |  w |  z) &
              ( x | ~y | ~w |  z) &
              (~x |  y |  w | ~z) &
              (~x | ~y |  w | ~z) &
              (~x | ~y | ~w |  z);
endmodule // f02a

module f02b ( output s, input x, input y, input w, input z );
   assign s = ( x | ~y |  z) & (~x |  w | ~z) & (~y | ~w |  z);
endmodule // f02b

// -------------------------
// c) F(x,y,w,z) = Pi M( 4, 7, 8, 12, 15 )
//   M4  = (X + Y' + W  + Z )
//   M7  = (X + Y' + W' + Z')
//   M8  = (X'+ Y  + W  + Z )
//   M12 = (X'+ Y' + W  + Z )
//   M15 = (X'+ Y' + W' + Z')
// Pares: (m4,m12)=yw'z' -> (Y'+W+Z) ; (m8,m12)=xw'z' -> (X'+W+Z) ; (m7,m15)=ywz -> (Y'+W'+Z')
// Simplificada: F = (Y'+W+Z)(X'+W+Z)(Y'+W'+Z')
// -------------------------
module f03a ( output s, input x, input y, input w, input z );
   assign s = ( x | ~y |  w |  z) &
              ( x | ~y | ~w | ~z) &
              (~x |  y |  w |  z) &
              (~x | ~y |  w |  z) &
              (~x | ~y | ~w | ~z);
endmodule // f03a

module f03b ( output s, input x, input y, input w, input z );
   assign s = (~y |  w |  z) & (~x |  w |  z) & (~y | ~w | ~z);
endmodule // f03b

// -------------------------
// d) F(x,y,w,z) = Pi M( 1, 5, 6, 11, 13, 15 )
//   M1  = (X + Y  + W  + Z')
//   M5  = (X + Y' + W  + Z')
//   M6  = (X + Y' + W' + Z )
//   M11 = (X'+ Y  + W' + Z')
//   M13 = (X'+ Y' + W  + Z')
//   M15 = (X'+ Y' + W' + Z')
// Pares e isolado: (m1,m5)=x'w'z->(X+W+Z') ; (m13,m15)=xyz->(X'+Y'+Z') ;
//   (m11,m15)=xwz->(X'+W'+Z') ; m6 isolado -> (X+Y'+W'+Z)
// Simplificada: F = (X+W+Z')(X'+Y'+Z')(X'+W'+Z')(X+Y'+W'+Z)
// -------------------------
module f04a ( output s, input x, input y, input w, input z );
   assign s = ( x |  y |  w | ~z) &
              ( x | ~y |  w | ~z) &
              ( x | ~y | ~w |  z) &
              (~x |  y | ~w | ~z) &
              (~x | ~y |  w | ~z) &
              (~x | ~y | ~w | ~z);
endmodule // f04a

module f04b ( output s, input x, input y, input w, input z );
   assign s = ( x |  w | ~z) & (~x | ~y | ~z) & (~x | ~w | ~z) & ( x | ~y | ~w | z);
endmodule // f04b

// -------------------------
// e) F(x,y,w,z) = Pi M( 2, 3, 6, 8, 11, 12, 14 )
//   M2  = (X + Y  + W' + Z )
//   M3  = (X + Y  + W' + Z')
//   M6  = (X + Y' + W' + Z )
//   M8  = (X'+ Y  + W  + Z )
//   M11 = (X'+ Y  + W' + Z')
//   M12 = (X'+ Y' + W  + Z )
//   M14 = (X'+ Y' + W' + Z )
// Pares: (m3,m11)=y'wz->(Y+W'+Z') ; (m8,m12)=xw'z'->(X'+W+Z) ;
//   (m2,m6)=x'wz'->(X+W'+Z) ; (m6,m14)=ywz'->(Y'+W'+Z)
// Simplificada: F = (Y+W'+Z')(X'+W+Z)(X+W'+Z)(Y'+W'+Z)
// -------------------------
module f05a ( output s, input x, input y, input w, input z );
   assign s = ( x |  y | ~w |  z) &
              ( x |  y | ~w | ~z) &
              ( x | ~y | ~w |  z) &
              (~x |  y |  w |  z) &
              (~x |  y | ~w | ~z) &
              (~x | ~y |  w |  z) &
              (~x | ~y | ~w |  z);
endmodule // f05a

module f05b ( output s, input x, input y, input w, input z );
   assign s = ( y | ~w | ~z) & (~x |  w |  z) & ( x | ~w |  z) & (~y | ~w |  z);
endmodule // f05b

// -------------------------
// modulo de teste
// -------------------------
module test_f06_q04;
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
      $display("Guia_0604 - Paulo Henrique - 827112");
      $display("Test Q04 - simplificacao por MAXTERMOS (4 variaveis)");
      $display(" x y w z | a1 b1 a2 b2 a3 b3 a4 b4 a5 b5");
      for ( i = 0; i < 16; i = i + 1 )
      begin
         { x, y, w, z } = i[3:0];
         #1 $display("%2b %2b %2b %2b | %2b %2b %2b %2b %2b %2b %2b %2b %2b %2b",
                     x, y, w, z, a1, b1, a2, b2, a3, b3, a4, b4, a5, b5);
      end
   end
endmodule // test_f06_q04
