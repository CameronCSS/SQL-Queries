-- UnitedHealth has a program called Advocate4Me, which allows members to call an advocate and receive support for their health care needs – whether that's behavioural, clinical, well-being, health care financing, benefits, claims or pharmacy help.

-- Write a query to find how many UHG members made 3 or more calls. case_id column uniquely identifies each call made.

                                      -- callers Example Table:  --
                                      
| policy_holder_id |       case_id       | call_category |    call_received    | call_duration_secs | original_order |
|:----------------:|:-------------------:|:-------------:|:-------------------:|:------------------:|:--------------:|
|     50837000     | dc63-acae-4f39-bb04 |     claims    | 03/09/2022 02:51:00 |         205        |       130      |
|     50837000     | 41be-bebe-4bd0-a1ba |   IT_support  | 03/12/2022 05:37:00 |         254        |       129      |
|     50936674     | 12c8-b35c-48a3-b38d |     claims    |  05/31/2022 7:27:00 |         240        |       31       |
    
    
 -- Submission: --
WITH members AS (
SELECT policy_holder_id, COUNT(case_id) AS members
FROM callers
GROUP BY policy_holder_id
)

SELECT COUNT(policy_holder_id) AS member_count
FROM members 
WHERE members >=3
 
 
-- Output: --
| member_count |
|:------------:|
|      76      |
