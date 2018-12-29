# Parameters
param M; # Number of lines (economy, basic, and hand-crafted)
param N; # Number of sizes (student, standard, and executive)
param Profit{m in 1..M, n in 1..N}; # Unit profit of each style of desks
param Order{m in 1..M, n in 1..N}; # Orders for each style of desks
param Aluminum{m in 1..M, n in 1..N}; # Aluminum required to produce each style of desks
param ParticleBoard{m in 1..M, n in 1..N}; # Particle board required to produce each style of desks
param PineSheets{m in 1..M, n in 1..N}; # Pine sheet required to produce each style of desks
param PL1{m in 1..M, n in 1..N}; # minutes required per desk for production line 1
param PL2{m in 1..M, n in 1..N}; # minutes required per desk for production line 2
param PL3{m in 1..M, n in 1..N}; # minutes required per desk for production line 3
param Assemble{m in 1..M, n in 1..N}; # minutes required per desk for assembling/finishing
param HandCraft{m in 1..M, n in 1..N}; # minutes required per desk for hand-crafting
param Labor_Available; # total labor available in September
param Aluminum_Available; # total aluminum available
param ParticleBoard_Available; # total particle boards available
param PineSheets_Available; # total pine sheets available
param PL1_Available; # production minutes available on production line 1
param PL2_Available; # production minutes available on production line 2
param PL3_Available; # production minutes available on production line 3
param MinLineQuotas{m in 1..M}; # minimum quotas for desk production of each line (econ, basic, handcrafted)
param MinSizeQuotas{n in 1..N}; # minimum quotas for desk production of each size (student, standard, exec)
param MaxLineQuotas{m in 1..M}; # maximum quotas for desk production of each line (econ, basic, handcrafted)
param MaxSizeQuotas{n in 1..N}; # maximum quotas for desk production of each size (student, standard, exec)

# Decision Variable
var X{m in 1..M, n in 1..N} integer >= 0; # Amount to produce for each desk type
var TotalProduction = sum{m in 1..M, n in 1..N} X[m,n];

# Objective Function
maximize totalprofit:
	sum{m in 1..M, n in 1..N} X[m,n]*Profit[m,n];
	
# Constraints
subject to meetorder {m in 1..M, n in 1..N}:
	X[m,n] >= Order[m,n];

subject to minline {m in 1..M}:
	MinLineQuotas[m] * TotalProduction <= sum{n in 1..N} X[m,n];
	
subject to maxline {m in 1..M}:
	MaxLineQuotas[m] *  TotalProduction>= sum{n in 1..N} X[m,n];

subject to minprod {n in 1..N}:
	MinSizeQuotas[n] * TotalProduction <= sum{m in 1..M} X[m,n];
	
subject to maxprod {n in 1..N}:
	MaxSizeQuotas[n] * TotalProduction >= sum{m in 1..M} X[m,n];
		
subject to aluminum_availability:
	sum{m in 1..M, n in 1..N} (X[m,n] * Aluminum[m,n]) <= Aluminum_Available;

subject to PB_availability:
	sum{m in 1..M, n in 1..N} (X[m,n] * ParticleBoard[m,n]) <= ParticleBoard_Available;

subject to PS_availability:
	sum{m in 1..M, n in 1..N} (X[m,n] * PineSheets[m,n]) <= PineSheets_Available;
	
subject to PL1_availability:
	sum{m in 1..M, n in 1..N} (X[m,n] * PL1[m,n]) <= PL1_Available;
	
subject to PL2_availability:
	sum{m in 1..M, n in 1..N} (X[m,n] * PL2[m,n]) <= PL2_Available;

subject to PL3_availability:
	sum{m in 1..M, n in 1..N} (X[m,n] * PL3[m,n]) <= PL3_Available;
	
subject to labor_availability:
	(sum{m in 1..M, n in 1..N} (X[m,n] * (PL1[m,n]+PL2[m,n]+PL3[m,n]))) * 2 +
	sum{m in 1..M, n in 1..N} (X[m,n] * (Assemble[m,n]+HandCraft[m,n]))
	<= Labor_Available;
	