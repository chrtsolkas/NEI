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

# Question 6:
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

library(dplyr)
library(ggplot2)

png("plot6.png", height = 480, width = 640)

Baltimore <- SCC %>%
  filter(grepl("Veh", Short.Name, ignore.case = TRUE)) %>%
  mutate(SCC = as.character(SCC)) %>%
  inner_join( NEI, by = "SCC") %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarise(totalEmissions = sum(Emissions)) %>%
  ungroup(year) %>%
  mutate(Year = factor(year),
         Emissions = totalEmissions,
         City = "Baltimore")

LA <- SCC %>%
  filter(grepl("Veh", Short.Name, ignore.case = TRUE)) %>%
  mutate(SCC = as.character(SCC)) %>%
  inner_join( NEI, by = "SCC") %>%
  filter(fips == "06037") %>%
  group_by(year) %>%
  summarise(totalEmissions = sum(Emissions)) %>%
  ungroup(year) %>%
  mutate(Year = factor(year),
         Emissions = totalEmissions,
         City = "Los Angeles")

bind_rows(Baltimore, LA) %>%
  ggplot(aes(x=Year, y=format(Emissions, scientific = FALSE), fill = City)) +
  labs(x = "Year", y = "Total emissions from motor vehicle sources (in tons)", 
       title = expression("Baltimore City versus Los Angeles City - Total PM"[2.5] * " emission from motor vehicle sources")) +
  geom_bar(stat = "identity", position = position_dodge()) +
  theme_minimal()

dev.off()

# Answer: Emissions from motor vehicle sources in the Baltimore City were significantly lower
# than those in the Los Angeles City from 1999 to 2008.

