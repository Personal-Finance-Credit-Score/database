# Personal Finance - Database Structure

## Flowchart
![Database Structure Flowchart](./flowchart/personal-finance.png)


## Setup
1. Open a command prompt or terminal window.
2. Navigate to the directory where you saved the .sql file using the cd command.
3. Execute the script using the psql command. Replace your_database_name with the name of your PostgreSQL database:

<pre>
<code>
psql -d your_database_name -f database_setup.sql
</code>
</pre>

## Preb-Built View List
1. DTI - will return `customer_id`, `total_monthly_debt`, `income`, `dti_ratio`
<pre>
<code>
SELECT * FROM DTIRatioView WHERE customer_id = 1;
</code>
</pre>

2. Credit Score Formula - will return `customer_id`, `avg_credit_score`
<pre>
<code>
SELECT * FROM AverageCreditScoresView WHERE customer_id = 1;
</code>
</pre>