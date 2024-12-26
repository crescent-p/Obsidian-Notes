	 
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

#SuperKey : set of attributes such that any extension is distinct, superkeys may have redundant attributes

A minimal super key is chosen as the #key

Set of all possible keys is the set of #candidatekeys

entity integrity : primary key attribute can't be null
referential integrity : connects two relations. connected using primary key and foreign key.
	the foreign key must point to a primary key that exits, otherwise it is a violation


# Schema Diagram

![[Pasted image 20241116135104.png]]


# ER To Relational Mapping ( Algorithm ) ( Just look at an example )

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
	Graefe
		1) convert logical operators to physical operators
		2) 
		
sort merge -> sorts both attributes in both the relations.
hash join -> create a hash table for the relation with smaller attribute


# Concurrency control
## Strawman system
	Do each txn one by one. Copy entire database before making any changes. if txn fails, remove the copy.

Transaction syntax
	BEGIN 
	COMMIT / ABORT
## ACID
atomicity : either all commits or none commits
consistency : if txn started consistent and commits consistent then DB is consistent
isolation : execution of one txn is isolated from other transactions
durability : if txn commits the effect persist

### Atomicity 
	1) logging
	2) shadow paging. Add transaction written to copied page. when txn commits this page is made visible to others.
### Isolation

	1) DBMS interleaves Read/Write of different transactions. We need a way to make it look like it ran in a sequence.
	pessimistic ( make sure problems dont arise ) vs optimistic ( assume problems dont arise )

#### Serial Schedule
	a schedule that doesn't interleave multiple read/writes
#### Equivalent Schedules
	the effect of executing first schedule is the same as executuing the second schedule.
#### Serializable Schedule
	a schedule that is equivalent to some serial execution of the transactions.

#### Conflicts
##### Read write (RW) 
	unrepeatable reads. Txn gets different values reading the same value multiple times.
##### write write (WW)
	one txn overwrites uncommited data from another transaction
##### write read (WR)
	dirty read : one txn reads data that is uncommited by another txn.

#### Conflict Serializability
	Most DBMS support this
	reorder R W to acheive this
	Use dependency graphs
	if Oi of Ti conflicts with Oj of Tj then add edge from Ti to Tj. The schedule is conflict serializable if there is no cycles in the precedence graph.

#### View Serializability
	  Impossible to achieve. 
	  Take a concurrent schedule and a serial schedule. Now the concurrent schedule is view serializable if T1 in Conc. Schedule reads the same initaila value as Seri. Schedule. if T1 reads value written by value T2 in conc schedule it is the same in seri. Schedule. And the if final value is written by T1 in conc. then it is written by T1 in seri. as well.

Subset of == > 
==$$all Schedules  \subset View Serializable \subset conflict serializable \subset serial$$==

## Durability
	 no torn updates
	 no changes from failed transactions
	 use logging or shadow paging to achieve this.
## Lock Types
	S Locks shared
	X Locks Exclusive
			
![[Pasted image 20241117125417.png]]
1) transactions request for lock
2) lock manager looks at lock table and decides whethere to grant or deny locks
3) transactions release lock after use
4) lock manager updates the lock table and loos for transactions that are waiting for lock
# Two Phase locking (2PL)
	use locks to protect database objects.

### Growing
	only acqurires locks
### Shrinking
	only releases locks.

==Subject to cascading aborts==
==may also have dirty reads because T1 release locks before committing==
==may lead to deadlocks==

Because the transaction T1 might abort after releasing some locks. So it might influence the T2 transaction even though it aborted.]] ]]                                                                        ![[Pasted image 20241117130046.png]]
 
## Strong strict 2PL ( aka rigorous 2PL )

	transaction is allowed to release locks after it has ended.
	a schedule is strict if a value written by transaction not read by other tranactions before it is commited.
advantages
	1) avoids cascading aborts
	2) to revert back changes just go back and change the modified values made by aborted transaction


## Deadlocks In 2PL
### Deadlock detection
	The DBMS creates a waits for graph to keep track of what locks each txn in waiting for to acquire.
	System periodically checks the graph for cycles and decides when to break them.

	 When a cycle is detected the DBMS picks a victim transaction to restart or abort.
### Deadlock handling
	Completely : rollback entire txn and tell it was aborted
	partial : checkpoints or savepoints. rolls back to nearest checkpoint and retries.
### Deadlock prevention
	When a txn tries to acquire a lock that is held by another txn the txn is aborted.
	Doesn't require a dependency/"waits for" graph

#### Based on priority
older timestamp = higher priority 
Txn that started earlier should complete first
##### Wait die ( old wait for young)
	if requesting txn has higher priority, then it waits
	if requesting txn has lower priority it aborts
##### Wound wait (young wait for old)
	if requesting txn has higher priority, then holding txn aborts.
	if requesting txn has lower priority it waits.

![[Pasted image 20241117132613.png]]

Why does this work (wound wait and wait die) ? 
	- only one direction of locking allowed, hence no chance of forming deadlocks
When txn restart it gets it initial timestamp to prevent starvation.

# Lock granularities

Decide the  scope of a lock. ==Database, Attribute, Tuple, Page, Table== 
Trade Off 
	Fewer lock, Larger granularity vs More locks, smaller granularity
## Intention Locks
	Allows for a table or database to be locked without individually locking all the tuples in it.
	If a node is locked in intention lock then some txn is doing explicit locking in lower levels in the tree.
### Types of intension Locks
	1) Intention Shared (IS)
	2) Intention Exclusive (IX)
	3) Shared + intention Exclusive (SIX)
#### Locking protocol
	1) To get S lock on node the txn should have atleast S or IS on parent node.
	2) To get X lock on node the txn should ahve atleaset X or IX or SIX on parent node.

![[Pasted image 20241117140220.png]]

Lock escalation - > DBMS automatically switched to higher level lock when a transaction starts acquiring too many lower level locks.

# Time Stamp Ordering Concurrency Control
## Basic T/O
	Every object is tagged with the timestamp of the txn that last read/write it.
	W-TS(X) write timestamp on X
	R-TS(X) Read timestamp on X
	
	If a txn tries to read a value that was written in the "future" abort W-TS(X) > TS(Ti).
	or allow txn to read the value but update the R-TS(X) to max(TS(Ti), R-TS(X)) and create a local copy of X to ensure repeatable reads Ti.

	TS(Ti) < R-TS(X) or TS(Ti) < W-TS(X)
	If a transaction tries to write to a value that was modified (read/write) by a txn in the future, then abort.
	or allow to write but make a local copy to ensure repeatable reads.

### Thomas Write Rule
	if TS(Ti) < R-TS(X): "can't write to something that was already read by someone from future"
		abort and restart Ti
	if TS(Ti) < W-TS(X): 
		ignore the write to allow executing 
	else
		overwrite X and update timestamp
==In Layman terms if a new update has already written to the data item then there is no need to write it now, since it would be overwritten in the future anyway==

==Long running transactions might get starved, the possibility that it might read from some future txn increases==
Every read requires updating the database for timestamp.

# Optimistic concurrency control (OCC)
	Assume conflicts between txns are rare and most txns are short lived.
	The DBMS create a private workspace.
	The values read are copied into the workspace and all modifications are made on this workspace.
	After commit, it checks whether the write set of workspace conflicts with other txns.


## Phases
#### Read
	the transaction number is assigned at the end of read phase. Read phase also includes writing.
#### Validation
	Check for serializable schedule-related anomalies.
#### Write
	safe to write
	Serial commit : only a single txn can be in write at the same time
	parallel commits : use fine grainded lactch locks to enable parallel writing
					- txns aquire locks in primary key order to avoid deadlocks.

![[Pasted image 20241117145153.png]]

Here the values might be mid way written in Ti Write phase and Tj might copy it into its workspace. And Ti might abort during the write. So in order to avoid this ensure the write set of $$Ti \cap  Tj = \phi$$
==OCC works best when all txn's read only and number of conflicts are low and txn access disjoint set of data==

**Drawbacks**
- High overhead of copying data to private workspace
- Bottleneck of validate/write phase.
- Aborts are more wasteful as it occurs in last stage after all the work has been completed.



## Phantom Problem

	What if something is inserted in the middle of another query. That query has no idea of the currently inserted tuple.
### Solutions
	1) Re-execute Scans, re run scan at commit to check what difference it made
	2) Predicate Locking : logically determine the overlap of predicates before starting queries
	Shared lock on SELECT querie's WHERE clause. And Exclusive lock on DELETE, UPDATE, INSERT
	3) Index Locking : Use keys in indexes to protect ranges.`


## KEY LOCKING SCHEMES

**Using Indexes**

	1) Key value locks -> covers a single key-value in an index, virtual key for non-existent values.
	2) Gap locks
	3) Range locks
	4) Hierarchial locks
	
Locking without an index -> A lock on every table with status = 'lit' and lock on the table to prevent other txns from adding entry with status = 'lit'

### ISOLATION
	Levels
	1) SERIALIZABLE 
		- Obtain all locks first, index locks, strong Strict 2PL
	2) REPEATABLE READS : phantoms may happen
		- Doesnt get index locks
	3) READ COMMITED : phantoms and unreapeatable reads can occur
		- S locks released immediately
	4) READ UNCOMMITED : phantom, unrepeatable read, dirty read can occur
		- no S locks




# Functional Dependency
	formal definition of the goodness of a relational design
	FD's and keys are used to define the normal forms.

# Normalization
	1) minimize redundancy
	2) minimize insert delete update anomalies
	3) Conditions to be met by using keys and funcitonal dependencies.
		1) Should have lossless join propery
		2) dependency preservation property

	1NF: no multivalued attribute 
	2NF: every non prime attribute is entirely dependent on composite key (no partial dependency)
	3NF: no transitive dependency, if X -> Y, then X is a superkey or a prime attribute
	BCNF: 3NF + for every dependency X -> Y X is a superkey (there is no hook back dependency)
	4NF: No multi valued dependencies 
	
- **1NF (First Normal Form):**
    
    - Ensures the table has a **unique identifier (primary key)**.
    - Removes **repeating groups**; all values must be atomic (no lists or sets).
- **2NF (Second Normal Form):**
    
    - Achieves 1NF and removes **partial dependencies** (no non-prime attribute depends on part of a composite key).
- **3NF (Third Normal Form):**
    
    - Achieves 2NF and removes **transitive dependencies** (non-prime attributes must depend only on the candidate keys).
- **BCNF (Boyce-Codd Normal Form):**

    - A stricter version of 3NF where every **determinant** (attribute that determines others) must be a candidate key.
- **4NF (Fourth Normal Form):**
    
    - Removes **multi-valued dependencies** (one attribute being dependent on two independent attributes).
- **5NF (Fifth Normal Form):**
    
    - Ensures data is split into the smallest possible tables to eliminate redundancy and dependency anomalies.

![[Pasted image 20241117201417.png]]
![[Pasted image 20241117201424.png]]

#### Spurious tuples
	Spurious tuples are rows that appear due to improper joining after decompostion. They don't exist in the original table and result from incorrect or incomplete decomposition of a database table.
	1) Occurs when the decomposition is not lossless.
	2) Decomposition is done on attributes that don't fully preserve the relationships.


# MVCC multiversion concurrency control

	DBMS maintain many physical version of a single logical data. When a txn writes a tuple, a new version is created. When a txn reads the data reads the latest version.
	Writer don't block reader
	Reader don't block writer

Read only transactions can read a consistent snapshot without acquiring locks. Time travel queries.

## Snapshot Isolation
	When a txn starts it sees the consistent snapshot when the txn started.
SI is susceptible for write skew anomaly. marble example.

### Version Storage
	uses tuple pointer field to create a list of versino chain per logical tuple.
	helps to show the lateset version to read 
	indexes always point to the head of the list.
	1) append only storage
		1) stored in same table
		2) version chain order
			1) oldest to newest (02N) : append at end. must traverse whole list on lookup
			2) newest to oldest (N2O)  : must update all the index pointers as they must point to the head.
	2) time travel storage
		1) keep a separate table 
		2) main table keeps the latest version
		3) time travel table keeps a list of previous versions
	3) delta storage
		1) keep a separate table
		2) when update are made only the updates are stored in the sep. table.
		3) transactions can recreate the inital value by replaying the changes.
### Garbage Collection
	Need to reclaim physical memory by removing redundant physical versions.
		1) no active txn can see the version (SI)
		2) versino made by aborted transaction
#### Tuple level
	1) Background vaccuming
		1) separate threads periodically scans for reclaimable versions
	2) Cooperative cleaning
		1) Worker threads identify reclaimable ones as they traverse version chain.
		2) only works in oldest to newest, in newest to oldest all the versions are not visited.
#### Transaction level
	Transactions keep track of their old versions so DBMS dont have to scan tuples to determine visibilty.
	1) each txn keeps track of its read/write set.
	2) on commit/abort this information is passed to a centralized Garbage collector 

### Index Management
	The indexes point to head of version list
#### Primary Indexes
	When a tuple is updated, it is treated as a delete and insert in indexes. Since the logical location of the data should change. (Beacuse it is ordered). Primary indexes are easy. Secondary indexes are complicated
#### Secondary indexes
	1) logical pointers
		1) use a fixed identifier per tuple that doesn't change
		2) requires an extra indirection layer
		3) eg: primary key vs tuple id
		4) map the secondary index to primary index and then to tuple id
		5) create a TupleId->Address table and map secondary index to this

![[Pasted image 20241117222014.png]]

		2) Physical pointers
			1) Use the physical addrss to the version chain head. The indexes store the adress of the location where the head would be and everytime we update it, we can just update the value at the address position.



# Crash Recovery
	Action during normal txn processing to ensure DBMS can recover from failure.

	1) data stored in non volatile storage but this is slow.
	2) copy the data to main memory, write the data to memory
	3) write back to disk
	4) Should be able to UNDO and REDO
	5) UNDO -> removing the effects of a commited transaction
	6) REDO -> repplying the effects of a completed transaction

## Steal Policy
	Whether the DBMS allows an uncommited txn to write to disk, because another trasaction that changed the same tuple is commiting.
	STEAL -> allowed
	NO STEAL -> not allowed
### Force
	Whether the DBMS requires all changes made by txn to be in disk before saying commited.
	FORCE -> yes 
	NO FORCE -> no

### NO STEAL + FORCE
	Force mean the data should be written to disk before saying commited, and steal means uncommited data is not written to disk.
	Very easy to rollback. Since uncommited data is not written to disk, just ignore.
	Never have to do REDO, since all changes are written to disk before saying we commited.
	Problem : since it is no steal, we can't make changes that are bigger than the buffer pool of the Database.

#### Shadow Paging 
	uses NO STEAL + FORCE
	keeps a master and shadow page. Instead of copying entire database, individual pages are copied. On commiting the root pointer is updated to point to the shadow page, effectively swapping them.
	UNDO : remove shadow pages.and change the root back to master. 
==NOTE : the shadow pages are written to disk only after committing.==

**DISADVANTAGES**
	1) memory gets fragmented
	2) commit overhead is high, we have to flush entire pages, even though only a few tuples are updated.
	3) Copying entire page table is expensive.
	4) need garbage collection for master pages turned shadow pages.
	5) When committing only one writer is allowed

## Write ahead log
	All changes that are made to the db are written to memory, then this is written to disk before the actual writes/reads can be flushed to disk.
	STEAL + NO FORCE
	When all the log records are written to disk it is considered to be commited.

==In **Write-Ahead Logging (WAL)**, a transaction is considered **committed** when its **commit record** is written to the **log file** and **flushed to disk**.==

### Logging Schemas
	1) Physical Logging -> keep the byte by byte diff eg: git diff
	2) Logical Logging -> keep the update, delete, insert cmds only.
	3) Physiological logging -> hybrid approach

**PHYSICAL VS LOGICAL LOGGING**
	1) In logical logging very difficult to recover the data, as in concurrent txns its very difficult to determine where the txn failed. Also its slow because we need to re execute all the txns.

### Log Structured Systems
	No dirty page concept.
	The Pages retrieved from databse are immutable meaning they can't be modified.
### Checkpoints
	The WAL may grow forever. So when it crashes we might have to rerun months worth of logs. So the DBMS periodically flushes the buffer and write a checkpoint. 
	1) Blocking/ Consistent checkpoint Protocol
		1) pause all queries
		2) flush all the WAL to disk
		3) flush all block in buffer pool to disk
		4) write a <CHECKPOINT> in WAL and flush to disk.
		5) resume queries.
	2) on recovery UNDO uncommited records and REDO commtited records. 

![[Pasted image 20241117232244.png]]


# ARIES (Algorithms for Recovery and Isolation Exploiting Semantics)

	1) Write ahead logging STEAL + NO FORCE
	2) Repeat history during redo
	3) Logging changes during undo, record undo actions in log so that it is not repeated in case of multiple failures.

## Log sequence Numbers
		Include Log sequence number which is globally unique.

![[Pasted image 20241117234411.png]]

	Before a page can be flushed it shoudl have pageLSN <= flushedLSN
	meanging all the logs before the last access to page should be flushed to disk.
	Everytime a txn modifies a page update its pageLSN
	update flushedLSN everytime log is flushed to disk.
	write TXN-END log record after txn finishes. Guarentees that no new log records of this TXN will appear after that point. doesnt need to be flushed immmediately.


## Transaction Abort
	Include an additional prevLSN to all the log records. Creates a linked list that makes it easier to go through all the previous actions.

## Compensation log record
	stores actions that we took to undo a previous update record.
	it has all fields of a log record + undoNext pointer (the next to be undone LSN)
### Abort algorithm
	1) write an abort log to wal
	2) analyze the txn updates in reverse order. Go from last to first.
	3) for each reversal write a log record. restore the old value.
	4) write a TXN-END at the end of WAL and release locks
	5) CLR's are never undone. 
## Non Fuzzy checkpoints
	1) stops the start of any new txns
	2) wait until all active txns finish executing
	3) flushed dirty pages to disk
Bad for runtime but makes recovery easy.
### Active transaction table
	one entry per acitve transaction
	1) txnId
	2) status -> runnging, commited, candidate for undo
	3) lastLSN
Remove the entry after TXN-END

### Dirty page table
	keep track of which pages in the buffer pool are dirty.
	recLSN -> LSN of txn which first made it dirty.

### Fuzzy checkpoint
	until now the checkpoints where forcing dirty page writes
	1) no restirctions in ongoing txns
	2) no attempt to force dirty pages to disk
	3) write CHECKPOINT BEGIN and CHECKPOINT END 
	4) CHECKPOINT END contains ATT (acive transaction table) and DPT (dirty page table)

Steps 
	1) write CHECKPOINT BEGIN
	2) any txn that begins after this is not considered for final ATT DPT
	3) The LSN of checkpoint begin is written to masterLSN after CHECKPOINT END

# Armstrong axioms
	1) reflexive A+ = {A} if 
			
			$$ A \subset B $$ then 
		
		$$ B \rightarrow A$$
	
	2) Augmentation : if
	
	$$ X \rightarrow Y  \space then   \space \space ZX \rightarrow ZY $$

	3) Transitive : 
		
		$$ X \rightarrow Y \space and  \space T \rightarrow A \space then \space X \rightarrow A $$
		