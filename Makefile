#Linux Generic
CC=gcc

OUTPATH=./build/
SOURCE_MODULES_PATH=./library/

#FOR DEBUG PURPOSE 
CFLAGS=-c -Wall -I. -g -O0
#CFLAGS=-c -Wall -I.
OPTIMIZATION=-O3
HEADERS=-I
LIBPATH=./build/modules/
BUILDFILES=start uFTP end
LIBS=-lpthread -lssl -lcrypto

#DEFINITIONS=

#TO ENABLE THE LARGE FILE SUPPORT UNCOMMENT THE NEXT LINE
DEFINITIONS=-D_LARGEFILE64_SOURCE

all: $(BUILDFILES)

start:
	@echo Compiler: $(CC)
	@echo Output Directory: $(OUTPATH)
	@echo CGI FILES: $(BUILDFILES)
	@rm -rf $(LIBPATH)*.o $(OUTPATH)uFTP
	@echo "Clean ok"
	
end:
	@echo Build process end

uFTP: uFTP.c fileManagement.o configRead.o logFunctions.o ftpCommandElaborate.o ftpData.o ftpServer.o daemon.o signals.o connection.o openSsl.o
	@$(CC) $(DEFINITIONS) uFTP.c $(LIBPATH)dynamicVectors.o $(LIBPATH)fileManagement.o $(LIBPATH)configRead.o $(LIBPATH)logFunctions.o $(LIBPATH)ftpCommandElaborate.o $(LIBPATH)ftpData.o $(LIBPATH)ftpServer.o $(LIBPATH)daemon.o $(LIBPATH)signals.o $(LIBPATH)connection.o $(LIBPATH)openSsl.o -o $(OUTPATH)uFTP $(LIBS)

daemon.o: 
	@$(CC) $(CFLAGS) $(SOURCE_MODULES_PATH)daemon.c -o $(LIBPATH)daemon.o

dynamicVectors.o: 
	@$(CC) $(CFLAGS) $(SOURCE_MODULES_PATH)dynamicVectors.c -o $(LIBPATH)dynamicVectors.o
	
openSsl.o: 
	@$(CC) $(CFLAGS) $(SOURCE_MODULES_PATH)openSsl.c -o $(LIBPATH)openSsl.o

configRead.o: dynamicVectors.o fileManagement.o
	@$(CC) $(CFLAGS) $(SOURCE_MODULES_PATH)configRead.c -o $(LIBPATH)configRead.o 

fileManagement.o:
	@$(CC) $(CFLAGS) $(SOURCE_MODULES_PATH)fileManagement.c -o $(LIBPATH)fileManagement.o

signals.o:
	@$(CC) $(CFLAGS) $(SOURCE_MODULES_PATH)signals.c -o $(LIBPATH)signals.o
	
connection.o:
	@$(CC) $(CFLAGS) $(SOURCE_MODULES_PATH)connection.c -o $(LIBPATH)connection.o

logFunctions.o:
	@$(CC) $(CFLAGS) $(SOURCE_MODULES_PATH)logFunctions.c -o $(LIBPATH)logFunctions.o

ftpCommandElaborate.o:
	@$(CC) $(CFLAGS) ftpCommandElaborate.c -o $(LIBPATH)ftpCommandElaborate.o

ftpData.o:
	@$(CC) $(CFLAGS) ftpData.c -o $(LIBPATH)ftpData.o

ftpServer.o: openSsl.o
	@$(CC) $(CFLAGS) ftpServer.c -o $(LIBPATH)ftpServer.o

clean:
	@rm -rf $(LIBPATH)*.o $(OUTPATH)uFTP
	@echo "Clean ok"
