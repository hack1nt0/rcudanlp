
library(Rcpp)
library(Matrix)

dyn.load('/Users/dy/nlp-cuda/bin/libgmmR.dylib')

dtm <- .Call('read_csr', '/Users/dy/TextUtils/data/train/spamsms.dtm')
dtm2 <- .Call('normalize_csr', dtm)
gmmModel <- .Call('gmmR', dtm2, 10, 10, 1)

plot(gmmModel$likelihood)

y <- matrix(c(11,21,31,12,22,32),nrow=3,ncol=2)
address(y)
y[2:3,] <- matrix(c(1,1,8,12),nrow=2)
address(y)
