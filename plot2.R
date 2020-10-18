source("import_data.R")

# Question 2:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.


png("plot2.png")

library(dplyr)
totalEmisionsBaltimore <- NEI %>%
  filter(fips == "24510") %>%
  select(Emissions, year) %>%
  group_by(year) %>%
  summarise(totalEmissions = sum(Emissions))

atx <- seq(0, max(totalEmisionsBaltimore$totalEmissions), length.out = 5 )
barplot(totalEmisionsBaltimore$totalEmissions,
        horiz=TRUE,
        names.arg=totalEmisionsBaltimore$year,
        xaxt = "n",
        col = c(2:5),
        main="Total PM2.5 emissions in the Baltimore City, Maryland per year",
        xlab = "Total PM2.5 emissions in the Baltimore City, Maryland (in tons)"
)
axis(1, at=atx, labels=format(atx, scientific=FALSE), hadj=0.5, las=1)

# Answer: The total emissions from PM2.5 have significantly decreased 
# in the Baltimore City, Maryland from 1999 to 2008.




dev.off()