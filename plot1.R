source("import_data.R")

# Question 1:
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.


png("plot1.png")
library(dplyr)
totalEmisionsPerYear <- NEI %>%
  select(Emissions, year) %>%
  group_by(year) %>%
  summarise(totalEmissions = sum(Emissions))

atx <- seq(0, max(totalEmisionsPerYear$totalEmissions), length.out = 5 )
barplot(totalEmisionsPerYear$totalEmissions,
        horiz=TRUE,
        names.arg=totalEmisionsPerYear$year,
        xaxt = "n",
        col = c(2:5),
        main="Total PM2.5 emissions per year",
        xlab = "Total PM2.5 emissions in tons"
        )
axis(1, at=atx, labels=format(atx, scientific=FALSE), hadj=0.5, las=1)

# Answer: The total emissions from PM2.5 have significantly decreased 
# in the United States from 1999 to 2008.

dev.off()
