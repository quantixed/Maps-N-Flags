if (!require("rworldmap")) {
  install.packages("rworldmap")
  library(rworldmap)
}
# ggplot2, ggFlags, dplyr are needed for the bar charts
library(ggplot2)
library(dplyr)
if (!require("ggflags")) {
  devtools::install_github("rensa/ggflags")
  library(ggflags)
}

# csv file with each person as a row and containing a column with the header Origin and
# countries in 2-letter ISO format (change joinCode for other formats)
file_name <- file.choose()
df1 <- read.csv(file_name, header = TRUE, stringsAsFactors = FALSE)
countries_lab <- as.data.frame(table(df1$Origin))
colnames(countries_lab) <- c("country", "value")
matched <- joinCountryData2Map(countries_lab, joinCode="ISO2", nameJoinColumn="country")
# make png of the map
png(file = "labWorldMap.png",
    width = 1024, height = 768)
par(mai=c(0,0,0.2,0))
mapCountryData(matched,
               nameColumnToPlot="value",
               mapTitle= "",
               catMethod = "logFixedWidth",
               colourPalette = "heat",
               oceanCol="lightblue",
               missingCountryCol="white",
               addLegend = FALSE,
               lwd = 1)
dev.off()
# make bar chart of lab members
countries_lab %>%
  mutate(code = tolower(country)) %>%
  ggplot(aes(x = reorder(country, value), y = value)) +
  geom_bar(stat = "identity") +
  geom_flag(y = -2.5, aes(country = code), size = 8) +
  scale_y_continuous(expand = c(0.1, 1)) +
  xlab("Country") +
  ylab("Lab members") +
  theme_bw() +
  theme(legend.title = element_blank()) +
  coord_flip()
ggsave("plot.png", plot = last_plot())