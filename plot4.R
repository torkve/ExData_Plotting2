library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

comb <- subset(SCC,
               SCC.Level.One %in% c("External Combustion Boilers",
                                    "Internal Combustion Engines",
                                    "Stationaty Source Fuel Combustion")
               & SCC.Level.Three %in% c("Anthracite Coal",
                                        "Bituminous/Subbituminous Coal",
                                        "Gasified Coal",
                                        "Waste Coal")
               )
NEI <- subset(NEI, SCC %in% comb$SCC)

emissions <- tapply(NEI$Emissions, NEI$year, sum)
x <- as.numeric(names(emissions))
y <- emissions
png("plot4.png", width=480, height=480, units="px")
plot(x, y, type="p", xlab="Year",
     ylab="Total emission", main="Total emission from coal combustion related sources")
abline(lm(y ~ x))
legend("topright", legend="Regression line", lwd=1)

dev.off()