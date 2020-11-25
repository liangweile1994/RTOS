#include "cpu.h"


#define		TASK1_STK_SIZE				128
#define 	TASK2_STK_SIZE				128

static		CPU_STK				Task1Stk[TASK1_STK_SIZE];
static		CPU_STK				Task2Stk[TASK2_STK_SIZE];



uint32_t flag1;
uint32_t flag2;


void Task1(void *p_arg)
{
	for(;;)
	{
		flag11 = 1;
		delay(100);
		flag11 = 0;
		delay(100);
	}
}


void Task2(void *p_arg)
{
	for(;;)
	{
		flag12 = 1;
		delay(100);
		flag12 = 0;
		delay(100);
	}
}

int main(void)
{
	for(;;)
	{
		
	}
}
