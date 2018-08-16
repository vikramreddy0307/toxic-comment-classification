# toxic-comment-classification
The Kaggle competition for toxic comment classification about detection of different types of toxic comments by 
classifying them into one or more labels.

# 
# Introduction:
Problem statement
As it is a classification problem, I have designed a model which predicts a probability of each type of toxicity for each comment and resulted in good accuracy and made a complete report of the project.
# Data

Data has a large number of Wikipedia comments which have been labeled by human raters for toxic behavior. The types of toxicity are:

* toxic
* severe_toxic
* obscene
* threat
* insult
* identity_hate
# Exploratory data analysis:

* Distribution of classes in each type
* Class imbalance by plotting the histograms of targets
* Checking the Histogram of words in total wikipedia comments
# Pre processing:

* Replace certain words such as shorcut words with its full word
* Cleaning text comments(converting to lower,removing punctuations,numbers etc)
* Creating corpus of words
* creating document term matrix
# Modelling:

* Model selection:I have selected random forest algorithm after trying with other algorithms 
* Sampling selection:I have used K_fold cross validation to avoid overfitting
 and the last step computing results and checking the accuracu on test data.


