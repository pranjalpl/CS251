#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>
#include<string.h>
#include<pthread.h>

#define MAX_THREADS 64

pthread_mutex_t lock;
static int counter = 0;

#define USAGE_EXIT(s) do{ \
    printf("Usage: %s <acc filename> <transaction filename> <# of transactions> <# of threads> \n %s\n", argv[0], s); \
    exit(-1);\
}while(0);

#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))

struct acc{
    int acc_no[10000];
    float balance[10000];
};

struct txn{
    int seq[10000];
    int type[10000];
    float amount[10000];
    int acc_1[10000];
    int acc_2[10000];
};

struct acc a1;
struct txn t1;

void make_txn(int ctr, int num_txn){
    
    if(ctr < num_txn){
        if(t1.type[ctr] == 1){
            a1.balance[t1.acc_1[ctr] - 1001] = a1.balance[t1.acc_1[ctr] - 1001] + (.99 * t1.amount[ctr]);
        }
        if(t1.type[ctr] == 2){
            a1.balance[t1.acc_1[ctr] - 1001] = a1.balance[t1.acc_1[ctr] - 1001] - (1.01 * t1.amount[ctr]);
        }
        if(t1.type[ctr] == 3){
            a1.balance[t1.acc_1[ctr] - 1001] = 1.071*a1.balance[t1.acc_1[ctr] - 1001];
        }
        if(t1.type[ctr] == 4){
            a1.balance[t1.acc_2[ctr] - 1001] = a1.balance[t1.acc_2[ctr] - 1001] + (.99 * t1.amount[ctr]);
            a1.balance[t1.acc_1[ctr] - 1001] = a1.balance[t1.acc_1[ctr] - 1001] - (1.01 * t1.amount[ctr]);
        }
    }
    return;
}

void *transaction(void *arg){
    int ccounter;
    int *size = (int *)arg;

    while(1){
        pthread_mutex_lock(&lock);
        if(counter >= *size){
            pthread_mutex_unlock(&lock);
            break;
        }
        ccounter = counter;
        counter++;
        pthread_mutex_unlock(&lock);

        make_txn(ccounter,*size);       
    }
    pthread_exit(NULL);
}

int main(int argc, char **argv){

    struct timeval start, end;
    int num_threads,num_txn; 

    if(argc != 5){
        USAGE_EXIT("not enough parameters");
    }

    num_threads = atoi(argv[4]);
    if(num_threads <=0 || num_threads > MAX_THREADS){
        USAGE_EXIT("invalid num of threads");
    }
    pthread_t threads[num_threads];
    num_txn = atoi(argv[3]);
    if(num_txn <=0){
          USAGE_EXIT("invalid number of transactions");
    }

    FILE *accfile;
    FILE *txnfile;
    accfile = fopen(argv[1], "r");
    txnfile = fopen(argv[2], "r");

    for (int i = 0; i < 10000; i++){
        fscanf(accfile, "%d", &a1.acc_no[i]);
        fscanf(accfile, "%f", &a1.balance[i]);
    }

    for (int i = 0; i < num_txn; i++){
        fscanf(txnfile, "%d", &t1.seq[i]);
        fscanf(txnfile, "%d", &t1.type[i]);
        fscanf(txnfile, "%f", &t1.amount[i]);
        fscanf(txnfile, "%d", &t1.acc_1[i]);
        fscanf(txnfile, "%d", &t1.acc_2[i]);
    }

    gettimeofday(&start, NULL);

    pthread_mutex_init(&lock, NULL);

    for(int ctr = 0; ctr < num_threads; ++ctr){
        if(pthread_create(&threads[ctr], NULL, transaction, &num_txn) != 0){
            perror("pthread_create");
            exit(-1);
        }
    }

    for(int ctr = 0; ctr < num_threads; ctr++){
        pthread_join(threads[ctr], NULL);
    }

    for (int i = 0; i < 10000; i++){
        printf("%d %.2f\n",a1.acc_no[i],a1.balance[i]);
    }   

    gettimeofday(&end, NULL);
    printf("Time taken = %ld microsecs\n", TDIFF(start, end));
    return 0;
}