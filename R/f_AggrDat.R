#' Aggregate a local data frame and returning multiple summary statistics
#'
#' aggregates a single variable of a dataframe and returns summary statistics including CI's
#'
#' @param  dataframe dataframe
#' @param  groupVars grouping variables 
#' @param  valueVar variable to aggregate
#' @param  WideToLong  change format of results dataset from wide to long format 
#' 
#'
 f_aggrDat <- function(dataframe, groupVars, valueVar, WideToLong=FALSE){

 dataframe <- as.data.frame(dataframe)
 dataframe$tempvar <- dataframe[,colnames(dataframe)==valueVar]
 datAggr <- dataframe %>% 
			dplyr::group_by_(.dots=groupVars) %>%
			dplyr::summarise(
					 min.val 	= min(tempvar, na.rm = TRUE),
					 max.val	= max(tempvar, na.rm = TRUE),
					 mean.val 	= mean(tempvar, na.rm = TRUE),
					 median.val	= median(tempvar, na.rm = TRUE),
					 sd.val		= sd(tempvar, na.rm = TRUE),
					 n.val 		= n(),										 
					 q25		= quantile(tempvar, probs=0.25, na.rm = TRUE),
					 q75		= quantile(tempvar, probs=0.75, na.rm = TRUE),
					 q2.5		= quantile(tempvar, probs=0.025, na.rm = TRUE),
					 q97.5  	= quantile(tempvar, probs=0.975, na.rm = TRUE)) %>%
			dplyr::mutate(	
					se.val 			= sd.val / sqrt(n.val),
					lower.ci.val 	= mean.val - qt(1 - (0.05 / 2), n.val - 1) * se.val,
					upper.ci.val 	= mean.val + qt(1 - (0.05 / 2), n.val - 1) * se.val,
					weighted=0) %>%
			#dplyr::select(-sd.val, -n.val,-se.val) %>%
			as.data.frame()
	
	if(WideToLong){
		datAggr <- gather(datAggr, -groupVars)
		colnames(datAggr)[colnames(datAggr)=="variable"] <- "statistic" 
		colnames(datAggr)[colnames(datAggr)=="value"] <- valueVar
		datAggr$statistic <- gsub(".val","",datAggr$statistic)
		}
 
return(datAggr)
}

#'
#'
#'
#' dataframe = dataframe to aggregate (new datafram will be created)
#' groupVars = variables to aggregate at 
#' valueVar = variable to aggregate 
#' weightVar = weighting variable  
#' WideToLong = transfrom data to long format, so that statistics are in one column instead of spread over rows

 f_weighted.aggrDat <- function(dataframe, groupVars, valueVar, weightVar, WideToLong=FALSE){
 # dataframe = dataframe to aggregate (new datafram will be created)
 # groupVars = variables to aggregate at 
 # valueVar = variable to aggregate 
 # WideToLong = transfrom data to long format, 
 #              so that statistics are in one column instead of spread over rows
 
 dataframe <- as.data.frame(dataframe)
 dataframe$tempvar <- dataframe[,colnames(dataframe)==valueVar]
 dataframe$w <- dataframe[,colnames(dataframe)==weightVar]
 
 datAggr <- dataframe %>% 
			dplyr::group_by_(.dots=groupVars) %>%
			dplyr::summarise(
					 min.val 	= min(tempvar, na.rm = TRUE),
					 max.val	= max(tempvar, na.rm = TRUE),
					 mean.val 	= weighted.mean(tempvar, w),
					 median.val	= weighted.median(tempvar, w),
					 sd.val		= sqrt(sum(w * (tempvar - mean.val)^2)),
					 n.val 		= n(),										 
					 q25		= weighted.quantile(tempvar,w, probs=0.25),
					 q75		= weighted.quantile(tempvar,w, probs=0.75),
					 q2.5		= weighted.quantile(tempvar,w, probs=0.025),
					 q97.5  	= weighted.quantile(tempvar,w, probs=0.975)) %>%
			dplyr::mutate(	
					se.val 			= sd.val / sqrt(n.val),
					lower.ci.val 	= mean.val - qt(1 - (0.05 / 2), n.val - 1) * se.val,
					upper.ci.val 	= mean.val + qt(1 - (0.05 / 2), n.val - 1) * se.val,
					weighted=1) %>%
			#dplyr::select(-sd.val, -n.val,-se.val) %>%
			as.data.frame()
	
	if(WideToLong){
		datAggr <- gather(datAggr, -groupVars)
		colnames(datAggr)[colnames(datAggr)=="variable"] <- "statistic" 
		colnames(datAggr)[colnames(datAggr)=="value"] <- valueVar
		datAggr$statistic <- gsub(".val","",datAggr$statistic)
		}
 
return(datAggr)
}
