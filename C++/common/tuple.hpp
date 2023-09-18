#pragma once

#include <tuple>
#include <variant>
#include <ostream>
template <unsigned int n, typename... T>
std::variant<T...> _tuple_index(std::tuple<T...> t, unsigned int index) {
    if (index >= sizeof...(T)) {
        throw out_of_range("tuple 下标越界");
    }
    if (index == n) {
        return std::variant<T...>{std::in_place_index<n>, get<n>(t)};
    }
    return _tuple_index < n < sizeof...(T) - 1 ? n + 1 : 0 > (t, index);
}

template <typename... T>
std::variant<T...> tuple_index(std::tuple<T...> t, unsigned int index) {
    return _tuple_index<0>(t, index);
}

template <typename T0, typename... T>
std::ostream &operator<<(std::ostream &s, std::variant<T0, T...> const &v) {
    visit([&](auto x) {
        s << x;
    },
          v);
    return s;
}