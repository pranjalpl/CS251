#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>
#include<string.h>
#include<pthread.h>
#include<math.h>

#define SEED 0x75

#define USAGE_EXIT(s) do{ \
    printf("Usage: %s <# of elements> <# of threads> \n %s\n", argv[0], s); \
    exit(-1);\
}while(0);

#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))

struct thread_param{
    pthread_t tid;
    int *array;
    int size;
    int skip;
    int thread_counter;
    double max_prime;  
    int max_prime_index;
};

int checkprime(int element){
	if(element <= 1){
		return 0;
	}
	if(element <= 3){
		return 1;
	}
	if((element%2 == 0)||(element%3 == 0)){
		return 0;
	}
	for(int i = 5; pow(i,2)<element; i++){
		if((element%i == 0)||(element%(i+2) == 0)){
			return 0;
		}
	}
	return 1;
}

void* find_max_prime(void *arg){
	struct thread_param *param = (struct thread_param *)arg;
	int counter = param->thread_counter;
	
	param->max_prime = -1;
	param->max_prime_index = 0;

	while(counter < param->size){
		int prime = checkprime(param->array[counter]);
		if(prime == 1){
			if(param->array[counter] > param->max_prime){
				param->max_prime = param->array[counter];
				param->max_prime_index = counter;
			}
		}
		counter = counter + param->skip;
	}
}

int main(int argc, char **argv){
	struct thread_param *params;
 	struct timeval start, end;
 	int *a, num_elements, counter, num_threads;
 	int max_prime;
	int max_prime_index;

	if(argc !=3){
   		USAGE_EXIT("not enough parameters");
	}
	num_elements = atoi(argv[1]);
  	if(num_elements <=0){
       	USAGE_EXIT("invalid num elements");
  	}
  	num_threads = atoi(argv[2]);
  	if((num_threads <=0)||(num_threads > 64)){
       	USAGE_EXIT("invalid num of threads");
    }

    a = malloc(num_elements * sizeof(int));
    if(!a){
        USAGE_EXIT("invalid num elements, not enough memory");
  	}

  	srand(SEED);  
  	for(counter=0; counter<num_elements; ++counter){
        a[counter] = random();
  	}

  	params = malloc(num_threads * sizeof(struct thread_param));
  	bzero(params, num_threads * sizeof(struct thread_param));

  	gettimeofday(&start, NULL);

	for(counter = 0; counter < num_threads; ++counter){
		struct thread_param *param = params + counter;
		param->size = num_elements;
		param->skip = num_threads;
		param->array = a;
		param->thread_counter = counter;

		if(pthread_create(&param->tid,NULL,find_max_prime,param) != 0){
			perror("pthread_create");
			exit(-1);
		}
	}

	for(counter = 0; counter < num_threads; ++counter){
		struct thread_param *param = params + counter;
		pthread_join(param->tid, NULL);
		if((counter == 0)||((counter > 0)&&(param->max_prime > max_prime))){
			max_prime = param->max_prime;
			max_prime_index = param->max_prime_index;
		}
	}  	

	printf("Max = %d at index=%d\n", max_prime, max_prime_index);
  	gettimeofday(&end, NULL);
  	printf("Time taken = %ld microsecs\n", TDIFF(start, end));
 	free(a);
  	free(params);
	return 0;
}
