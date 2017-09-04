#include <Rcpp.h>
using namespace Rcpp;

CharacterVector help() {
    CharacterVector x = CharacterVector::create("hello from (RCUDANLP) R with CUDA on NLP");
    return x;
}
