#include <cos_quotes.h>
#include <stdio.h>

int main() {
    // Tests

    // It is normal if the same quotes are displayed if the 
    // function is called too quickly
    print_random_quote();
    
    printf("Manual output: %s \n", get_random_quote());
}