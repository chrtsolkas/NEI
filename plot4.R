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

# Question 4:
# Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999–2008?

library(dplyr)
library(ggplot2)
     
png("plot4.png", height = 480, width = 640)

SCC %>%
  filter(grepl("Coal", Short.Name, ignore.case = TRUE) ,
         grepl("Comb", Short.Name, ignore.case = TRUE)) %>%
  mutate(SCC = as.character(SCC)) %>%
  inner_join( NEI, by = "SCC") %>%
  group_by(year) %>%
  summarise(totalEmissions = sum(Emissions)) %>%
  ungroup(year) %>%
  mutate(Year = factor(year),
         Emissions = totalEmissions) %>%
  ggplot(aes(x = Year, y = format(Emissions, scientific = FALSE), fill = Year)) +
  labs(x = "Year", y = "Total emissions (in tons)", 
       title = expression("Total PM"[2.5] * " emission from coal combustion-related sources")) +
  geom_bar(stat = "identity") +
  coord_flip() +
  theme_minimal()

dev.off()

# Answer: Emissions from coal combustion-related sources have significantly 
# decreased from 1999 to 2008.
