# Analysis of 2008 Crisis on Corporate Firms

### Introduction

In this report, we will show the effects of the 2008 Financial Crisis on corporate firms. For which I will analyze theirannual financial data. Focusing on their
annual net income
I will see how much it decreased in
crisis years(2007-2008)
as compared to
pre-crisis years (2004-2006)
by calculating the
percentage decrease
and the
absolute decrease
of the
average annual net income
. This would help me ascertain how much firms wereadversely affected by the crisis. Furthermore, I will also list the top 10 firms for which the percentage and absolutedecrease was largest, and the top 10 for which it was smallest. Lastly, I will calculate the time it took each firm torecover the maximum annual net income in the
post-crisis years (2009-2014)
, that they had attained in the pre-crisis era.

### Reading Data and preliminary analysis

The first step of our analysis is to run some basic analysis functions to ascertain what sort of data we have andwhat exactly is inside the data file. To accomplish this we use the functions like
str()
,
head()
and
tail()

### Filtering and Calculations

We filter the original data set to get the relevant columns and periods. Dividing the new data set into pre-crisis andcrisis years we calculate the mean of the annual net income for both periods. Using them to calculate thepercentage and absolute decrease, arranging them from largest to smallest value. We clean the data set andremove the positive values from the percentage change data frame as they represent the percentage increase andnot the percentage decrease.

### Largest and Smallest percentage and absolute change

As we arrange our data sets of absolute and percentage change from largest to smallest value, we can use the
head()
and
tail()

### Years it took firms to recover

We want to ascertain how many years it took firms to recover their maximum annual net income in the post-crisisera. For that, we find maximum annual net income in the pre-crisis era. Then we find the year in the post-crisis erain which that maximum annual net income value was breached. We subtract that year from 2008 to find thenumber of years it took to recover that net income.
functions to get the top ten firms with the largest and smallest absolute and percentage change.

### Conclusion

By studying the tables for
percentage and absolute decrease
we observe that almost all industries wereadversely effected by the
2008 Crisis
. Some of industries that deserve special mention though are the
Construction
,
Cement and Concrete Product Manufacturing
and
Oil/Gas and mining
. After the bailout andstimulus programs were passed to recover from the recession many industries recovered. The recovery periodranged from 1 year to 6 years. Though some companies took longer to recover or didn’t recover to pre-crisisyears.
