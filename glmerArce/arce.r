library(lme4)
arce$Trat.f <- factor(arce$tratam)
arce$TREE.f<-factor(arce$TREE)

arcePoi.glmm <- glmer(num_int~1+Trat.f+(1|TREE.f) ,data=arce,family=poisson)
summary(arcePoi.glmm)