# table of missing values, similar to the "mdesc" function in Stata

mdesc <- function(x, y = NULL, digits = 1, miss = NULL, label = FALSE, print = TRUE) {
tabrows = matrix(NA,length(colnames(x)),4)
colnames(tabrows)<- c("total", "nonmissing", "missing", "%missing")
dimnames(tabrows)[[1]]<- c(colnames(x))
# if transforming NA to a negative number, the negative number comes always first and can be indexed
for(i in 1:length(colnames(x))) {
      nonmissing <- sum(table(x[,i]))
      total <-  sum(table(x[,i], exclude = NULL))
      count <- (table(x[,i], exclude = NULL) )
      perc <- (prop.table(table(x[,i], exclude = NULL) ))
      tab<- cbind(total,nonmissing, count[dim(count)], round((perc[dim(perc)]*100),2))               # take only first column, first index with -9
      tabrows[i,] <- tab
}
print(tabrows) 
}

