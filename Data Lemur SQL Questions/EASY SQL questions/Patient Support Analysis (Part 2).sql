-- UnitedHealth Group has a program called Advocate4Me, 
-- which allows members to call an advocate and receive support for their health care needs 
-– whether that's behavioural, clinical, well-being, health care financing, benefits, claims or pharmacy help.

-- Calls to the Advocate4Me call centre are categorised, but sometimes they can't fit neatly into a category. 
-- These uncategorised calls are labelled “n/a”, or are just empty (when a support agent enters nothing into the category field).

-- Write a query to find the percentage of calls that cannot be categorised. Round your answer to 1 decimal place.


                                           -- callers Example Table: --
| policy_holder_id |       case_id       | call_category |    call_received    | call_duration_secs | original_order |
|:----------------:|:-------------------:|:-------------:|:-------------------:|:------------------:|:--------------:|
|     52481621     | a94c-2213-4ba5-812d |               | 01/17/2022 19:37:00 |         286        |       161      |
|     51435044     | f0b5-0eb0-4c49-b21e |      n/a      |  01/18/2022 2:46:00 |         208        |       225      |
|     52082925     | 289b-d7e8-4527-bdf5 |    benefits   |  01/18/2022 3:01:00 |         291        |       352      |


-- Solution: --
SELECT ROUND(100 * COUNT(
    CASE WHEN call_category IS NULL OR call_category = 'n/a' THEN case_id END)
    /
    COUNT(*):: numeric, 1) AS call_percentage
  FROM callers
  
  
   -- Output --
| call_percentage |
|:---------------:|
|       45.0      |
