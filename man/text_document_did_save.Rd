% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/handlers-textsync.R
\name{text_document_did_save}
\alias{text_document_did_save}
\title{textDocument/didSave notification handler}
\usage{
text_document_did_save(self, params)
}
\arguments{
\item{self}{a \link{LanguageServer} object}

\item{params}{a \link{did_save_text_document_params}}
}
\description{
Handler to the \href{https://microsoft.github.io/language-server-protocol/specification#textDocument_didSave}{textDocument/didSave} \link{Notification}
}
\keyword{internal}
