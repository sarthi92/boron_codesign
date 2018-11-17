/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* XILINX CONSORTIUM BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_io.h"
#include "xbasic_types.h"
#include "xparameters.h"
#include "sleep.h"

u32 *baseaddr_p = (u32 *)0x43c00000;
void Encrypt(u32 plainText1,u32 plainText0,u32 masterKey2,u32 masterKey1,u32 masterKey0)
{
	u32 data;

	Xil_Out32((u32)(baseaddr_p+3),plainText1);
	Xil_Out32((u32)(baseaddr_p+4),plainText0);
	Xil_Out32((u32)(baseaddr_p+5),masterKey2);
	Xil_Out32((u32)(baseaddr_p+6),masterKey1);
	Xil_Out32((u32)(baseaddr_p+7),masterKey0);
	Xil_Out32((u32)(baseaddr_p+8),1);
	Xil_Out32((u32)(baseaddr_p+9),1);
	Xil_Out32((u32)(baseaddr_p+9),0);

	usleep(1000000);
	xil_printf("\nStarting Encryption...");

	data=Xil_In32((u32)(baseaddr_p));
	xil_printf("\n%08x",data);
	data=Xil_In32((u32)(baseaddr_p+1));
	xil_printf("%08x",data);

	xil_printf("\nDone.");
}
void Decrypt(u32 plainText1,u32 plainText0,u32 masterKey2,u32 masterKey1,u32 masterKey0)
{
	u32 data;

		Xil_Out32((u32)(baseaddr_p+3),plainText1);
		Xil_Out32((u32)(baseaddr_p+4),plainText0);
		Xil_Out32((u32)(baseaddr_p+5),masterKey2);
		Xil_Out32((u32)(baseaddr_p+6),masterKey1);
		Xil_Out32((u32)(baseaddr_p+7),masterKey0);
		Xil_Out32((u32)(baseaddr_p+8),0);
		Xil_Out32((u32)(baseaddr_p+9),1);
		Xil_Out32((u32)(baseaddr_p+9),0);

		usleep(1000000);
		xil_printf("\nStarting Decryption...");

		data=Xil_In32((u32)(baseaddr_p));
		xil_printf("\n%08x",data);
		data=Xil_In32((u32)(baseaddr_p+1));
		xil_printf("%08x",data);

		xil_printf("\nDone.");
}
int main()
{
    init_platform();

    Encrypt(0x00000000,0x00000000,0x00000000,0x00000000,0x00000000);
    Encrypt(0x01234567,0x89abcdef,0x00000000,0x00000000,0x00000000);

    Decrypt(0x3CF72A8B,0x7518E6F7,0x00000000,0x00000000,0x00000000);
    Decrypt(0x5A664928,0xB961C619,0x00000000,0x00000000,0x00000000);

    cleanup_platform();
    return 0;
}
