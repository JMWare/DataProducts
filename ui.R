## Comparison of monthly UK road casualties before & after seatbelt law.

library (shiny)
shinyUI (pageWithSidebar 
(	headerPanel ("United Kingdom Vehicle Related Road Casualties : Pre / Post Seatbelt Legislation"),
	sidebarPanel 
	( radioButtons("obs", 
				 "Select required data :",
				 c("All casualties" = "1","Drivers" = "2",
					"Front passengers" = "3",	"Rear passengers" = "4"),
				 inline = FALSE),
	  radioButtons("stat", 
				 "Select statistic type :",
				 c("Annual variation" = "1","Seasonal variation" = "2",
					"Function of distance driven" = "3",
					"Function of petrol price" = "4"), 
				 inline = FALSE),
	  sliderInput("Begin", "Start point (year)", min=1969, max=1981,
				 value=1969, step = 1, round = FALSE),
	  radioButtons("style", 
				 "Select chart type :",
				 c("Style 1" = "1", "Style 2" = "2"),
				 inline = FALSE),
	  actionButton("goButton", "EXECUTE")), 
	mainPanel
	( ## h2(""),
	  plotOutput("distPlot"),
	  h4("(Note : variable 'law' coded '0' & '1' indicating pre / post legislation)"))
))

