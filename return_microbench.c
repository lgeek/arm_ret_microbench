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

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <time.h>
#include <assert.h>

#define ITER 300000000
#define print_timed_run(bench) \
  printf(#bench": "); \
  run_timed(bench, ITER); 

typedef void (*ubench)(uint32_t iter);

extern void bl_bx_lr(uint32_t iter);
extern void b_bx_lr(uint32_t iter);
extern void bl_pop_pc(uint32_t iter);
extern void b_pop_pc(uint32_t iter);
extern void bl_bx_r1(uint32_t iter);
extern void b_bx_r1(uint32_t iter);
extern void bl_ldr_pc(uint32_t iter);
extern void b_ldr_pc(uint32_t iter);

void run_timed(ubench bench, uint32_t iter) {
  struct timespec start, end;
  int ret;
  uint64_t start_ms, end_ms;
  
  ret = clock_gettime(CLOCK_MONOTONIC_RAW, &start);
  assert(ret == 0);
  
  bench(iter);
  
  ret = clock_gettime(CLOCK_MONOTONIC_RAW, &end);
  assert(ret == 0);
  
  start_ms = start.tv_sec * 1000 + start.tv_nsec / 1000000;
  end_ms = end.tv_sec * 1000 + end.tv_nsec / 1000000;
  printf("%llu ms\n", end_ms - start_ms);
}

int main(int argc, char **argv) {
  print_timed_run(bl_bx_lr);
  print_timed_run(b_bx_lr);
  print_timed_run(bl_pop_pc);
  print_timed_run(b_pop_pc);
  print_timed_run(bl_bx_r1);
  print_timed_run(b_bx_r1);
  print_timed_run(bl_ldr_pc);
  print_timed_run(b_ldr_pc);

  return 0;
}
