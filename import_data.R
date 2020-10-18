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

# str(NEI)
# colSums(is.na(NEI))  # There are no NAs in data
# 
# str(SCC)
# colSums(is.na(SCC))  # 11358 NAs in Map.To column and 8972 NAs in Last.Inventory.Year column
