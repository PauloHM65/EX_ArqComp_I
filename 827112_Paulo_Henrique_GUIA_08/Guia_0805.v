// -------------------------
// Guia_0805.v  -  Unidade logica (LU): complemento de 2 de valor binario de 6 bits
// Nome: Paulo Henrique
// Matricula: 827112
// -------------------------
// Tecnica: complemento-de-1 (inverter todos os bits) + 1, usando somador completo.
//   c1 = ~x          (subcircuito de complemento de 1)
//   c2 = c1 + 1      (somador completo, vai-um inicial = 1 ou y = 0...001)
// Apenas portas nativas.
// -------------------------

// -------------------------
// half adder
// -------------------------
module halfAdder ( output s1, output s0, input a, input b );
   xor XOR1 ( s0, a, b );
   and AND1 ( s1, a, b );
endmodule // halfAdder

// -------------------------
// full adder
// -------------------------
module fullAdder ( output s1, output s0,
                   input a, input b, input carryIn );
   wire t0, t1, t2;
   halfAdder HA1 ( t1, t0,   a, b      );
   halfAdder HA2 ( t2, s0,   t0, carryIn );
   or OR1 ( s1, t1, t2 );
endmodule // fullAdder

// -------------------------
// complemento de 1 (subcircuito)
//   c1[i] = NOT x[i]   para i = 0..5
// -------------------------
module compl1_6 ( output [5:0] c1, input [5:0] x );
   not N0 ( c1[0], x[0] );
   not N1 ( c1[1], x[1] );
   not N2 ( c1[2], x[2] );
   not N3 ( c1[3], x[3] );
   not N4 ( c1[4], x[4] );
   not N5 ( c1[5], x[5] );
endmodule // compl1_6

// -------------------------
// complemento de 2  (6 bits)
//   c2 = ~x + 1
// Implementacao: somar 1 ao complemento de 1 usando vai-um inicial = 1
// (no LSB usamos um fullAdder com carryIn=1 e b=0).
// -------------------------
module compl2_6 ( output [5:0] c2, output vaiUmFinal, input [5:0] x );
   wire [5:0] c1;
   wire [5:0] carry;

   compl1_6 CP1 ( c1, x );

   fullAdder F0 ( carry[0], c2[0], c1[0], 1'b0, 1'b1   ); // soma 1 (carry in=1)
   fullAdder F1 ( carry[1], c2[1], c1[1], 1'b0, carry[0] );
   fullAdder F2 ( carry[2], c2[2], c1[2], 1'b0, carry[1] );
   fullAdder F3 ( carry[3], c2[3], c1[3], 1'b0, carry[2] );
   fullAdder F4 ( carry[4], c2[4], c1[4], 1'b0, carry[3] );
   fullAdder F5 ( carry[5], c2[5], c1[5], 1'b0, carry[4] );
   assign vaiUmFinal = carry[5];
endmodule // compl2_6

// -------------------------
// modulo de teste
// -------------------------
module test_compl2_6;
   reg  [5:0] x;
   wire [5:0] c2;
   wire       vaiUmFinal;

   compl2_6 C2 ( c2, vaiUmFinal, x );

   initial
   begin : main
      $display("Guia_0805 - Paulo Henrique - 827112");
      $display("LU: complemento de 2 de valor binario de 6 bits");
      $display("    x      |   c2    | vaiUmFinal");
      x = 6'b000000;
      #1 $display(" %6b   | %6b  |    %1b      (-0  =  0)", x, c2, vaiUmFinal);
      x = 6'b000001;
      #1 $display(" %6b   | %6b  |    %1b      (-1)", x, c2, vaiUmFinal);
      x = 6'b000010;
      #1 $display(" %6b   | %6b  |    %1b      (-2)", x, c2, vaiUmFinal);
      x = 6'b000101;
      #1 $display(" %6b   | %6b  |    %1b      (-5)", x, c2, vaiUmFinal);
      x = 6'b001111;
      #1 $display(" %6b   | %6b  |    %1b      (-15)", x, c2, vaiUmFinal);
      x = 6'b011111;
      #1 $display(" %6b   | %6b  |    %1b      (-31)", x, c2, vaiUmFinal);
      x = 6'b100000;
      #1 $display(" %6b   | %6b  |    %1b      (-(-32) = -32 em 6b)", x, c2, vaiUmFinal);
      x = 6'b111111;
      #1 $display(" %6b   | %6b  |    %1b      (-(-1) = 1)", x, c2, vaiUmFinal);
   end
endmodule // test_compl2_6
