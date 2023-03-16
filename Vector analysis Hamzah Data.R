
filename = AdaptiveP1Engagement_Raw
library(Hmisc)
library(ggplot2)
library(grid)
# Frontal -----------------------------------------------------------------


plot(P1_Engagement$Frontal, type = 'l')

filename$Frontal_lag1 <- Lag(filename$Frontal, 1)
filename$Frontal_lead1 <- Lag(filename$Frontal, -1)
filename$Frontal_change1 <- (filename$Frontal_lead1 - filename$Frontal_lag1)/2


# Central -----------------------------------------------------------------

filename$Central_lag1 <- Lag(filename$Central, 1)
filename$Central_lead1 <- Lag(filename$Central, -1)
filename$Central_change1 <- (filename$Central_lead1 - filename$Central_lag1)/2


# Parietal ----------------------------------------------------------------

filename$Parietal_lag1 <- Lag(filename$Parietal, 1)
filename$Parietal_lead1 <- Lag(filename$Parietal, -1)
filename$Parietal_change1 <- (filename$Parietal_lead1 - filename$Parietal_lag1)/2



# Total -------------------------------------------------------------------
filename$Total_lag1 <- Lag(filename$Total, 1)
filename$Total_lead1 <- Lag(filename$Total, -1)
filename$Total_change1 <- (filename$Total_lead1 - filename$Total_lag1)/2




# Time --------------------------------------------------------------------


filename$Time_lag1 <- Lag(filename$X, 1)
filename$Time_lead1 <- Lag(filename$X, -1)
filename$Time_change1 <- (filename$Time_lag1- filename$Time_lead1)/2



# Plot Frontal ------------------------------------------------------------


plot(filename$Frontal_change1,type='l', xlab = "Time in seconds", ylab =" Change in EEG Engagement")

ggplot(data=filename,aes(x=X + Time_change1,y=Frontal + Frontal_change1))+
  geom_segment(aes(xend=X + Time_change1,yend=Frontal + Frontal_change1),arrow=arrow(length=unit(.2,"cm")))+
  stat_density2d(aes(colour=..level..))+
  labs(list(title="Participant 1 Vector Density Plot", x= "Time", y = "EEG Engagement"))



# Linear predictor frontal--------------------------------------------------------

plot(y = filename$Frontal_change1, x = filename$Frontal)
model1 <- lm(formula = Frontal_change1 ~ Frontal, data = P1_Engagement )
plot(model1)
summary(model1)


# Plot Central ------------------------------------------------------------


plot(filename$Central_change1,type='l', xlab = "Time in seconds", ylab =" Change in EEG Engagement")

ggplot(data=filename,aes(x=X + Time_change1,y=Central + Central_change1))+
  geom_segment(aes(xend=X + Time_change1,yend=Central + Central_change1),arrow=arrow(length=unit(.2,"cm")))+
  stat_density2d(aes(colour=..level..))+
  labs(list(title="Participant 1 Vector Density Plot", x= "Time", y = "EEG Engagement"))


# Linear predictor Central ------------------------------------------------
plot(y = filename$Central_change1, x = filename$Central)
model1 <- lm(formula = Central_change1 ~ Central, data = filename )
plot(model1)
summary(model1)


# Plot Parietal -----------------------------------------------------------


plot(filename$Parietal_change1,type='l', xlab = "Time in seconds", ylab =" Change in EEG Engagement")

ggplot(data=filename,aes(x=X + Time_change1,y=Parietal + Parietal_change1))+
  geom_segment(aes(xend=X + Time_change1,yend=Parietal + Parietal_change1),arrow=arrow(length=unit(.2,"cm")))+
  stat_density2d(aes(colour=..level..))+
  labs(list(title="Participant 1 Vector Density Plot", x= "Time", y = "EEG Engagement"))


# Linear predictor Parietal -----------------------------------------------

plot(y = filename$Central_change1, x = filename$Central)

model1 <- lm(formula = Central_change1 ~ Central, data = filename )
plot(model1)
summary(model1)



# Plot total --------------------------------------------------------------

plot(filename$Total_change1,type='l', xlab = "Time in seconds", ylab =" Change in EEG Engagement")

ggplot(data=filename,aes(x=X + Time_change1,y=Total + Total_change1))+
  geom_segment(aes(xend=X + Time_change1,yend=Total + Total_change1),arrow=arrow(length=unit(.2,"cm")))+
  stat_density2d(aes(colour=..level..))+
  labs(list(title="Participant 1 Vector Density Plot", x= "Time", y = "EEG Engagement"))


# Linear predictor total --------------------------------------------------

plot(y = filename$Total_change1, x = filename$Total)

model1 <- lm(formula = Total_change1 ~ Total, data = filename )
plot(model1)
summary(model1)

# Bartels tests --------------------------------------------------------


bartels.rank.test(P1_Engagement_Raw$Frontal, alternative = "two.sided")


bartels.rank.test(P1_Engagement_Raw$Central, alternative = "two.sided")


bartels.rank.test(P1_Engagement_Raw$Parietal, alternative = "two.sided")

bartels.rank.test(P1_Engagement_Raw$Total, alternative = "two.sided")



# auto-correlation --------------------------------------------------------

pacf(na.exclude(P1_Engagement_Raw$Frontal),lag.max = 1000)
pacf(na.exclude(P1_Engagement_Raw$Central),lag.max = 1000)
pacf(na.exclude(P1_Engagement_Raw$Parietal),lag.max = 1000)
pacf(na.exclude(P1_Engagement_Raw$Total),lag.max = 1000)

# KPSS test  --------------------------------------------

kpss.test(na.exclude(P1_Engagement_Raw$Frontal), lshort=TRUE, 
          null="Level")


kpss.test(na.exclude(P1_Engagement_Raw$Central), lshort=TRUE, 
          null="Level")


kpss.test(na.exclude(P1_Engagement_Raw$Parietal), lshort=TRUE, 
          null="Level")

kpss.test(na.exclude(P1_Engagement_Raw$Total), lshort=TRUE, 
          null="Level")


# Change point analysis ---------------------------------------------------

#Frontal
ts <- matrix(na.exclude(P1_Engagement_Raw$Frontal))

e.out <- ecp::e.divisive(ts, R=500, sig.lvl=.002) 
df.e <- length(which(e.out$p.values<.002))
e.out$estimates
df.e
#Central
ts <- matrix(na.exclude(P1_Engagement_Raw$Central))

e.out <- ecp::e.divisive(ts, R=500, sig.lvl=.002) 
df.e <- length(which(e.out$p.values<.002))
e.out$estimates
df.e
#Parietal 
ts <- matrix(na.exclude(P1_Engagement_Raw$Parietal))

e.out <- ecp::e.divisive(ts, R=500, sig.lvl=.002) 
df.e <- length(which(e.out$p.values<.002))
e.out$estimates
df.e

#Total
ts <- matrix(na.exclude(P1_Engagement_Raw$Total))

e.out <- ecp::e.divisive(ts, R=500, sig.lvl=.002) 
df.e <- length(which(e.out$p.values<.002))
e.out$estimates
df.e

