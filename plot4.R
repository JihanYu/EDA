#workingpath <- "C:\\Users\\MED1\\Desktop\\Coursera\\project"
workingpath <- "C:\\Users\\pc\\Desktop\\Jihan\\EDA"
setwd(workingpath)

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

NEI$Pollutant <- factor(NEI$Pollutant)
NEI$type <- factor(NEI$type)
NEI$year <- factor(NEI$year)

id.Coal <- which(grepl("Coal", SCC$EI.Sector))
SCC.Coal <- as.character(SCC$SCC[id.Coal])

id.NEI.Coal <- which(NEI$SCC %in% SCC.Coal)
NEI.Coal <- NEI[id.NEI.Coal,]

library(dplyr)
NEI.Coal.tot <- NEI.Coal %>% 
	group_by(year) %>%
	summarize(Emi.Tot = sum(Emissions))

#png(filename = "plot4.png")
barplot(Emi.Tot ~ year, data=NEI.Coal.tot, 
		xlab="Year", ylab="total emissions", main="Total PM2.5 from Coal")
#dev.off()
