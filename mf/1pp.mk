n=temp
$(n).exe:$(n).cpp
	g++ -Wall -std=c++11 --save-temps -o $(n).exe $(n).cpp
	$(n).exe
.PHONY:clean
.IGNORE:clean
clean:
	del *.ii *.o *.s *.exe
