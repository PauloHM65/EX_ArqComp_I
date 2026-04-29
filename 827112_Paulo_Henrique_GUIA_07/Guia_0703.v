// -------------------------
// Guia_0703.v  -  Unidade logica (LU): AND/NAND e OR/NOR (com 2 chaves)
// Nome: Paulo Henrique
// Matricula: 827112
// -------------------------
// Sinais de selecao:
//   selPort  -> escolhe a porta dentro do grupo (0=positiva ; 1=negada)
//      grupo AND/NAND : selPort=0 -> AND, selPort=1 -> NAND
//      grupo OR /NOR  : selPort=0 -> OR , selPort=1 -> NOR
//   selGrp   -> escolhe o grupo (0 = OR/NOR ; 1 = AND/NAND)
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
// LU completo
// -------------------------
module lu_a_n_o_n ( output s,
                    input  a, input b,
                    input  selPort, input selGrp );
   wire sAnd, sNand, sOr, sNor;
   wire sGrp1, sGrp0;

// grupo AND/NAND
   and  AND1 ( sAnd,  a, b );
   nand NAND1( sNand, a, b );
   mux2x1 MUX_AN ( sGrp1, sAnd, sNand, selPort );

// grupo OR/NOR
   or   OR1  ( sOr,  a, b );
   nor  NOR1 ( sNor, a, b );
   mux2x1 MUX_ON ( sGrp0, sOr, sNor, selPort );

// selecao de grupo (selGrp=1 -> AND/NAND ; selGrp=0 -> OR/NOR)
   mux2x1 MUX_G ( s, sGrp0, sGrp1, selGrp );
endmodule // lu_a_n_o_n

// -------------------------
// modulo de teste
// -------------------------
module test_lu_a_n_o_n;
   reg  a, b, selPort, selGrp;
   wire s;

   lu_a_n_o_n LU ( s, a, b, selPort, selGrp );

   integer i;
   initial
   begin : main
      $display("Guia_0703 - Paulo Henrique - 827112");
      $display("LU: selGrp=1 AND/NAND ; selGrp=0 OR/NOR  ;  selPort=1 negada / 0 positiva");
      $display(" selGrp selPort a b |  s");
      for ( i = 0; i < 16; i = i + 1 )
      begin
         { selGrp, selPort, a, b } = i[3:0];
         #1 $display("   %1b      %1b    %1b %1b |  %1b",
                       selGrp, selPort, a, b, s);
      end
   end
endmodule // test_lu_a_n_o_n
