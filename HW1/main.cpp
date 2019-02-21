#include <iostream>
#include <string>
#include <fstream>
#include "8080emuCPP.h"
#include "gtuos.h"
#include "memory.h"

using namespace std;

	// This is just a sample main function, you should rewrite this file to handle problems 
	// with new multitasking and virtual memory additions.
int main (int argc, char**argv)
{
	if (argc != 3){
		std::cerr << "Usage: prog exeFile debugOption\n";
		exit(1); 
	}

	string filename = "exe.mem";
	FILE* outputFile;


	int DEBUG = atoi(argv[2]);
	int totalCycleTime = 0;

	memory mem;
	CPU8080 theCPU(&mem);
	GTUOS	theOS;

	srand(time(NULL));
	theCPU.ReadFileIntoMemoryAt(argv[1], 0x0000);	
 
	do	
	{
		totalCycleTime += theCPU.Emulate8080p(DEBUG);

		if(theCPU.isSystemCall()) {


			totalCycleTime += theOS.handleCall(theCPU);
		}

		if (DEBUG == 2)
			cin.get();

	}	while (!theCPU.isHalted()) ;

	fprintf(stdout, "\nTotal cycle of Program is %d.\n", totalCycleTime);
	if (NULL == (outputFile = fopen(filename.c_str(), "w"))) {
		fprintf(stderr, "Failed to open file %s\n", filename.c_str());
		fprintf(stderr, "Failed to write memory to file.\n");
		return 1;
	}
	theOS.saveMemory(theCPU, outputFile);
	fclose(outputFile);
	return 0;
}

