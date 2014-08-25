# Loading Data
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")

names(nei) <- tolower(names(nei))
names(scc) <- tolower(names(nei))

#-----------------------------------
#Plot1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.
agg.nei <- aggregate(emissions~year,data=nei,sum)
plot(emissions~year,data=agg.nei,type="l",main="Plot 1- Total PM2.5 Emissions in the US 1999-2008")

#------------------------------------
#Plot2 
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.
balt <- nei[which(nei$fips == "24510") ,]
agg.balt <- aggregate(emissions~year,data=balt,sum)
plot(emissions~year,data=agg.balt,type="l",col="red",main="Plot 2- Total PM2.5 Emissions in Baltimore City 1999-2008")



#----------------------------------
#Plot3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a 
# plot answer this question.
library(ggplot2)
summary(balt)


qplot(year,emissions,data=balt,color=type)
#Removing outlier to see the pattern better
#summary(balt$emissions)
clean.balt <- balt[balt$emissions<300,]
#qplot(year,emissions,data=clean.balt,color=type)
#qplot(year,emissions,data=clean.balt,color=type,facets  =	.	~	type)
g <-qplot(year,emissions,data=clean.balt,color=type,facets  =  .	~	type)
g+ geom_point(size=3) 
g+ geom_smooth(size=1,method="lm") 
#g+ ggtitle("New plot title")
#g+ labs(title ="Plot3")

#------------------------------
#Plot4
# Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999–2008?

coal.pattern <- "[cC]oal"
coal.index   <- grep (coal.pattern,scc$pollutant)

combustion.pattern <- "[cC]ombustion"
combustion.index   <- grep (combustion.pattern,scc$pollutant)

# My Strategy :Where both words coal and combustion exist 
intersect <- intersect (coal.index,combustion.index)
intersect.scc <- scc[intersect, ]

coal.comb  <- nei[nei$scc %in% intersect.scc$fips, ]

agg.coalcomb <- aggregate(emissions~year,data=coal.comb,sum)
plot(emissions~year,data=agg.coalcomb,type="l",main="Plot 4- Emissions from coal combustion-related sources")

#------------------------------
#Plot5
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
motor.pattern <- "[Mm]otor"
motor.index   <- grep (motor.pattern,scc$pollutant)

vehicle.pattern <- "[Vv]ehicle"
vehicle.index   <- grep (vehicle.pattern,scc$pollutant)

# My Strategy :Where both words motor and vehicle exist 
intersect5 <- intersect (motor.index,vehicle.index)
intersect5.scc <- scc[intersect5, ]


motor.balt  <- balt[balt$scc %in% intersect5.scc$fips, ]

agg.motor <- aggregate(emissions~year,data=motor.balt,sum)

plot(emissions~year,data=agg.motor, main="Plot5 - Emissions from motor vehicle sources(1999–2008)
in Baltimore City",type="l",col="red")

 
#---------------------------------------
#Plot6
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle 
# sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes 
# over time in motor vehicle emissions?

LA <- nei[which(nei$fips == "06037") ,]
motor.LA  <- LA[LA$scc %in% intersect5.scc$fips, ]
plot(emissions~year,data=motor.LA, main="Plot5 - Emissions from motor vehicle sources(1999–2008)
in Los Angeles",type="l")
par(mfrow = c(2, 1))
plot(emissions~year,data=agg.motor, main="Plot5 - Emissions from motor vehicle sources(1999–2008)
in Baltimore City",type="l",col="red")
plot(emissions~year,data=motor.LA, main="Plot5 - Emissions from motor vehicle sources(1999–2008)
in Los Angeles",type="l",col="blue")


