#Indicator vector of whether each day is a trading day
traDay = rep(0,length(Dates));
iter = 1;
while(is.na(rawPrices[iter])){
#-1 means the time series of prices have not started yet
traDay[iter] = -1;
iter = iter + 1;
}
traDay[iter] = 1;  #iter points to the 1st trading day
traDayCtr = 1;

for (n in (iter+1):length(rawPrices)){
if (!is.na(rawPrices[n])){
traDay[n] = 1;
traDayCtr = traDayCtr + 1;}
}
#Find the 2nd trading day, at which the return time series starts; iter1 points to it
iter1 = iter + 1;
while(is.na(rawPrices[iter1])){ iter1 = iter1 + 1}

##Recover trading dates and return realization dates (w.r.t given frequency, daily, weekly,etc)
traDates = Dates[1:traDayCtr] #Initialization
retDates = Dates[1:(traDayCtr-1)] #Initialization

traDatePtr = 1;
for (n in iter:length(Dates)){
if (traDay[n] == 1){
traDates[traDatePtr] = Dates[n];
traDatePtr = traDatePtr + 1;
}
}

retDatePtr = 1;
for(n in iter1:length(Dates)){
if (traDay[n] == 1){
retDates[retDatePtr] = Dates[n];
retDatePtr = retDatePtr + 1;
}
}





##Now assign iferred states to each date
##It assigns NA to dates before iter1/nontrading day

#"STD" is "StatesToDate"

spSTD = rep(NA,length(Dates))
#Begin assignments
statesPtr = 1;
for (n in iter1:length(Dates)){
if (traDay[n] == 1){
spSTD[n] = traStates[statesPtr];
statesPtr = statesPtr + 1;
}
}




