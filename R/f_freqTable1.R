#' library(summarytools)
#'

f_freqTable1 <- function(data, Variables){
  
  count=0
  for(var in Variables){
    #var="water_depth"
    print(var)
    count=count+1
  
   if(var=="waterovement")var <- "water_movement"
    
    data$tempvar <- data[,colnames(data)==var]
    temptab <- summarytools::freq(data$tempvar, order = "freq")
    
    tempName <- matrix("",1,5)
    rownames(tempName) <- var
    
   tempTab1 <- rbind(tempName, temptab)
   
   if(count==1)Table1 <- tempTab1
   if(count>1)Table1 <- rbind(Table1,tempTab1)
   rm(tempTab1,  temptab, var)
  
  }

return(Table1)

}