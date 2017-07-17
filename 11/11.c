#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define N 20

void store_filedata(FILE* fp, int *data);
int max_vertical_product(int *data);
int max_horizonal_product(int *data);
int max_diagonal_to_right_product(int *data);
int max_diagonal_to_left_product(int *data);
int max_array(int* data, int length);

int main(){
  /* file open */
  FILE* fp;
  if((fp= fopen("input.txt","r")) == NULL){
    printf("file open error!!\n");
    exit(1);
  }

  /* store data to 2d-array */
  int *data = malloc(sizeof(int)*N*N);
  store_filedata(fp, data);

  int max[4];

  /* check vertical row */
  max[0] = max_vertical_product(data);
  printf("max vertical: %d\n",max[0]);

  /* check horizonal row */
  max[1] = max_horizonal_product(data);
  printf("max horizonal: %d\n",max[1]);

  /* check diagonal to right row */
  max[2] = max_diagonal_to_right_product(data);
  printf("max diagonal to right: %d\n",max[2]);

  /* check diagonal to left row */
  max[3] = max_diagonal_to_left_product(data);
  printf("max diagonal to left: %d\n",max[3]);

  /* which is max of four? */
  printf("Answer: %d\n",max_array(max, 4));

  /* file close */
  fclose(fp);
  
  /* get pieces of memory free  */
  free(data);

  return 0;

}

void store_filedata(FILE* fp, int *data){
  char string[100];
  char buffer[N][3];
  int i,j;

  for(i=0;i<N;i++){
    /* get string from the available row */
    fgets(string, 100, fp);

    /* first call of strtok */
    strcpy(buffer[0], strtok(string, " \n"));
    *(data+i*N) = atoi(buffer[0]);
    //printf("%d ",*(data+i*N));

    /* store numbers as string */
    for(j=1;j<N;j++){
      strcpy(buffer[j], strtok(NULL, " \n"));
      *(data+i*N+j) = atoi(buffer[j]);
      //printf("%d ",*(data+i*N+j));      
    }
    //printf("\n");
  }


}

int max_vertical_product(int *data){
  int i,j,k,product=1,max=0;
  int buffer[4] = {0, 0, 0, 0};

  for(i=0;i<N;i++){
    for(j=0;j<N;j++){
	/* substitute a value */
	buffer[j%4]=*(data+j*N+i);
	/* get a product */
	for(k=0;k<4;k++) product*=buffer[k];
	/* evaluate the product */
	if(max<product) max = product;
	/* reset 'product' */
	product=1;
      }
  }

  return max;
}

int max_horizonal_product(int *data){
  int i,j,k,product=1,max=0;
  int buffer[4] = {0, 0, 0, 0};

  for(i=0;i<N;i++){
    for(j=0;j<N;j++){
	/* substitute a value */
	buffer[j%4]=*(data+i*N+j);
	/* get a product */
	for(k=0;k<4;k++) product*=buffer[k];
	/* evaluate the product */
	if(max<product) max = product;
	/* reset 'product' */
	product=1;
      }
  }

  return max;

}

int max_diagonal_to_right_product(int *data){
  int i,j,k,product=1,max=0;

  for(i=0;i<N;i++){
    for(j=0;j<N;j++){
      /* get a product */
      product *= *(data+i*N+j);

      if(i*N+j + N+1 > N*N-1 || (i*N+j + N+1)%N < (i*N+j)%N){
		product = 1;
		continue;
      }else product *= *(data+i*N+j + N+1);

      if(i*N+j + 2*N+2 > N*N-1 || (i*N+j + 2*N+2)%N < (i*N+j)%N){
		product = 1;
		continue;
      }else product *= *(data+i*N+j + 2*N+2);

      if(i*N+j + 3*N+3 > N*N-1 || (i*N+j + 3*N+3)%N < (i*N+j)%N){
		product = 1;
		continue;
      }else product *= *(data+i*N+j + 3*N+3);

      /* evaluate the product */
      if(max<product) max = product;
      /* reset 'product' */
      product=1;

      }
  }

  return max;

}

int max_diagonal_to_left_product(int *data){
  int i,j,k,product=1,max=0;

  for(i=0;i<N;i++){
    for(j=0;j<N;j++){
      /* get a product */
      product *= *(data+i*N+j);

      if(i*N+j + N-1 > N*N-1 || (i*N+j + N-1)%N > (i*N+j)%N){
		product = 1;
		continue;
      }else product *= *(data+i*N+j + N-1);

      if(i*N+j + 2*N-2 > N*N-1 || (i*N+j + 2*N-2)%N > (i*N+j)%N){
		product = 1;
		continue;
      }else product *= *(data+i*N+j + 2*N-2);

      if(i*N+j + 3*N-3 > N*N-1 || (i*N+j + 3*N-3)%N > (i*N+j)%N){
		product = 1;
		continue;
      }else product *= *(data+i*N+j + 3*N-3);

      /* evaluate the product */
      if(max<product) max = product;
      /* reset 'product' */
      product=1;

      }
  }

  return max;

}

int max_array(int* data, int length){
  int i,max=*data;

  for(i=1;i<length;i++){
    if(max < *(data+i)) max = *(data+i);
  }

  return max;
}

