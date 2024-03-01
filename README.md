CFR2M: Interval Estimation for R2-based Mediation Effect of High-dimensional Mediators via Cross-fitting
================

The [CFR2M](https://github.com/zhichaoxu04/CFR2M) `R` package constructs confidence intervals based on the newly-derived closed-form asymptotic distribution of the R-squared measure.
To avoid potential bias, we perform iterative Sure Independence Screening (iSIS) and False Discovery Rate (FDR) control in two subsamples to exclude the non-mediators, followed by ordinary least squares (OLS) regressions for the variance estimation.

# Get started
### Download and install:

- Download [CFRM2](https://github.com/zhichaoxu04/CFRM2) package from Github using:

<!-- -->

    git clone https://github.com/zhichaoxu04/CFRM2.git

- Or, install [MetaR2M](https://github.com/zhichaoxu04/CFRM2) package in R directly

  - First, install [devtools](https://devtools.r-lib.org) in R from CRAN:
    ``` r
    install.packages("devtools")
    ```
  - Then, install [CFRM2](https://github.com/zhichaoxu04/CFRM2) using the `install_github` function and load the package:
    ``` r
    devtools::install_github("zhichaoxu04/CFRM2")
    library(CFRM2)
    ```
- Make sure that all the required packages have been installed or updated. Here are some of the required packages:
  - [RsqMed](https://cran.r-project.org/web/packages/RsqMed/index.html): An implementation of calculating the R-squared measure as a total mediation effect size measure and its confidence interval for moderate- or high-dimensional mediator models. It gives an option to filter out non-mediators using variable selection methods. The original R package is directly related to the paper [Yang et al (2021)](https://pubmed.ncbi.nlm.nih.gov/34425752/). The new version contains a choice of using cross-fitting, which is computationally faster. The details of the cross-fitting method are available in our paper [Xu et al (2023)](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9934518/).
  - [SIS](https://cran.r-project.org/web/packages/SIS/index.html): Variable selection techniques are essential tools for model selection and estimation in high-dimensional statistical models. Through this publicly available package, they provide a unified environment to carry out variable selection using iterative sure independence screening (SIS) ([Fan and Lv (2008)](https://academic.oup.com/jrsssb/article/70/5/849/7109492)) and all of its variants in generalized linear models ([Fan and Song (2009)](https://projecteuclid.org/journals/annals-of-statistics/volume-38/issue-6/Sure-independence-screening-in-generalized-linear-models-with-NP-dimensionality/10.1214/10-AOS798.full)) and the Cox proportional hazards model ([Fan, Feng and Wu (2010)](https://projecteuclid.org/ebooks/institute-of-mathematical-statistics-collections/Borrowing-Strength--Theory-Powering-Applications--A-Festschrift-for/chapter/High-dimensional-variable-selection-for-Coxs-proportional-hazards-model/10.1214/10-IMSCOLL606)).
  - [HDMT](https://cran.r-project.org/web/packages/HDMT/index.html): A multiple-testing procedure for high-dimensional mediation hypotheses. Mediation analysis is of rising interest in epidemiology and clinical trials. Methods used in the package refer to [James Y. Dai, Janet L. Stanford & Michael LeBlanc (2020)](https://www.tandfonline.com/doi/full/10.1080/01621459.2020.1765785).
  - [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html): A Grammar of Data Manipulation: a fast, consistent tool for working with data frame like objects, both in memory and out of memory.

