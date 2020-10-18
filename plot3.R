source("import_data.R")

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
  mutate(Year = factor(year),
         Emissions = totalEmissions,
         Type = factor(type)) %>%
  ggplot(aes(x=Type, y=Emissions, fill=Year)) +
  labs(x = "Types of sources", y = "Total emissions (in tons)", 
       title = "Types of sources of PM2.5 emissions in the Baltimore City, Maryland") +
  geom_bar(stat = "identity", position=position_dodge()) +
  theme_minimal()

dev.off()

# Answer: The following types of sources have seen decreases in emissions from 1999–2008 for 
# Baltimore City: NON-ROAD, NONPOINT and ON-ROAD. The POINT type of source have seen 
# increases in emissions from 1999–2008.