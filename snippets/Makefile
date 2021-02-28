exec = name.out
sources = $(wildcard src/*.c)
objects = $(sources:.c=.o)
flags = -g -Wall -lm -ldl -fPIC -rdynamic
LPATH = $(HOME)/.local


$(exec): $(objects)
	gcc $(objects) $(flags) -o $(exec)

libname.a: $(objects)
	ar rcs $@ $^

%.o: %.c include/%.h
	gcc -c $(flags) $< -o $@

install:
	make
	make libname.a
	mkdir -p $(LPATH)/include/name
	cp -r ./src/include/* $(LPATH)/include/name/.
	cp ./libname.a $(LPATH)/lib/.
	cp ./name.out $(LPATH)/bin/name

clean:
	-rm *.out
	-rm *.o
	-rm *.a
	-rm src/*.o

lint:
	clang-tidy src/*.c src/include/*.h
