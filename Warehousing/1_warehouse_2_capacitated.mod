# Warehousing 
# Capacitated model 

# call relavent parameters ----------------------------------------------------
set F_15 := 1..15; # facilities
set C_60 := 1..60; # clients

# coordinates for clients and facilities
param X_CLIENT{C_60};
param Y_CLIENT{C_60};
param DEMAND{C_60};
param X_FACILITY{C_60};
param Y_FACILITY{C_60};

param COST_OPEN{f in F_15} := 100 * 3^(-f); # opening costs
param COST_ASSIGN{c in C_60, f in F_15} := abs(X_CLIENT[c] - X_FACILITY[f]) + abs(Y_CLIENT[c] - Y_FACILITY[f]); # assignment costs
param CAPACITY{f in F_15} := 100 * 2^(f); # NEW PARAMTER TYPE: facility capcities

# decision variables ----------------------------------------------------------
var open_facility{F_15} binary; # decide whether or not to open facility
var assign_f_c{F_15, C_60} binary; # decide which facilities to assign to client

# objective function ----------------------------------------------------------

# notes:
# 1. first sum represents total costs for opening facilities
# 2. second sum represents total costs for assigning facilities to clients

minimize TotalCost:
    sum{f in F_15} COST_OPEN[f] * open_facility[f] 
  + sum{c in C_60, f in F_15} COST_ASSIGN[c,f] * assign_f_c[f,c];

# constraints -----------------------------------------------------------------
subject to 

# assign exactly 1 facility per client
AssignClient_C{c in C_60}: sum{f in F_15} assign_f_c[f,c] = 1;

# client can only be served by a facility that is open 
FacilityOpen_C{f in F_15, c in C_60}: assign_f_c[f,c] <= open_facility[f];

# ADDITIONAL CONSTRAINT: facilities have limited capacities
CapacityDemand_C{f in F_15}: sum{c in C_60} assign_f_c[f,c] * DEMAND[c] <= open_facility[f] * CAPACITY[f];