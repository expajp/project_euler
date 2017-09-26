#include <stdio.h>
#include <stdlib.h>

int main(){

  /* read the file */
  FILE* fp=fopen("input.txt","r");

  /* set variables */
  int max=0, comparator=1, pointer=0;
  int buffer[5] = {0, 0, 0, 0, 0};
  char buffer2;
  int i;

  /* main loop */
  while((buffer2 = getc(fp)) != EOF){
    /* transform char to int */
    buffer[pointer] = atoi(&buffer2);
    //printf("%d", buffer[pointer]);
    
    /* caliculate and check the value */
    for(i=0;i<5;i++){
      comparator *= buffer[i];
    }
    if(max < comparator) max = comparator;
    
    /* shift the pointer */
    pointer++;
    pointer %= 5;
    /* reset the comparator */
    comparator = 1;
  }
  //printf("\n");

  /* output the answer */
  printf("Answer: %d\n", max);

  /* close the file */
  fclose(fp);

  return 0;

}
