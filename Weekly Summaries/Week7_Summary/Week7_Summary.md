Week #7 Summary
========================================================
Anusha

What we did:
-------------
Read papers

1. Besag J & Diggle PJ. 1977. Simple Monte Carlo Tests for Spatial Pattern. Journal of the Royal Statistical Society. Series C (Applied Statistics), Vol. 26, No. 3, pp. 327-333.

2. Lancaster J and Downes BJ. 2004. Spatial Point Pattern Analysis of Available and Exploited Resources. Ecography, Vol. 27, No. 1, pp. 94-102.

3. Crowley PH. 1992. Resampling methods for computation-intensive data analysis in ecology and evolution. Annual Review of Ecology, Evolution and  Systematics, 23:405-47.


Monte Carlo  vs. MCMC
----------------------

we first clarified that the term Monte Carlo does not only refer to Markov Chain Monte Carlo (MCMC) methods. A Monte Carlo process is any random draw process. Markov Chain Monte Carlo methods, on the other hand, only relate to the preceeding time step. However, note that because the preceeding time step is always correlated with its corresponding previous time step, you could get very long correlation times. MCMC methods can sometimes be used to get likelihoods- when you don't know a likelihood function, but would like to sample from it, you might use MCMC. This is also relevant because this is in contrast to Bayesian methods, where you don't have a final distribution you can draw from.


Besag and Diggle (1977)
------------------
The Besag and Diggle paper focused on general Monte Carlo methods.
Monte Carlo processes can be very useful when full randomisation tests would be useful but are computationally difficult. They can also be used to test for spatial randomness in data. Here, the null would be complete spatial randomness, and you would use a test statistic to test this. For example, a test statistic proposed by Clarke and Evans (1954) uses nearest neighbor distances. A large sum of the nearest neighbor distances shows a tendency towards regularity, while a small sum shows clustering.

The next test using Monte Carlo methods is testing for pattern transference, for example, from small-scale migration to larger scales.

The third test was for space-time interaction. They give the example of disease outbreak, where to test if there is an outbreak, you need to see a large number of infected individuals in the SAME time step- you cannot collapse the data over time or over space and deduce an outbreak. Monte Carlo methods can help with this.

The fourth and last test is for patterns of scale, where you partition the area into blocks of different sizes and test for patterns over various combinations of blocks.

Jacknife vs. Bootstrap. Crowley (1992)
----------------------
The Crowley paper contrasted different randomisation methods (monte Carlo, jacknife, bootstrap; and their applications in Ecology and Evolution). We first discussed when one would use jacknife over bootstrap methods. Jacknife only gives you standard errors, unlike bootstrap which also gives you percentile values. So the bootstrap gives you more information than the jacknife does. The bootstrap also simulates a rerun of your experiment, while the jacknife is a more independent test.

However, you might want to use jacknife rather than bootstrap if you are running species distribution models (SDMs). When you bootstrap in SDMs, you might be assuming that your environmental variables are coming from a bigger set of variables, in which case you are testing the effect of your variables as opposed to that bigger set. So doesn't make as much sense as doing a jacknife- where you are testing the effect of any one variable at a time on the distribution.

Reviewing some concepts
-----------------------
We then reviewed a few concepts (just to be clear!):
A parametric bootstrap is when you fit your data to a distribution and sample from the distribution rather than from the original data (which is a non-parametric bootstrap, of course).
We defined power- the probability that you will correctly reject the null hypothesis. This is also the opposite of a Type II error. Non-parametric methods are rank-based methods, like Wilcoxon's signed-rank test. These methods have low power. Parametric tests, on the other hand, have high power given that their assumptions are met.

When you do randomisation tests, you get high power (which also means a high false alarm rate), high rate of Type I errors, and low rate of type II errors. If you violate the assumptions of the t-test, your power increases, but you no longer know what your level of sginificance is. This is linked to why experimental design in frequentist statistics is subjective- depending on the design of your experiment, your thresholds of significance change. Thus, you need to have considerable transparency when you are publishing significance levels after performing frequentist statistics.

Spatial autocorrelation. Lancaster and Downes (2004)
-----------------------
We then continued by discussing the Lancaster and Downes (2004) paper and parts of the Crowley (1992) paper in parallel, as their themes overlapped. The Lancaster and Downes paper addressed spatial point pattern analysis, given patchiness vs regularity of resource availability.

The first problem is that of autocorrelation. It does not allow you to easily write down likelihoods, as they would be functions of other likelihoods. Here arises the difference between independent variables, and conditionally independent variables. In this case, the spatial structure of covariates and responses is important. You only have to account for spatial autocorrelation when you create a joint probability of all likelihoods- when there is conditional independence. For example:

P(brown hair AND blue eyes) = P(brown hair)*P(blue eyes)

is true only if the two terms on the right are independent. Otherwise, you don't know the interaction term where they intersect. In these situations of conditional probability, randomisation methods come in handy. In our partcular interest here- with spatial autocorrelation- you would use MCMC methods, because even though you can't write down the likelihood function, you can sample from the likelihood distribution. The Knox test is one technique, where you hold space constant and permute time, and the other way around. This technique is not used much, because specifying a cut-off is difficult.

We then moved to the exciting issue of edge correction. Drawing an amorphous form on the board, which was then christened a lake, we discussed different ways of correcting for sampling from edges. To determine how resource availability and species presence are related, for instance in stated lake, we might sample a point at random from within the lake. We would then draw a circle of radius 't' with that ,point at the center, and count how many points in total that circle encompasses. The Lancaster and Downes paper focuses on how you can correct for the inevitable bias of sampling points near the edge of this lake- the circles around those points would encompass much fewer points than those at the center, simply because half the circle would fall outside the habitat edge.

Using this formula, you can describe a cumulative frequency distribution of all point-to-point distances: 
\[
K(t) = n^{-2}A\sum_{i=i}^{n} \sum_{j\neq i}^{n}w_{ij}I_{t}(u_{ij})
\]

This K(t) function is often represented as a linearised L function:
\[
L(t) = \sqrt{K(t)/\pi} - t
\]
L(t)= K(t)/- t 

