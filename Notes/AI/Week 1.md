# Search Problems
## Terms
	1) Agent
		1) An entity that percieves its environment and acts upon that environment 
	2) State
		1) A configuration of an agent and its environment at a point of time
	3) actions
		1) going from one state to another
		2) ACTION(S) -> returns the set of actions that can be executed in this state
	4) Transistion Model
		1) Result(s, a) return the state after we perform action a in state s
	5) goal state
		1) if you reached expected state
	6) path cost
		1) numerical cost with associated path
	7) node
		1) keeps track of cost to reach the node from initial state
		2) a state
		3) a parent node(node that generated this node)
		4) an action (the action took to reach the node from the parent)
	8) Frontier 
		1) the state that can be explored next
		2) if frontier is empty then their is no solution
		3) How to use nodes in frontier
			1) remove a node from the frontier
			2) if the node contains the goal state, return the solution
			3) or expand the node and add resulting nodes to the frontier

### Frontier
	- should we remove randomnly?
	- use a stack for representing the frontier (LIFO), then it becomes a depth first search
	- after removing the node from the stack move it to the explored set
	- use a queue for breadth first search

