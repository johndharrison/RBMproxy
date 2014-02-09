#' CLASS errorHandler
#'
#' class to handle errors
#'
#' brief desc here
#'  
#'@section Methods:
#'  \describe{
#'    \item{\code{new(...)}:}{ Create a new \code{errorHandler} object. ... is used to define the appropriate slots.}
#'    }
#'      
#' @export errorHandler
#' @exportClass errorHandler
#' @examples
#' \dontrun{
#' }
#' 
errorHandler <- setRefClass("errorHandler",
                            fields   = list(statusCodes = "character"
                            ),
                            methods  = list(
                              initialize = function(){
                                statusCodes <<- NA_character_
                              },
                              
                              queryProxy = function(ipAddr, method = "POST", httpheader = c(Accept = "text/html"), qdata = NULL){
                                if(!is.null(qdata)){
                                  getURLContent(ipAddr, customrequest = method
                                                , httpheader = httpheader,  postfields = qdata, isHTTP = FALSE)
                                }else{
                                  #browser()
                                  getURLContent(ipAddr, customrequest = method
                                                , httpheader = httpheader, isHTTP = FALSE)
                                }
                                
                              }
                            )
)
