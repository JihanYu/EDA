workingpath <- "C:\\Users\\MED1\\Desktop\\Coursera\\project"
#workingpath <- "C:\\Users\\pc\\Desktop\\Jihan\\EDA"
setwd(workingpath)

### Load data & change data format ###
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

NEI$Pollutant <- factor(NEI$Pollutant)
NEI$type <- factor(NEI$type)
NEI$year <- factor(NEI$year)

# Find the SCC related Coal
#   and select the NEI subset corresponding to the SCC
id.Coal <- which(grepl("Coal", SCC$EI.Sector))
SCC.Coal <- as.character(SCC$SCC[id.Coal])

id.NEI.Coal <- which(NEI$SCC %in% SCC.Coal)
NEI.Coal <- NEI[id.NEI.Coal,]

### Total emission of PM2.5 for each year ###
library(dplyr);  library(ggplot2)
NEI.Coal.tot <- NEI.Coal %>% 
	group_by(year) %>%
	summarize(Emi.Tot = sum(Emissions))

### Plot & save the result ###
png(filename = "plot4.png")
g <- ggplot(data=NEI.Coal.tot, aes(x=year, y=Emi.Tot))
g + geom_bar(stat="identity") + 
	coord_cartesian(ylim=c(200000, 600000)) +
	ggtitle("Total emission related to Coal") +
	xlab("year") + ylab("total emission") +
	theme(plot.title=element_text(size=16, face="bold"))
dev.off()

# Conclusion :
#  Emission from Coal decreased through the year