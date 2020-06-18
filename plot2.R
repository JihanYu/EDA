workingpath <- "C:\\Users\\MED1\\Desktop\\Coursera\\project"
#workingpath <- "C:\\Users\\pc\\Desktop\\Jihan\\EDA"
setwd(workingpath)

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)

NEI.BT <- subset(NEI, fips=="24510")

library(dplyr)
NEI.BT.tot <- NEI.BT %>% 
	group_by(year) %>%
	summarize(Emi.Tot = sum(Emissions))

png(filename = "plot2.png")
barplot(Emi.Tot ~ year, data=NEI.BT.tot,
		xlab="Year", ylab="total emissions", main="Total PM2.5 in Baltimore City")
dev.off()
