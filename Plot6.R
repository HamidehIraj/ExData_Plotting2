# Loading Data
if(!(exists("nei"))){
  nei <- readRDS("summarySCC_PM25.rds")}

if(!(exists("scc"))){
  scc <- readRDS("Source_Classification_Code.rds")}

#Renaming Column Names To Lowercase
names(nei) <- tolower(names(nei))
names(scc) <- tolower(names(nei))
#---------------------------------------
#Plot6
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle 
# sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes 
# over time in motor vehicle emissions?
balt <- nei[which(nei$fips == "24510") ,]
LA <- nei[which(nei$fips == "06037") ,]

motor.pattern <- "[Mm]otor"
motor.index   <- grep (motor.pattern,scc$pollutant)

vehicle.pattern <- "[Vv]ehicle"
vehicle.index   <- grep (vehicle.pattern,scc$pollutant)

# My Strategy :Where both words motor and vehicle exist 
intersect5 <- intersect (motor.index,vehicle.index)
intersect5.scc <- scc[intersect5, ]


motor.LA  <- LA[LA$scc %in% intersect5.scc$fips, ]
agg.LA <- aggregate(emissions~year,data=motor.LA,sum)

motor.balt  <- balt[balt$scc %in% intersect5.scc$fips, ]
agg.balt <- aggregate(emissions~year,data=motor.balt,sum)
#--------------------------------------

png(filename = "Plot6.png",width = 640, height = 480)

par(mfrow = c(2, 1))
plot(emissions ~ year,data=agg.balt, main="Plot6 - Emissions from motor vehicle sources(1999–2008)
in Baltimore City",type="l",col="red")

plot(emissions ~ year,data=motor.LA, main="Plot6 - Emissions from motor vehicle sources(1999–2008)
in Los Angeles",type="l",col="blue")

dev.off()


