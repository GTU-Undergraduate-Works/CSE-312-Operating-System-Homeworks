#include <iostream>
#include <cstring>
#include "8080emuCPP.h"
#include "gtuos.h"


uint64_t GTUOS::handleCall(const CPU8080 & cpu){

	uint8_t acumulator = cpu.state->a;
	int cycleTime  = 0;

	switch(acumulator) {

		case PRINT_B: cycleTime = printRegisterBContent(cpu); break;
		case PRINT_MEM: cycleTime = printMem(cpu); break;
		case READ_B: cycleTime = readToBRegiter(cpu); break;
		case READ_MEM: cycleTime = ReadToMem(cpu); break;
		case PRINT_STR: cycleTime = printStr(cpu); break;
		case READ_STR: cycleTime = readStr(cpu); break;
		case GET_RND: cycleTime = getRand(cpu); break;
	}


	return cycleTime;
}


int GTUOS::printRegisterBContent(const CPU8080 & cpu) {
	fprintf(stdout, "%d", cpu.state->b);
	return 10;
}

int GTUOS::printMem(const CPU8080 & cpu) {
	uint16_t address;
	address = (cpu.state->b << 8) | cpu.state->c;
	fprintf(stdout, "%d", cpu.memory->at(address));
	return 10;
}

int GTUOS::readToBRegiter(const CPU8080 & cpu) {
	int tempValue = 0;
	scanf("%d", &tempValue);
	if (tempValue < 0 || tempValue > 255)
		throw "Register Overflow";
	cpu.state->b = tempValue;
	return 10;
}

int GTUOS::ReadToMem(const CPU8080 & cpu) {
	uint16_t address;
	int tempValue = 0;
	scanf("%d", &tempValue);
	if (tempValue < 0 || tempValue > 255)
		throw "Memory Overflow";
	address = (cpu.state->b << 8) | cpu.state->c;
	cpu.memory->at(address) = tempValue;
	return 10;
}

int GTUOS::printStr(const CPU8080 & cpu) {
	uint16_t address;
	address = (cpu.state->b << 8) | cpu.state->c;
	int i = 0;
	while (cpu.memory->at(address + i) != '\0') {
		fprintf(stdout, "%c", cpu.memory->at(address + i));
		i++;
	}
	return 100;
}

int GTUOS::readStr(const CPU8080 & cpu) {
	uint16_t address;
	int i = 0;
	char str[256];
	scanf("%255s", str);	
	address = (cpu.state->b << 8) | cpu.state->c;
	for (i = 0; i < strlen(str); i++) {
		cpu.memory->at(address+i) = str[i];
	}
	cpu.memory->at(address+i) = '\0';
	return 100;
}

int GTUOS::getRand(const CPU8080 & cpu) {
	int tempValue = 0;
	tempValue = rand() % 255;
	cpu.state->b = (uint8_t)tempValue;
	return 5;
}

void GTUOS::saveMemory(const CPU8080 & cpu, FILE* outputFile) {

	int i = 0;
	for (i = 0; i < 0x10000; i++) {
		fprintf(outputFile, "%04x ", cpu.memory->at(i));
		if (i+1% 16 == 0)
			fprintf(outputFile, "\n");
	}
}
