-- Find blocked / blocking pid

select pid, pg_blocking_pids(pid) as blocked_by, query as blocked_query
from pg_stat_activity
where pg_blocking_pids(pid)::text != '{}';

-- For PostgreSQL 9.2 lookup lock
select l.pid, l.mode, sa.pid, sa.query
from pg_locks l
inner join pg_stat_activity sa
        on l.pid = sa.pid
where l.mode like '%xclusive%';

 -- Terminate offending pid
SELECT pg_terminate_backend(46662);
