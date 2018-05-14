#Warning:
#  As data is huge it took some hours for me to execute the process.
#So make sure your computer is fast enough(RAM) to execute the process

#reading data
train_data=read.csv('train.csv',na.strings=c("",NA),stringsAsFactors = F,sep=',')
test_data=read.csv('test.csv',na.strings=c("",NA))
submission=read.csv('sample_submission.csv')

#empty values
sapply(train,function(x) sum(is.na(x)))
sapply(test,function(x) sum(is.na(x)))
targets = c('obscene','insult','toxic','severe_toxic','identity_hate','threat')
#unlabbeled comments
unlabelled_comments = sum((train_data$toxic!=1) & (train_data$severe_toxic!=1) & (train_data$obscene!=1) & 
                              (train_data$threat!=1) & (train_data$insult!=1) & (train_data$identity_hate!=1))
#unlabelled_comments percentage
print(unlabelled_comments/159571)
for (category in c('obscene','insult','toxic','severe_toxic','identity_hate','threat')){
  print(category)
  print('percentage of ones')
  print(sum(train_data[category]==1)*100/159571)
  print('percentage of zeroes')
  print(sum(train_data[category]==0)*100/159571)
  print('number of empty cells')
  print(sum(train_data[category]==""))
}
library(corrgram)
corrgram(cor(train1[,3:8]),order=TRUE,main="plot",upper.panel=panel.cor,text.panel=panel.txt)
#count of words in each comment
library(stringr)
for (i in (1:length(train_data))){
  train_data[i,9]=str_count(train_data[i,2])
}
#plotting histogram of words
hist(train_data[,9],main = 'Histogram of words',xlab = 'number of words in comments')
#Clean up the comment text
find    <- c("what's","\'s","\'ve","can't","n't","i'm","\'re",
             "\'d","\'ll","\'scuse","\'W",'\'s+',"\"i",
             "\"\"","\n\n","there's",'<','else' )
replace <- c("what is "," "," have ","cannot " ," not ","i am ",
             " are "," would "," will "," excuse ",' ',' ',"i","","",
             "there is","","")
#replacing some words
library(qdap)
mgsub(find,key,train_data[,2])
mgsub(find,key,test_data[,2])
library(tm)
#combining train and test data
combined_data=rbind(train_data[,1:2],test_data)
#creating source
corpus=Corpus(VectorSource(combined_data[,2]))
#Remove all punctuation marks
corpus=tm_map(corpus,removePunctuation)
#Make all characters lowercase
corpus=tm_map(corpus,tolower)
#Remove text within brackets
corpus=tm_map(corpus,bracketX)
#Replace abbreviations
corpus=tm_map(corpus,replace_abbreviation)
#Replace contractions
corpus=tm_map(corpus,replace_contraction)
#Replace symbols with words
corpus=tm_map(corpus,replace_symbol)
#removing words
corpus=tm_map(corpus,removeNumbers)
#removing stop words
corpus=tm_map(corpus,removeWords,stopwords('english'))
#removing white space
corpus=tm_map(corpus,stripWhitespace)
#creating a corpus of words as document term matrix
corpus=DocumentTermMatrix(corpus,control = list(weighting = function(x) weightTfIdf(x, normalize = FALSE)))
#sparsity threshold
corpus=removeSparseTerms(corpus, .97)
#inspecting corpus
inspect(corpus)
#converting to data frame
dat=as.data.frame(unlist(as.matrix(corpus)))
#converting to factors
dat=factor(unclass(as.factor(dat)))
for (i in (1:length(dat))){
  dat[,i]=factor(dat[,i],labels=c(1:length(unique(dat[,i]))))
}
dat1=factor(dat1,levels=c(1:length(unique(dat1))))

#converting to factors
for (i in (3:8)){
  train_data[,i]=factor(train_data[,i])
}
#saperating train corpus

train_corpus=dat[1:159571,]
dat1=dat[-(1:159571),]


#combinng text rows back to test data
test_corpus=dat


#model
library(caret)
#random forest using K-fold and down sampling with 
#binary relevance method
for (category in c('obscene','insult','toxic','severe_toxic','identity_hate','threat')){
  training_data=cbind(train_data[category],train_corpus)
  down_sample=downSample(x=training_data[,2:100],y=training_data[,1]
                        ,yname = category)
  train_control= trainControl(method="cv", number=5)
  model= train(reformulate(termlabels = listoffactors, response = category),data=down_sample,trControl=train_control,method="glm",family=binomial('logit'))
  
    pred=predict(model,test_corpus,type='raw')
     print(category)
     summary(model)
#storing predict results of a category to submission file     
     submission[category]=pred
#removing that category as we are doing binary eqivalence
     training_data[category]=NULL
     
}
#using classifier chain method
for (category in c('obscene','insult','toxic','severe_toxic','identity_hate','threat')){
  training_data=cbind(train_data[category],train_corpus)
  down_sample=downSample(x=training_data[,2:100],y=training_data[,1]
                         ,yname = category)
  train_control= trainControl(method="cv", number=5)
  model_classchain= train(reformulate(termlabels = listoffactors, response = category),data=down_sample,trControl=train_control,method="glm",family=binomial('logit'))
  
  pred=predict(model_classchain,test_corpus,type='raw')
  print(category)
  summary(model)
  #storing predict results of a category to submission file     
  submission[category]=pred
  
}
#wordcloud for different categories
library(SnowballC)
library(wordcloud)
myfunction=function(i) {
  print('word cloud of')
  print(colnames(train_data)[i])
  type=as.data.frame(train_data[train_data[,i]==1,])
  corpus1=Corpus(VectorSource(type[,2]))
  corpus1=tm_map(corpus1,removeWords,stopwords('english'))
  corpus1=tm_map(corpus1,removeNumbers)
  corpus1=tm_map(corpus1,removePunctuation)
  corpus1=tm_map(corpus1,stemDocument)
  wordcloud(corpus1, max.words = 100, random.order = FALSE)
}
for (i in (3:8)){
  print(myfunction(8))
  
  
}

