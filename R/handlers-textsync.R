#' textDocument/didOpen notification handler
#'
#' Handler to the [textDocument/didOpen](https://microsoft.github.io/language-server-protocol/specification#textDocument_didOpen) [Notification]
#'
#' @template self
#' @param params a [did_open_text_document_params]
#'
#' @keywords internal
text_document_did_open <- function(self, params) {
    textDocument <- params$textDocument
    uri <- textDocument$uri
    doc <- readLines(path_from_uri(uri), warn = FALSE)
    self$documents[[uri]] <- doc
    self$text_sync(uri, document = NULL, run_lintr = TRUE, parse = TRUE)
}

#' textDocument/didChange notification handler
#'
#' Handler to the [textDocument/didChange](https://microsoft.github.io/language-server-protocol/specification#textDocument_didChange) [Notification]
#'
#' @template self
#' @param params a [did_change_text_document_params]
#'
#' @keywords internal
text_document_did_change <- function(self, params) {
    textDocument <- params$textDocument
    contentChanges <- params$contentChanges
    text <- contentChanges[[1]]$text
    uri <- textDocument$uri
    logger$info("did change: ", uri)
    doc <- stringr::str_split(text, "\r\n|\n")[[1]]
    # remove last empty line
    if (nchar(doc[[length(doc)]]) == 0) doc <- doc[-length(doc)]
    self$documents[[uri]] <- doc
    self$text_sync(uri, document = doc, run_lintr = TRUE, parse = FALSE)
}

#' textDocument/willSave notification handler
#'
#' Handler to the [textDocument/willSave](https://microsoft.github.io/language-server-protocol/specification#textDocument_willSave) [Notification]
#'
#' @template self
#' @param params a [will_save_text_document_params]
#'
#' @keywords internal
text_document_will_save <- function(self, params) {

}

#' textDocument/didSave notification handler
#'
#' Handler to the [textDocument/didSave](https://microsoft.github.io/language-server-protocol/specification#textDocument_didSave) [Notification]
#'
#' @template self
#' @param params a [did_save_text_document_params]
#'
#' @keywords internal
text_document_did_save <- function(self, params) {
    textDocument <- params$textDocument
    uri <- textDocument$uri
    logger$info("did save:", uri)
    self$documents[[uri]] <- readLines(path_from_uri(uri), warn = FALSE)
    self$text_sync(uri, document = NULL, run_lintr = TRUE, parse = TRUE)
}

#' textDocument/didClose notification handler
#'
#' Handler to the [textDocument/didClose](https://microsoft.github.io/language-server-protocol/specification#textDocument_didClose) [Notification]
#'
#' @template self
#' @param params a [did_close_text_document_params]
#'
#' @keywords internal
text_document_did_close <- function(self, params) {
    textDocument <- params$textDocument
    uri <- textDocument$uri
    rm(list = uri, envir = self$documents)
}

#' textDocument/willSaveWaitUntil notification handler
#'
#' Handler to the [textDocument/willSaveWaitUntil](https://microsoft.github.io/language-server-protocol/specification#textDocument_willSaveWaitUntil) [Request]
#'
#' @template self
#' @template id
#' @param params a [will_save_text_document_params]
#'
#' @keywords internal
text_document_will_save_wait_until <- function(self, id, params) {

}
