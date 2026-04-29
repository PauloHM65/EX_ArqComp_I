// -------------------------
// Guia_0501.v - apenas portas NAND
// Nome: Paulo_Henrique
// Matricula: 827112
// -------------------------
// f01 : s = ~a & ~b   (equivalente a ~(a | b) - De Morgan)
// m a b s
// 0 0 0 1
// 1 0 1 0
// 2 1 0 0
// 3 1 1 0
// -------------------------
module f01a ( output s,
              input  a,
              input  b );
// dados locais
   wire na, nb, t;
// descrever por portas (apenas NAND)
   nand NAND1 ( na, a, a );      // na = ~a
   nand NAND2 ( nb, b, b );      // nb = ~b
   nand NAND3 ( t,  na, nb );    // t  = ~(~a & ~b)
   nand NAND4 ( s,  t,  t  );    // s  =  ~a & ~b
endmodule // f01a

// -------------------------
// referencia por expressao
// -------------------------
module f01b ( output s,
              input  a,
              input  b );
   assign s = ~a & ~b;
endmodule // f01b

// -------------------------
// modulo de teste
// -------------------------
module test_f01;
   reg  x, y;
   wire a, b;
   f01a moduloA ( a, x, y );
   f01b moduloB ( b, x, y );

   initial
   begin : main
      $display("Guia_0501 - xxx yyy zzz - 999999");
      $display("Test module: s = ~a & ~b   (somente NAND)");
      $display(" x y | a b");
      $monitor("%4b %4b | %4b %4b", x, y, a, b);
      x = 1'b0; y = 1'b0;
      #1 x = 1'b0; y = 1'b1;
      #1 x = 1'b1; y = 1'b0;
      #1 x = 1'b1; y = 1'b1;
   end
endmodule // test_f01
