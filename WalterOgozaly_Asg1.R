##  WALTER OGOZALY 
##  March 14 2021


#                --------------------------------
#################       Data visualization       #################
#                --------------------------------

#No scientific notation
options(scipen=999)

library(readxl)
library(ggplot2)

myAgeData <- read_excel("~/Downloads/WPP2019_INT_F02A_1_ANNUAL_POPULATION_INDICATORS_BOTH_SEXES.xlsx")

colnames(myAgeData)

# Remove first 11 columns (irrelevant)
myAgeData = myAgeData[-c(1:11),]

# Function to convert first row to column names.
# https://stackoverflow.com/questions/32054368/use-first-row-data-as-column-names-in-r
header.true <- function(df) {
  names(df) <- as.character(unlist(df[1,]))
  df[-1,]
}

# Running that function.
myAgeData = header.true(myAgeData)

colnames(myAgeData)[3] = "Country"
colnames(myAgeData)[8] = "Year"
colnames(myAgeData)[47] = "popAged25to49"

myAgeDataFiltered = myAgeData[myAgeData$Country == "China" | myAgeData$Country == "India" , c(3,8,47)]

myAgeDataFiltered$Year = as.numeric(myAgeDataFiltered$Year)
myAgeDataFiltered$popAged25to49 = as.numeric(myAgeDataFiltered$popAged25to49)

# This column should be in millions, not thousands.
myAgeDataFiltered$popAged25to49 = myAgeDataFiltered$popAged25to49 / 1000

ggplot(myAgeDataFiltered, aes(x = Year, y = popAged25to49, color = Country)) +
  geom_point() +
  labs(x = "Year", y = "Working Age Population (in millions)",
       color = "Country\nindicated\nby colors:") +
  theme(legend.title = element_text(color = "chocolate",
                                    size = 14, face = "bold"))


ggsave("goIndia.png")
