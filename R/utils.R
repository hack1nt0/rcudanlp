.onLoad <- function(libname, pkgname) {
    rcudanlp.path <- '/Users/dy/nlp-cuda/bin/librcudanlp.so'
    sysname <- Sys.info()['sysname']
    if (sysname == 'Windows') {
        path <- 'C:/lib'
    }
    print(dyn.load(rcudanlp.path))
}
