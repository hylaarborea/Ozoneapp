# Shiny app to study how the Ozone concentration change according to temperature, wind and solar radiation

# The App

[https://atelopuszeteki.shinyapps.io/appozone/](https://atelopuszeteki.shinyapps.io/appozone/)

# Introduction

This is the final project, with the title "Shiny Application and Reproducible Pitch", of the course
["Developing Data Products"](https://www.coursera.org/learn/data-products)
of coursera, part of the 
["Datas science specialization"](https://www.coursera.org/specializations/jhu-data-science). The goal of this app is to study how the Ozone concentration varies according to "Solar radiation", "Wind" and "Temperature".


# Data

We consider the data set ***airquality*** included in the package datasets of R.
They describe the daily air quality measurements in New York, May to September 1973.

A data frame with 154 observations on 6 variables:


- [,1]	Ozone	 numeric	 Ozone (ppb)
- [,2]	Solar.R	 numeric	 Solar R (lang)
- [,3]	Wind	 numeric	 Wind (mph)
- [,4]	Temp	 numeric	 Temperature (degrees F)
- [,5]	Month	 numeric	 Month (1--12)
- [,6]	Day	     numeric	 Day of month (1--31)


# Details of the app

The app is built in R using the library ***shiny***. 

The UI structure:

- by *selectInput* can select between the 3 predictors
- by *sliderInput* can select the value of the predictor
- by *checkboxInput* can select which model wants to show

The SERVER structure:

- 2 models have been implemented (linear and cubic model)
- by *brushedPoints* one have to select, using the mouse, the points which will be interpolated
- interpolating curves and values are calculated
- fraction of points included in the interpolation calculated


# How to use the app

The app can be found at this address: 
[https://atelopuszeteki.shinyapps.io/appozone/](https://atelopuszeteki.shinyapps.io/appozone/)


Here a simple description to use it:

- First of all one has to select the predictor variable form from the multiple item list (solar radiation, wind, temperature)

- Than one has to select the value of the variable previously selected, using
the slider widget to select from a range of values

- Now one can select which of the two models (linear or cubic, or both) wants
to see

- Using the mouse, select the points which will be included in the interpolation

At this point the page will be populated with new information:

- the models selected will be plotted on the curve and two bold points (one red and one black) will show the Ozone  value predicted for the two models

- under the plot three text lines will give the eprcentage of points selected and the Ozone value predicted by the two models.




# Small presentation

A small presentatio of the app can be found at this link:
https://hylaarborea.github.io/Ozoneapp/app_presentation.html

