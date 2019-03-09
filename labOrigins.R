if (!require("rworldmap")) {
  install.packages("rworldmap")
  library(rworldmap)
}
# csv file with each person as a row and containing a column with the header Origin and
# countries in 2-letter ISO format (change joinCode for other formats)
file_name <- file.choose()
df1 <- read.csv(file_name, header = TRUE, stringsAsFactors = FALSE)
countries_lab <- as.data.frame(table(df1$Origin))
colnames(countries_lab) <- c("country", "value")
matched <- joinCountryData2Map(countries_lab, joinCode="ISO2", nameJoinColumn="country")
png(file = "labWorldMap.png",
    width = 1024, height = 768)
#mapCountryData(matched, nameColumnToPlot="value", mapTitle="Origin of CMCB Members", catMethod = "pretty", colourPalette = brewer.pal(6,"Set3"))
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
