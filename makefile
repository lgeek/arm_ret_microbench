CFLAGS=-Os -g

all: return_microbench

return_microbench: return_microbench.c bench.S

clean:
	rm return_microbench
