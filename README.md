# Impacts of NYCT ADA Expansion
This project is for the [MTA Open Data Challenge](https://new.mta.info/article/mta-open-data-challenge). In light of the New York State Governor unilaterally striking down the [MTA's Congestion Pricing plan](https://www.governor.ny.gov/news/what-they-are-saying-governor-hochul-announces-pause-congestion-pricing-address-rising-cost), funding for the [2025-2029 Capital Plan](https://future.mta.info/capitalplan/) is in peril. The Capital Plan covers a suite of important repairs and enhancements to the system, one of which is expanded ADA access. 

This project explores the benefits to New York City's ADA community should the full gamut of ADA station enhancements be completed, as well as the costs if it doesn't. 

## Project Setup and Overview
### Setup
1. Install [Conda](anaconda.org)
2. Run the script below in your terminal from the same directory where `environment.yml` lives. Replace "my_environment_name" with any string you want

```bash
conda env create -f environment.yml -n my_environment_name
```
3. I used VSCode for this project. If you'd like to do the same, you can download it [here](https://code.visualstudio.com/download)
4. Since I use DuckDB for this project, I thought it was useful to download the [SQLTools](https://marketplace.visualstudio.com/items?itemName=mtxr.sqltools) and corresponding [DuckDB SQLTools](https://marketplace.visualstudio.com/items?itemName=RandomFractalsInc.duckdb-sql-tools) extensions. SQLTools doesn't work super well with DuckDB, so I might suggest different connections in future versions of this project.
5. Make sure that you "brew install" node.js
6. You'll have to create a `config.py` file in `/database_setup/` with a few variables defined. Follow the 
instructions on the NY Open Data Program website to create
an account. After you have your account, you should get a 
username, password, and API key. Within `config.py` set
the following variables correspondingly: 

- `NY_OPEN_DATA_API_TOKEN` = "[Your API Key]"
- `NY_OPEN_DATA_USERNAME`= "[Your User Name]"
- `NY_OPEN_DATA_PASSWORD`= "nodwap-Podged-cuswi4"
7. Create a file called `src/accessibility_dbt/mta_dev.duckdb`


### Overview

#### Extract
I'm using several datasets from the [New York Open Data Program](https://data.ny.gov/browse?Dataset-Information_Agency=Metropolitan+Transportation+Authority) to perform my analysis. The database setup is covered in the `/database_setup` folder and will use the Socrata API to pull the datasets. Please note by default the origin_destination dataset is limited to one day's data, and named accordingly. 

#### Transform
[dbt](https://www.getdbt.com) fully handles the transformation layer of the project. I also use dbt's documentation feature to document the full lineage of transformations. 

[*Instructions to follow*]


## Datasets
