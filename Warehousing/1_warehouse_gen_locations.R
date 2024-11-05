# 1. Warehousing 
# Generating (random) coordinates for facilities and clients

# Clear environment 
rm(list = ls())
set.seed(1)

# -------------------------------------------------------------------------

# let n = number of coordinates to generate
n = 15+60
x = c()
y = c()

# each loop creates a coordinate point pair
for (i in 1:n) {
  # use different uniform distributions 
  U1 = runif(1)
  U2 = runif(1)
  # re-scale to allow coordinate to be between -10 and 10, and round to 3.d.p
  x[i] = round(20*U1 - 10, 3)
  y[i] = round(20*U2 - 10, 3)
}

# bind together the x coordinates with the y coordinates and store as data frame
all_coordinates = data.frame(cbind(x,y))

# select first 15 coordinate pairs to be for facilities, 
# and the remaining 60 coordinate pairs to be for the clients
facilities = all_coordinates[1:15, ]
clients = all_coordinates[16:n, ]

# reset the row index to start at 1
rownames(clients) <- NULL

# view the locations
facilities
clients

# export the data frames as CSV files
write.csv(facilities, "location_facilities.csv", row.names = FALSE)
write.csv(clients, "location_clients.csv", row.names = FALSE)

