workingpath <- "C:\\Users\\MED1\\Desktop\\Coursera\\project"
#workingpath <- "C:\\Users\\pc\\Desktop\\Jihan\\EDA"
setwd(workingpath)

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

NEI$Pollutant <- factor(NEI$Pollutant)
NEI$type <- factor(NEI$type, levels=c("POINT", "NONPOINT", "ON-ROAD", "NON-ROAD"))
NEI$year <- factor(NEI$year)

library(dplyr);  library(ggplot2)
NEI.BT.type.tot <- NEI %>% 
	group_by(year, type) %>%
	summarize(Emi.Tot = sum(Emissions))

#png(filename = "plot3.png")
g <- ggplot(data=NEI.BT.type.tot, aes(x=year, y=Emi.Tot, fill=type))
g + geom_bar(stat="identity")

g + geom_bar(stat="identity", position="dodge")


#dev.off()
