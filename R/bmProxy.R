#' CLASS bmProxy
#'
#' bmProxy Class uses the RESTAPI to communicate with the BrowserMob Proxy.
#'
#' bmProxy is a generator object. To define a new bmProxy class method `new` is called. The slots (default value) that are user defined are:
#'
#'@section Slots:      
#'  \describe{
#'    \item{\code{host}:}{Object of class \code{"character"}, giving the ip of the remote server. Defaults to localhost}
#'    \item{\code{port}:}{Object of class \code{"numeric"}, the port of the remote server on which to connect.}
#'    \item{\code{selHost}:}{Object of class \code{"character"}, giving the ip of the remote server. Defaults to localhost}
#'    \item{\code{selPort}:}{Object of class \code{"numeric"}, the port of the remote server on which to connect.}
#'  }
#'
#' @include errorHandler.R
#' @export bmProxy
#' @exportClass bmProxy
#' @examples
#' \dontrun{
#' }

bmProxy <- setRefClass("bmProxy",
                       fields = list(
                         host = "character",
                         serverport = "integer",
                         clientport = "integer",
                         selHost = "character",
                         selPort = "integer",
                         downstreamKbps = "numeric",
                         upstreamKbps = "numeric",
                         latency = "numeric"
                       ),
                       contains = "errorHandle",
                       methods = list(
                         initialize = function(host = "localhost",
                                               serverport             = 8080L,
                                               clientport             = NA_integer_,
                                               selHost         = "localhost",
                                               selPort       = 4444L,
                                               downstreamKbps       = NA_real_,
                                               upstreamKbps     = NA_real_,
                                               latency = NA_real_,
                                               ...
                         ){
                           host <<- host
                           serverport <<- serverport
                           clientport <<- clientport
                           selHost <<- selHost
                           selPort <<- selPort
                           downstreamKbps <<- downstreamKbps
                           upstreamKbps <<- upstreamKbps
                           latency <<- latency
                           callSuper(...)
                         },
                         
                         start = function(port = NULL){
                           if(!is.null(port)){
                             clientport <<- as.integer(port)
                             ipAddr <- paste0("http://", host, ":", serverport, "/proxy")
                             res <- queryProxy(ipAddr, qdata = paste0("port=", clientport))
                             clientport <<- as.integer(fromJSON(res))
                           }else{
                             ipAddr <- paste0("http://", host, ":", serverport, "/proxy")
                             res <- queryProxy(ipAddr)                             
                             clientport <<- as.integer(fromJSON(res))
                           }
                           print(paste0("Browser Mob Proxy listening on port: ", clientport))
                         },
                         
                         closePort = function(port = NULL){
                           if(is.null(port)){
                             ipAddr <- paste0("http://", host, ":", serverport, "/proxy/", clientport)
                             res <- queryProxy(ipAddr, method = "DELETE")
                             res
                           }else{
                             ipAddr <- paste0("http://", host, ":", serverport, "/proxy/", port)
                             res <- queryProxy(ipAddr, method = "DELETE")
                             res                             
                           }
                         },
                         
                         getPorts = function(){
                           # return all open ports
                           ipAddr <- paste0("http://", .self$host, ":", .self$serverport, "/proxy")
                           res <- queryProxy(ipAddr, method = "GET")
                           fromJSON(res)
                         },
                         
                         closeAllPorts = function(){
                           res <- .self$getPorts()[[1]]
                           lapply(res, .self$closePort)
                         },
                         
                         getHAR = function(){
                           ipAddr <- paste0("http://", host, ":", serverport, "/proxy/", clientport, "/har")
                           res <- queryProxy(ipAddr, method = "GET") 
                           res
                         },
                         
                         startHAR = function(initialPageRef = NULL, captureHeaders = FALSE, captureContent = FALSE, captureBinaryContent = FALSE){            
                           ipAddr <- paste0("http://", host, ":", serverport, "/proxy/", clientport, "/har")
                           cr <- NULL
                           if(!is.null(initialPageRef)){
                             cr <- paste0("initialPageRef=", initialPageRef)
                           }
                           if(captureHeaders){
                             cr <- ifelse(is.null(cr), "captureHeaders=true", paste(cr, "captureHeaders=true", sep = "&"))
                           }
                           if(captureContent){
                             cr <- ifelse(is.null(cr), "captureContent=true", paste(cr, "captureContent=true", sep = "&"))
                           }
                           if(captureBinaryContent){
                             cr <- ifelse(is.null(cr), "captureBinaryContent=true", paste(cr, "captureBinaryContent=true", sep = "&"))
                           }
                           if(is.null(cr)){
                             res <- queryProxy(ipAddr, method = "PUT")
                           }else{
                             res <- queryProxy(ipAddr, method = "PUT", qdata = cr)                             
                           }
                           res
                         },
                         
                         selProxy = function(){
                           if(is.na(clientport)){
                             print("START A PROXY using $start\\(\\) first")
                           }else{
                             list(proxy = list(proxyType = 'manual', httpProxy = paste(host, clientport, sep = ':')))
                           }
                         },
                         
                         newPage = function(){
                           
                         },
                         
                         limit = function(){
                           
                         },
                         
                         doHAR = function(){
                           
                         },
                         
                         doReq = function(){
                           
                         }
                       )
)
