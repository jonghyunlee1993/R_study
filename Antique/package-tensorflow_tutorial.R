# ##install pkgs##
# install.packages("keras") # not using
# install.packages("caret")
# install.packages("tidyverse")
# install.packages("rlang")
# install.packages("tensorflow")
# devtools::install_github("rstudio/keras")

library(keras) # for deep learning
library(tidyverse) # general utility functions
library(caret) # machine learning utility functions
library(tensorflow)
library(ggplot2)
library(dplyr)

# install_keras()
# install_tensorflow()

##load files##
series <- read.csv("C:/Users/dyyang/Documents/fitogether/rnn_practice/MEI_FIN_15052020040450871.csv", stringsAsFactors = FALSE)
names(series)[1] <- "SUBJECT"

# str(series)
lct <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME", "C")
series$TIME <- as.Date(paste0("01-", toupper(series$TIME)), format = '%d-%b-%y')
data_row <- series %>% filter(Country == "Korea", SUBJECT == "IRLT")

p <- ggplot(data_row, aes(x = TIME, y = Value/100)) +
  geom_line() + 
  xlab("") +
  scale_x_date(date_labels = "%m-%Y", date_breaks = "1 year") +
  theme(axis.text.x=element_text(angle=60, hjust=1))

data <- data_row$Value/100

diffed <- diff(data, differences = 1)
head(diffed)

lag_transform <- function(x, k = 1){
  
  lagged <- c(rep(NA, k), x[1:(length(x)-k)])
  DF <- as.data.frame(cbind(lagged, x))
  colnames(DF) <- c(paste0('x-', k), 'x')
  DF[is.na(DF)] <- 0
  return(DF)
}
# supervised <- data.frame(diffed) %>% mutate(LAG = lag(diffed, 1)) %>% replace(., is.na(.), 0) %>%
#   rename("x-1" = LAG, "x" = diffed) %>%
#   select('x-1', 'x')
supervised <- lag_transform(diffed, 1)
head(supervised)

N     <- nrow(supervised)
n     <- round(N * 0.7, digits = 0)
train <- supervised[1:n, ]
test  <- supervised[(n+1):N, ]

## scale data
scale_data <- function(train, test, feature_range = c(0, 1)) {
  x         <- train
  fr_min    <- feature_range[1]
  fr_max    <- feature_range[2]
  std_train <- ((x - min(x)) / (max(x) - min(x)))
  std_test  <- ((test - min(x)) / (max(x) - min(x)))
  
  scaled_train <- std_train * (fr_max - fr_min) + fr_min
  scaled_test  <- std_test  * (fr_max - fr_min) + fr_min
  
  return(list(scaled_train = as.vector(scaled_train),
              scaled_test  = as.vector(scaled_test),
              scaler       = c(min = min(x), max = max(x))))
  
}


Scaled <- scale_data(train, test, c(-1, 1))

y_train <- Scaled$scaled_train[, 2]
x_train <- Scaled$scaled_train[, 1]

y_test <- Scaled$scaled_test[, 2]
x_test <- Scaled$scaled_test[, 1]

## inverse-transform
invert_scaling <- function(scaled, scaler, feature_range = c(0, 1)) {
  min          <- scaler[1]
  max          <- scaler[2]
  t            <- length(scaled)
  mins         <- feature_range[1]
  maxs         <- feature_range[2]
  inverted_dfs <- numeric(t)
  
  for(i in 1:t){
    X = (scaled[i]- mins)/(maxs - mins)
    rawValues = X * (max - min) + min
    inverted_dfs[i] <- rawValues
  }
  return(inverted_dfs)
}

# Reshape the input to 3-dim
dim(x_train) <- c(length(x_train), 1, 1)

# specify required arguments
X_shape2   <- dim(x_train)[2]
X_shape3   <- dim(x_train)[3]
batch_size <- 1                # must be a common factor of both the train and test samples
units      <- 1                # can adjust this, in model tuninig phase

#=========================================================================================

model <- keras_model_sequential() 
model %>%
  layer_lstm(units, batch_input_shape = c(batch_size, X_shape2, X_shape3), stateful = TRUE) %>%
  layer_dense(units = 1)

model %>% compile(
  loss      = 'mean_squared_error',
  optimizer = optimizer_adam( lr= 0.02, decay = 1e-6 ),  
  metrics   = c('accuracy')
)

summary(model)

Epochs <- 50
for(i in 1:Epochs){
  model %>% fit(x_train, y_train, epochs=1, batch_size=batch_size, verbose=1, shuffle=FALSE) # error
  model %>% reset_states()
}

L           <- length(x_test)
scaler      <- Scaled$scaler
predictions <- numeric(L)

for(i in 1:L){
  X      <- x_test[i]
  dim(X) <- c(1,1,1)
  yhat   <- model %>% predict(X, batch_size=batch_size)
  # invert scaling
  yhat <- invert_scaling(yhat, scaler,  c(-1, 1))
  # invert differencing
  yhat <- yhat + data[(n+i)]
  # store
  predictions[i] <- yhat
}

# predictions

data_test <- tail(data_row, length(predictions))
data_test <- cbind(data_test, predictions)
data_test <- data_test %>%
  mutate(TEST = Value/100)

data_test <- data_test %>%
  select(TIME, predictions, TEST) %>%
  pivot_longer(-TIME, names_to = 'variable')

data_train <- head(data_row, length(x_train))
data_train <- data_train %>%
  mutate(TRAIN = Value/100)
data_train <- data_train %>%
  select(TIME, TRAIN)
data_train <- data.frame(TIME = data_train$TIME, variable = "TRAIN", value = data_train$TRAIN)

data_pred <- rbind(data_train, data_test)

p2 <- ggplot(data_pred, aes(x = TIME, y = value, colour = variable)) +
  geom_line() + 
  xlab("") +
  scale_x_date(date_labels = "%m-%Y", date_breaks = "1 year") +
  theme(axis.text.x=element_text(angle=60, hjust=1))

p2

result = data_pred %>% filter(variable %in% c("TEST", "predictions"))
test = data_pred %>% filter(variable == "TEST") %>%  select(c("value"))
prediction = data_pred %>% filter(variable == "predictions") %>% select(c("value"))

RMSE = sum(sqrt((test - predictions) ** 2))
MAPE = sum(abs(predictions - test) / test) / nrow(test) * 100

MAPE

