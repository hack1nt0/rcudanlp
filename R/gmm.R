library(Matrix)

shared.lib.path <- file.path('~', 'nlp-cuda', 'bin')

set.shared.lib.path <- function(path) {
    shared.lib.path <- path
}

get.shared.lib.path <- function() {
    shared.lib.path
}

load.shared.lib <- function(name) {
    sysname <- Sys.info()['sysname']
    path <- shared.lib.path
    if (sysname == 'Darwin') {
        path <- file.path(path, paste0('lib', name, ".dylib"))
    } else {
        stop("Not implemented.")
    }
    if (!is.loaded(path)) {
        dyn.load(path);
    }
}

gmm <- function(dtm, k, max_itr=10, seed=17, alpha=1e-5, beta=1e-5) {
    load.shared.lib('gmm')
    .Call('gmm', PACKAGE = 'libgmm.dylib', dtm, k, max_itr, seed, alpha, beta);
}
