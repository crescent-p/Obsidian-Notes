
# Relational Data Model

a relation is a mathematical concept based on the idea of sets
found by EF Codd
Relation = table in database aka a set of rows aka a set of coloumns
a relation may be regarded as a set of tuples

#### intension and extension
intension is the attributes
extension is the values of the attributes 

extension aka population aka state

intension doesn't change often, extension changes very often
R(A1 , A2 , .........., An ) eg: R(Name, age, address) 
r(R) = dom (A1 ) X dom (A2 ) X ....X dom(An ) eg: (crescent, 21, Crescent House)

### Informal Terms         Formal Terms
Table                                     Relation
Column                                 Attribute/DomainRow Tuple
Values in a column               Domain
Table Definition                    Schema of a Relation
Populated Table                    Extension

## Keys

#SuperKey : set of attributes such that any extension is distinct

A minimal super key is chosen as the #key

Set of all possible keys is the set of #candidatekeys

entity integrity : primary key attribute can't be null
referential integrity : connects two relations. connected using primary key and foreign key.
	the foreign key must point to a primary key that exits, otherwise it is a violation


# Schema Diagram

![[Pasted image 20241116135104.png]]


# ER To Relational Mapping ( Algorithm) ( Just look at an example )

Step 1: Mapping of Regular Entity Types
	In the ER schema pick strong aka regular entity type E and create a relation with that entity and E's simple attributes.
	Choose one of the key attributes of E as the primary key.
Step 2: Mapping of Weak Entity Types
Step 3: Mapping of Binary 1:1 Relation Types
Step 4: Mapping of Binary 1:N Relationship Types.
Step 5: Mapping of Binary M:N Relationship Types.
Step 6: Mapping of Multivalued attributes.
Step 7: Mapping of N-ary Relationship Types.

# Mapping EER Model Constructs to Relations
Step 8: Options for Mapping Specialization or Generalization.
Step 9: Mapping of Union Types (Categories).

ER MODEL
![[Pasted image 20241116140523.png]]

Schema Diagram
![[Pasted image 20241116140548.png]]


Relational model is a purely mathematical model using set theory and logic.

![[Pasted image 20241116140900.png]]

# RELATIONAL MODEL

Data manipulation languages
	Procedural  :  Specifies the (high level) strategy to find the data in sets or bags  = ==RELATIONAL ALGEBRA
	
	   NON Procedural : Only specifies what data it wants to find = **RELATIONAL CALCULUS**


## Relational Algebra
Select : symbol ![[Pasted image 20241116143149.png]]

Projection : ![[Pasted image 20241116143222.png]]

Union : R U S

Intersection : ***(SELECT * FROM R) INTERSECT (SELECT * FROM S);*

Difference : ***(SELECT * FROM R) EXCEPT (SELECT * FROM S);***  
![[Pasted image 20241116143431.png]]

Product : aka CROSS JOIN ***SELECT * FROM R CROSS JOIN S;*** or ***SELECT * FROM R, S***

Join : ***SELECT * FROM R NATURAL JOIN S;***
		***SELECT * FROM R JOIN S USING (a_id, b_id);***
	![[Pasted image 20241116143640.png]]

# SQL 
#SQL is based on bags not sets. So its allows for duplicates.



## Window Functions

	Aka analytical functions
	
suppose there is a table employee with emp_id, emp_name, dept_name, salary 

You want to find the max salary in all whole Institure.

`SELECT MAX(salary) FROM employee`

Now you want to find the max salary with employee details in each dept

`SELECT *, MAX(salary) over(PARTITION BY dept_name) as max_salary from employee`

`SELECT *, row_number()/rank()/dense_rank() over (PARTITION BY dept_name order by emp_id) as rn from employee`

rank -> if equal shows same number, then skips the number of equal rows.
dense_rank -> if equal shows same number , but doesn't skip the values.

# Query Processing

1) Iterartor model :- aka volcano aka pipe. Each operator implements a NEXT() function that either returns null or the next tuple.
		allows for output control, operators must block till children emit all the tuples. 
		in order by all tuples need to found first to successfully sort them. LIkewise in hashjoin. All tuples need to be hashed before           joining
2) materialization model
	processes its input all at once and then emits its output all at once.
	output can be whole tuples (Nary storage) or subset of columns (Decomposition storage)
	good for OLTP processing bcoz small amount of tuples are accessed. fewer function calls. 
3) vectorized/batch model
	just like iterator model, but the size of ouput is batched. Internally runs a loop of NEXT() calls and outputs when it hits a certain number of tuples.
	ideal for OLAP. allows for SIMD to process batches of tuples.

# Plan processing direction

1) Top to bottom
2) Bottom to top

## Access Methods ( not part of relational algebra )
1) sequential scan -> retrieve from buffer pool, look at the last scan item. Scan from the next element.
Data skipping : approximate queries (lossy), Zone maps (lossless) zone map contain data like max min avg so it can decide whether to check that page or not. Trade off between page size and filter efficacy.
1) index scan
2) multi index scan
Halloween problem. the update operation changes the physical location of the tuple causing it to be scanned again.
solution : track modified record ids per query.

## Optimal plan
1) Heuristic approach
2) cost based search

### Logical query optimization
	1) split conjuctive predicates
	2) predicate pushdown
	3) replace cartesian products with joins
	4) projection pushdown
### Nested sub queries
	1) rewrite to decorelate the queries.
	2) decompose nested query to temporary tables.

### Cost model components
	1) Physical costs
		1) predict cpu cycle, cache, memory hits
	2) Logical Costs
		1) estimate output size per operator. Choose smaller one initally to avoid redundant overhead
		2) need estimations for operator result size.
	3) Algorithmic costs
		1) complexity of algorithm implementation

#### Logical Costs
	Equality
	Negation
	Range
	Conjunction (AND)
	Disjunction (OR)
SELECTION Cardinality = |occurrence of the element| / total # elements
	1) uniform data
	2) independent predicates 
	3) inclusion principle for joins the attribute joined on exists on both the relations
#### Statistics
1) Histograms : stores count of values in certain range sets
2) Sketches : gives approximate count for given value
3) Sampling : DBMS stores sample data set of a large table.

### Single Relation Query planning
1) pick best access method (bin search for clustered indexes, seq scan , index scan)
2) predicate evaluation ordering
3) pick best index
4) simple heuristics
5) joins always on foreign keys with small cardinality
### Multi Relation Query planning
	1) Bottom up optimization
		Selinger
		1) choose best access path for each table
		2) enumerate all possible join orderings for table
			1) choose which join to use sort-merge join or hash join
		3) take ordering with minimum cost
	1) Top down optimization

sort merge -> sorts both attributes in both the relations.
hash join -> create a hash table for the relation with smaller attribute