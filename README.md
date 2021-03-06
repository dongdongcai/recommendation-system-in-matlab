## INTRODUCTION

In order to implement a recommendation system from the matrix R whose row represent the user-id and column represent the movie-id. We need to obtain the matrix for user-preference(U) and feature-movie(V) which have much lower dimension than R. We can factorize R = UV using alternating least square algorithm. That is, randomly pick U first and calculating the V such that minimize squared error, then with calculated V, update U to minimize squared error . Keep doing this until U and V converges. The algorithm can be easily implemented using multiple programming languages. Here we use Matlab to do this since Matlab is easier to use in terms of matrix calculation. In this project, we would analyze 100k data from MovieLens which contains 943 users and 1682 movies.

## REQUIREMENT

The main program of the project is *main.m* and there are seven helper programs: *build_matrix.m* which build up the user-movie matrix from raw data, *createtest.m* shuffle the raw data and create test and train datasets for cross validation, the *wnmfrule.m* is for matrix factorization *pj3_part4* is for weight and R switched matrix factorization and *pj3_part42* is for regularized matrix factorization. *matrixNorm.m* and *mergeOption.m* are helper functions for *wnmfrule.m* and *pj3_part42.m*. To run the program properly, **you should put all eight files mentioned above and the raw data in one folder**.

## USAGE

Just run the main.m in matlab directly and you will get all plots required by the project manual. As for required data, the squared error required in part 1 is stored in *leastsquareerror1*, the minimum absolute error, maximum absolute error and the mean absolute error in part 2 are stored in *minerror2, maxerror2 and meanerror2* respectively, the squared error required in part4 is stored in *leastsquareerror4* and the average precision required by part 5 is stored in *averprecision5*.

## REFERENCES

>[Li, Yifeng, and Alioune Ngom. "The non-negative matrix factorization toolbox for biological data mining." Source code for biology and medicine 8.1 (2013): 1.](http://download.springer.com/static/pdf/925/art%253A10.1186%252F1751-0473-8-10.pdf?originUrl=http%3A%2F%2Flink.springer.com%2Farticle%2F10.1186%2F1751-0473-8-10&token2=exp=1457065702~acl=%2Fstatic%2Fpdf%2F925%2Fart%25253A10.1186%25252F1751-0473-8-10.pdf%3ForiginUrl%3Dhttp%253A%252F%252Flink.springer.com%252Farticle%252F10.1186%252F1751-0473-8-10*~hmac=0cc44e40b6eac4ad8f4bcb3645c7432ec9733460444eda7c65f9b2da6d46cda6)

Refer to this paper for details about wnmfrule.m

