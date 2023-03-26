with main_role_split as 
(
select
	split_part("Main Role"::text, ', ', 1) as main_role_1,
	split_part("Main Role"::text, ', ', 2) as main_role_2,
	split_part("Main Role"::text, ', ', 3) as main_role_3
from
	top100_kdrama),
main_role_all as
(
select
	main_role_1 as names
from
	main_role_split
union all
select
	main_role_2
from
	main_role_split
union all
select
	main_role_3
from
	main_role_split)
select
	names,
	count(*)
from
	main_role_all
where
	names != ''
group by
	names;
