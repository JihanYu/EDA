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
#   in Baltimore & LA city
id.Mob <- which(grepl("Mobile", SCC$EI.Sector))
SCC.Mob <- as.character(SCC$SCC[id.Mob])

NEI.BT <- subset(NEI, fips=="24510")
NEI.LA <- subset(NEI, fips=="06037")
id.NEI.BT.Mob <- which(NEI.BT$SCC %in% SCC.Mob)
id.NEI.LA.Mob <- which(NEI.LA$SCC %in% SCC.Mob)
NEI.BT.Mob <- NEI.BT[id.NEI.BT.Mob,]
NEI.LA.Mob <- NEI.LA[id.NEI.LA.Mob,]

### Total emission of PM2.5 for each year ###
library(dplyr);  library(ggplot2)
NEI.BT.Mob.tot <- NEI.BT.Mob %>% 
	group_by(year) %>%
	summarize(Emi.Tot = sum(Emissions))

NEI.LA.Mob.tot <- NEI.LA.Mob %>%
	group_by(year) %>%
	summarize(Emi.Tot = sum(Emissions))

NEI.Mob <- data.frame(rbind(NEI.BT.Mob.tot, NEI.LA.Mob.tot),
						city=rep(c("BT", "LA"), each=4))
NEI.Mob$city <- factor(NEI.Mob$city)

### Plot & save the result ###
png(filename = "plot6.png")
g <- ggplot(data=NEI.Mob, aes(x=year, y=Emi.Tot, fill=city))
g + geom_bar(stat="identity", position="dodge") + 
	ggtitle("Total emission of Motor : Baltimore vs LA") +
	xlab("year") + ylab("total emission") +
	theme(plot.title=element_text(size=16, face="bold"))
dev.off()

# Conclusion :
#  The emission from motor vehicles in LA increased from 1999 to 2005
#   then decreased in 2008
#  The amount of change is greater in LA