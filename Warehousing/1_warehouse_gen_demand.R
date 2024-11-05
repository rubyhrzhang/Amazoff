# 1. Warehousing 
# generating (random) demand 

# Clear environment 
rm(list = ls())
set.seed(1)

# -------------------------------------------------------------------------

n = 60
demand = c()

for (i in 1:n) {
  # use random uniform distribution
  U = runif(1)
  # re-scale to allow coordinate to be between 1 and 25 (inclusive)
  demand[i] = floor(25*U) + 1
}

# store as data frame
demand = data.frame(demand)
demand

# export the data frame as CSV file
write.csv(demand, file='demand.csv', row.names = FALSE)
