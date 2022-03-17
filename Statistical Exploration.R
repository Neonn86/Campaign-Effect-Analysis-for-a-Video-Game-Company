rm(list=ls())
library(readxl)
library(Hmisc)
library(MASS)
library(caret)
library(regclass)
library(ISLR)
library(boot)
library(vcd)
library(pROC)
library (ROCR)

#install.packages("readxl")
data3 <- readxl::read_excel("Assignment3HW3_Data.xlsx", sheet="Data 3")

str(data3)
campaign <- data3$`Campaign/Organic`
customerID <- data3$`Customer ID`
month_before <- data3$`Month Before`
month_after <- data3$`Month After`
customer_age <- data3$`Customer Age with Firm at time of launching the online community`
joined <- data3$`Joined?`
churned <- data3$`Churned at 3 months`
average_spend <- data3$`Average Spend Last 3 months of Life with the firm`

data3_campaign <- subset(data3, data3$`Campaign/Organic`==1)
data3_organic <- subset(data3, data3$`Campaign/Organic`==0)

prop.test(x=c(sum(data3_campaign$`Joined?`), sum(data3_organic$`Joined?`)), 
          n=c(length(data3_campaign$`Joined?`), length(data3_organic$`Joined?`)), alternative="two.sided")

prop.test(x=c(sum(data3_campaign$`Churned at 3 months`), sum(data3_organic$`Churned at 3 months`)), 
          n=c(length(data3_campaign$`Churned at 3 months`), length(data3_organic$`Churned at 3 months`)), alternative="two.sided")

# In both cases, we fail to reject the null hypothesis.

spend_campaign_lm <- lm(average_spend ~ campaign)
summary(spend_campaign_lm)


t.test(x=data3_campaign$`Average Spend Last 3 months of Life with the firm`, 
       y=data3_organic$`Average Spend Last 3 months of Life with the firm`,
       alternative="two.sided")

# Campaign did not have an effect on average spend, churn and joining of the online community. No interaction.

month_before_lm <- lm(month_before ~ campaign)
summary(month_before_lm)

month_after_lm <- lm(month_after ~ campaign)
summary(month_after_lm)

age_lm <- lm(customer_age ~ campaign)
summary(age_lm)


t.test(x=data3_campaign$`Month Before`, 
       y=data3_organic$`Month Before`,
       alternative="two.sided")

t.test(x=data3_campaign$`Month After`, 
       y=data3_organic$`Month After`,
       alternative="two.sided")

t.test(x=data3_campaign$`Customer Age with Firm at time of launching the online community`, 
       y=data3_organic$`Customer Age with Firm at time of launching the online community`,
       alternative="two.sided")

mylogit1 <- glm(churned ~ campaign + customer_age + joined + average_spend, family=binomial(link="logit"))
summary(mylogit1)

mylogit2 <- glm(churned ~ customer_age + joined + average_spend, family=binomial(link="logit"))
summary(mylogit2)

oddsr1=round(exp(cbind(OddsRatio=coef(mylogit1),confint(mylogit1))),4)
oddsr1

confmat1 <- confusion_matrix(mylogit1)
confmat1

predict_prob <- predict(mylogit1, newdata=data.frame(churned), type="response")
predict_prob

retention_prob <- 1 - predict_prob

margin <- 0.5*average_spend*3

clv <- margin*((1+0.0010728)/(1+0.0010728-retention_prob))
clv

campaign_clv <- data.frame(customerID, campaign, joined, churned, clv)
inorganic <- subset(campaign_clv, campaign==1)
organic <- subset(campaign_clv, campaign==0)

var.test(inorganic$clv, organic$clv, alternative="two.sided")

t.test(inorganic$clv, organic$clv, alternative="two.sided")

clv_lm <- lm(data=campaign_clv, clv ~ campaign + joined)
summary(clv_lm)
hist(clv)
summary(clv)

clv_lm2 <- lm(data=campaign_clv, clv ~ campaign + joined + campaign:joined)
summary(clv_lm2)



