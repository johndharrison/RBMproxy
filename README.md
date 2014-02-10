R bindings for Browser Mob proxy.
==========================

hese are R bindings for the Browser Mob proxy. They use
the RESTAPI defined at
https://github.com/lightbody/browsermob-proxy to communicate with
a Browser Mob proxy.

### Install 

To install, install the `devtools` package if necessary (`install.packages("devtools")`) and run:

```
devtools::install_github("RBMproxy", "johndharrison")
```

To get started using `RBMproxy` you can run the following code to produce a `HAR` file in tandem with `RSelenium`

```
library(RSelenium)
library(RBMproxy)
# start server and proxy if needed
# RSelenium::startServer()
# RBMproxy::startProxy()
proxy <- bmProxy()
proxy$closeAllPorts()
proxy$start(9091)
proxy$startHAR()
remDr <- remoteDriver(extraCapabilities = proxy$selProxy())
remDr$open()
remDr$navigate("http://www.bbc.com")
remDr$navigate("http://www.google.com")
proxy$getHAR()
```
