# crime-regression-analysis
Project Overview

This project builds and evaluates multiple linear regression models to predict crime rates in U.S. cities using socio-economic and demographic variables. The analysis focuses on model interpretability, feature selection, and generalization performance, with a comparison between full and reduced models to understand the trade-off between complexity and predictive accuracy.

The goal is not only to build a predictive model but also to evaluate how model simplification affects out-of-sample performance.

Data Description
Dataset: U.S. crime dataset 
Observations: 47 cities
Response variable: Crime rate
Predictors: 15 socio-economic indicators (e.g., education, inequality, unemployment, police expenditure, demographics)

Methodology

1. Full Linear Regression Model

A multiple linear regression model was fitted using all 15 predictors. Model performance and statistical significance of coefficients were analyzed.

Key observations:

Several predictors showed statistical significance (e.g., education, inequality, probability of conviction)
High in-sample explanatory power (R² ≈ 0.80)
Signs of multicollinearity and potential overfitting due to high dimensionality relative to sample size

2. Model Interpretation

The full model was analyzed to understand directional relationships between predictors and crime rate:

Higher education levels and inequality were associated with changes in crime rates
Probability-related variables showed strong negative association with crime
Several predictors were weak or not statistically significant individually

3. Model Reduction

A reduced model was constructed using only statistically significant predictors:

M (population-related factor)
Ed (education)
Ineq (inequality)
Prob (probability-related measure)

This model was evaluated to compare simplicity vs predictive performance.

4. Model Evaluation

Models were assessed using:

In-sample R² and residual diagnostics
Prediction intervals for a new observation
4-fold cross-validation for out-of-sample performance

Results

Full Regression Model
R² (training): ~0.80
CV R²: ~0.35
Strong in-sample fit but signs of overfitting
Wide prediction intervals for new observations
Reduced Model
Simpler and more interpretable
Narrower prediction intervals for mean estimates
Lower cross-validation performance (CV R² ≈ 0.13)
Evidence of underfitting after aggressive feature removal

Key Insights

The full model achieves better predictive performance on unseen data compared to the reduced model, despite higher complexity.
Reducing variables based solely on statistical significance improves interpretability but can reduce generalization performance.
The dataset exhibits clear signs of overfitting due to the high ratio of predictors (15) to observations (47).
Model selection requires balancing interpretability and predictive accuracy rather than relying only on p-values.

Conclusion

This analysis demonstrates that while full linear regression models may overfit small datasets, they often outperform overly simplified models in predictive accuracy. Feature selection based purely on statistical significance can lead to loss of predictive power. Cross-validation highlights the importance of evaluating models based on out-of-sample performance rather than in-sample fit alone.

Techniques Used
Multiple Linear Regression (OLS),
Feature Selection and Model Reduction,
Statistical Significance Testing,
Prediction Intervals,
Cross-Validation (4-fold),
Residual Analysis
