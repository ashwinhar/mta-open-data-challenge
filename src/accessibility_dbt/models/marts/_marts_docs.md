{% docs total_time_gain_hrs %}
The total time gain in hours for the whole time period defined in the staging layer (typically 1 year) if all of the `planned_ada_stations` in the record become accessible. The suffix (ex: 2p) determines the percent of rides that we *assume* had a different intended destination. 

For example, 2% of riders to **59 St-Columbus Circle** actually intended on going to **116 St / Eighth Avenue (B,C lines)**.

{% enddocs %}

{% docs fct_time_gain %}
Shows the estimated time gain whole time period defined in the staging layer (typically 1 year) for the given record assuming the planned ada stations within the record become accessible. Since we have no way of knowing how many rides had a "different" intended destination, multiple estimates are given. `total_time_gain_hrs_2p` shows the estimated time gain assuming 2% of rides had a different intended destination (to one of the stations listed in `planned_ada_stations`), `total_time_gain_hrs_4p` estimates time gain for 4% of rides having a different intended destination, and so on. 

{% enddocs %}