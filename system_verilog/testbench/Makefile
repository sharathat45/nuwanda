BASE_NAME = fib
EXECUTABLE = $(BASE_NAME)
SRC_TB = $(BASE_NAME)_tb.sv
SRC_C = $(BASE_NAME).sv
SRC_H = $(BASE_NAME).h
CC = iverilog
CFLAGS = -g2012

$(EXECUTABLE): $(SRC_C)
	$(CC) $(CFLAGS) -o $(EXECUTABLE) $(SRC_C) 
	
run: $(EXECUTABLE)
	vvp $(EXECUTABLE)

clean:
	rm -f *.bin *.o *.out *.vcd $(EXECUTABLE)

.PHONY: clean