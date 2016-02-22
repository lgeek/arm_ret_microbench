/*  Copyright (C) 2016, Cosmin Gorgovan <cosmin at linux-geek dot org>
    All rights reserved.

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:

    1. Redistributions of source code must retain the above copyright notice,
       this list of conditions and the following disclaimer.

    2. Redistributions in binary form must reproduce the above copyright
       notice, this list of conditions and the following disclaimer in the
       documentation and/or other materials provided with the distribution.

    3. Neither the name of the copyright holder nor the names of its
       contributors may be used to endorse or promote products derived from
       this software without specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
    AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
    IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
    ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
    LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
    CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
    SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
    INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
    CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
    ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
    POSSIBILITY OF SUCH DAMAGE.    
*/

.syntax unified

/* Single return address */
.align 5
.thumb_func
.global bl_bx_lr
.func bl_bx_lr
.type bl_bx_lr, %function
bl_bx_lr: PUSH {LR}
      r1: SUBS R0, #1
          IT EQ
          POPEQ {PC}
          ADR LR, d1+1
          BL c1
      d1: B r1
      c1: BX LR
.endfunc

.align 5
.global bl_pop_pc
.func bl_pop_pc
.type bl_pop_pc, %function
bl_pop_pc: PUSH {LR}
       r2: SUBS R0, #1
           IT EQ
           POPEQ {PC}
           ADR LR, d2+1
           BL c2
       d2: B r2
       c2: PUSH {LR}
           POP {PC}
.endfunc

.align 5
.thumb_func
.global b_bx_lr
.func b_bx_lr
.type b_bx_lr, %function
b_bx_lr: PUSH {LR}
     r3: SUBS R0, #1
         IT EQ
         POPEQ {PC}
         ADR LR, d3+1
         B.W c3
     d3: B r3
     c3: BX LR
.endfunc

.align 5
.global b_pop_pc
.func b_pop_pc
.type b_pop_pc, %function
b_pop_pc: PUSH {LR}
       r4: SUBS R0, #1
           IT EQ
           POPEQ {PC}
           ADR LR, d4+1
           B.W c4
       d4: B r4
       c4: PUSH {LR}
           POP {PC}
.endfunc

.align 5
.thumb_func
.global bl_bx_r1
.func bl_bx_r1
.type bl_bx_r1, %function
bl_bx_r1: PUSH {LR}
      r5: SUBS R0, #1
          IT EQ
          POPEQ {PC}
          ADR LR, d5+1
          BL c5
      d5: B r5
      c5: MOV R1, LR
          BX R1
.endfunc

.align 5
.thumb_func
.global b_bx_r1
.func b_bx_r1
.type b_bx_r1, %function
b_bx_r1: PUSH {LR}
     r6: SUBS R0, #1
         IT EQ
         POPEQ {PC}
         ADR LR, d6+1
         B.W c6
     d6: B r6
     c6: MOV R1, LR
         BX R1
.endfunc

.global ret_addr
ret_addr: .word 0

.align 5
.thumb_func
.global bl_ldr_pc
.func bl_ldr_pc
.type bl_ldr_pc, %function
bl_ldr_pc: PUSH {LR}
       r7: SUBS R0, #1
           IT EQ
           POPEQ {PC}
           ADR LR, d7+1
           BL c7
       d7: B r7
       c7: LDR R1, =ret_addr
           STR LR, [R1]
           LDR PC, ret_addr
.endfunc

.align 5
.thumb_func
.global b_ldr_pc
.func b_ldr_pc
.type b_ldr_pc, %function
b_ldr_pc: PUSH {LR}
      r8: SUBS R0, #1
          IT EQ
          POPEQ {PC}
          ADR LR, d8+1
          B.W c8
      d8: B r8
      c8: LDR R1, =ret_addr
          STR LR, [R1]
          LDR PC, ret_addr
.endfunc

/* Two return addresses */
.align 5
.thumb_func
.global b_ldr_pc2
.func b_ldr_pc2
.type b_ldr_pc2, %function
b_ldr_pc2: PUSH {LR}
      r9: SUBS R0, #1
          IT EQ
          POPEQ {PC}
          ADR LR, d9+1
          B.W c9
      d9: ADR LR, e9+1
          B.W c9
      e9: B r9
      c9: LDR R1, =ret_addr
          STR LR, [R1]
          LDR PC, ret_addr
.endfunc

//.data
