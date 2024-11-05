# 1. Warehousing 
# Selecting a (random) subset of clients to treat as composite clients

# Clear environment 
rm(list = ls())
set.seed(1)

# -------------------------------------------------------------------------

# In this file we define the function generate_subset that takes as input
# integers N and R outputs a random subset of 1,...,N of size R.

# later the function will select the last R entries of a randomly shuffled P
R = 25

# the number of clients
N = 60


generate_subset = function(N,R)
{ 
  # generate a list of all the clients (from 1 to 60 inclusive)
  P = c(1:N)
  
  k = N
  
  # go through list of 60 clients and shuffle by randomly selecting two clients and swapping them
    while (k > N-R){
    U = runif(1)
    I = floor(k*U)+1
    
    # swap P[I] and P[k]
    temp = P[I]
    P[I] = P[k]
    P[k] = temp
    
    k = k -1
  }
  
  # once the clients are thoroughly shuffled, 
  # select that last R (25) elements of P (clients)
  S = tail(P,R)
  
  return(S)
  
}

# call the function with the desired parameter values for context and order 
composite_index = sort(generate_subset(60, 25))
composite_index

# convert these into respective client coordinate locations by ...

# read in the data for all client locations
clients = read.csv('location_clients.csv')

# only select the composite clients and rename 
composite_clients = clients[composite_index, ]
rownames(composite_clients) = paste0("c", rownames(composite_clients))
composite_clients

# export the data frames as CSV files
write.csv(composite_clients, file="location_composite.csv", row.names = TRUE)
