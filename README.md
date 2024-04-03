CFR2M: Efficient interval estimation for high-dimensional Cross-Fitting R2-based Mediation effect
================

> [!IMPORTANT]  
> For more details, please refer to our preprint Speeding up interval estimation for R2-based mediation effect of high-dimensional mediators via cross-fitting [(Xu et al)](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC9934518/). For the code used to perform simulations or real data analysis in the paper, please refer to [CFR2M-paper](https://github.com/zhichaoxu04/CFR2M-paper).


The [CFR2M](https://github.com/zhichaoxu04/CFR2M) `R` package constructs confidence intervals based on the newly-derived closed-form asymptotic distribution of the R-squared measure.
To avoid potential bias, we perform iterative Sure Independence Screening (iSIS) and False Discovery Rate (FDR) control in two subsamples to exclude the non-mediators, followed by ordinary least squares (OLS) regressions for the variance estimation.

<div align="center"><img src="man/Figure/CFOLS.gif" ></div>
</br>

# Get started
### Download and install:

- Download [CFR2M](https://github.com/zhichaoxu04/CFR2M) package from Github using:

<!-- -->

    git clone https://github.com/zhichaoxu04/CFR2M.git

- Or, install [CFR2M](https://github.com/zhichaoxu04/CFR2M) package in R directly

  - First, install [devtools](https://devtools.r-lib.org) in R from CRAN:
    ``` r
    install.packages("devtools")
    ```
  - Then, install [CFR2M](https://github.com/zhichaoxu04/CFR2M) using the `install_github` function and load the package:
    ``` r
    devtools::install_github("zhichaoxu04/CFR2M")
    library(CFR2M)
    ```
- Make sure that all the required packages have been installed or updated. Here are some of the required packages:
  - [RsqMed](https://cran.r-project.org/web/packages/RsqMed/index.html): An implementation of calculating the R-squared measure as a total mediation effect size measure and its confidence interval for moderate- or high-dimensional mediator models. It gives an option to filter out non-mediators using variable selection methods. The original R package is directly related to the paper [Yang et al (2021)](https://pubmed.ncbi.nlm.nih.gov/34425752/).
  - [SIS](https://cran.r-project.org/web/packages/SIS/index.html): Variable selection techniques are essential tools for model selection and estimation in high-dimensional statistical models. Through this publicly available package, they provide a unified environment to carry out variable selection using iterative sure independence screening (SIS) ([Fan and Lv (2008)](https://academic.oup.com/jrsssb/article/70/5/849/7109492)) and all of its variants in generalized linear models ([Fan and Song (2009)](https://projecteuclid.org/journals/annals-of-statistics/volume-38/issue-6/Sure-independence-screening-in-generalized-linear-models-with-NP-dimensionality/10.1214/10-AOS798.full)) and the Cox proportional hazards model ([Fan, Feng and Wu (2010)](https://projecteuclid.org/ebooks/institute-of-mathematical-statistics-collections/Borrowing-Strength--Theory-Powering-Applications--A-Festschrift-for/chapter/High-dimensional-variable-selection-for-Coxs-proportional-hazards-model/10.1214/10-IMSCOLL606)).
  - [HDMT](https://cran.r-project.org/web/packages/HDMT/index.html): A multiple-testing procedure for high-dimensional mediation hypotheses. Mediation analysis is of rising interest in epidemiology and clinical trials. Methods used in the package refer to [James Y. Dai, Janet L. Stanford & Michael LeBlanc (2020)](https://www.tandfonline.com/doi/full/10.1080/01621459.2020.1765785).
  - [dplyr](https://cran.r-project.org/web/packages/dplyr/index.html): A Grammar of Data Manipulation: a fast, consistent tool for working with data frame like objects, both in memory and out of memory.

- [CFR2M](https://github.com/zhichaoxu04/CFR2M) is also available in the R package [RsqMed](https://cran.r-project.org/web/packages/RsqMed/index.html).

