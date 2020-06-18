workingpath <- "C:\\Users\\MED1\\Desktop\\Coursera\\project"
#workingpath <- "C:\\Users\\pc\\Desktop\\Jihan\\EDA"
setwd(workingpath)

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)

library(dplyr)
NEI.tot <- NEI %>% 
	group_by(year) %>%
	summarize(Emi.Tot = sum(Emissions))

png(filename = "plot1.png")
barplot(Emi.Tot ~ year, data=NEI.tot, 
		xlab="Year", ylab="total emissions", main="Total PM2.5 in US")
dev.off()
