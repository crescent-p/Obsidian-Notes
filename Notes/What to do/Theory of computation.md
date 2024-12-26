# Regular languages
	 can be recognized by finite auto mata. Simplest type of language in chomsky hierarchy.
	 can be fully explained by regular expressions.
		1) deterministic finite automata
		2) non-deterministic finite automata

$$A \rightarrow aB \space or A \rightarrow a$$

	Where A and B are non terminals and a is a terminal.
## Regular grammar
### Left linear grammar
$$S \rightarrow aA$$$$A \rightarrow bB$$$$B \rightarrow c$$
### Right linear grammar
	$$S \rightarrow Aa$$$$A \rightarrow Bb$$$$B \rightarrow c$$
==Can't contain memory due to their correspondence with finite automata which lacks storage==


# Regular Grammar
	used to generate regular languages.

$$G = (N ( set of non terminals ), \sum ( set of terminals), P(production rules), S ( start symbol))$$ 
	cant generate languages that need memory to genrate such as balanced  paranthesis, recursive patterns. 


# Context Free languages
	languages that can be created by context free grammars. Can genrate more complex structures like pattern matching, matching parenthesis or expressions in programming languages.

$$G = (N ( set of non terminals ), \sum ( set of terminals), P(production rules), S ( start symbol))$$

	examples : balanced parenthesis, palindrome language, arithmetic expression
	Closure properties : 
1) union $$ (L1 \cap L2)$$
2) concatenation
			$$L1L2$$
	
	
		not closed under intersection and  complementation
		
		CFL's can be recognized by push down automata #PDA, which are finite automata with a stack.
## Production rules
The production rules in a CFG must follow these guidelines:

- **Single Non-Terminal on the Left-Hand Side**:
    
    - Every rule must have a single non-terminal symbol on the left-hand side $$(e.g., A→α).$$
    - Example:$$ S→aSb $$is valid, but$$ aS→b $$is not.
- **Right-Hand Side Can Be a Combination**:
    
    - The right-hand side (α\alphaα) can consist of:
        - Terminals only$$ (e.g., S→a).$$
        - Non-terminals only (e.g., S→A).
        - A mix of terminals and non-terminals$$ (e.g., S→aA)$$.
        - The empty string $$(S→ϵ).$$
-![[Pasted image 20241120220636.png]]

balanced parentheses
	$$S \rightarrow  (S) \space S \rightarrow SS \space S \rightarrow  \epsilon$$
![[Pasted image 20241120221100.png]]

# Chomsky normal form 

![[Pasted image 20241120224412.png]]

# Greibach normal form
![[Pasted image 20241121092438.png]]

![[Pasted image 20241121092941.png]]

	$$S\rightarrow \epsilon$$ only allowed for start symbol.

# Ambiguous grammar
	A parse tree generated from the grammar has one or more forms.
	Ambiguity occurs when the grammar fails to enforce a single, unique structure for each string.

## Removing ambiguity ::TODO



# Converting PDA to CFG
	For simplicity assume the following:
		1) have a single start state
		2) use final state acceptance
		3) empty its stack before final acceptance
1) Define the grammar's non terminals.
	1) It contains of symbols Apq that take machine from state p to state q while leaving the stack unchanged.