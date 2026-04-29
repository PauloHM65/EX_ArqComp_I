// -------------------------
// Guia_0701.v  -  Unidade logica (LU): AND e NAND
// Nome: Paulo Henrique
// Matricula: 827112
// -------------------------
// Inicialmente duas saidas independentes (paralelas):
//   sAnd  =  a & b
//   sNand = ~(a & b)
// Em seguida, uma saida unica selecionavel:
//   sel = 0 -> AND
//   sel = 1 -> NAND
// MUX2x1: s = sa*sel' + sb*sel
// Apenas portas nativas; SEM switch-case ou operador ternario.
// -------------------------

// -------------------------
// LU paralelo (2 saidas)
// -------------------------
module lu_and_nand_par ( output sAnd, output sNand,
                         input  a,    input  b );
   and AND1  ( sAnd,  a, b );
   nand NAND1( sNand, a, b );
endmodule // lu_and_nand_par

// -------------------------
// MUX 2x1 (com portas nativas)
//   sel=0 -> a0 ; sel=1 -> a1
// -------------------------
module mux2x1 ( output s, input a0, input a1, input sel );
   wire nsel, t0, t1;
   not  N1 ( nsel, sel );
   and  A0 ( t0,  a0, nsel );
   and  A1 ( t1,  a1, sel );
   or   O1 ( s,   t0, t1   );
endmodule // mux2x1

// -------------------------
// LU com saida unica selecionavel
// -------------------------
module lu_and_nand_sel ( output s, input a, input b, input sel );
   wire sAnd, sNand;
   lu_and_nand_par PAR ( sAnd, sNand, a, b );
   mux2x1          MX  ( s, sAnd, sNand, sel );
endmodule // lu_and_nand_sel

// -------------------------
// modulo de teste
// -------------------------
module test_lu_and_nand;
   reg  a, b, sel;
   wire sAnd, sNand, sSel;

   lu_and_nand_par PAR ( sAnd, sNand, a, b );
   lu_and_nand_sel SEL ( sSel, a, b, sel );

   integer i;
   initial
   begin : main
      $display("Guia_0701 - Paulo Henrique - 827112");
      $display("LU: AND e NAND  (sel=0 -> AND, sel=1 -> NAND)");
      $display(" sel a b | sAnd sNand | sSel");
      for ( i = 0; i < 8; i = i + 1 )
      begin
         { sel, a, b } = i[2:0];
         #1 $display("  %1b  %1b %1b |  %1b    %1b   |  %1b",
                      sel, a, b, sAnd, sNand, sSel);
      end
   end
endmodule // test_lu_and_nand
