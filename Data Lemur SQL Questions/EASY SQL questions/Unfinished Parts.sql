-- Tesla is investigating bottlenecks in their production, and they need your help to extract the relevant data. 
-- Write a query that determines which parts have begun the assembly process but are not yet finished.

 -- Assumptions --
-- Table parts_assembly contains all parts in production.
-- A part with no finish_date is an unfinished part.


      -- parts_assembly Example Table: --
| part    | finish_date         | assembly_step |
|---------|---------------------|---------------|
| battery | 01/22/2022 00:00:00 | 1             |
| bumper  | 01/22/2022 00:00:00 | 1             |
| bumper  |                     | 3             |


-- Solution: --
SELECT DISTINCT(part)
FROM parts_assembly
WHERE finish_date IS NULL;


-- Output --
| part   |
|--------|
| bumper |
| engine |
