# MySQL
	"mysql -u username -P" for loggin in to mysql <sudo mysql -p  --- password>
	- project need a database to work
	- in config file update database url according to database name and admin details
		- "mysql+pymysql://root:password@localhost/db1" for example
	- USE MYSQL WORKBENCH


# FRONTEND
```C
 turned off all redirects
```
	
	- use npm run dev

# BACKEND

```C
I have disabled all if role != checks -revert back in prod-
```

	- VSCode debug has some issue use python app.py to start working.
	
# Implement more than 2 allocation for a student

```python
Map <studentid, List<string>[slots_alloted, last alloted pref, anti_luck] student
```

	
# TODO
	1) write a allocateFunction
	2) calculate number of allocations to make
	3) while allocation_to_make > 0:
		1) edge case if prev and curr allocations didn't change : some person can't be allotted
	4) generate_random_list -> store in file explorer
	5) generate random list of students
		1) Go from top to bottom
		2) if thier pref1 is availabe allocate that else go to the next one
			1) upadate the database
	6) again generate a random list
		1) sort based on student.anti_luck
	7) Go from top to bottom
		2) if thier pref1 is availabe allocate that else go to the next one
			1) upadate the database
	8) goto step 2 until it is finished

	Tables to use : preferences for getting preference in order, courses for remaingin slots, student for total number of allocations,
	at each step print_out courses and allocation_list

# TODO
	1) prevent same course codes to same person
	2) make slot selection dymanic (detect via - )




## SSH into from public
	ssh -i microkey ubuntu@68.233.101.85
	ssh -oPort=8001 student@68.233.101.85
	JsEL0R4Y2d
	pm2 status
	pm2 restart <service>

