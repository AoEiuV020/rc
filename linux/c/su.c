/*****************************************************
	^> File Name: su.c
	^> Author: AoEiuV020
	^> Mail: 490674483@qq.com
	^> Created Time: 2015/10/28 - 23:44:28
****************************************************/
#include <unistd.h>
#include <stdio.h>
int main(int argc, char **argv)
{
	printf("<%d,%d>\n",getuid(),geteuid());
	//printf("(%d)\n",setuid(geteuid()));
	printf("(%d)\n",setuid(0));
	printf("<%d,%d>\n",getuid(),geteuid());
	execlp("bash","bash",NULL);
	perror("error");
	return 0;
}
