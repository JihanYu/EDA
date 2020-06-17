workingpath <- "C:\\Users\\pc\\Desktop\\Jihan\\EDA"
setwd(workingpath)

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

NEI$fips <- as.numeric(NEI$fips)
NEI$Pollutant <- as.factor(NEI$Pollutant)
NEI$type <- as.factor(NEI$type)
NEI$year <- as.factor(NEI$year)

library(dplyr)
NEI.tot <- NEI %>% 
  group_by(year) %>%
  summarize(Emi.Tot = sum(Emissions))

with(NEI.tot, plot(year, Emi.Tot, type="l"))
barplot(Emi.Tot ~ year, data=NEI.tot)
