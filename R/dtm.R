setClass("Dtm", representation( pointer = "externalptr"))
# helper
.dtm_method <- function(name) {
    paste("Dtm", name, sep = "_")
}

# syntactic sugar to allow object$method( ... )
setMethod("$", "Dtm", function(x, name) {
    function(...)
        .Call(.dtm_method(name), x@pointer, PACKAGE='librcudanlp', ...)
})

# syntactic sugar to allow new( "Dtm", ... )
setMethod("initialize", "Dtm",
          function(.Object) {
              # .Object@pointer <- .Call(dtm_method("new"), PACKAGE='librcudanlp', ...)
              .Object
          })

read.dtm <- function(path) {
    dtm <- new('Dtm')
    dtm@pointer <- .Call(.dtm_method('read'), PACKAGE='librcudanlp', path)
    return(dtm)
}

Dtm <- function(path) {
    dtm <- new('Dtm')
    dtm@pointer <- .Call(.dtm_method('new'), PACKAGE='librcudanlp', path)
    return(dtm)
}

summary.Dtm <- function(dtm, topK=10, ...) {
    dtm$summary(topK)
}

print.Dtm <- function(dtm, ids=c(1), ...) {
    dtm$print(ids)
}

is.Dtm <- function(x) { return(class(x) == "Dtm") }

test.dtm <- function() {
    # dtm <- new('Dtm', '/Users/dy/TextUtils/data/train/spamsms.dtm')
    dtm <- read.dtm('/Users/dy/TextUtils/data/train/spamsms.dtm')
    print(summary(dtm))
    return(dtm)
}
