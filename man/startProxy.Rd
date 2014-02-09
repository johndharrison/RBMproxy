\name{startProxy}
\alias{startProxy}
\title{Start the BrowserMob proxy binary.}
\usage{
startProxy(dir = NULL, port = 9090)
}
\arguments{
  \item{dir}{A directory in which the binary is placed.}

  \item{port}{Port number on which BMproxy runs}
}
\description{
\code{startProxy} A utility function to start the proxy
binary.
}
\section{Detail}{
  By default the binary is assumed to be in the RBMproxy
  package /bin directory.
}
\examples{
\dontrun{
startProxy()
}
}

