#include <stdio.h>
#include <stdlib.h>

int main(){
  int a,b,c;
  int answer=0;

  /* a<b<c, (c+b)(c-b)=a^2, a+b+c=1000 */
  for(c=1;c<1000;c++){
    for(b=1;b<c;b++){
      /* set a */
      a = 1000-b-c;
      
      /* check the value */
      if(a <= 0) continue;
      if(a >= b) continue;

      /* is this suitable? */
      if((c-b)*(c+b) == a*a){
	answer = a*b*c;
	printf("a: %d b: %d c: %d \n", a, b, c);
	printf("Answer: %d \n", answer);
      }
    }
  }

  return 0;

}
