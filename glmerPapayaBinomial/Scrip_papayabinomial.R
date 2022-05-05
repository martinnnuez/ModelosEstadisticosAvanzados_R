library(lme4)
# recorder declarer las variables que actuan como factores
PapayaBinomial$Trat.f <- factor(PapayaBinomial$Trat)
PapayaBinomial$Parcela.f<-factor(PapayaBinomial$Parcela)

# Modelo
PapayaBin.glmm <- glmer(cbind(Enfermas,Plantas-                            		                 Enfermas)~Trat.f+Dias+Trat.f:Dias+
                          (1|Parcela.f),data=PapayaBinomial, nAGQ = 1,
                        family=binomial)

summary(PapayaBin.glmm)
