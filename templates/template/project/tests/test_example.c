/**
 * @file test_example.c
 * @brief Example unit test
 * 
 * Replace this with your actual test framework and tests.
 * Popular options: Unity, Google Test, Check, etc.
 */

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

// Example: Simple test framework
#define ASSERT(condition) \
    do { \
        if (!(condition)) { \
            printf("FAIL: %s:%d: %s\n", __FILE__, __LINE__, #condition); \
            exit(1); \
        } \
    } while(0)

#define RUN_TEST(test_func) \
    do { \
        printf("Running %s... ", #test_func); \
        test_func(); \
        printf("PASS\n"); \
    } while(0)

// Example test function
void test_example(void)
{
    ASSERT(1 + 1 == 2);
}

int main(void)
{
    printf("Running unit tests...\n");
    RUN_TEST(test_example);
    printf("All tests passed!\n");
    return 0;
}

