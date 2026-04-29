// -------------------------
// Guia_0705.v  -  Unidade logica (LU): NOT, AND, NAND, OR, NOR, XOR, XNOR (MUX 8x1)
// Nome: Paulo Henrique
// Matricula: 827112
// -------------------------
// Selecao com 3 bits (e2 e1 e0). Sao 7 operacoes nativas e 1 codigo de sobra
// que, conforme dica do enunciado, foi empregado para negar o "outro" operando:
//   000 -> NOT a
//   001 -> NOT b           (codigo de sobra: negacao do outro operando)
//   010 -> AND   ( a & b )
//   011 -> NAND  ( ~(a & b) )
//   100 -> OR    ( a | b )
//   101 -> NOR   ( ~(a | b) )
//   110 -> XOR   ( a ^ b )
//   111 -> XNOR  ( ~(a ^ b) )
// Apenas portas nativas; SEM switch-case ou operador ternario.
// -------------------------

// -------------------------
// MUX 8x1 com portas nativas
// -------------------------
module mux8x1 ( output s,
                input  a0, input a1, input a2, input a3,
                input  a4, input a5, input a6, input a7,
                input  e2, input e1, input e0 );
   wire ne2, ne1, ne0;
   wire t0, t1, t2, t3, t4, t5, t6, t7;
   wire u0, u1, u2, u3;
   wire v0, v1;
   not N2 ( ne2, e2 );
   not N1 ( ne1, e1 );
   not N0 ( ne0, e0 );
   and AA0 ( t0, a0, ne2, ne1, ne0 );
   and AA1 ( t1, a1, ne2, ne1,  e0 );
   and AA2 ( t2, a2, ne2,  e1, ne0 );
   and AA3 ( t3, a3, ne2,  e1,  e0 );
   and AA4 ( t4, a4,  e2, ne1, ne0 );
   and AA5 ( t5, a5,  e2, ne1,  e0 );
   and AA6 ( t6, a6,  e2,  e1, ne0 );
   and AA7 ( t7, a7,  e2,  e1,  e0 );
   or  O01 ( u0, t0, t1 );
   or  O23 ( u1, t2, t3 );
   or  O45 ( u2, t4, t5 );
   or  O67 ( u3, t6, t7 );
   or  Oh1 ( v0, u0, u1 );
   or  Oh2 ( v1, u2, u3 );
   or  Otop( s,  v0, v1 );
endmodule // mux8x1

// -------------------------
// LU 7x1 (8 codigos, 1 sobrando)
// -------------------------
module lu_q05 ( output s, input a, input b,
                input  e2, input e1, input e0 );
   wire nA, nB, sAnd, sNand, sOr, sNor, sXor, sXnor;
   not  N1   ( nA,    a );
   not  N2   ( nB,    b );
   and  AND1 ( sAnd,  a, b );
   nand NAND1( sNand, a, b );
   or   OR1  ( sOr,   a, b );
   nor  NOR1 ( sNor,  a, b );
   xor  XOR1 ( sXor,  a, b );
   xnor XNOR1( sXnor, a, b );
   mux8x1 MX ( s, nA, nB, sAnd, sNand, sOr, sNor, sXor, sXnor,
               e2, e1, e0 );
endmodule // lu_q05

// -------------------------
// modulo de teste
// -------------------------
module test_lu_q05;
   reg  a, b, e2, e1, e0;
   wire s;

   lu_q05 LU ( s, a, b, e2, e1, e0 );

   integer i;
   initial
   begin : main
      $display("Guia_0705 - Paulo Henrique - 827112");
      $display("LU 8x1: 000=NOTa 001=NOTb 010=AND 011=NAND 100=OR 101=NOR 110=XOR 111=XNOR");
      $display(" e2 e1 e0  a b |  s");
      for ( i = 0; i < 32; i = i + 1 )
      begin
         { e2, e1, e0, a, b } = i[4:0];
         #1 $display(" %1b  %1b  %1b   %1b %1b |  %1b",
                      e2, e1, e0, a, b, s);
      end
   end
endmodule // test_lu_q05
