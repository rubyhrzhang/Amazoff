# Routing 
# Use exactly 3 vehicles

# call relavent parameters ----------------------------------------------------
set D_1; # depot(s)
set CC_25; # composite clients
set V_3; # vehicles

set Nodes := CC_25 union D_1; # ordered nodes
set Arcs := {i in Nodes, j in Nodes: i<>j}; # possible arcs

# coordinates for composite clients and depot(s)
param X{Nodes}; 
param Y{Nodes}; 

param COST_DISTANCE {(i,j) in Arcs} := 	sqrt((X[j] - X[i])^2 + (Y[j] - Y[i])^2); # distance cost (l2 norm)

# decision variables ----------------------------------------------------------
var u{Nodes, V_3} >=0; # order nodes (position / index)
var included{i in Nodes, j in Nodes, k in V_3} binary; # indicator for if arc included in route

# objective function ----------------------------------------------------------

# minimises total cost of taking the route for all three vehicles (only cost is the distance cost)
minimize TotalCost:	sum{(i,j) in Arcs, k in V_3} included[i,j,k] * COST_DISTANCE[i,j];

# constraints -----------------------------------------------------------------
subject to

# each node has exactly one outgoing arc included in the route
Out_C{i in Nodes}: sum{(i,j) in Arcs, k in V_3} included[i,j,k] = 1;

# each node has exactly one incoming arc included in the route
In_C{i in Nodes}: sum{(j,i) in Arcs, k in V_3} included[j,i,k] = 1;
    
# flow balance at each node
Balance_C{i in Nodes, k in V_3}: sum{j in Nodes} included[i,j,k] - sum{j in Nodes} included[j,i,k] = 0;

# start must be at node s
Start_C{k in V_3}: sum{i in Nodes} included["s",i,k] = 1;
	
# no sub-tours allowed
Sub_C{(i,j) in Arcs, k in V_3: i!="s" and j!="s"}: u[i,k] - u[j,k] + N*included[i,j,k] <= N-1;