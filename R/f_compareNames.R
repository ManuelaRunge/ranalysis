#'  f_compareNames
#' 
#' 
#' 
#' 
f_compareNames <- function(A, B, showNames="none"){
  A = unique(as.character(A))
  B = unique(as.character(B))

  AinB = which(A %in% B)
  BinA = which(B %in% A)

  AnotinB = which(!(A %in% B))
  BnotinA = which(!(B %in% A))

  print(paste0("A in B n= ", length(AinB)))
  print(paste0("B in A n= ", length(BinA)))

  print(paste0("A not in B n= ", length(AnotinB)))
  print(paste0("B not in A n= ", length(BnotinA)))

  if(showNames=="both"){
    print(paste0("A not in B: "))
    print(A[AnotinB])

    print(paste0("B not in A: "))
    print(B[BnotinA])
  }
  if(showNames=="AB"){
    print(paste0("A not in B: "))
    print(A[AnotinB])
  }
  if(showNames=="BA"){
    print(paste0("B not in A: "))
    print(B[BnotinA])
  }

  #outlist = list("A"=A,"B"=B,"AinB"=AinB, "BinA"=BinA, "AnotinB"=AnotinB, "BnotinA"=BnotinA)

}
