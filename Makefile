COMPILE_FLAGS = -Wall -Wextra -Werror -Wpedantic -std=c11
MAXIMUM_PAIN = -fsanitize=leak -fsanitize=address -fsanitize=undefined -fsanitize=unreachable -fno-sanitize-recover -fstack-protector -g
GCOVFLAGS = -fprofile-arcs -ftest-coverage
GCOVPATH = gcovr
GCOVPATH1 = ~/.local/bin/gcovr
LIBSFLAGS = -lcheck -lsubunit -lm -lrt -lpthread -D_GNU_SOURCE
CLANG = clang-format -style=Google

SRC = $(wildcard *.c)
OBJ = $(SRC:.c=.o)

all: clean s21_math.a test gcov_report

%.o: %.c
	gcc $(COMPILE_FLAGS) -c $< -o $@

s21_math.a: $(OBJ)
	ar rcs $@ $^
	rm -f $(OBJ)

test: s21_math.a
	gcc $(COMPILE_FLAGS) tests/unit_tests.c s21_math.a -o test.out -lcheck -lrt -lm -lsubunit
	./test.out
	# valgrind --tool=memcheck --leak-check=yes ./test.out

gcov_report: $(OBJ)
	gcc --coverage *.c tests/unit_tests.c -o test.out s21_math.a $(LIBSFLAGS)
	./test.out
	$(GCOVPATH) -r . --html-details -o gcov_report.html
	mkdir GCOVRreport
	mv *.html *.css GCOVRreport
	rm -rf *.gcno *.gcda *.info report.out *.gcov
	open GCOVRreport/gcov_report.html

valgrind:
	valgrind --tool=memcheck --leak-check=yes ./test.out 2>&1 | grep "ERROR SUMMARY:"

style:
	$(CLANG) -i *.c *.h tests/*.c
	$(CLANG) -n *.c *.h tests/*.c

clean: 
	rm -f *.o *.a *.gcno *.gcda tests/*.gcno tests/*.gcda *.out *.gcov *.html *.css
	rm -rf GCOVRreport
