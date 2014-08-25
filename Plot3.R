# Loading Data
if(!(exists("nei"))){
  nei <- readRDS("summarySCC_PM25.rds")}

if(!(exists("scc"))){
  scc <- readRDS("Source_Classification_Code.rds")}

#Renaming Column Names To Lowercase
names(nei) <- tolower(names(nei))
names(scc) <- tolower(names(nei))

#----------------------------------
#Plot3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a 
# plot answer this question.
if(!(exists("balt"))){
balt <- nei[which(nei$fips == "24510") ,]}

library(ggplot2)


#qplot(year,emissions,data=balt,color=type)

#Removing outlier to see the pattern better
clean.balt <- balt[balt$emissions<300,]

#qplot(year,emissions,data=clean.balt,color=type)
#qplot(year,emissions,data=clean.balt,color=type,facets  =  .	~	type)
#------------------------------------

png(filename = "Plot3.png",width = 1200, height = 600)

g <-qplot(year,emissions,data=clean.balt,color=type,facets  =  .	~	type)
g+ geom_point(size=3) 
g+ geom_smooth(size=1,method="lm") 
#g+ ggtitle("New plot title")
#g+ labs(title ="Plot3")

dev.off()