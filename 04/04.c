#include <stdio.h>
#include <string.h>
#define N 10

int main(int argc, char argv[]){
  int i, j, k, buffer;
  int result[3]={0, 0, 0};
  char before[N] = {'\0'};
  char after[N] = {'\0'};

  for(i=100;i<1000;i++){
    for(j=100;j<1000;j++){
      /* 積を計算 */
      buffer = i*j;

      /* 文字列にしてひっくり返す */
      sprintf(before, "%d", buffer);
      int len = strlen(before);
      for(k=len-1;k>=0;k--){
	after[len-k-1] = before[k];
      }
      after[len] = '\0';
      
      /* ひっくり返した文字列が元のものと同じ、かつ積が最大なら値を更新 */
      if(strcmp(before, after) == 0 && buffer > result[2]){
	result[0] = i;
	result[1] = j;
	result[2] = buffer;
      }

    }
  }

　/* 結果を表示 */
  printf("%d × %d = %d\n",result[0], result[1], result[2]);

  return 0;
}
