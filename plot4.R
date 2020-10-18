source("import_data.R")

# Question 4:
# Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999–2008?

png("plot4.png")
SCC %>%
  filter(grepl("Coal", Short.Name))


dev.off()