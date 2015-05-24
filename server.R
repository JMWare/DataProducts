## Comparison of monthly UK road casualties before & after seatbelt law.

options(warn=-1)
library (shiny)
library(ggplot2)
library(datasets)
T <- as.integer(Seatbelts[,2] + Seatbelts[,3] + Seatbelts[,4])
Y <- 1969 + (0:191)/12
M <- 1 + (0:191)%%12
B <- 1
E <- 192
Data <- data.frame(Seatbelts[ , c(2:6)], "Total" = T, 
				law = as.factor(Seatbelts[ ,8]), "Year" = Y, "Month" = M)

TITLE <- c("ANNUAL TOTAL CASUALTIES", 
		"MONTHLY TOTAL CASUALTIES",
		"TOTAL CASUALTIES BY ANNUAL KILOMETRES DRIVEN", 
		"TOTAL CASUALTIES BY PETROL PRICE",   
		"ANNUAL DRIVER CASUALTIES", 
		"MONTHLY DRIVER CASUALTIES",
		"DRIVER CASUALTIES BY ANNUAL KILOMETRES DRIVEN", 
		"DRIVER CASUALTIES BY PETROL PRICE",   
		"ANNUAL FRONT PASSENGER CASUALTIES", 
		"MONTHLY FRONT PASSENGER CASUALTIES",
		"FRONT PASSENGER CASUALTIES BY ANNUAL KILOMETRES DRIVEN", 
		"FRONT PASSENGER CASUALTIES BY PETROL PRICE",   
		"ANNUAL REAR PASSENGER CASUALTIES", 
		"MONTHLY REAR PASSENGER CASUALTIES",
		"REAR PASSENGER CASUALTIES BY ANNUAL KILOMETRES DRIVEN", 
		"REAR PASSENGER CASUALTIES BY PETROL PRICE")  

XLAB <- c("YEAR", "MONTH", "KILOMETRES", "PETROL PRICE")
YLAB <- c("TOTAL CASUALTIES PER MONTH", "DRIVER CASUALTIES PER MONTH", 
		"FRONT PASSENGER CASUALTIES PER MONTH", 
		"REAR PASSENGER CASUALTIES PER MONTH")

Graphic <- function(Obs, Stat, Style, Begin)
{	B <- 1+(Begin-1969)*12
	C2 <- switch(Obs, 6, 1, 2, 3)
	C1 <- switch(Stat, 8, 9, 4, 5)
	XL <- XLAB[Stat]
	YL <- YLAB[Obs]
	T <- TITLE[(Obs-1)*4+Stat]
	COL <- 3
	switch(Style, 
		{ qplot(Data[B:E,C1], Data[B:E,C2], geom=c("point", "smooth"), 
			method="loess", col=Data$law[B:E], main=T, xlab=XL, ylab=YL) },
	 	{ par( bg="lavender")
		  plot(Data[B:E,C1], Data[B:E,C2], pch=19, col=COL,
			cex.main=2, cex.lab=1.5, cex.axis=1.5,
			main=T, xlab=XL, ylab=YL)
		  SS <- subset(Data, Data$law==1)
		  points(SS[ ,C1], SS[ ,C2], pch=19, col=COL+1)
		  abline(lm(Data[B:E,C2] ~ Data[B:E,C1]), col="grey", lwd=2)
		  legend("topright", legend=c("Pre legislation", "Post legislation"),
			fill=c(COL, COL+1)) } )
} 

shinyServer (	function (input, output) 
{	output$distPlot <- renderPlot(
	{	STAT <- as.integer(isolate(input$stat))
		OBS <- as.integer(isolate(input$obs))
		BEGIN <- as.integer(isolate(input$Begin))
		STYLE <- as.integer(isolate(input$style))
		input$goButton
		Graphic(OBS, STAT, STYLE, BEGIN)
	} )

} )
