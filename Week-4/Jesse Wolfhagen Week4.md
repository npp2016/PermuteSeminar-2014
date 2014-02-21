Title
========================================================

We'll be looking at the luteinizing hormone data from Efron and Tibshirani Chapter 8. Those authors used the AR(1) model: $$z{t} = /beta{t - 1} + /epsilon{t}$$.

Step 1: Find beta-hat using Equation (8.20)



We just have beta-hat, we don't have any confidence intervals or standard error. To get those, sample with replacement from those error terms.



Another way to do this is a moving-block bootstrap. Sample-with-replacement from chunks of time.



