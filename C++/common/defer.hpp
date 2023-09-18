#pragma once
#ifndef COMMON_HEADER_ONLY
#include <functional>

#define defer1(a, b) a##b
#define defer2(a, b) defer1(a, b)
#define defer(expr) Defer defer2(__Defer, __COUNTER__)([&]() { expr; })

class Defer {
public:
    Defer(std::function<void()> fn) : fn(fn) {}
    ~Defer() noexcept {
        if (fn) {
            fn();
        }
    }

private:
    std::function<void()> fn;
};
#endif