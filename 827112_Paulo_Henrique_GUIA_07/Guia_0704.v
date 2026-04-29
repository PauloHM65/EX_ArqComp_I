// -------------------------
// Guia_0704.v  -  Unidade logica (LU): OR/NOR e XOR/XNOR  (MUX 4x1)
// Nome: Paulo Henrique
// Matricula: 827112
// -------------------------
// Codigo de selecao (2 bits e1 e0):
//   00 -> XOR
//   01 -> XNOR
//   10 -> NOR
//   11 -> OR
// Apenas portas nativas; SEM switch-case ou operador ternario.
// -------------------------

// -------------------------
// MUX 4x1 (com portas nativas)
//   sel = 00 -> a0 ;  01 -> a1 ;  10 -> a2 ;  11 -> a3
// -------------------------
module mux4x1 ( output s,
                input  a0, input a1, input a2, input a3,
                input  e1, input e0 );
   wire ne1, ne0;
   wire t0, t1, t2, t3;
   wire u0, u1;
   not  NN1 ( ne1, e1 );
   not  NN0 ( ne0, e0 );
   and  AA0 ( t0, a0, ne1, ne0 );
   and  AA1 ( t1, a1, ne1,  e0 );
   and  AA2 ( t2, a2,  e1, ne0 );
   and  AA3 ( t3, a3,  e1,  e0 );
   or   OO1 ( u0, t0, t1 );
   or   OO2 ( u1, t2, t3 );
   or   OO3 ( s,  u0, u1 );
endmodule // mux4x1

// -------------------------
// LU OR/NOR/XOR/XNOR
// -------------------------
module lu_or_nor_xor_xnor ( output s,
                            input  a, input b,
                            input  e1, input e0 );
   wire sOr, sNor, sXor, sXnor;
   or   OR1  ( sOr,   a, b );
   nor  NOR1 ( sNor,  a, b );
   xor  XOR1 ( sXor,  a, b );
   xnor XNOR1( sXnor, a, b );
   mux4x1 MX ( s, sXor, sXnor, sNor, sOr, e1, e0 );
endmodule // lu_or_nor_xor_xnor

// -------------------------
// modulo de teste
// -------------------------
module test_lu_q04;
   reg  a, b, e1, e0;
   wire s;

   lu_or_nor_xor_xnor LU ( s, a, b, e1, e0 );

   integer i;
   initial
   begin : main
      $display("Guia_0704 - Paulo Henrique - 827112");
      $display("LU 4x1: 00=XOR  01=XNOR  10=NOR  11=OR");
      $display(" e1 e0 a b |  s");
      for ( i = 0; i < 16; i = i + 1 )
      begin
         { e1, e0, a, b } = i[3:0];
         #1 $display(" %1b  %1b  %1b %1b |  %1b", e1, e0, a, b, s);
      end
   end
endmodule // test_lu_q04
