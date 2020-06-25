workingpath <- "C:\\Users\\MED1\\Desktop\\Coursera\\project"
#workingpath <- "C:\\Users\\pc\\Desktop\\Jihan\\EDA"
setwd(workingpath)

### Load data & change data format ###
# assign the order of "type" variable #
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

NEI$Pollutant <- factor(NEI$Pollutant)
NEI$type <- factor(NEI$type, levels=c("POINT", "NONPOINT", "ON-ROAD", "NON-ROAD"))
NEI$year <- factor(NEI$year)

### Select Baltimore City ###
NEI.BT <- subset(NEI, fips=="24510")

### Total emission of PM2.5 for each year ###
library(dplyr);  library(ggplot2)
NEI.BT.type.tot <- NEI.BT %>% 
	group_by(year, type) %>%
	summarize(Emi.Tot = sum(Emissions))

### Plot & save the result ###
png(filename = "plot3.png")
g <- ggplot(data=NEI.BT.type.tot, aes(x=year, y=Emi.Tot, fill=type))
g + geom_bar(stat="identity", position="dodge") +
	ggtitle("Total emission in Baltimore City") + 
	xlab("year") + ylab("total emission") +
	theme(plot.title=element_text(size=16, face="bold"))
dev.off()

# Conclusion :
#  Emission decreased through the year in all types
#  But the emission from "POINT" increased from 1999 to 2005