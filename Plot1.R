# Loading Data
if(!(exists("nei"))){
nei <- readRDS("summarySCC_PM25.rds")}

if(!(exists("scc"))){
scc <- readRDS("Source_Classification_Code.rds")}

#Renaming Column Names To Lowercase
names(nei) <- tolower(names(nei))
names(scc) <- tolower(names(nei))

#-----------------------------------
#Plot1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.
agg.nei <- aggregate(emissions~year,data=nei,sum)
#----------------------------------

png(filename = "plot1.png",width = 480, height = 480)

plot(emissions~year,data=agg.nei,type="l",col="green",
     main="Plot 1- Total PM2.5 Emissions in the US 1999-2008")
dev.off()