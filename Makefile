HEXFILES = 0_quadratic_s.hex 1_quadratic_s.hex \
           2_max3_s.hex 3_max3_s.hex 4_find_max_s.hex 5_find_max_s.hex 6_fib_rec_s.hex 7_fib_rec_s.hex \
           8_merge_s.hex 9_merge_s.hex 10_merge_s.hex 11_merge_sort_s.hex 12_merge_sort_s.hex

AS = as
OBJDUMP = objdump

%.o: %.s
	${AS} -o $@ $<

%.hex: %.o
	${OBJDUMP} -d $< | python3 makerom3.py > $@	

all : ${HEXFILES}
	
clean:
	rm -rf ${HEXFILES}

