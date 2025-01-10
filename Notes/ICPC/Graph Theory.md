	 Printing the path = storing the previous node in an array and backtrackig.
	 
	 
	 0/1 BFS -> instead of using a priotiy queue we use a deque.
		 - The weights are only 0 or 1.
		 - if we get a node via an edge of weight 0 we add it to front of deque. and 1 to the back of the deque.
		 - this is same as sorting. rest all the same.



## Tracks in the snow


`https://oj.uz/problem/view/BOI13_tracks`

	Uses 0/1 disjktra's
	The whole array can be flood filled to find the individual "spots". Then each time we go from one spot of Fox to Rabbit we increase the depth. The max depth + 1 is the correct answer.
	Alternate TLE solution. 
		-Find the last animal that traversed the array. Flood fill from top left corner and change it to opposite animal.
		-Repeat until all the visited positions are affected.



## Tree path quries
	Technique of creating treearrays. 


![[Pasted image 20241209220611.png]]

	- Write dfs alogrithm that updates an array in order of traversal. 

```cpp
int dfs(vector<pll> &treearray, int src, int parent) {  
    int treesize = 1;  
  
    for(auto&k : edges[src]) {  
        if(k == parent)  
            continue;  
        treesize += dfs(treearray, k, src);  
    }  
    treearray.push_back({src, treesize});  
    return treesize;  
}
```

# Binary Lifting

```cpp
  for(int j = 2; j <= n; j++) {  
   for(int i = 1; i <= 18; i++){  
        depth[j][i] = depth[depth[j][i - 1]][i - 1];  
    }  
}
```


![[Pasted image 20241210112052.png]]

## Topo sort
	for DAG we can do DP from outside to inside. First do toposort and then dp on each layer working from outside to inside. 
```cpp
queue<ll> q;  
for(int i = 1; i <= n; i++) {  
    if(indegree[i] == 0) {  
        q.push(i);  
    }  
}  
//initializing dp
// finding number of path sum ways to reach a node from starting node 1;
dp[1].insert(0);  
while(!q.empty()) {  
    int top = q.front();  
    q.pop();  
    for(auto&k : edges[top]) {  
        for(auto&q : dp[top]) {  
            dp[k].insert(q + 1);  
        }  
        if(--indegree[k] == 0) {  
            q.push(k);  
        }  
    }  
}  
return dp[n];
```


## Building the answer bottom up
	first iterate dfs the children and form the answer for them.
```cpp
	void dfs(int src, int par) {  
    dp[src][0]= 1;  
    for(auto&edg : edges[src]) {  
        if(edg == par)  
            continue;  
        dfs(edg, src);  
	//adding the dp answer from current child after calucating.
	// this means no overlaop/
        for(int i = 1; i <= k; i++) {  
            ans += dp[src][i - 1] * dp[edg][k - i];  
        }  
        for(int i = 1; i <= 500; i++) {  
            dp[src][i] += dp[edg][i - 1];  
        }  
    }  
}
```
![[Pasted image 20241219110709.png]]


## Paths on grid DP
	you can consider them as sequences LDLLDDLLD and write a dp for them, rather than vizualise the movement on a matrix.
	1) # Cow Checklist
		1) Rather than computing the choices you can make in a 2D plane. convert them to sequence like 
					1) H1G1G2G3H2.... 
					2) dp state would be [h number][g number][end in g or h]

## Range DP
	1) start with a for loop for picking subarray length
	2) another for loop for startin location of subarray.
	3) next loop for finding min of dp[i][i + j]

```cpp
//for finding lenght of subarray
for(int j = 0; j < s.size(); j++) { 
//starting location
    for(int i = 0; i < s.size() - j; i++) {  
        dp[i][i + j] = dp[i + 1][i + j] + 1;  
        //finding min in that range in O(j) time;
        for(int k = i + 1; k <= i + j; k++) {  
            if(s[k] == s[i]) {  
                dp[i][i + j] = min(dp[i][i + j],  
                    dp[i + 1][k - 1] + dp[k + 1][i + j]);  
            }  
        }  
    }  
}
```


# Shortest Path Modeling

	Graph modeling is where instead of rewriting dijkstra's to match the problem, we reconfigure the graph and use normal dijkstra to find the solution.
	We want to craete additional nodes to represent some state.
	 For example if there is 10 nodes and there can be 5 states for each. We create a 10 * 5 node graph to represent it.
			 For these the time complexity would be of order O(n^2).

### Problem 1
	You have to travel from city A to city B, car can store K litres of petrol. Each city has price of petrol Ci, and traveling between city u to v cost Li litres of petrol. Find minimum litres of petrol needed.
		- the graph has to have node for (city, fuel_in_tank)

  ![[Pasted image 20250110201525.png]]  

	 Here going from cityA to cityB, C, D doesn't take any weight, and fueling the car costs Li dollars. No we can run dijkstra from (0,0) and answer would be min of (n, [0 - max_capacity]).
