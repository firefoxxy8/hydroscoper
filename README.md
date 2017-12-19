
<!-- README.md is generated from README.Rmd. Please edit that file -->
hydroscoper
===========

The goal of **hydroscoper** is to provide an interface to the Greek National Databank for Hydrological and Meteorological Information, [Hydroscope](http://www.hydroscope.gr/). It provides functions for downloading stations and timeseries data.

The stations and timeseries data in Hydroscope are in Greek, so this package transliterates the Unicode text to Latin, and translates various Greek terms to English. Finally, the **hydroscoper** provides a function to convert raw timeseries' data into a tidy dataframe.

Installation
------------

You can install **hydroscoper** from github with:

``` r
# install.packages("devtools")
devtools::install_github("kvantas/hydroscoper")
```

Stations list
-------------

This is a basic example which shows you how to get the stations list from the Hydroscope database:

``` r
library(hydroscoper)
stations <- get_stations(subdomain = "kyy")
head(stations[c("StationID", "WaterDivisionID", "Name", "Owner", "Type")])
#>   StationID WaterDivisionID          Name   Owner          Type
#> 1    501062            GR11       Peirama   other meteo_station
#> 2    200251            GR12          ABAS min_env meteo_station
#> 3    200280            GR13 AG. BASILEIOS min_env meteo_station
#> 4    501032            GR13 AG. BASILEIOS min_rur   stream_gage
#> 5    200171            GR04   AG. BLASIOS min_env meteo_station
#> 6    200292            GR13  AG. GEORGIOS min_env meteo_station
```

Stations coordinates
--------------------

With the following code you can get the coordinates and the elevation for the meteorological stations from Ministry of Environment and Energy (min\_env) in the Water Division of Crete, GR13:

``` r
library(plyr)
crete_stations <-subset(stations, WaterDivisionID == 'GR13' & Owner == 'min_env')
crete_coords <- ldply(crete_stations$ID, function(x) {
  get_coords(subdomain = "kyy", stationID = x)})
head(crete_coords)
#> data frame with 0 columns and 0 rows
```

Timeseries list
---------------

To get the timeseries list in a dataframe from a specific station you can use the following code:

``` r

ts_data <- get_timeseries(subdomain = "kyy", stationID = 200292)
ts_data
#>   TimeSeriesID   Variable TimeStep Unit Instrument           StartDate
#> 1         1023       snow      day   mm   20029203 1954-09-01 08:00:00
#> 2         1024 wind_direc variable    °   20029204 1964-05-01 08:00:00
#> 3         1022   rainfall      day   mm   20029201 1954-09-01 08:00:00
#> 4           78   rainfall    30min   mm   20029202 1954-08-30 07:30:00
#>               EndDate StationID
#> 1 1996-12-31 08:00:00    200292
#> 2 1996-12-31 08:00:00    200292
#> 3 2001-08-31 01:00:00    200292
#> 4 1996-12-29 22:00:00    200292
```

Raw data
--------

With the following code you can get the timeseries values from using a timeseries ID

``` r
ts_raw <- get_data(subdomain = "kyy", timeID = 1022)
```

Let's create a plot for the rainfall data:

``` r
suppressPackageStartupMessages(library(ggplot2))
ggplot(data = ts_raw, aes(x = Date, y = Value))+
  geom_line()+
  labs(title="Daily rainfall for station 200292",
       x="Date", y = "Rain (mm)")+
  theme_classic()
```

![](README-plot%20data-1.png)
