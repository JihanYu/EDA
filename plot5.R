workingpath <- "C:\\Users\\MED1\\Desktop\\Coursera\\project"
#workingpath <- "C:\\Users\\pc\\Desktop\\Jihan\\EDA"
setwd(workingpath)

### Load data & change data format ###
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

NEI$Pollutant <- factor(NEI$Pollutant)
NEI$type <- factor(NEI$type)
NEI$year <- factor(NEI$year)

# Find the SCC related Mobile
#   and select the NEI subset corresponding to the SCC
#   in Baltimore city
id.Mob <- which(grepl("Mobile", SCC$EI.Sector))
SCC.Mob <- as.character(SCC$SCC[id.Mob])

NEI.BT <- subset(NEI, fips=="24510")
id.NEI.BT.Mob <- which(NEI.BT$SCC %in% SCC.Mob)
NEI.BT.Mob <- NEI.BT[id.NEI.BT.Mob,]

### Total emission of PM2.5 for each year ###
library(dplyr);  library(ggplot2)
NEI.BT.Mob.tot <- NEI.BT.Mob %>% 
	group_by(year) %>%
	summarize(Emi.Tot = sum(Emissions))

### Plot & save the result ###
png(filename = "plot5.png")
g <- ggplot(data=NEI.BT.Mob.tot, aes(x=year, y=Emi.Tot))
g + geom_bar(stat="identity") + 
	ggtitle("Total emission of Motor in Baltimore") +
	xlab("year") + ylab("total emission") +
	theme(plot.title=element_text(size=16, face="bold"))
dev.off()


