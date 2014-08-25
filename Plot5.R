# Loading Data
if(!(exists("nei"))){
  nei <- readRDS("summarySCC_PM25.rds")}

if(!(exists("scc"))){
  scc <- readRDS("Source_Classification_Code.rds")}

#Renaming Column Names To Lowercase
names(nei) <- tolower(names(nei))
names(scc) <- tolower(names(nei))

#----------------------------------
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
#---------------------------------
png(filename = "Plot5.png",width = 480, height = 480)

plot(emissions~year,data=agg.motor, main="Plot5 - Emissions from motor vehicle sources(1999–2008)
in Baltimore City",type="l",col="red")

dev.off()