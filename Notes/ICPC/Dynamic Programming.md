
	1) IF you have to pick something but if you pick in a certaing range you lose something. Then give +1 and -1 to objects and do a maximum subarraysum to get optimal choice.

Increasing Frequency: https://codeforces.com/problemset/problem/1082/E

	2) 

## Bitmask DP
	use bits to represent sets.
	state should be like dp[subset][some attribute].

	- There are n cities and m flight connections between them. You want to travel from Syrjälä to Lehmälä so that you visit each city exactly once. How many possible routes are there?
			Let $dp[S][i]$ be the number of routes that visit all the cities in the subset
$S$ and end at city $i$. The transitions will then be:

$$dp[S][i] = \sum_{x \in adj[i]} dp[S \setminus \{i\}][x] \text{ if $x \in S$}$$

where $S \setminus \{i\}$ is the subset $S$ without city $i$.


## Longest increasing subsequence.
	If the LIS is 3 then there will be atleast 3 different LDS in that same array. This is because all the elements in a LIS should belong to diffent LDS sequences.
	1 3 4 4 4 3 2 1
		1) should use lowerbound to get sequence of 1 3 4
		2) should use upperbound to get sequence of 1 3 4 4 4
			1) inorder to find number of decreasing sequences this is needed. As 1, 3, 4, 4, 4 should belong to different sequences.


## Digit DP
	Solve for 0 to a - 1 and 0 to b and subtract.
	1) things we need to remember ->
		1) a boolean f1 :: if we have choosen something smaller building the number from the left. If we have then we are free to choose any number greater or lesser than b. Else we can only choose choose max(b[i]) at that position.
		2) a boolean f2 :: if we have chooosen a number bigger than a building the number from left to right. IF YES then we are free to choose anything, otherwise we have to chosse in range a[i] to 9.



```cpp
  
ll dp[25][2][2][2];
  
ll find(ll pos, ll under, ll over, ll started, ll prod, string num);


//basic parameters to have
```

	1) under if number is already lower than b in [a, b]
	2) over if number is already higher than a in [a, b]  ie, if we chose a nubmer a + 1 before then we are free to choose anything for the next digits.