# Online Campaign Effect Analysis for a Video Game Company
## Objective
Online communities are perceived as a way to increase user engagement in video games. 

The goal is to examine the effect of the online community by statistically evaluating its impact on metrics such as **revenue, retention and Customer Lifetime Value (CLV).**

## Data
-  Users' spending before and after the introduction of the online community.
-  Users' age at the time of the introduction.
-  Users' average spend 3 months after the introduction.
-  Users' churn status 3 months after the introduction.
-  Users' acquisition channel.

## Structure
### 1. Evaluate the change in revenue
- Split the user spend data into two groups, those who were invited to participate the online community and those who were not.
- Split into two time periods, the month before the introduction of the online community and the month after.

Using the **diff-in-diff model**, we were able to infer that joining the online community resulted in a statistically significant increase in spend of $29.02.

### 2. Estimate the customer churn
We use **logistic regression** to estimate the customer churn.

<img width="500" alt="Screen Shot 2022-03-26 at 3 39 26 PM" src="https://user-images.githubusercontent.com/98130185/160259296-f436e479-009f-4fca-b495-92994cc45471.png">

Only joining the online community makes a statistically significant impact on churn.

## Conclusion
-  Although the user spend increased by $29 in the short term, there was a significant uptick in churn which ultimately resulted in no significant difference in CLV among the joined users.
-   The method of customer acquisition has no statistically significant impact on churn and also other predictors.
