rm(list=ls())

library(data.table)
library(curl)

url = "https://archive.ics.uci.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data"

wdbc <- data.frame(fread(url))
str(wdbc)

colnames(wdbc) <- c("id", "diagnosis", "radius_mean", "texture_mean", 
                    "perimeter_mean", "area_mean", "smoothness_mean", "compactness_mean",
                    "concavity_mean", "concave.points_mean", "symmetry_mean", "fractal_dimension_mean", 
                    "radius_se", "texture_se", "perimeter_se", "area_se", 
                    "smoothness_se", "compactness_se", "concavity_se", "concave.points_se", 
                    "symmetry_se", "fractal_dimension_se", "radius_worst", "texture_worst", 
                    "perimeter_worst", "area_worst", "smoothness_worst", "compactness_worst", 
                    "concavity_worst", "concave.points_worst", "symmetry_worst", "fractal_dimension_worst")
summary(wdbc)

# (1) 결측값 확인 및 처리
# (2) 중복 데이터 확인 및 처리
# (3) 목표변수 범주/계급 구성 분포 확인 및 처리
# (4) 설명변수 간 다중공선성 확인 및 처리
# (5) 표준화, 척도 변환

# 결측치 확인
attach(wdbc)
colSums(is.na(wdbc))
sum(is.na(wdbc))

# 중복 확인
sum(duplicated(wdbc))

# 분포 확인
table(diagnosis); cat("total :", margin.table(table(diagnosis)))

# 다중 공선성 확인
y = ifelse(diagnosis == 'M', 1, 0)
x = wdbc[,c(3:32)]

names(x)

library(PerformanceAnalytics)
chart.Correlation(x[,c(1:10)], histogram=TRUE, col="grey10", pch=1)
chart.Correlation(x[,c(11:20)], histogram=TRUE, col="grey10", pch=1)
chart.Correlation(x[,c(21:30)], histogram=TRUE, col="grey10", pch=1)

library(GGally)
ggcorr(x, name="Corr", label=T)

library(car)

# Multi-collinearity check and remove the highly correlated variables step by step

# UDF of stepwise VIF function with preallocated vectors

# code source: https://beckmw.wordpress.com/2013/02/05/collinearity-and-stepwise-vif-selection/



vif_func <- function(in_frame,thresh=10, trace=F,...){

  require(fmsb)
  
  if(class(in_frame) != 'data.frame') in_frame<-data.frame(in_frame)
  #get initial vif value for all comparisons of variables
  vif_init <- vector('list', length = ncol(in_frame))
  names(vif_init) <- names(in_frame)
  var_names <- names(in_frame)

  for(val in var_names){
    regressors <- var_names[-which(var_names == val)]
    form <- paste(regressors, collapse = '+')
    form_in <- formula(paste(val,' ~ .'))
    vif_init[[val]] <- VIF(lm(form_in,data=in_frame,...))
  }
  vif_max<-max(unlist(vif_init))
  
  if(vif_max < thresh){
    if(trace==T){ #print output of each iteration
      prmatrix(vif_init,collab=c('var','vif'),rowlab=rep('', times = nrow(vif_init) ),quote=F)
      cat('\n')
      cat(paste('All variables have VIF < ', thresh,', max VIF ',round(vif_max,2), sep=''),'\n\n')
    }
    return(names(in_frame))
  }
  else{
    in_dat<-in_frame

    #backwards selection of explanatory variables, stops when all VIF values are below 'thresh'
    
    while(vif_max >= thresh){
      vif_vals <- vector('list', length = ncol(in_dat))
      names(vif_vals) <- names(in_dat)
      var_names <- names(in_dat)

      for(val in var_names){
        regressors <- var_names[-which(var_names == val)]
        form <- paste(regressors, collapse = '+')
        form_in <- formula(paste(val,' ~ .'))
        vif_add <- VIF(lm(form_in,data=in_dat,...))
        vif_vals[[val]] <- vif_add
      }
      
      max_row <- which.max(vif_vals)
      #max_row <- which( as.vector(vif_vals) == max(as.vector(vif_vals)) )
      vif_max<-vif_vals[max_row]

      if(vif_max<thresh) break
      
      if(trace==T){ #print output of each iteration
        vif_vals <- do.call('rbind', vif_vals)
        vif_vals
        prmatrix(vif_vals,collab='vif',rowlab=row.names(vif_vals),quote=F)
        cat('\n')
        cat('removed: ', names(vif_max),unlist(vif_max),'\n\n')
        flush.console()
      }
      in_dat<-in_dat[,!names(in_dat) %in% names(vif_max)]
    }
    return(names(in_dat))
  }
}

x_independent <- vif_func(x, thresh=10, trace=F)
x_independent

# vif free
x_2 <- x[, x_independent]

# scale
x_3 = scale(x_2)
X = cbind(y, x_3)

# model 
model = glm(y ~ ., data=as.data.frame(X), family=binomial(link="logit"))
final_model = step(model, direction="both")
summary(final_model)
