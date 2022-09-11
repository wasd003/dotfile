obj-m += mytimer.o

.PHONY: all test clean ccls

all: 
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean

ccls:
	bear make -B -j12
