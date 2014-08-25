# Loading Data
if(!(exists("nei"))){
  nei <- readRDS("summarySCC_PM25.rds")}

if(!(exists("scc"))){
  scc <- readRDS("Source_Classification_Code.rds")}

#Renaming Column Names To Lowercase
names(nei) <- tolower(names(nei))
names(scc) <- tolower(names(nei))

#----------------------------------
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
#----------------------------------

png(filename = "Plot4.png",width = 480, height = 480)

plot(emissions~year,data=agg.coalcomb,type="l",col="brown",main="Plot 4- Emissions from coal combustion-related sources")

dev.off()
