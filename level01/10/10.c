#include <stdio.h>
#include <math.h>
#define N 2000000

int pucci(int n);

int main(int argc, char argv[]){
  long long int answer=2;
  int i;

  for(i=3;i<N;i+=2){
    if(pucci(i) == 1){
      answer += i;
      //      printf("%d %lld.\n", i, answer);
    }
  }

  printf("Answer made in heaven: %lld\n", answer);

  return 0;
}

/* is this number a prime? */
int pucci(int n){
  int i;
  int whitesnake = (int)(sqrt((double)n))+1;

  if(n < 2){
    return 0;
  }else if(n == 2){
    return 1;
  }else{
    for(i=2;i<whitesnake;i++){
      if(n%i == 0) return 0;
    }
  }
  return 1;

}
