CROSS_COMPILE = arm-none-eabi-

CC = $(CROSS_COMPILE)gcc
AR = $(CROSS_COMPILE)ar

# build for Cortex-M4F
CPUFLAGS = -mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16

CFLAGS = -ggdb3 -Og -fmessage-length=0 -fsigned-char -ffunction-sections \
         -fdata-sections -fno-move-loop-invariants

SRCS = $(wildcard FreeRTOS/*.c)
OBJS = $(patsubst %.c,%.o,$(SRCS))
DEPS = $(patsubst %.c,%.d,$(SRCS))

TARGET = libFreeRTOS.a

all: $(OBJS) Makefile
	$(AR) rcs $(TARGET) $(OBJS)

clean:
	rm -rf $(OBJS) $(DEPS) $(TARGET)

%.o: %.c Makefile
	$(CC) -Wall -Wextra -IFreeRTOS/include $(CPUFLAGS) $(CFLAGS) -MMD -c -o $@ $<

-include $(DEPS)