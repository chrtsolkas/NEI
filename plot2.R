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

# Question 2:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.

library(dplyr)

png("plot2.png", height = 480, width = 640)


totalEmisionsBaltimore <- NEI %>%
  filter(fips == "24510") %>%
  select(Emissions, year) %>%
  group_by(year) %>%
  summarise(totalEmissions = sum(Emissions))

atx <- seq(0, max(totalEmisionsBaltimore$totalEmissions), length.out = 5 )
barplot(totalEmisionsBaltimore$totalEmissions,
        horiz = TRUE,
        names.arg = totalEmisionsBaltimore$year,
        xaxt = "n",
        col = c(2:5),
        main = expression("Total PM"[2.5] * " emissions in the Baltimore City, Maryland per year"),
        xlab = "Total emissions (in tons)"
)
axis(1, at = atx, labels = format(atx, scientific = FALSE), hadj = 0.5, las = 1)

dev.off()


# Answer: The total emissions from PM2.5 have significantly decreased 
# in the Baltimore City, Maryland from 1999 to 2008.

