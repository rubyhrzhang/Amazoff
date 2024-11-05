# Routing 
# Use exactly 1 vehicle 

# call relavent parameters ----------------------------------------------------
set D_1; # depot(s)
set CC_25; # composite clients

set Nodes := CC_25 union D_1; # ordered nodes
set Arcs := {i in Nodes, j in Nodes: i<>j}; # possible arcs

# coordinates for composite clients and depot(s)
param X{Nodes}; 
param Y{Nodes}; 

param COST_DISTANCE {(i,j) in Arcs} := 	sqrt((X[j] - X[i])^2 + (Y[j] - Y[i])^2); # distance cost (l2 norm)
param N := card(Nodes); # cardinality of the set of nodes (for sub-tour elimination)

# decision variables ----------------------------------------------------------
var u{Nodes} >= 0, <= N-1; # order nodes (position / index)
var included{i in Nodes, j in Nodes} binary; # indicator for if arc included in route

# objective function ----------------------------------------------------------

# minimises total cost of taking the route (only cost is the distance cost)
minimize TotalCost:	sum{(i,j) in Arcs} included[i,j] * COST_DISTANCE[i,j];
	
# constraints -----------------------------------------------------------------
subject to

# each node has exactly one outgoing arc included in the route
Out_C{i in Nodes}: sum{(i,j) in Arcs} included[i,j] = 1;

# each node has exactly one incoming arc included in the route
In_C{i in Nodes}: sum{(j,i) in Arcs} included[j,i] = 1;
    
# ordering of nodes (node j comes after node i in the node order variable u)
Ordering_C{(i,j) in Arcs: i<>j and i!="s" and j!="s"}: u[i] - u[j] + N*included[i,j] <= N-1;

# start must be at node s
Start_C{i in Nodes: i!="s"}: u[i] <= N - 1 - (N-2)*included["s",i];

# end must also be at node s
End_C{i in Nodes: i!="s"}: u[i] >= 1 + (N-2)*included[i,"s"];