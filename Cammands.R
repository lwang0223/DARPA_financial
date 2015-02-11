library(moments)
library(HiddenMarkov)
library(HMMCont)
#########fit the model and infer for the states#############
rawData = read.csv("SP500Daily.csv", header = TRUE);
rawPrices = rawData[,7]
Dates = rawData[,1]



#Records of returns start at 2009/1/5
tradePrices = na.omit(rawPrices);
tradeReturns = logreturns(tradePrices);
sdTradeRets =  (tradeReturns - mean(tradeReturns))/sd(tradeReturns) #standardized

Pi <- matrix(c(0.8,0.1,0.1,0.1,0.8,0.1,0.1,0.1,0.8),byrow=TRUE, nrow=3)
delta <- c(1/3,1/3,1/3)
hmm <- dthmm(tradeReturns*100, Pi, delta, "norm",list(mean=c(0.10,0.5, -0.5), sd=c(1,2,3)))

hmm1 = BaumWelch(hmm)
traStates = Viterbi(hmm1)  #states iferred on each trading day



##output dates in state 2
for (n in 1:length(traStates)){
if (traStates[n] == 2){print(retDates[n])}
}

$pm
$pm$mean
[1]  0.08841992 -0.06422404

$pm$sd
[1] 0.7646121 1.9376191


##Plotting stuff
dateAxis <- seq(as.Date("04/01/2012", format = "%d/%m/%Y"), by = "days", length = length(f))