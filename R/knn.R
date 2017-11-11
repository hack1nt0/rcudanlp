
knn <- function(train, test = NULL, cl = NULL, k = 1, l = 0, prob = FALSE, use.all = TRUE, verbose = False) {
    if (class(train) == 'Dtm') {
        if (is.null(test) && is.null(cl))
            return(knn.dtm(train, k, verbose))
        else
            stop("not implemtented yet...")
    }
    d$knn(k, includeKthTie, verbose)
}

knn.dtm <- function(d, k, verbose=F) {
    .Call('dtm_knn', PACKAGE='librcudanlp', d@pointer, k, verbose)
}

test.knn <- function(k = 10) {
    dtm <- read.dtm('/Users/dy/TextUtils/data/train/spamsms.dtm')
    nn  <- knn(dtm, k = k, verbose=T)
    return(nn)
}
