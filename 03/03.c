#include <stdio.h>

unsigned long long int prime(unsigned long long int obj);

int main(int argc, char argv[]){
  unsigned long long int obj = 600851475143;
  
  unsigned long long int answer = prime(obj);

  printf("%d", answer);

  return 0;

}

unsigned long long int prime(unsigned long long int obj){
  int i=2;

  while(1){
    if(obj%i == 0){
      prime(obj/i);
      break;
    }else if(obj == i){
      return obj;
    }
  }
  return obj;
}
