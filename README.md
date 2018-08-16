# toxic-comment-classification
The Kaggle competition for toxic comment classification about detection of different types of toxic comments by 
classifying them into one or more labels.

# Procedure
# Introduction:
Problem statement
As it is a classification problem, I have designed a model which predicts a probability of each type of toxicity for each comment and resulted in good accuracy and made a complete report of the project.
# Data
Data has a large number of Wikipedia comments which have been labeled by human raters for toxic behavior. The types of toxicity are:

1.toxic
2.severe_toxic
3.obscene
4.threat
5.insult
6.identity_hate
# Exploratory data analysis:
1.Distribution of classes in each type
2.Class imbalance by plotting the histograms of targets
3.Checking the Histogram of words in total wikipedia comments
# Pre processing:
1.Replace certain words such as shorcut words with its full word
2.Cleaning text comments(converting to lower,removing punctuations,numbers etc)
3.Creating corpus of words
4.creating document term matrix
# Modelling:
1.Model selection:I have selected random forest algorithm after trying with other algorithms 
2.Sampling selection:I have used K_fold cross validation to avoid overfitting
 and the last step computing results and checking the accuracu on test data.


