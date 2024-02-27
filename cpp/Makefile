# data_struct_2 OOP_2
BASE_NAME = try
EXECUTABLE = $(BASE_NAME)
SRC_C = $(BASE_NAME).cpp
SRC_H = $(BASE_NAME).h
CC = g++
CFLAGS = -g -std=c++11 
#-Wall -Wshadow -Wvla -Werror -pedantic -Wno-error=unused-variable

# CC = gcc

$(EXECUTABLE): $(SRC_C)
	$(CC) -o $(EXECUTABLE) $(SRC_C) $(CFLAGS)

run: $(EXECUTABLE)
	./$(EXECUTABLE)

clean:
	rm -f *.bin *.o *.out $(EXECUTABLE) OOP_0 OOP_1 OOP_2 data_struct_0 data_struct_1 data_struct_2 try algo

.PHONY: clean