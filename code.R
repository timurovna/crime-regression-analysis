crime_data <- read.table("", header=TRUE)

#Applying linear regression model
model <- lm(Crime ~., data=crime_data)
print(summary(model))
# Call:
#   lm(formula = Crime ~ ., data = crime_data)
# Residuals:
#   Min      1Q  Median      3Q     Max 
# -395.74  -98.09   -6.69  112.99  512.67 
# 
# Coefficients:
#              Estimate Std. Error t value Pr(>|t|)    
# (Intercept) -5.984e+03  1.628e+03  -3.675 0.000893 ***
# M            8.783e+01  4.171e+01   2.106 0.043443 *  
# So          -3.803e+00  1.488e+02  -0.026 0.979765    
# Ed           1.883e+02  6.209e+01   3.033 0.004861 ** 
# Po1          1.928e+02  1.061e+02   1.817 0.078892 .  
# Po2         -1.094e+02  1.175e+02  -0.931 0.358830    
# LF          -6.638e+02  1.470e+03  -0.452 0.654654    
# M.F          1.741e+01  2.035e+01   0.855 0.398995    
# Pop         -7.330e-01  1.290e+00  -0.568 0.573845    
# NW           4.204e+00  6.481e+00   0.649 0.521279    
# U1          -5.827e+03  4.210e+03  -1.384 0.176238    
# U2           1.678e+02  8.234e+01   2.038 0.050161 .  
# Wealth       9.617e-02  1.037e-01   0.928 0.360754    
# Ineq         7.067e+01  2.272e+01   3.111 0.003983 ** 
# Prob        -4.855e+03  2.272e+03  -2.137 0.040627 *  
# Time        -3.479e+00  7.165e+00  -0.486 0.630708    
# ---
# Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
# 
# Residual standard error: 209.1 on 31 degrees of freedom
# Multiple R-squared:  0.8031,	Adjusted R-squared:  0.7078 
# F-statistic: 8.429 on 15 and 31 DF,  p-value: 3.539e-07

#Saving new data to predict
new_city <- data.frame(
  M = 14.0, So = 0, Ed = 10.0, Po1 = 12.0, Po2 = 15.5,
  LF = 0.640, M.F = 94.0, Pop = 150, NW = 1.1,
  U1 = 0.120, U2 = 3.6, Wealth = 3200, Ineq = 20.1,
  Prob = 0.04, Time = 39.0
)

#Running predict function
model_pred <- predict(model, newdata = new_city, interval="prediction")
print(model_pred)
# fit       lwr      upr
# 155.4349 -1370.845 1681.715

#Running qqplot of residuals to see its normality
qqnorm(residuals(model))

#Doing cross validation on linear regression model with all parameters
library(DAAG)
model_CV <- cv.lm(crime_data, model, m=4)
#Calculationg R2 for the above model
obs <- crime_data$Crime
pred <- model_CV$cvpred
SSE_cv <- sum((obs - pred)^2)
SST    <- sum((obs - mean(obs))^2)
R2_cv  <- 1 - SSE_cv / SST
print(R2_cv)
# CV R2 = 0.353018 for full model

#Applying linear regression model only for "insignificant" parameters 
model_reduced <- lm(Crime ~ M + Ed + Ineq + Prob, data=crime_data)
print(model_reduced)
# Call:
#   lm(formula = Crime ~ M + Ed + Ineq + Prob, data = crime_data)
# 
# Coefficients:
#   (Intercept)            M           Ed         Ineq         Prob  
# -1339.35        35.97       148.61        26.87     -7331.92  

#Running qqplot of residuals for reduced model to see its normality
qqnorm(residuals(model_reduced))

new_city_reduced <- data.frame(
  M = 14.0, Ed = 10.0, Ineq = 20.1,
  Prob = 0.04
)
model_pred_reduced <- predict(model_reduced, newdata = new_city_reduced, interval="confidence")
print(model_pred_reduced)
# fit      lwr      upr
# 1 897.2307 767.6195 1026.842

#Doing cross validation on linear regression to reduced model and calculating R2
model_CV_reduced <- cv.lm(crime_data, reduced, m=4)
print(model_CV_reduced)
obs1 <- crime_data$Crime
pred1 <- model_CV_reduced$cvpred
SSE_cv1 <- sum((obs1 - pred1)^2)
SST1   <- sum((obs1 - mean(obs1))^2)
R2_cv1  <- 1 - SSE_cv1 / SST1
print(R2_cv1)
# CV R2 = 0.1345074 for reduced model

