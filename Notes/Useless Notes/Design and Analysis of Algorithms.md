# Topics
	1) NP, P, I, NP-complete, NP-Hardness
	2) Reductions between problems
	3) Vertex cover and independent set problems
	4) Boolean satisfiability (SAT)
	5) Fractional Knapsack problem
	6) karp reduction
	7) Levin Cook Theorem


# What is reduction?
	- Problem A inputs are converted to equivalent (meaning the same YES/NO answers) Problem B inputs. 
	- If B ε NP then A ε NP
	- If B ε P then A ε P
	A reduction of problem instances of A to B means that :
		- a solution to problem B directly provides a solution to A
		- the transformation itself must be computationaly efficient
	There are many types of reduction
		1) Many-one reduction aka KARP REDUCTION
			- maps instances of A to instances of B such that A's answer is "YES" iff B answer is "YES"
			- strict and structure preserving. used for NP-Completeness proofs
		2) Cook Levin Reduction
			- Solve A using a hypthetical algorithm for B. Allowing multiple queries to B.
			- more flexible but 
		3) Polynomial time reduction
## What are certificates?
	A certificate is a string or a proof that validates the answer to a computational problem
	Certificates provide evidence that can be efficiently verified by a verifier in polynomial time.
## Misconceptions
	- If A reduces to B, then it doesn't mean B is harde than A. It only means B's hardness upper bounds A's hardness.
# NP, P, I, NP-complete, NP-Hardness
	There are 3 types of problems
	1) problems that can't be computed
	2) problems that can be computed in polynomial time by computers
	3) problems that can't be computed in polynomial time by a classical computer

	Common resources for computing are time and space.
	Time complexity of O(n^k)  where k is constant and n is input size is called polynomial time algorithm
	Time complexity of O(k^n) is called exponenetial time complexity

![[Pasted image 20250320212616.png]]
## P Class
	These are decision problems. Problems that a yes/no solution.
	- Solution to P problems are easy to find
	- P is often a class of computational problems that are solvable and tractable
		- Tractable : The problem can be solved in theory and in practice
		- Intractable : The problem can be solved in theory but not in practise
## NP class
	 Non Deterministic Polynomial Time decision problems.
	 A collection of problems that can solved in polynoimal time by a non-deterministic machine.
	 - The solutions are hard to find.
	 - But given a solution it is easy to verify it in polynomial time.
	- A non deterministic machine can guess the answers and the results of the gusses can be called a certificate
	- Eg: SAT, Hamiltonian Path Problem, Graph colouring
## Co-NP 
	The set of problems whose solution can be discarded in polynomial time.
	- If a problem X is in NP then its complement X` is also in Co-NP
	- Eg; checking if prime
## NP-Hard 
	A class of problems such that is harder than every problem in NP. 
	- Every problem in NP reduces to NP-hard

![[Pasted image 20250321110418.png]]
The intersection of NP and NP-Hard is NP-complete

	- We believe P != NP. In that case if a problem is in NP-Hard then it is not P.
	- 

## NP-Complete
	- If x is in NP
	- If x is NP-Hard
	- How to prove X is NP-Complete
		- prove NP
			- give a non-deterministic poly time algorithm
			- give a certificate + verifier
		- reduce a NP-complete problem Y to X 
## 3SAT
	literal -> variable
	clause -> x OR y OR z (3 literals with an OR)
	Q: Can you set the variables such that formula comes out TRUE
Examples:
- **(x1 ∨ x2 ∨ x3) ∧ (¬x1 ∨ x2 ∨ x4) ∧ (x3 ∨ ¬x4 ∨ x5)**
- **(a ∨ b ∨ c) ∧ (¬a ∨ ¬b ∨ c) ∧ (a ∨ ¬b ∨ ¬c)**
- **(x ∨ y ∨ z) ∧ (¬x ∨ ¬y ∨ ¬z)**
- **(p ∨ q ∨ r) ∧ (¬p ∨ ¬q ∨ r) ∧ (p ∨ q ∨ ¬r) ∧ (¬p ∨ ¬q ∨ ¬r)** 

		-  Why is 3SAT NP-Complete
		- Any problem can be turned into a computer program
		- Any computer prgram can be converted to a circuit
		- Any circuit can be converted to a 3SAT problem.
		- Now the problem is solvable if there exists a ceritificate for 3SAT that can gives YES by a verifier

	

# 3SAT to Super Mario Brothers
	- Super mario brothers in NP-Hard
	- A variable module (also calles a gadget)
		- you can enter, but can't exit through the entrance.
		- you can fall into two holes (also not reversible)
		- corresponds to a literal and choosing TRUE or FALSE for that variable.
		
![[Pasted image 20250321113214.png]]

	- There are clause gadget as well
		- If a variable is TRUE, then it connects to all the clause gadget that has x literal
		- if a variable is FLASE, then it connects to all the clause gadgets that has !x literal
	- So in essence there are many literals that many clausese.
		- mario goes through all the literals one by one
			- first he goes to x and if he chooses X TRUE, the he takes a path through all the clauses that has the X set to TRUE (not !X). and vice versa. After taking the path he ends up at y. where he again needs to choose y or !y and visit all  the corresponding clauses.
	- After going through all the variable. He goes throught all the clauses. Now if he made all the correct choicses he can pass through all the clauses and end the level. Otherwise he fails.

![[Pasted image 20250321114610.png]]

## 3Dimentional Matching
	- You are given 3 sets X, Y, Z of size n
	- A collection T set of X x Y x Z of ordered triplets
	- The goal is to determine if there is a subset such that M subset of T such that
		- each element of X, Y, Z appears in one triplet in M (compulsorly)
		- The size of M is exactly n, the size of the original sets.
	- In simpler terms you want to select a subset such that no triplet has repeated values.
	- This problem is NP, Becuase given a solution we can check the solution in polynomial time.
		- For every size of M = k
		- Form a set X U Y U Z, then for every k ε M, remove the corresponding 3 elements from set X U Y U Z, if at any stage we can't remove the element then solution is wrong, otherwise if we finish then the solution is correct.


$example :$ 
#### $**Input:**$
- $X={a,b,c}X = \{a, b, c\}X={a,b,c}$
- $Y={1,2,3}Y = \{1, 2, 3\}Y={1,2,3}$
- $Z={α,β,γ}Z = \{ \alpha, \beta, \gamma \}Z={α,β,γ}$
- $T={(a,1,α),(b,2,β),(c,3,γ),(a,3,γ)}$
#### $**Output:**$
- $A perfect matching: {(a,1,\alpha), (b,2,\beta), (c,3,\gamma)}$

# Time Complexity
## Measuring Complexity
	Let M be a deterministic turing machine that halts on all inputs. The running time or time complxity of M is the fucntion f: N -> N where f(n) is the maximum number of steps the machine might take on an input of length n. WE say M is a f(n) time turing machine.

### Big O and Small O notation
	Calculating running time is very inconvinient. So we just estimate it.

	- Asymptotic upper bound aka Big O notation.
		- We say f(n) = O(g(n)) if f(n) <= c * g(n)
	- We can think of O() as suppressed constant