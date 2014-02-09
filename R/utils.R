#' Check for Proxy binary
#' 
#' \code{checkForProxy}
#' A utility function to check if the Browser Mob proxy stanalone binary is present.
#' @param dir A directory in which the binary is to be placed.
#' @param update A boolean indicating whether to update the binary if it is present.
#' @export
#' @section Detail: The downloads for the Browser Mob proxy can be found at 
#' http://bmp.lightbody.net/. This convience function downloads the standalone proxy and places it in the 
#' RBMproxy package directory bin folder by default.
#' @examples
#' \dontrun{
#' checkForProxy()
#' }

checkForProxy <- function (dir = NULL, update = FALSE) 
{
  bmpURL <- "http://bmp.lightbody.net/"
  bmpXML <- htmlParse(bmpURL)
  bmpZIP <- xpathSApply(bmpXML, "//a[@id=\"download-zip\"]/@href")[[1]]
  bmpDIR <- ifelse(is.null(dir), paste0(find.package("RBMproxy"), 
                                        "/bin/"), dir)
  bmpFILE <- paste0(bmpDIR, "browsermob-proxy.zip")
  bmpBIN <- dir(bmpDIR, pattern = "browsermob-proxy$|browsermob-proxy.bat$", recursive = TRUE)
  if (update || length(bmpBIN) < 2) {
    dir.create(bmpDIR, showWarnings=FALSE)
    print("DOWNLOADING BROWSER MOB proxy. THIS MAY TAKE SEVERAL MINUTES")
    download.file(gsub("https", "http", bmpZIP), bmpFILE, mode = "wb")
    unzip(bmpFILE, exdir = bmpDIR)
  }
}

#' Start the BrowserMob proxy binary.
#' 
#' \code{startProxy}
#' A utility function to start the proxy binary. 
#' @param dir A directory in which the binary is placed.
#' @param port Port number on which BMproxy runs
#' @export
#' @section Detail: By default the binary is assumed to be in
#' the RBMproxy package /bin directory. 
#' @examples
#' \dontrun{
#' startProxy()
#' }

startProxy <- function (dir = NULL, port = 9090) 
{
  bmpDIR <- ifelse(is.null(dir), paste0(find.package("RBMproxy"), "/bin/"), dir)
  bmpBIN <- dir(bmpDIR, pattern = "browsermob-proxy$|browsermob-proxy.bat$", recursive = TRUE)
  if (length(bmpBIN) < 2) {
    stop("No BrowserMob proxy binary exists. Run checkForServer or start proxy manually.")
  }
  else {
    if (.Platform$OS.type == "unix") {
      # use browsermob-proxy
      bmpScript <- paste0(bmpDIR, bmpBIN[!grepl(".bat", bmpBIN)])
      system(paste0('sh ', bmpScript, ' -port ', port), wait = FALSE, 
             ignore.stdout = TRUE, ignore.stderr = TRUE)
    }
    else {
      # use browsermob-proxy.bat
      bmpScript <- bmpBIN[grepl(".bat", bmpBIN)]
      system(paste0(bmpScript, ' -port ', port), wait = FALSE, 
             invisible = FALSE)
      system(paste0("java -jar ", shQuote(selFILE)), wait = FALSE, 
             invisible = FALSE)
    }
  }
}

