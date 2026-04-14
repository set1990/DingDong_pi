#include <iostream>
#include "foo.h"
#include "bar.h"

int main() {
    std::cout << "Hello Raspberry Pi Zero 2 W!" << std::endl;
    foo_function();
    bar_function();
    blink_act_led(5, 500);
    std::cout << "rybka" << std::endl;
    while(true){};
    return 0;
}
