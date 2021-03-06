// Main.c - makes LEDG0 on DE2-115 board blink if NIOS II is set up correctly
// for ECE 385 - University of Illinois - Electrical and Computer Engineering
// Author: Zuofu Cheng
volatile unsigned int *LED_PIO = (unsigned int*)0x40;
volatile unsigned int key_held = 0;

int lightMeUpGreen(){
	int i = 0;

	//make a pointer to access the PIO block

	*LED_PIO = 0; //clear all LEDs
	while ( (1+1) != 3) //infinite loop
	{
		for (i = 0; i < 100000; i++); //software delay
		*LED_PIO |= 0x1; //set LSB
		for (i = 0; i < 100000; i++); //software delay
		*LED_PIO &= ~0x1; //clear LSB
	}
	return 1; //never gets here
}

int accumulator(){
	volatile unsigned int *switches_and_keys = (unsigned int*)0x2000;
//	volatile unsigned int *LED_PIO = (unsigned int*)0x40;
	/*
	 * switches_and_keys[3] - KEY3 - Accumulate
	 * switches_and_keys[2] - KEY2 - Reset
	 */

	volatile unsigned int key_2 = (*switches_and_keys & 0x04);
	volatile unsigned int key_3 = (*switches_and_keys & 0x08);
	volatile unsigned int switches_value = (*switches_and_keys>>4) & 0x0FFFF;
//	volatile unsigned int sum = *LED_PIO;

	if (key_2){
		key_held = 2;
	}

	else if (key_3) {
		key_held = 3;
	}

	else {

		if (key_held == 3){
//			*LED_PIO = switches_value;
			*LED_PIO = (*LED_PIO + switches_value) % 256;
			key_held = 0;
		}

		else if (key_held == 2){
//			sum = 0;
			*LED_PIO = 0x0;
			key_held = 0;
		}
	}

	return 1;
}

int main()
{
	while (1 != 2)
//		*LED_PIO = 0xF;
		lightMeUpGreen();
}
