# MAUI

<!-- @import "[TOC]" {cmd="toc" depthFrom=1 depthTo=6 orderedList=false} -->

<!-- code_chunk_output -->

- [MAUI](#maui)
  - [I. 基础](#i-基础)
    - [1. xaml 文件:](#1-xaml-文件)
    - [2. cs 文件](#2-cs-文件)
  - [II.布局组件](#ii布局组件)
    - [1. 水平垂直布局](#1-水平垂直布局)
    - [2. Grid 布局](#2-grid-布局)
  - [III. 数据绑定](#iii-数据绑定)
    - [1. 基本概念(BindingContext, SetContext)](#1-基本概念bindingcontext-setcontext)
    - [2. 数据绑定类型](#2-数据绑定类型)
    - [3. cs 中绑定](#3-cs-中绑定)
    - [4. xaml 文件中绑定](#4-xaml-文件中绑定)

<!-- /code_chunk_output -->

[官方文档](https://learn.microsoft.com/dotnet/maui)

maui 从 xarmin 组件演化而来, 采用 c#, xaml 语言开发

## I. 基础

maui 界面开发采用的是 Xaml 文件定义视图布局, 与之相关的 cs 文件定义逻辑操作. 内部的本质把 xaml 文件转换为 cs 类文件 maui 控件, 并和 cs 文件共同组成视图

在 xaml 文件中定义的控件 (x:Name) 属性,在相应类中都会产生对应的变量, 名字就是 x:Name 中指定的名字

### 1. xaml 文件:

```xaml
<?xml version="1.0" encoding="utf-8" ?>
<ContentPage xmlns="http://schemas.microsoft.com/dotnet/2021/maui"
             xmlns:x="http://schemas.microsoft.com/winfx/2009/xaml"
             x:Class="MauiStarter.MainPage">
    <StackLayout Padding="10, 0">
    <Label x:Name="label"
            Text="TEXT"
            FontSize="40"
            HorizontalOptions="Center"
            VerticalOptions="Center"></Label>
    <Slider x:Name="slider"
    Maximum="360"
    VerticalOptions="Center"></Slider>
</StackLayout>
</ContentPage>
```

其中在 ContentPage 中指定了微软的 dotnet 命名空间和 maui 命名空间

x:Class 指定这个页面的类, 和后面的 cs 文件共同组成了这个视图类

**note**: ContentPage 中只能有一个字控件, 但是可以放入布局控件, 布局控件大多可以放入多个子控件

xaml 文件有热重载功能

### 2. cs 文件

这里的类文件需要和 xaml 文件中的 x:Class 相匹配, 并且文件名的命名方式应该为 .xaml.cs

```cs
namespace MauiStarter;

public partial class MainPage : ContentPage {

    public MainPage() {
        InitializeComponent();

        //label.BindingContext = slider;
        //label.SetBinding(Label.RotationProperty, "Value");
        label.SetBinding(Label.RotationProperty, new Binding("Value", source: slider));
    }
}
```

如上图,在 xaml 文件中通过 x:Name 指定的名字可以直接在类中使用该变量

## II.布局组件

- VerticalStackLayout: 垂直方向排列组件
- HorizationStackLayout: 水平方向排列的组件
- StackStackLayout: 栈组件

### 1. 水平垂直布局

VerticalStackLayout, HorizationStackLayout 一样, 通过 Orientation 属性进行调整

```xml
<StackLayout Padding="20, 20" Orientation="Vertical">
    <Label Text="label3" Margin="0, 0,0,20"></Label>
    <Label Text="label4"></Label>
</StackLayout>
```

### 2. Grid 布局

先定义行和列的信息, 然后在里面组件内使用 Grid.Row 和 Grid.Column 设置在组件中的位置

如下: 定义 3 行 5 列的 grid

```xml
<Grid>
    <Grid.RowDefinitions>
        <RowDefinition Height="20"></RowDefinition>
        <RowDefinition Height="20"></RowDefinition>
        <RowDefinition Height="20"></RowDefinition>
    </Grid.RowDefinitions>
    <Grid.ColumnDefinitions>
        <ColumnDefinition Width="40"></ColumnDefinition>
        <ColumnDefinition Width="20"></ColumnDefinition>
        <ColumnDefinition Width="40"></ColumnDefinition>
    </Grid.ColumnDefinitions>
    <Label Background="#ccc" Grid.Row="0" Grid.Column="0"></Label>
    <Label Background="red" Grid.Row="3" Grid.Column="1"></Label>
</Grid>
```

## III. 数据绑定

数据绑定指的是某个对象的某个属性改变之后, 影响某个对象的属性. 在此基础之上建立的关系称之为数据绑定

### 1. 基本概念(BindingContext, SetContext)

maui 中事件产生的对象称之为属性源, 受到影响的对象称之为目标属性

BindingContext: 指定属性源

SetContext: 指定目标属性和源属性

### 2. 数据绑定类型

- Default:默认
- TwoWay: 数据在源和目标之间双向移动
- OneWay: 数据从源流向目标
- OneWayToSouce: 数据从目标流向源
- OneTime: 数据从源转到目标，但仅当更改时 BindingContext

maui 的默认数据绑定行为在大多情况下是双向绑定的(TwoWay), 但是在一些特定组件是单项绑定的(OneWay)

### 3. cs 中绑定

通过在 xaml 文件指定 x:Name 之后, 会自动在 cs 文件中添加对应的字段属性, 因此本质就是调用这些属性进行绑定

```xaml
<StackLayout Padding="10, 0">
    <Label x:Name="label"
            Text="TEXT"
            FontSize="18"
            HorizontalOptions="Center"
            VerticalOptions="Center"></Label>
    <Slider x:Name="slider"
    Maximum="360"
    VerticalOptions="Center"></Slider>
</StackLayout>
```

绑定方法一:

```cs
// 可以直接在构造方法中进行绑定

// 通过BingingContext指定源slider滑块
label.BindingContext = slider;
// 通过SetBinding指定受影响的属性
label.SetBinding(Label.RotationProperty, "Value");
```

绑定方法二:

可以在 SetBinding 的第二个参数中直接定义一个 Binding 对象, 并指定相应的源为 slider

```cs
label.SetBinding(Label.RotationProperty, new Binding("Value", source: slider));
```

### 4. xaml 文件中绑定

可以直接在 xaml 文件中通过属性 BingingContext 指定源
{% raw %}

```xaml
<StackLayout Padding="10, 0">
    <Label x:Name="label"
            Text="TEXT"
            FontSize="40"
            HorizontalOptions="Center"
            VerticalOptions="Center"
            BindingContext="{x:Referenct Name=slider}"
            Rotation="{Binding Path=Value}"
            ></Label>
    <Slider x:Name="slider"
    Maximum="360"
    VerticalOptions="Center"></Slider>
</StackLayout>
```

可以直接在属性中指定源和属性

```xaml
<StackLayout Padding="10, 0">
    <Label x:Name="label"
            Text="TEXT"
            FontSize="40"
            HorizontalOptions="Center"
            VerticalOptions="Center"
            Rotation="{Binding Value, Source={x:Reference Name=slider}}"
            ></Label>
    <Slider x:Name="slider"
    Maximum="360"
    VerticalOptions="Center"></Slider>
</StackLayout>
```

{% endraw %}
