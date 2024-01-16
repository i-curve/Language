# TEST

测试文档

测试主要分为单元测试和性能测试, 单元测试用来测试功能是否正确, 基准测试用来测试方法的性能怎么样

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [TEST](#test)
  - [Go](#go)
    - [unit 测试](#unit-测试)
    - [bench 测试](#bench-测试)
  - [C++](#c)
    - [unit 测试](#unit-测试-1)
    - [bench 测试](#bench-测试-1)
  - [java](#java)
    - [unit 测试](#unit-测试-2)
    - [bench 测试](#bench-测试-2)
  - [c#](#c-1)
    - [unit 测试](#unit-测试-3)
    - [bench 测试](#bench-测试-3)
  - [python](#python)
    - [unittest](#unittest)

<!-- /code_chunk_output -->

## Go

go 测试以后缀\_test 文件命名方式指明该文件是一个单元测试文件

### unit 测试

测试文件编写

```go
func TestSum(t *testing.T){
    if res:=Sum(5);res!=5{
        t.Errorf("TestSum error: Sum(5) != 5")
    }
    if res:=Sum(6);res!=6{
        t.Errorf("TestSum error: Sum(5) != 6")
    }
    if res:=Sum(7);res!=7{
        t.Errorf("TestSum error: Sum(5) != 7")
    }
}
```

执行命令

```bash
go test -v [文件名|包名|.] [-run 指定要运行的函数]
```

### bench 测试

测试文件编写

```go
func TestSum(t *testing.B){
    t.ReportAlloc()
    for i:=0;i<t.N;i++{
        Sum(15)
    }
}
```

执行命令

```bash
go test -bench=.
```

## C++

### unit 测试

google 测试

安装 gtest 包

gtest 支持两种方式的断言, 第一种采用 ASSERT...的方式, 另一种采用 EXPECT...的方式, assert 前缀的方式在出现失败时, 会终止后续的才做, 而 expect 会继续执行

| assert              | expect              | 条件 |
| ------------------- | ------------------- | ---- |
| ASSERT_TRUE(cond)   | EXPECT_TRUE(cond)   | cond |
| ASSERT_FALSE (cond) | EXPECT_FALSE (cond) | cond |
| ASSERT_EQ(A,B)      | EXPECT_EQ(A,B)      |      |
| ASSERT_NE(A,B)      | EXPECT_NE(A,B)      |      |
| ASSERT_LT(A,B)      | EXPECT_LT(A,B)      |      |
| ASSERT_LE(A,B)      | EXPECT_LE(A,B)      |      |
| ASSERT_GT(A,B)      | EXPECT_GT(A,B)      |      |
| ASSERT_GE(A,B)      | EXPECT_GE(A,B)      |      |

c++程序通过把测试样例写到 TEST 宏类型的函数中来执行

```c++
TEST(COPYPP_FIELDS_NON_INTRUSIVE, one) {
    A a(3, "Incididunt et veniam non aute nulla.", true);
    B b;
    EXPECT_TRUE(a.id == 3);
    EXPECT_TRUE(a.name == "Incididunt et veniam non aute nulla.");
    EXPECT_TRUE(a.sex == true);
    EXPECT_TRUE(b.id == 0);
    EXPECT_TRUE(b.name == "");
    EXPECT_TRUE(b.sex == false);
    icurve::copy(b, a);
    EXPECT_TRUE(b.id == a.id);
    EXPECT_TRUE(b.name == a.name);
    EXPECT_TRUE(b.sex == a.sex);
}
```

```c++
TEST(COPYPP_FIELDS_INTRUSIVE, one) {
    AA a(15, "Velit cupidatat deserunt dolor non ullamco.", false);
    BB b;
    EXPECT_TRUE(a.getId() == 15);
    EXPECT_FALSE(a.getName() == "");
    EXPECT_TRUE(a.getSex() == false);
    icurve::copy(b, a);
    EXPECT_TRUE(b.getId() == a.getId());
    EXPECT_TRUE(b.getName() == a.getName());
    EXPECT_TRUE(b.getSex() == a.getSex());
    EXPECT_EQ(b.getId(), a.getId());
    EXPECT_EQ(b.getName(), a.getName());
}
```

### bench 测试

安装 google 的 benchmark 包

```c++
#include <benchmark/benchmark.h>
#include <array>

constexpr int len = 6;

// constexpr function具有inline属性，你应该把它放在头文件中
constexpr auto my_pow(const int i)
{
    return i * i;
}

// 使用operator[]读取元素，依次存入1-6的平方
static void bench_array_operator(benchmark::State& state)
{
    std::array<int, len> arr;
    constexpr int i = 1;
    for (auto _: state) {
        arr[0] = my_pow(i);
        arr[1] = my_pow(i+1);
        arr[2] = my_pow(i+2);
        arr[3] = my_pow(i+3);
        arr[4] = my_pow(i+4);
        arr[5] = my_pow(i+5);
    }
}
BENCHMARK(bench_array_operator);

// 使用at()读取元素，依次存入1-6的平方
static void bench_array_at(benchmark::State& state)
{
    std::array<int, len> arr;
    constexpr int i = 1;
    for (auto _: state) {
        arr.at(0) = my_pow(i);
        arr.at(1) = my_pow(i+1);
        arr.at(2) = my_pow(i+2);
        arr.at(3) = my_pow(i+3);
        arr.at(4) = my_pow(i+4);
        arr.at(5) = my_pow(i+5);
    }
}
BENCHMARK(bench_array_at);

// std::get<>(array)是一个constexpr function，它会返回容器内元素的引用，并在编译期检查数组的索引是否正确
static void bench_array_get(benchmark::State& state)
{
    std::array<int, len> arr;
    constexpr int i = 1;
    for (auto _: state) {
        std::get<0>(arr) = my_pow(i);
        std::get<1>(arr) = my_pow(i+1);
        std::get<2>(arr) = my_pow(i+2);
        std::get<3>(arr) = my_pow(i+3);
        std::get<4>(arr) = my_pow(i+4);
        std::get<5>(arr) = my_pow(i+5);
    }
}
BENCHMARK(bench_array_get);

BENCHMARK_MAIN();
```

## java

### unit 测试

### bench 测试

## c#

### unit 测试

官方: MSTest

```c#

```

### bench 测试

## python

### unittest

python 单元测试文件名以 test\_ 开头

unittest 有三种特殊函数

1. setUpModule(), tearDownModule(): 运行在模块开始前, 结束后执行的函数
2. setUpClass(), tearDownClass(self): 运行在类实例化前, 实例化后的函数
3. setUp(), tearDown(): 运行在类方法前, 类方法后的函数

具体样例请参考 github 项目

```python
import unittest
import filesystem_pysdk as filesystem

client: filesystem.Client = None

def setUpModule():
print("into test_client.py")
global client
client, err = filesystem.new_client("system",
"53fc91f6fe8ab61ca9bf5ce7c159c0c9",
"http://localhost:8001",
"http://localhost:8000")
assert client is not None
assert err is None

def tearDownModule():
print('go out test_client.py')

class TestUser(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        cls.user = filesystem.User("i-curve", "", filesystem.User.UType.UTypeUser)

    def test_01_add_user(self):
        with self.assertRaises(TypeError):
            client.add_user("i-curve")
        res = client.add_user(self.user)
        self.assertIsNone(res, res)

    def test_02_delete_user(self):
        res = client.delete_user("i-curve")
        self.assertIsNone(res, res)

class TestBucket(unittest.TestCase):
@classmethod
def setUpClass(cls):
cls.bucket = filesystem.Bucket("i-curve", filesystem.Bucket.BType.BTypeReadWrite, False)

    def test_01_add_bucket(self):
        with self.assertRaises(TypeError):
            client.add_bucket("bucket1")

        res = client.add_bucket(self.bucket)
        self.assertIsNone(res, res)

    def test_02_delete_bucket(self):
        res = client.delete_bucket("i-curve")
        self.assertIsNone(res, res)

if **name** == '**main**':
unittest.main()
```
