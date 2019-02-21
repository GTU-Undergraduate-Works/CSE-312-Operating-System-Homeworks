#ifndef H_GTUOS
#define H_GTUOS

#define PRINT_B 1
#define PRINT_MEM 2
#define READ_B 3
#define READ_MEM 4
#define PRINT_STR 5
#define READ_STR 6
#define GET_RND 7



#include "8080emuCPP.h"
using namespace std;


class GTUOS{
	public:
		uint64_t handleCall(const CPU8080 & cpu);
		void saveMemory(const CPU8080 & cpu, FILE* outputFile);

	private:
		int printRegisterBContent(const CPU8080 & cpu);
		int printMem(const CPU8080 & cpu);
		int readToBRegiter(const CPU8080 & cpu);
		int ReadToMem(const CPU8080 & cpu);
		int printStr(const CPU8080 & cpu);
		int readStr(const CPU8080 & cpu);
		int getRand(const CPU8080 & cpu);
};

#endif
