#include <Rcpp.h>
#include <iostream>
#include <fstream>
using namespace Rcpp;

// [[Rcpp::export]]
S4 read_csr(const std::string& path) {
    int docs, items, nnz;
    double sparsity, constructionCost;
    std::ifstream in(path.c_str());
    in >> docs;
    in >> items;
    in >> nnz;
    in >> sparsity;
    in >> constructionCost;
    NumericVector data(nnz);
    IntegerVector index(nnz);
    IntegerVector row_ptr(docs + 1);
    std::string word;
    getline(in, word); // todo
    for (int i = 0; i < items; ++i) {
        getline(in, word);
    }
    double idf;
    for (int i = 0; i < items; ++i) {
        in >> idf;
    }
    for (int i = 0; i <= docs; ++i) {
        int d;
        in >> d;
        row_ptr[i] = d;
    }
    for (int i = 0; i < nnz; ++i) {
        int d;
        in >> d;
        index[i] = d;
    }
    for (int i = 0; i < nnz; ++i) {
        double d;
        in >> d;
        data[i] = d;
    }
    in.close();

    S4 csr("dgRMatrix");
    csr.slot("x") = data;
    csr.slot("j") = index;
    csr.slot("p") = row_ptr;
    csr.slot("Dim") = IntegerVector::create(docs, items);
    return csr;
}

// [[Rcpp::export]]
S4 normalize_csr(S4 dtm) {
    IntegerVector dims = as<IntegerVector>(dtm.slot("Dim"));
    IntegerVector row_ptr = as<IntegerVector>(dtm.slot("p"));
    IntegerVector index = as<IntegerVector>(dtm.slot("j"));
    NumericVector data = as<NumericVector>(dtm.slot("x"));
    NumericVector new_data(data.size());

    int rows = dims[0];
    for (int r = 0; r < rows; ++r) {
        int from = row_ptr[r];
        int to = row_ptr[r + 1];
        double norm2 = 0.f;
        for (int j = from; j < to; ++j) {
            norm2 += data[j] * data[j];
        }
        norm2 = sqrt(norm2);
        for (int j = from; j < to; ++j) {
            new_data[j] = data[j] / norm2;
        }
    }
    S4 csr("dgRMatrix");
    csr.slot("x") = new_data;
    csr.slot("j") = index;
    csr.slot("p") = row_ptr;
    csr.slot("Dim") = dims;
    return csr;
}

