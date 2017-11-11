
gmm <- function(dtm, k, max_itr=10, seed=17, alpha=1e-5, beta=1e-5, topics=10) {
    .Call('gmm', PACKAGE = 'librcudanlp', dtm, k, max_itr, seed, alpha, beta, topics);
}

kmeans <- function(x, centers, iter.max = 10, nstart = 1,
                   algorithm = c("Elkan", "Cuda",
                                 "Hartigan-Wong", "Lloyd", "Forgy",
                                 "MacQueen"), ...) {
     if (is.Dtm(x)) {
        if (!is.integer(centers)) stop("Not implemeted...")
         kmeans.Dtm(x, centers, iter.max, nstat, algorithm[1], ...)
     } else {
         stats::kmeans(x, centers, iter.max, nstart, algorithm, ...)
     }
}

kmeans.Dtm <- function(dtm, centers, iter.max = 10, nstats = 1, algorithm = c("Elkan", "Cuda"), seed = 17, verbose = F) {
    .Call('kmeans', PACKAGE = 'librcudanlp', dtm, centers, iter.max, nstat, algorithm[1], seed, verbose);
}

test.cluster <- function() {
    dtm <- read.dtm('/Users/dy/TextUtils/data/train/spamsms.dtm')
    kmeans(dtm)
}

