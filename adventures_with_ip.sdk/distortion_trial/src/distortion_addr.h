/*
 * distortion_addr.h
 *
 *  Created on: 25 May 2020
 *      Author: eseny
 */

#ifndef DISTORTION_ADDR_H_
#define DISTORTION_ADDR_H_

#define  IPCore_Reset_distortion     0x0  //write 0x1 to bit 0 to reset IP core
#define  IPCore_Enable_distortion    0x4  //enabled (by default) when bit 0 is 0x1
#define  IPCore_Strobe_distortion    0x8  //write 1 to bit 0 after write all input data
#define  IPCore_Ready_distortion     0xC  //wait until bit 0 is 1 before read output data
#define  IPCore_Timestamp_distortion 0x10
#define  Fin__Data_distortion        0x100  //data register for port x(k)
#define  Fout__Data_distortion       0x104  //data register for port d(k)


#endif /* DISTORTION_ADDR_H_ */
