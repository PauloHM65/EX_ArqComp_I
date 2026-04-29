// -------------------------
// Guia_0503.v - apenas portas NAND
// Nome: Paulo_Henrique
// Matricula: 827112
// -------------------------
// f03 : s = ~(~a | b)  =  a & ~b   (De Morgan)
// m a b s
// 0 0 0 0
// 1 0 1 0
// 2 1 0 1
// 3 1 1 0
// -------------------------
module f03a ( output s,
              input  a,
              input  b );
// dados locais
   wire nb, t;
// descrever por portas (apenas NAND)
   nand NAND1 ( nb, b, b );     // nb = ~b
   nand NAND2 ( t,  a, nb );    // t  = ~(a & ~b)
   nand NAND3 ( s,  t, t  );    // s  =  a & ~b   =  ~(~a | b)
endmodule // f03a

// -------------------------
// referencia por expressao
// -------------------------
module f03b ( output s,
              input  a,
              input  b );
   assign s = ~(~a | b);
endmodule // f03b

// -------------------------
// modulo de teste
// -------------------------
module test_f03;
   reg  x, y;
   wire a, b;
   f03a moduloA ( a, x, y );
   f03b moduloB ( b, x, y );

   initial
   begin : main
      $display("Guia_0503 - Paulo Henrique - 827112");
      $display("Test module: s = ~(~a | b)   (somente NAND)");
      $display(" x y | a b");
      $monitor("%4b %4b | %4b %4b", x, y, a, b);
      x = 1'b0; y = 1'b0;
      #1 x = 1'b0; y = 1'b1;
      #1 x = 1'b1; y = 1'b0;
      #1 x = 1'b1; y = 1'b1;
   end
endmodule // test_f03


