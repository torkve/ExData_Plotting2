NEI <- readRDS("summarySCC_PM25.rds")
NEI <- subset(NEI, fips == "24510")

emissions <- tapply(NEI$Emissions, NEI$year, sum)

x <- as.numeric(names(emissions))
y <- emissions
png("plot2.png", width=480, height=480, units="px")
plot(x, y, type="p", xlab="Year",
     ylab="Total emission", main="PM[2.5] total emission in Baltimore City")
abline(lm(y ~ x))
legend("topright", legend="Regression line", lwd=1)
dev.off()
