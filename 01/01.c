#include <stdio.h>

int main(char argv[], int argc){

  int answer=0,i;
  
  for(i=1;i<1000;i++){
    if(i%3==0 || i%5==0){
      answer += i;
    }
  }
  printf("%d\n",answer);
  
  return 0;
}
