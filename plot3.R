workingpath <- "C:\\Users\\MED1\\Desktop\\Coursera\\project"
#workingpath <- "C:\\Users\\pc\\Desktop\\Jihan\\EDA"
setwd(workingpath)

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)

library(dplyr);  library(ggplot2)
NEI.BT.type.tot <- NEI %>% 
	group_by(year, type) %>%
	summarize(Emi.Tot = sum(Emissions))

#png(filename = "plot3.png")
ggplot(data=NEI.BT.type.tot, aes(x=year, y=Emi.Tot, group=type, color=type)) + 
geom_line()

#dev.off()
