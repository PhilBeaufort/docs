---
layout: post
title: Java Cheat Sheet
date: 2025-06-02 20:26 -0400
description: Simple Java cheat sheet.
categories: [Cheat sheet, Java]
tags: [java, cheat sheet]
---

This is a simple cheat sheet for Java.

## Startup

```java
public class Main {
  public static void main(String[] args) {
    System.out.println("Hello World");
  }
}
```

## Variables Types

|Type|Description|
|-|-|
|`String` | Stores text, such as "Hello". String values are surrounded by double quotes|
|`int`|stores integers (whole numbers), without decimals, such as 123 or -123|
|`float`|stores floating point numbers, with decimals, such as 19.99 or -19.99|
|`char`|Stores single characters, such as 'a' or 'B'. Char values are surrounded by single quotes|
|`boolean`|stores values with two states: true or false|

> Examples
> ```java
    int myNum = 5;               // Integer (whole number)
    float myFloatNum = 5.99f;    // Floating point number
    char myLetter = 'D';         // Character
    boolean myBool = true;       // Boolean
    String myText = "Hello";     // String
> ```
{: .prompt-info }

## Arithmetic Operators

|Operator|Name|Description|Example|
|----|------------------|---------------------------------------|-------|
|`+` |Addition 	        |Adds together two values               |`x + y`|
|`-` |Subtraction       |Subtracts one value from another 	    |`x - y`|
|`*` |Multiplication 	|Multiplies two values 	                |`x * y`|
|`/` |Division 	        |Divides one value by another 	        |`x / y`|
|`%` |Modulus 	        |Returns the division remainder 	    |`x % y`|
|`++`|Increment 	    |Increases the value of a variable by 1 |`++x` 	|
|`--`|Decrement 	    |Decreases the value of a variable by 1 |`--x`  |

## Assignment Operators

|Operator|Example|Same As|Description|
|-|-|-|
|`=`  | `x = 5`  | `x = 5`      ||
|`+=` |	`x += 3` | `x = x + 3` 	|Adds and assign|
|`-=` |	`x -= 3` | `x = x - 3` 	|Subtract and assign|
|`*=` |	`x *= 3` | `x = x * 3` 	|Multiply and assign|
|`/=` |	`x /= 3` | `x = x / 3` 	|Divide and assign|
|`%=` |	`x %= 3` | `x = x % 3` 	|Modulo and assign remainder|
|`&=` |	`x &= 3` | `x = x & 3` 	|Bitwise AND (`0101(5) & 0011(3) = 0001(1)`)|
|`|=` |	`x |= 3` | `x = x | 3` 	|Bitwise OR (`0101(5) | 0011(3) = 0111(7)`)|
|`^=` |	`x ^= 3` | `x = x ^ 3` 	|Bitwise XOR (`0101(5) ^ 0011(3) = 0110(6)`)|
|`>>=`| `x >>= 3`| `x = x >> 3` |Shift bits right (`0100(4) >>= 2` = `0001(1)`)|	
|`<<=`| `x <<= 3`| `x = x << 3` |Shift bits left (`0100(4) <<= 1` = `1000(8)`)|

## Comparison Operators

| Operator | Name                      | Example   | Description                     |
|----------|---------------------------|-----------|---------------------------------|
| `==`     | Equal to                  | `x == y`  | Returns `true` if `x` equals `y`. |
| `!=`     | Not equal                 | `x != y`  | Returns `true` if `x` is not equal to `y`. |
| `>`      | Greater than              | `x > y`   | Returns `true` if `x` is greater than `y`. |
| `<`      | Less than                 | `x < y`   | Returns `true` if `x` is less than `y`. |
| `>=`     | Greater than or equal to  | `x >= y`  | Returns `true` if `x` is greater than or equal to `y`. |
| `<=`     | Less than or equal to     | `x <= y`  | Returns `true` if `x` is less than or equal to `y`. |

## Logical Operator

|Operator|Name| Description |Example|
|-|-|-|-|
|`&&`| Logical AND | Returns `true` if **both** conditions are true                | `x < 5 && x < 10`   |
|`||`| Logical OR  | Returns `true` if **at least one** condition is true          | `x < 5 || x < 4`    |
|`!` | Logical NOT | Reverses the result: returns `false` if the expression is true| `!(x < 5 && x < 10)`|

## If...Else

### Else If

> Syntax
>```java
if (condition1) {
  // block of code to be executed if condition1 is true
} else if (condition2) {
  // block of code to be executed if the condition1 is false and condition2 is true
} else {
  // block of code to be executed if the condition1 is false and condition2 is false
}
```

> Example
>```java
int time = 22;
if (time < 10) {
  System.out.println("Good morning.");
} else if (time < 18) {
  System.out.println("Good day.");
} else {
  System.out.println("Good evening.");
}
// Outputs "Good evening."
```

### Short hand

> Syntax
>```java
variable = (condition) ? expressionTrue :  expressionFalse;
``` 

> Example
>```java
String result = (time < 18) ? "Good day." : "Good evening.";
```

## Switch Case

> Syntax
>```java
switch(expression) {
  case x:
    // code block
    break;
  case y:
    // code block
    break;
  default:
    // code block
}
```

> Example
>```java
int day = 4;
switch (day) {
  case 1:
    System.out.println("Monday");
    break;
  case 2:
    System.out.println("Tuesday");
    break;
  case 3:
    System.out.println("Wednesday");
    break;
  case 4:
    System.out.println("Thursday");
    break;
  case 5:
    System.out.println("Friday");
    break;
  case 6:
    System.out.println("Saturday");
    break;
  case 7:
    System.out.println("Sunday");
    break;
}
// Outputs "Thursday" (day 4)
```

## While Loop

### While

> Syntax
>```java
while (condition) {
  // code block to be executed
}
```

> Example
>```java
int dice = 1;
while (dice <= 6) {
  if (dice < 6) {
    System.out.println("No Yatzy.");
  } else {
    System.out.println("Yatzy!");
  }
  dice = dice + 1;
}
```

### Do/While

> Syntax
>```java
do {
  // code block to be executed
}
while (condition);
```

> Example
>```java
int i = 0;
do {
    System.out.println(i);
    i++;
}
while (i < 5);
```

## For Loops

### For Loop

> Syntax
>```java
for (statement 1; statement 2; statement 3) {
  // code block to be executed
}
```

> Example
>```java
for (int i = 0; i < 5; i++) {
  System.out.println(i);
}
```

### Nested

```java
// Outer loop
for (int i = 1; i <= 2; i++) {
    System.out.println("Outer: " + i); // Executes 2 times
  
    // Inner loop
    for (int j = 1; j <= 3; j++) {
        System.out.println(" Inner: " + j); // Executes 6 times (2 * 3)
    }
} 
```

### For Each

> Syntax
>```java
for (type variableName : arrayName) {
  // code block to be executed
}
```

> Example
>```java
String[] cars = {"Volvo", "BMW", "Ford", "Mazda"};
for (String i : cars) {
  System.out.println(i);
}
```
