NEI <- readRDS("summarySCC_PM25.rds")
emissions <- tapply(NEI$Emissions, NEI$year, sum)

x <- as.numeric(names(emissions))
y <- emissions

png("plot1.png", width=480, height=480, units="px")
plot(as.numeric(names(emissions)), emissions, type="p", xlab="Year",
     ylab="Total emission", main="PM[2.5] total emission by year")
abline(lm(y ~ x))
legend("topright", legend="Regression line", lwd=1)
dev.off()