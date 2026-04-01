# Install and load the VGAM package
#install.packages("VGAM")
library(VGAM)

# Define parameters
rate <- 1/60
k <- 3
nn <- 1000

# Generate data
edata <- data.frame(y = rep(0, nn))
for (ii in 1:k)
  edata <- transform(edata, y = y + rexp(nn, rate = rate))

# Fit the model
fit <- vglm(y ~ 1, erlang(shape = k), edata, trace = TRUE)

# Display coefficients
coef(fit, matrix = TRUE)
Coef(fit)  # Answer = 1/rate
expected_length=1/rate
expected_length
variance=1/(k*(rate^2))
variance
summary(fit)

# Generate random numbers from Erlang distribution
data <- rgamma(nn, shape = k, rate = rate)

# Probability Density Function (PDF) of Erlang distribution
erlang_pdf <- function(x, k, rate) {
  rate^k * x^(k - 1) * exp(-rate * x) /factorial(k - 1)
}

# Plot the PDF
pdf_data <- curve(erlang_pdf(x, k, rate), from = 0, to = max(data), add = TRUE, col = "red",
      lwd = 2, lty = 2, n = 100, xlab = "x", ylab = "PDF", main = "PDF of Erlang Distribution")


#Saving dataframe to a CSV file
write.csv(pdf_data, file ="pdf_data.csv" , row.names = FALSE)


# Cumulative Distribution Function (CDF) of Erlang distribution
erlang_cdf <- function(x, k, rate) {
  pgamma(x, shape = k, rate = rate, lower.tail = TRUE)
}

# Plot the CDF
cdf_data<- curve(erlang_cdf(x, k, rate), from = 0, to = max(data), col = "red",
      lwd = 2, n = 100, xlab = "x", ylab = "CDF", main = "CDF of Erlang Distribution")

#Saving dataframe to a CSV file
write.csv(cdf_data, file ="cdf_data.csv" , row.names = FALSE)

