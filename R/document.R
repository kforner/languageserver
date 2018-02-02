detect_closure <- function(document, line, character) {
    if (character > 0 && !is.null(document)) {
        loc <- .Call(
            "document_backward_search", PACKAGE = "languageserver",
            document, line, character - 1, "(")
    } else {
        loc <- c(-1, -1)
    }

    if (loc[1] >= 0 && loc[2] >= 0) {
        content <- document_line(document, loc[1] + 1)
        trim_content <- trimws(substr(content, 1, loc[2] + 1))

        closure <- stringr::str_match(
            trim_content,
            "(?:([a-zA-Z][a-zA-Z0-9]+):::?)?([a-zA-Z.][a-zA-Z0-9_.]*)\\($")
        logger$info("func_name: ", closure)

        if (is.na(closure[2])) {
            list(funct = closure[3])
        } else {
            list(package = closure[2], funct = closure[3])
        }
    } else {
        list()
    }
}

detect_token <- function(document, line, character) {
    content <- document_line(document, line + 1)
    token <- stringr::str_match(substr(content, 1, character), "\\b[a-zA-Z0-9_.:]+$")[1]
    logger$info("token: ", token)
    if (is.na(token)) {
        ""
    } else {
        token
    }
}