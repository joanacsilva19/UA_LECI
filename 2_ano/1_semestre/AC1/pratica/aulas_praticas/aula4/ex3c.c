#include <stdio.h>

int array[4] = {7692, 23, 5, 234};
int i,soma = 0;
void main (void)
{
  while(i < 4)
  {
    soma = soma + array[i];
    i++;
  }
  printf("%d\n",soma);
}
