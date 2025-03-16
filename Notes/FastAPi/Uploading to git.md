
```.gitignore
.env
__pycache__
venv/
```

also create a requirements.txt file by piping pip freeze 
`pip freeze > requirements.txt`

You can install all the requirements via
`pip install -r requirements.txt`
```mermaid
graph TD;
    A[Market Demand & Supply] -->|Data Collection| B[Operations Analysis];
    B -->|Resource Allocation| C[Production Planning];
    C -->|Efficiency Optimization| D[Supply Chain Management];
    D -->|Inventory Control| E[Distribution & Logistics];
    E -->|Market Trends & Pricing| F[Sales & Revenue Management];
    F -->|Performance Metrics| G[Feedback & Adjustments];
    G -->|Economic Forecasting| A;
    G -->|Policy Changes| H[Regulatory Compliance];

```
