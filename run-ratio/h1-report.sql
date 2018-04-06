

-- h1.sql 

prompt
prompt report generated with ratio_to_report()
prompt


set linesize 200 trimspool on
set pagesize 50000

spool h1-report.log

with data as (
	select distinct
		region_id
		, dept_id
		, product_id
		, emp_id
		, sum(qty) over (partition by region_id, dept_id, product_id, emp_id) emp_qty_sold
		, sum(qty) over (partition by region_id, product_id) region_prod_total
	from af_test
)
select *
from (
	select
		region_id
		, dept_id
		, product_id
		, emp_id
		, emp_qty_sold
		, region_prod_total
		, ratio_to_report(emp_qty_sold) over (partition by region_id, product_id) ratio2rpt
	from data
	order by 7,4,2
)
/

spool off

