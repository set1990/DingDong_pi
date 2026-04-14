#include <iostream>
#include "bar.h"
#include <fstream>
#include <unistd.h>
#include <thread>

void bar_function() { std::cout << "bar_function() called!" << std::endl; }

void blink_act_led(int times, int delay_ms) {
    std::thread([=]() {
        const char* led_path = "/sys/class/leds/ACT/brightness";
        for (int i = 0; i < times; ++i) {
            std::ofstream led(led_path);
            if (!led.is_open()) break;
            led << "1" << std::flush;
            usleep(delay_ms * 1000);
            led << "0" << std::flush;
            usleep(delay_ms * 1000);
        }
    }).detach();
}
