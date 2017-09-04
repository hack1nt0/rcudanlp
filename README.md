# rcudanlp
R with CUDA on NLP

# Usage

### Setup

```R
library(devtools)
install_github('hack1nt0/rcudanlp')
```

### Read Document-Term-Matrix from csr(Compressed Sparse Row) file 

```R
dtm <- read_csr('path/to/csr')
```

### GMM on Sparse Matrix

```R
gmmParams <- gmm(dtm, k = 10, max_itr = 10, seed = 17, alpha = 1e-5, beta = 1e-5)
```
