CC = ../../bin/gcc
CFLAGS = -g -O2 -msoft-float
LDFLAGS = -Wl,-Ttext,0x80140000,-e,_start -msoft-float

PROG = main
OBJS = main.o

all: $(PROG)

$(PROG): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $(OBJS)

%.o: %.c
	$(CC) -c $(CFLAGS) -o $@ $<

clean:
	rm -f $(PROG) $(OBJS)
