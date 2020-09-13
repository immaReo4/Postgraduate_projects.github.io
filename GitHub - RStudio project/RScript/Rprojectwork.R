library(stringr)
library(tidyr)
library(dplyr)

countydata <- read.csv("C:\\Users\\Reonne\\Downloads\\TransportCSOfile.csv")

##county_sample <- countydata %>%
  #filter(!is.na(countydata)) %>%
  #ggboxplot(x=countydata$County,y=countydata[10:40],palette = aaas,
            #title = "County transport data outlier check",
            #xlab = countydata$County,
            #ylab = countydata[10:40],
            #ggtheme = theme_gray())

colnames(countydata)


for(x in 10:40) {
  word_location = str_locate(colnames(countydata)[x],"College_")[2]
  colnames(countydata)[x] = substring(colnames(countydata)[x],word_location+1)
  
}

colnames(countydata)[22]= "Mean_Total"
colnames(countydata)[32]= "Total_Time"
colnames(countydata)[40]= "Journey_Total"

for(x in 24:29){
  colnames(countydata)[x] <- paste("During_", sep = "",colnames(countydata)[x])
}

#Checking for the appropriate change in the column names

colnames(countydata)

str(countydata)

sum(is.na(countydata))
countydata <- na.omit(countydata)
summary(countydata)

boxplot(countydata[10:40])$out #finding the outliers using boxplot
which(countydata[10:40] %in% boxplot(countydata)$out) #Removing the outliers that were found

countydata1 = subset(countydata,
                      On_Foot_2011 < 50 &
                      Bus_Minibus_Coach_2011 < 40 &
                      Train_Dart_Luas_2011 < 10 &
                      Motorcycle_Scooter_2011 < 10 &
                      Car_Driver_2011 < 150 & 
                      Car_Passenger_2011 < 70 & 
                      Other_2011 < 25 &
                      Soft_Modes_Comb_2011 < 60 &
                      Public_Transport_Comb_2011 < 50 &
                      Private_Transport_Comb_2011 < 170 &
                      Before_0630_2011 < 20 & 
                      During_0630_0700_2011 < 30 & 
                      During_0701_0730_2011 < 30 &
                      During_0731_8000_2011 < 50 &
                      During_0801_0830_2011 < 60 & 
                      During_0831_0900_2011 < 70 & 
                      During_0901_0930_2011 < 40 &
                      After_0930_2011 < 25 &
                      Not_Stated_2011 < 20 & 
                      Under_15_mins_2011 < 100 &
                      Quarter_To_Under_Half_Hour_2011 < 100 &
                      Half_Hour_To_Under_Three_Quarter_Hours_2011 < 100 &
                      Three_Quarter_Hours_To_Under_One_Hour_2011 < 25 &
                      One_Hour_To_Under_One_Hour_Thirty_Mins_2011 < 20 &
                      One_And_Half_Hours_And_Over_2011 < 10 &
                      Not_Stated_2011 < 20)

#Q1
#What is the most popular mode of transport nationally?

Most_Pop_Transport_Mode = function(par_Data){
  meanModes=list()
  maxMeanModes = 0
  popularMode = ""
  i=10
  for(a in 1:9){
    meanModes[a] = mean(par_Data[,i])
    if(maxMeanModes < mean(par_Data[,i])){
      maxMeanModes = meanModes[a]
      popularMode = colnames(par_Data[i])
    }
    i = i+1
  }
  Response = list(popularMode,maxMeanModes)
  return(Response)
}


National_Pop_Mode = Most_Pop_Transport_Mode(countydata)
print(str_c('The most popular mode of trnsport nationally is ', National_Pop_Mode[1],' with a maximum mean of ', unlist(National_Pop_Mode[2])))


#Q2
#How does the above answer compare to the most popular mode of transport in your assigned county?

valid_column_names <- make.names(names=names(countydata),unique=TRUE, allow_ = TRUE)
names(countydata) <- valid_column_names
Corkcountydata <- filter(countydata,countydata$County == 'Cork County')
Cork_Pop_Mode = Most_Pop_Transport_Mode(Corkcountydata) 

Transport_Pop_mean <- list() #creating one list
i <- 10
for (x in 10:18) {
  Transport_Pop_mean[x] = mean(Corkcountydata[, i])
  i = i + 1
} #for loop till it finds the mean of the data
max(unlist(Transport_Pop_mean))
for (x in 10:18) {
  if (mean(Corkcountydata[,x]) == max(unlist(Transport_Pop_mean))) {
    print(str_c('most popular transport is ', colnames(Corkcountydata[x])))
  }
}

print(str_c('The most popular mode of transport in Cork is ', Cork_Pop_Mode[1], ' with a maximum mean of ', unlist(Cork_Pop_Mode[2])))

cat("Looking at the mean of modes of both nationality and county clare the Mode Car driver and mean value are same.\n So Clare county reflects the same mode popular as the whoel nation")


#Q3
#What differences are evident between the choice of transportation in the cities compared to the other regions?
region1 <- countydata %>% group_by(County) %>% summarise_all(funs(mean))
region2 <-
  countydata %>% group_by(Planning.Region) %>% summarise_all(funs(mean))

#Different approach 
Most_Pop_Compare_Mode = function(par_Data){  #A function to compare the most popular mode of transport
  meanCompareMode = list()
  maxMeanCompareMode = 0
  popularCompareMode = ""
  
  i = 10
  for (x in 1:9) {
    meanCompareMode[x] = colMeans(par_Data[,i], na.rm = TRUE)
    if(maxMeanCompareMode < colMeans(par_Data[,i],na.rm = TRUE)){
      maxMeanCompareMode = meanCompareMode[x]
      popularCompareMode = colnames(par_Data[i])
    }
    i = i+1
  }
  response = list(popularCompareMode,maxMeanCompareMode)
  return(response)
}

plan_Region_Data = countydata1 %>% group_by(Planning.Region) %>% summarise_all(funs(mean))
plan_Region_Data
County_data = countydata %>% group_by(County) %>% summarise_all(funs(mean))
region_Pop_Mode = Most_Pop_Compare_Mode(plan_Region_Data)
county_Pop_Mode = Most_Pop_Compare_Mode(County_data)

print(region_Pop_Mode[1])
print(region_Pop_Mode[2])
print(county_Pop_Mode[1])
print(county_Pop_Mode[2])

mean(plan_Region_Data[,10])

#Error in the following section of solution for Question 3
#countydata %>% aggregate(x = countydata$On_Foot_2011,y = countydata$Bicycle_2011,
#                         by = list(countydata$County),
#                         FUN = mean)

#Q4
#What proportion of the commuters leave home outside of the 8-9am rush hour?

Totaltime <-  sum(countydata$Total_Time)# Calculating total time
print(Totaltime)#printing total time

rush_hour_time <-  Totaltime - sum(sum(countydata[,"During_0801_0830_2011"]), sum(countydata[,"During_0831_0900_2011"])) #Calculating the rush hour time of the required enquiry

print(rush_hour_time)
Response = rush_hour_time/Totaltime #Calculating the proportion
print(str_c("Proportion of commuters leaving outside 8-9am is ", round(Response,2)))


#Q5
#Are commuters in your assigned county likely to travel for longer than 45 minutes each morning?
longerthan45Duration = sum(sum(Corkcountydata$Three_Quarter_Hours_To_Under_One_Hour_2011),
                       sum(Corkcountydata$One_Hour_To_Under_One_Hour_Thirty_Mins_2011),
                       sum(Corkcountydata$One_And_Half_Hours_And_Over_2011))
Apartfrom_45Duration = sum(Corkcountydata$Journey_Total)-longerthan45Duration
if(longerthan45Duration > Apartfrom_45Duration) {
  print("In Cork county, the commuters are likely to travel for longer than 45 minutes each morning")
}else{
  print("In Cork county, the commuters are likely to travel for shorter than 45 minutes each morning")
}

#Q6
#How does the above answer compare to other counties in the same NUTS III region?

#For this pupose, we obtain the NUTS III region for the assigned county: Cork
NUTSIIIReg <- filter(countydata, countydata$NUTS_III == 'Cork')
NUTSIIIReg
View(NUTSIIIReg)
colnames(NUTSIIIReg)
group_by(NUTSIIIReg)


dist_coun <- NUTSIIIReg %>% distinct(County)
dist_coun <- dist_coun$County
dist_coun
dist_coun[x]


for (x in 2:4) {
  DC <- countydata %>% filter(County == dist_coun[x])
  Tottime = sum(sum(DC$Three_Quarter_Hours_To_Under_One_Hour_2011),
                sum(DC$One_Hour_To_Under_One_Hour_Thirty_Mins_2011),
                sum(DC$One_And_Half_Hours_And_Over_2011))
  
  Jour_Tot <- sum(DC$Journey_Total)
  difference1 = Jour_Tot - Tottime
  print(difference1)
  
  if (difference1 > Tottime) {
    print(str_c(
      'For County ',
      dist_coun[x],
      'Final journey time is lesser than 45 minutes'
    ))
  } else{
    print(str_c(
      'For County ',
      dist_coun[x],
      'Final journey time longer than 45 minutes'
    ))
  }
}
print(Totaltime)


#Trying to solve the same using a different approach 
NUTSIIIReg = Corkcountydata$NUTS_III[1]
NUTSIIIReg
NUTSIIIRegCounties = countydata %>% filter(NUTS_III == NUTSIIIReg) %>% distinct(County)
NUTSIIIRegCounties = NUTSIIIRegCounties$County
NUTSIIIRegCounties[2]
for(x in 2:4){
  county_Data = countydata %>% filter(County == NUTSIIIRegCounties[x])
  longerthan45Duration = sum(sum(county_Data$Three_Quarter_Hours_To_Under_One_Hour_2011),
                         sum(county_Data$One_Hour_To_Under_One_Hour_Thirty_Mins_2011),
                         sum(county_Data$One_And_Half_Hours_And_Over_2011))
  print(longerthan45Duration)
  Apartfrom_45Duration = sum(county_Data$Journey_Total)-longerthan45Duration
  print(Apartfrom_45Duration)
  if(longerthan45Duration > Apartfrom_45Duration) {
    print(str_c("In ", NUTSIIIRegCounties[x]," county commuters are likely to travel for longer than 45 minutes every morning"))
  }else{
    print(str_c("In ", NUTSIIIRegCounties[x]," county commuters are likely to travel for shorter than 45 minutes every morning"))
  }
}


#Q7
#Which of the five counties have residents who experience the longest commute times?

CompleteCountyData <-  countydata %>% group_by(County) %>% summarise(sum(One_And_Half_Hours_And_Over_2011))
#CompleteCountyData <-  CompleteCountyData[order('sum(One_And_Half_Hours_And_Over_2011)')]

top5 = sort(CompleteCountyData$'sum(One_And_Half_Hours_And_Over_2011)',decreasing = TRUE)
for(a in 1:33){
  for (b in 1:5) {
    if(CompleteCountyData$'sum(One_And_Half_Hours_And_Over_2011)'[a] == top5[b]){
      factor(CompleteCountyData$County)
      print(CompleteCountyData$County[a])
    }
  }
}


#Q8
#What proportion of cars used in the morning commute contain only one person?

carno1 <- sum(countydata$Car_Passenger_2011)#Adding all the data in the car passesnger and storing it in carno1
carno1

carno2 <- sum(countydata$Car_Driver_2011)#Adding all the data in the car driver and storing it in carno2
carno2

Total_Car_Users = countydata %>% transmute(countydata$Car_Driver_2011 + countydata$Car_Passenger_2011)# Calculating the total time for passenger and driver and storing it in the variable
colnames(Total_Car_Users)[1] = "TotalCarUsers" #Assigning the name of the column

sing_Car_User <-  sum(nrow(subset(countydata,countydata$Car_Passenger_2011 == 1)),nrow(subset(countydata, countydata$Car_Driver_2011== 1)))

sing_Car_User_Proportion <- sing_Car_User/sum(Total_Car_Users) #Calculating the proportion

print(
  str_c(
    sing_Car_User_Proportion,
    " is the proportion of cars used in the morning commute, containing only one person"
  )
)

#Q10. 
#Which Electoral Division within each Planning Region do you propose should be prioritised for investment in public transportation? 

Dist_ED <- countydata %>% distinct(Electoral.Division.Name)# for distinct Electoral Division Name attribute
Dist_ED # Printing to check
ED <- countydata %>% group_by(Planning.Region) #Grouping based on Planning Region Attribute
ED
ED1 <- ED %>% distinct(Electoral.Division.Name)#Electoral division on distinct Electoral division name
ED <- ED %>% distinct(Planning.Region) #
ED1
ED <- ED[!apply(ED == "", 1, all),]
ED
#for(x in 1:4){
  #sol_var = countydata1 %>% filter(countydata$Planning.Region == ED[x]) %>% group_by(Electoral.Division.Name) %>% summarise_all()
#}
