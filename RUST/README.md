# RUST doc

## I. 基本使用

```bash
cargo build // 编译 项目
cargo run
```

## II. 数据类型

基本类型:
bool,char
u32,u64,usize
i32,i64,isize,f32,f64
复合类型:
tuple

rust 变量可以连续声明, 后面声明的会隐藏上面声明的变量

1. 使用 let 关键字声明变量

默认情况下变量是不可变的(immutable), 可以在变量前面加上 mut 使变量可变

```rust
let x = 5; // 不可变
println!("the value is {}",x);
let mut y = 6; // 可变
y = 12;
```

2. 常量 const(必须标注)

```rust
const PI: = 3.14159;
```

## III. 基本语法

- 声明函数

函数参数里面必须标注,返回类型后置

```rust
fn main() {
    println!("hello world!")
}
```

```rust
fn sum(a:i32,b:i32)->i32{
    return a+b
}
```

- if 语句

```rust
fn main() {
    let mut flag = 15;
    if flag <4 {
        println!("flat < 4")
    } else if flag < 10 {
        println!("4 < flag < 10")
    } else if flag < 16 {
        println!("flag < 16")
    } else {
        println!("flag >= 16")
    }
}
```

- 循环

```rust
fn main() {
    for number in (1..4).rev() {
        println!("{}!", number)
    }

    let a = [1,2,3];

}
```
