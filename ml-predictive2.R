# CARGA DE LIBRERÍAS ---------------------------------------------------
library(readxl)
library(dplyr)
library(ggplot2)
library(caret)
library(corrplot)
library(rpart)
library(randomForest)

data <- read_excel("C:/Users/User/Desktop/Certificado Data Science/Excel data sets/business_rf_dataset.xlsx")
str(data)

# EXPLORACIÓN DE DATOS ---------------------------------------------------
summary(data)

# Gráfico de ingresos por canal de venta ---------------------------------
ggplot(data, aes(x = sales_channel, y = monthly_revenue_usd)) +
  geom_boxplot(fill = "#69b3a2") +
  labs(title = "Distribución de ingresos mensuales por canal",
       x = "Canal de venta",
       y = "Ingresos mensuales (USD)")

# Correlaciones numéricas -----------------------------------------------
numeric_vars <- data %>% 
  dplyr::select(session_duration_min,
                monthly_visits,
                discount_level,
                review_score,
                monthly_revenue_usd)

corrplot(cor(numeric_vars), method = "color", addCoef.col = "black")

# TRANSFORMACIÓN DE CATEGÓRICAS ----------------------------------------
data$sales_channel <- as.factor(data$sales_channel)

# SPLIT TRAIN / TEST ----------------------------------------------------
set.seed(123)
splitIndex <- createDataPartition(data$monthly_revenue_usd, p = 0.8, list = FALSE)
train <- data[splitIndex, ]
test  <- data[-splitIndex, ]

# MODELO 1: REGRESIÓN LINEAL MÚLTIPLE -----------------------------------
model_lm <- lm(monthly_revenue_usd ~ session_duration_min +
                 monthly_visits + discount_level +
                 review_score + sales_channel,
               data = train)

summary(model_lm)

pred_lm <- predict(model_lm, newdata = test)
postResample(pred_lm, test$monthly_revenue_usd)

# MODELO 2: ÁRBOL DE DECISIÓN -------------------------------------------
model_tree <- rpart(monthly_revenue_usd ~ session_duration_min +
                      monthly_visits + discount_level +
                      review_score + sales_channel,
                    data = train)

plot(model_tree); text(model_tree, cex = 0.7)

pred_tree <- predict(model_tree, newdata = test)
postResample(pred_tree, test$monthly_revenue_usd)

# MODELO 3: RANDOM FOREST -----------------------------------------------
model_rf <- randomForest(monthly_revenue_usd ~ session_duration_min +
                           monthly_visits + discount_level +
                           review_score + sales_channel,
                         data = train,
                         ntree = 100,
                         importance = TRUE)

pred_rf <- predict(model_rf, newdata = test)
postResample(pred_rf, test$monthly_revenue_usd)

varImpPlot(model_rf)

