tags: [[Conditionals]], [[logical]], [[operators]], [[for loop]], [[arrays]]

## Conditionals

**Conditionals**, or `if` statements, are a way of telling a script to do something only under a specific condition.

Bash script conditionals use the following `if`-`then`-`else` syntax:

1. `if [ condition ]`
2. `then`
3.     `statement_block_1`  
4. `else`
5.     `statement_block_2`  
6. `fi`

Copied!

If the `condition` is `true`, then Bash executes the statements in `statement_block_1` before exiting the conditional block of code. After exiting, it will continue to run any commands after the closing `fi`.

Alternatively, if the `condition` is `false`, Bash instead runs the statements in `statement_block_2` under the `else` line, then exits the conditional block and continues to run commands after the closing `fi`.

> **Tips:**
> 
> - You must always put spaces around your condition within the square brackets `[` `]`.
> - Every `if` condition block must be paired with a `fi` to tell Bash where the condition block ends.
> - The `else` block is optional but recommended. If the condition evaluates to `false` without an `else` block, then nothing happens within the `if` condition block. Consider options such as echoing a comment in `statement_block_2` to indicate that the condition was evaluated as `false`.

In the following example, the condition is checking whether the number of command-line arguments read by some Bash script, `$#`, is equal to 2.

1. `if [[ $# == 2 ]]`
2. `then`
3.   `echo "number of arguments is equal to 2"`
4. `else`
5.   `echo "number of arguments is not equal to 2"`
6. `fi`

Notice the use of the double square brackets, which is the syntax required for making integer comparisons in the condition `[[ $# == 2 ]]`.

You can also make string comparisons. For example, assume you have a variable called `string_var` that has the value `"Yes"` assigned to it. Then the following statement evaluates to `true`:


1. `` `[ $string_var == "Yes" ]` ``


Notice you only need single square brackets when making string comparisons.

You can also include multiple conditions to be satified by using the "and" operator `&&` or the "or" operator `||`. For example:

1. `if [ condition1 ] && [ condition2 ]`
2. `then`
3.     `echo "conditions 1 and 2 are both true"`
4. `else`
5.     `echo "one or both conditions are false"`
6. `fi`


1. `if [ condition1 ] || [ condition2 ]`
2. `then`
3.     `echo "conditions 1 or 2 are true"`
4. `else`
5.     `echo "both conditions are false"`
6. `fi`

Copied!

## Logical operators

The following logical operators can be used to compare integers within a condition in an `if` condition block.

`==`: is equal to

If a variable `a` has a value of 2, the following condition evaluates to `true`; otherwise it evalutes to `false`.


1. `$a == 2`


`!=`: is not equal to

If a variable `a` has a value different from 2, the following statement evaluates to `true`. If its value is 2, then it evalutes to `false`.


1. `a != 2`

Copied!

> **Tip**: The `!` logical negation operator changes `true` to `false` and `false` to `true`.

`<=`: is less than or equal to

If a variable `a` has a value of 2, then the following statement evaluates to `true`:

1. `a <= 3`

Copied!

and the following statement evalutates to `false`:


1. `a <= 1`


Alternatively, you can use the equivalent notation `-le` in place of `<=`:


1. `a=1`
2. `b=2`
3. `if [ $a -le $b ]`
4. `then`
5.    `echo "a is less than or equal to b"`
6. `else`
7.    `echo "a is not less than or equal to b"`
8. `fi`


We've only provided a small sampling of logical operators here. You can explore resources such as the [Advanced Bash-Scripting Guide](https://tldp.org/LDP/abs/html/comparison-ops.html) to find out more.

## Arithmetic calculations

You can perform integer addition, subtraction, multiplication, and division using the notation `$(())`.  
For example, the following two sets of commands both display the result of adding 3 and 2.


1. `echo $((3+2))`


or

1. `a=3`
2. `b=2`
3. `c=$(($a+$b))`
4. `echo $c`

Copied!

Bash natively handles integer arithmetic but does not handle floating-point arithmetic. As a result, it will always truncate the decimal portion of a calculation result.

For example:

1. `echo $((3/2))`

Copied!

prints the truncated integer result, `1`, not the floating-point number, `1.5`.

The following table summarizes the basic arithmetic operators:

|Symbol|Operation|
|---|---|
|`+`|addition|
|`-`|subtraction|
|`*`|multiplication|
|`/`|division|

> Table: **Arithmetic operators**

## Arrays

The **array** is a Bash built-in data structure. An array is a space-delimited list contained in parentheses. To create an array, declare its name and contents:


1. `my_array=(1 2 "three" "four" 5)`

Copied!

This statement creates and populates the array `my_array` with the items in the parentheses: `1`, `2`, `"three"`, `"four"`, and `5`.

You can also create an empty array by using:

1. `declare -a empty_array`

Copied!

If you want to add items to your array after creating it, you can add to your array by appending one element at a time:

1. `my_array+=("six")`
2. `my_array+=(7)`

Copied!

This adds elements `"six"` and `7` to the array `my_array`.

By using indexing, you can access individual or multiple elements of an array:

1. `# print the first item of the array:`
2. `echo ${my_array[0]}`

4. `# print the third item of the array:`
5. `echo ${my_array[2]}`

7. `# print all array elements:`
8. `echo ${my_array[@]}`

Copied!

> **Tip:** Note that array indexing starts from 0, not from 1.

## `for` loops

You can use a construct called a `for` loop along with indexing to iterate over all elements of an array.

For example, the following `for` loops will continue to run over and over again until every element is printed:


1. `for item in ${my_array[@]}; do`
2.   `echo $item`
3. `done`


or


1. `for i in ${!my_array[@]}; do`
2.   `echo ${my_array[$i]}`
3. `done`


The `for` loop requires a `; do` component in order to cycle through the loop. Additionally, you need to terminate the `for` loop block with a `done` statement.

Another way to implement a `for` loop when you know how many iterations you want is as follows. For example, the following code prints the number 0 through 6.

1. `N=6`
2. `for (( i=0; i<=$N; i++ )) ; do`
3.   `echo $i`
4. `done`

Copied!

You can use `for` loops to accomplish all sorts of things. For example, you could count the number of items in an array or sum up its elements, as the following Bash script does:

1. `#!/usr/bin/env bash`
2. `# initialize array, count, and sum`
3. `my_array=(1 2 3)`
4. `count=0`
5. `sum=0`
6. `for i in ${!my_array[@]}; do`
7.   `# print the ith array element`
8.   `echo ${my_array[$i]}`
9.   `# increment the count by one`
10.   `count=$(($count+1))`
11.   `# add the current value of the array to the sum`
12.   `sum=$(($sum+${my_array[$i]}))`
13. `done`
14. `echo $count`
15. `echo $sum`