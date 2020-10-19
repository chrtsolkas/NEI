# Download the zip file and unzip it only if this was not already done
if(!file.exists("NEI.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", destfile = "NEI.zip")
}

if(!file.exists("Source_Classification_Code.rds")) {
  unzip("NEI.zip") 
}

# Read the two data files if this was not already done
if (!("NEI" %in% ls())) {
  NEI <- readRDS("summarySCC_PM25.rds")
  
}

if (!("SCC" %in% ls())) {
  SCC <- readRDS("Source_Classification_Code.rds")
  SCC$Created_Date <- as.Date(as.character(SCC$Created_Date), "%m/%d/%Y")
  SCC$Revised_Date <- as.Date(as.character(SCC$Revised_Date), "%m/%d/%Y")
}

# Question 3:
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

library(dplyr)
library(ggplot2)

png("plot3.png")

NEI %>%
  filter(fips == "24510") %>%
  select(Emissions, type, year) %>%
  group_by(year, type) %>%
  summarise(totalEmissions = sum(Emissions)) %>%
  ungroup(year) %>%
  mutate(Year = factor(year),
         Emissions = totalEmissions,
         Type = factor(type)) %>%
  ggplot(aes(x = Type, y = Emissions, fill = Year)) +
  labs(x = "Types of sources", y = "Total emissions (in tons)", 
       title = expression("Types of sources of PM"[2.5] * " emission in the Baltimore City, Maryland")) +
  geom_bar(stat = "identity", position = position_dodge()) +
  theme_minimal()

dev.off()

# Answer: The following types of sources have seen decreases in emissions from 1999–2008 for 
# Baltimore City: NON-ROAD, NONPOINT and ON-ROAD. The POINT type of source have seen 
# increases in emissions from 1999–2008.
