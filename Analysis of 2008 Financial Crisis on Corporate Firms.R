options(scipen = 100)
#Importing tidyverse package
library(tidyverse)

#Importing Data File
myfile<-"C:\\Users\\mahno\\OneDrive\\Desktop\\MS Business Analytics\\Fall Semester\\Financial Analytics\\Assignments\\Assignment 1\\Compustat 1990-2015 Lots.csv"
mydat<-read.csv(myfile,header=T,sep=',')

#Running Basic Diagnostics functions on file to get a sense of data in the file

# Find the dimensions
dim(mydat)

# Find the structure
str(mydat)

# See the first 6 rows
head(mydat)

# See the last 6 rows
tail(mydat)

# Find the column names
names(mydat)

# Find summary of "rand_number"
summary(mydat)

# View the data set
View(mydat)


#QUESTION 1

#Selecting relevant columns and Filtering out relevant year range
mydat1<-mydat%>%select(fyear,tic,ni)%>%filter(between(fyear,2004,2008))
head(mydat1)


#Filtering Crisis Years(2007-2008) and calculating their Mean Annual Net Income
Q1_crisis_yrs<-mydat1%>%select(fyear,tic,ni)%>% group_by(tic) %>%
  filter(between(fyear,2007,2008))%>%
  summarise(mean_Annual_NetIncome_crisis_yrs=mean(ni))%>%na.exclude()


#Filtering Pre-Crisis Years(2004-2006) and calculating their Mean Annual Net Income
Q1_precrisis_yrs<-mydat1%>%select(fyear,tic,ni)%>% group_by(tic)%>%
  filter(between(fyear,2004,2006))%>%
  summarise(mean_Annual_NetIncome_precrisis_yrs=mean(ni))%>%na.exclude()


#Merging the Two data frames 
Q1_merged<-merge(x=Q1_precrisis_yrs,y=Q1_crisis_yrs,by = 'tic')

#Calculating the Absolute Change of Mean Annual Net Income between the Pre-Crisis Years and Crisis Years
Q1_abs_dec<-Q1_merged%>%select(tic,mean_Annual_NetIncome_precrisis_yrs,mean_Annual_NetIncome_crisis_yrs)%>%
  group_by(tic)%>%
  mutate(abs_change = abs(mean_Annual_NetIncome_precrisis_yrs-mean_Annual_NetIncome_crisis_yrs))%>%
  arrange(-desc(abs_change))%>%na.exclude

#Filtering out values which are missing/zero
Q1_abs_dec[Q1_abs_dec==0] <- NA
Q1_abs_dec<-Q1_abs_dec%>%na.exclude()


#Calculating the Percentage Decrease of Mean Annual Net Income between the Pre-Crisis Years and Crisis Years
Q1_pct_dec<-Q1_merged%>%select(tic,mean_Annual_NetIncome_precrisis_yrs,mean_Annual_NetIncome_crisis_yrs)%>%
  group_by(tic)%>%
  mutate(pct_change = (((mean_Annual_NetIncome_crisis_yrs-(mean_Annual_NetIncome_precrisis_yrs))/abs(mean_Annual_NetIncome_precrisis_yrs))*100))%>%
  arrange(-desc(pct_change))%>%na.exclude()

#Filtering out +/- inf values from the data set
Q1_pct_dec<-Q1_pct_dec%>% filter_all(all_vars(!is.infinite(.)))

#Dropping the rows for which the Percentage Change column has Positive Values as they represent the percentage increase and not percentage decrease 
Q1_pct_dec <- Q1_pct_dec[Q1_pct_dec$pct_change <= 0, ]


#QUESTION 2

#The 10 firms with the largest and smallest Absolute Change
Q2_abs_dec_largest<-tail(Q1_abs_dec,n=10)
Q2_abs_dec_largest<-Q2_abs_dec_largest%>%arrange(desc(abs_change))
Q2_abs_dec_largest
Q2_abs_dec_smallest<-head(Q1_abs_dec,n=10)
Q2_abs_dec_smallest

#The 10 firms with the largest and smallest Percent Change
Q2_pct_dec_largest<-head(Q1_pct_dec,n=10)
Q2_pct_dec_largest
Q2_pct_dec_smallest<-tail(Q1_pct_dec,n=10)
Q2_pct_dec_smallest


#Question 3


#Filtering the Pre-Crisis Years 2004-2006 and finding the highest Net Income of each firm along with the year in which it was attained
Q3_precrisis_years<-mydat1%>%
  filter(between(fyear,2004,2006))%>%
  group_by(tic)%>%
  summarise(Highest_Annual_NetIncome_precrisis_yrs=max(ni))


#Filtering the Post-Crisis Years 2009-2014
Q3_post_crisis_years<-mydat%>%select(fyear,tic,ni)%>%filter(between(fyear,2009,2014))


#Merging the Post Crisis Years and Pre-Crisis Years  data frames
Q3_merged<-merge(x=Q3_post_crisis_years,y=Q3_precrisis_years,by = 'tic',all.y =TRUE )


#Finding the Year in which the Highest Net Income of Pre-Crisis Years was attained in the Post Crisis Years era 
#Calculating the Years it took to recover the Highest Net Income of Pre Crisis Years in the Post Crisis era
Years_To_Recover<-Q3_merged%>%group_by(tic)%>%
  summarise(Year_Highest_Annual_NetIncome_precrisis_yrs_Breached=fyear[min(which(ni>=Highest_Annual_NetIncome_precrisis_yrs))],
            YearsRecover=Year_Highest_Annual_NetIncome_precrisis_yrs_Breached-2008)%>%
  na.exclude()%>%distinct()%>%arrange(desc(YearsRecover))

#na.exclude() was used to exclude the firms which couldn't recover the Highest Net Income in the Post Crisis era

