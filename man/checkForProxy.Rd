\name{checkForProxy}
\alias{checkForProxy}
\title{Check for Proxy binary}
\usage{
checkForProxy(dir = NULL, update = FALSE)
}
\arguments{
  \item{dir}{A directory in which the binary is to be
  placed.}

  \item{update}{A boolean indicating whether to update the
  binary if it is present.}
}
\description{
\code{checkForProxy} A utility function to check if the
Browser Mob proxy stanalone binary is present.
}
\section{Detail}{
  The downloads for the Browser Mob proxy can be found at
  http://bmp.lightbody.net/. This convience function
  downloads the standalone proxy and places it in the
  RBMproxy package directory bin folder by default.
}
\examples{
\dontrun{
checkForProxy()
}
}

