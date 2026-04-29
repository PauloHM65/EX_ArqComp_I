// -------------------------
// Guia_0702.v  -  Unidade logica (LU): OR e NOR
// Nome: Paulo Henrique
// Matricula: 827112
// -------------------------
// Saida unica selecionavel:
//   sel = 0 -> OR
//   sel = 1 -> NOR
// Apenas portas nativas; SEM switch-case ou operador ternario.
// -------------------------

// -------------------------
// MUX 2x1
// -------------------------
module mux2x1 ( output s, input a0, input a1, input sel );
   wire nsel, t0, t1;
   not  N1 ( nsel, sel );
   and  A0 ( t0, a0, nsel );
   and  A1 ( t1, a1, sel );
   or   O1 ( s,  t0, t1   );
endmodule // mux2x1

// -------------------------
// LU OR / NOR
// -------------------------
module lu_or_nor ( output s, input a, input b, input sel );
   wire sOr, sNor;
   or   OR1 ( sOr,  a, b );
   nor  NOR1( sNor, a, b );
   mux2x1 MX ( s, sOr, sNor, sel );
endmodule // lu_or_nor

// -------------------------
// modulo de teste
// -------------------------
module test_lu_or_nor;
   reg  a, b, sel;
   wire s;

   lu_or_nor LU ( s, a, b, sel );

   integer i;
   initial
   begin : main
      $display("Guia_0702 - Paulo Henrique - 827112");
      $display("LU: OR e NOR  (sel=0 -> OR, sel=1 -> NOR)");
      $display(" sel a b |  s");
      for ( i = 0; i < 8; i = i + 1 )
      begin
         { sel, a, b } = i[2:0];
         #1 $display("  %1b  %1b %1b |  %1b", sel, a, b, s);
      end
   end
endmodule // test_lu_or_nor
