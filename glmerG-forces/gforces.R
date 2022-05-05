#install.packages("GLMsData")
library(GLMsData)
data(gforces)

nm.m2 <- glm( Signs ~ Age, data=gforces, family=binomial)
summary(nm.m2)

library(lme4)

gforces$subject.f <- factor(gforces$Subject)
nm.m3 <- glmer( Signs ~ Age+(1|subject.f:Age), data=gforces, family=binomial)
summary(nm.m3)
