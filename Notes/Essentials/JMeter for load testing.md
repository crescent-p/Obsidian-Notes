
	Desktop->JMeter->bin->jmeter.bat

![[Pasted image 20241201170431.png]]

# Add a thread

	Right click on Test Plan -> add -> threads -> thread group
##  Add a HTTP Request
	Right click on thread group -> add -> Sampler -> http

## Results Tree 
	Settings Icon -> add -> listner -> results tree/ graph tree etx.

## Running test in CLI mode
	open bin folder as cmd
	jmeter -n -t [jmx file] -l [results file] -e -o [Path to web report folder]
	eg: .\jmeter -n -t \Users\cresc\Desktop\JMeter\backups\request1.jmx -l C:\Users\cresc\Desktop\JMeter\backups\loading.csv


```
flowchart LR
    subgraph Frontend
        A[React + Vite Client]
    end

    subgraph Proxy
        N[Nginx Reverse Proxy]
    end

    subgraph Backend
        F[FastAPI Server]
        P[Pydantic Data Validation]
        S[SQLAlchemy ORM]
        D[(PostgreSQL Database)]
    end

    A -->|HTTP/HTTPS Request| N
    N -->|Forwarded Request| F
    F -->|Validate Input| P
    P -->|Query/Modify Data| S
    S -->|Database Interactions| D
    D -->|Query Results| S
    S -->|Validated Response| F
    F -->|Response| N
    N -->|Response| A

    classDef frontend fill:#f9f,stroke:#333,stroke-width:2px;
    classDef backend fill:#bbf,stroke:#333,stroke-width:2px;
    classDef proxy fill:#bfb,stroke:#333,stroke-width:2px;
    classDef database fill:#ff9,stroke:#333,stroke-width:2px;

    class A frontend;
    class N proxy;
    class F,P backend;
    class D database;
```