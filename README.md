# Impacts of NYCT ADA Expansion
This project is for the [MTA Open Data Challenge](https://new.mta.info/article/mta-open-data-challenge). In light of the New York State Governor unilaterally striking down the [MTA's Congestion Pricing plan](https://www.governor.ny.gov/news/what-they-are-saying-governor-hochul-announces-pause-congestion-pricing-address-rising-cost), funding for the [2025-2029 Capital Plan](https://future.mta.info/capitalplan/) is in peril. The Capital Plan covers a suite of important repairs and enhancements to the system, one of which is expanded ADA access. 

This project explores the benefits to New York City's mobility-impaired community should the full gamut of ADA station enhancements be completed. 

## Project Setup and Overview
### Setup
1. Install [Conda](anaconda.org)
2. Run the script below in your terminal from the same directory where `environment.yml` lives. Replace "my_environment_name" with any string you want

```bash
conda env create -f environment.yml -n my_environment_name
```
3. I used VSCode for this project. If you'd like to do the same, you can download it [here](https://code.visualstudio.com/download)
4. Duplicate the `example.env` file and rename to `.env`: 
- Follow the instructions [here](https://support.socrata.com/hc/en-us/articles/115004055807-How-to-Sign-Up-for-a-Tyler-Data-Insights-ID) to get the values for the `NY_OPEN_DATA` variables. 
- Sign up for TravelTime [here](https://account.traveltime.com/login) to get the values for the `TRAVEL_TIME` variables. 
5. Create a file called `src/accessibility_dbt/mta_dev.duckdb`


### Overview

#### Extract
I'm using several datasets from the [New York Open Data Program](https://data.ny.gov/browse?Dataset-Information_Agency=Metropolitan+Transportation+Authority) to perform my analysis. The database setup is covered in the `/database_setup` folder and will use the Socrata API to pull the datasets. Please note by default the origin_destination dataset is limited to one day's data, and named accordingly. 

#### Transform
[dbt](https://www.getdbt.com) fully handles the transformation layer of the project. I also use dbt's documentation feature to document the full lineage of transformations. 

[*Instructions to follow*]


## Datasets
