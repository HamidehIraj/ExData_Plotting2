# Loading Data
if(!(exists("nei"))){
  nei <- readRDS("summarySCC_PM25.rds")}

if(!(exists("scc"))){
  scc <- readRDS("Source_Classification_Code.rds")}

#Renaming Column Names To Lowercase
names(nei) <- tolower(names(nei))
names(scc) <- tolower(names(nei))

#------------------------------------
#Plot2 
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.
balt <- nei[which(nei$fips == "24510") ,]
agg.balt <- aggregate(emissions~year,data=balt,sum)

#-----------------------------------
png(filename = "plot2.png",width = 480, height = 480)

plot(emissions~year,data=agg.balt,type="l",col="darkgray",main="Plot 2- Total PM2.5 Emissions in Baltimore City 1999-2008")

dev.off()
