#include <Rcpp.h>
#include <iostream>
#include <fstream>
using namespace Rcpp;

// [[Rcpp::export]]
S4 read_dtm(const std::string& path) {
    int docs, terms, nnz;
    double sparsity, constructionCost;
    std::ifstream in(path.c_str());
    in >> docs;
    in >> terms;
    in >> nnz;
    NumericVector data(nnz);
    IntegerVector index(nnz);
    IntegerVector row_ptr(docs + 1);
    CharacterVector termVector(terms);
    std::string word;
    getline(in, word); // todo
    for (int i = 0; i < terms; ++i) {
        getline(in, word);
        termVector[i] = word;
    }
    double idf;
    for (int i = 0; i < terms; ++i) {
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

    S4 dtm("dgRMatrix");
    dtm.slot("x") = data;
    dtm.slot("j") = index;
    dtm.slot("p") = row_ptr;
    dtm.slot("Dim") = IntegerVector::create(docs, terms);
    List dimnames = as<List>(dtm.slot("Dimnames"));
    dimnames.at(1) = termVector;
    return dtm;
}

// [[Rcpp::export]]
S4 normalize_dtm(S4 dtm) {
    IntegerVector dims = as<IntegerVector>(dtm.slot("Dim"));
    IntegerVector row_ptr = as<IntegerVector>(dtm.slot("p"));
    IntegerVector index = as<IntegerVector>(dtm.slot("j"));
    NumericVector data = as<NumericVector>(dtm.slot("x"));
    List dimnames = as<List>(dtm.slot("Dimnames"));
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
    S4 ndtm("dgRMatrix");
    ndtm.slot("x") = new_data;
    ndtm.slot("j") = index;
    ndtm.slot("p") = row_ptr;
    ndtm.slot("Dim") = dims;
    ndtm.slot("Dimnames") = dimnames;
    return ndtm;
}

