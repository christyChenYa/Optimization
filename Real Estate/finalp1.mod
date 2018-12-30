# decision variables
var x_total >= 0;
var x_GE >= 0;
var x_GWC >= 0;
var x_LPH >= 0;
var x_CC >= 0;
## GRAND ESTATES
var x_trump >= 0;
var x_trump_lake >= 8; # each of the Grand Estate series plans must have at least 8 units on the lake
var x_vand >= 0;
var x_vand_lake >= 8;
var x_hughes >= 0;
var x_hughes_lake >= 8;
var x_jack >= 0;
var x_jack_lake >= 8;
## GLEN WOOD COLLECTION
var x_GC >= 0;
var x_GC_prem >= 0;
var x_LO >= 0;
var x_WR >= 0;
var x_orange >= 0;
## LAKEVIEW PATIO HOMES
var x_bay >= 0;
var x_bay_prem >= 0;
var x_store >= 0;
var x_DE >= 0;
var x_GP >= 0;
## COUNTRY CONDOMINIUMS
var x_CS >= 0;
var x_WW >= 0;
var x_PF >= 0;

# objective
maximize profit:
	0.22 * (x_trump_lake * 960 + x_trump * 700 + x_vand_lake * 934 + x_vand * 680 
	+ x_hughes_lake * 895 + x_hughes * 650 + x_jack_lake * 817 + x_jack * 590)
	+ 0.18 * (x_GC * 420 + x_GC_prem * 460 + x_LO * 380 + x_WR * 320 + x_orange * 280)
	+ 0.2 * (x_bay * 300 + x_bay_prem * 330 + x_store * 270 + x_DE * 240 + x_GP * 200)
	+ 0.25 * (x_CS * 220  + x_WW * 160 + x_PF * 140);

# constraints

# total number of properties is the sum of all properties
subject to total:
	x_total = x_GE + x_GWC+ x_LPH + x_CC;

# the make-up of Grand Estate Series
subject to grand_estate:
	x_GE = x_trump_lake + x_trump + x_vand_lake + x_vand + x_hughes_lake + x_hughes
	+ x_jack_lake + x_jack;

# the make-up of Glen Wood Collection
subject to glen_wood:
	x_GWC = x_GC + x_GC_prem + x_LO + x_WR + x_orange;

# the make-up of Lakeview Patio Homes
subject to lakeview_patio:
	x_LPH = x_bay + x_bay_prem + x_store + x_DE + x_GP;

# the make-up of Country Condos	
subject to condos:
	x_CC = x_CS  + x_WW + x_PF;

# available land to build properties on
subject to land:
	(x_trump_lake + x_trump) * 23180 + (x_vand_lake + x_vand + x_hughes_lake + x_hughes) * 22980
	+ (x_jack_lake + x_jack) * 22780 + x_GC * 6150 + x_GC_prem * 12090 + (x_LO + x_bay) * 5756
	+ (x_WR + x_orange + x_store + x_DE) * 5556 + x_bay_prem * 8660 + x_GP * 5356
	+ x_CS * 3100 + (x_WW + x_PF) * 2900 <= 300 * 43560;

# 50 1/2 acres (units) on the lake is dedicated to Grand Estate
subject to lake:
	x_trump_lake + x_vand_lake + x_hughes_lake + x_jack_lake <= 50;

# no more than 25% of the total Grand Cypress models are premium
subject to GC_premium:
	x_GC_prem <= (x_GC + x_GC_prem) * 0.25;

# no more than 25% of the total Bayview models are premium
subject to bay_premium:
	x_bay_prem <= (x_bay + x_bay_prem) * 0.25;

# total parking space dedicated to this project
subject to parking:
	(x_trump_lake + x_trump + x_LO + x_bay + x_bay_prem + x_WW + x_PF) * 400 + (x_vand_lake + x_vand 
	+ x_hughes_lake + x_hughes + x_GC + x_GC_prem + x_WR + x_orange + x_store + x_DE) * 200 
	+ x_CS * 600 <= 15 * 43560;

# variety for 2 bedroom: lower bound
subject to 2b_lowerbound:
	x_GP + x_WW + x_PF >= 0.15 * x_total;

# variety for 2 bedroom: upper bound
subject to 2b_upperbound:
	x_GP + x_WW + x_PF <= 0.25 * x_total;

# variety for 3 bedroom: lower bound
subject to 3b_lowerbound:
	x_jack + x_jack_lake + x_WR + x_orange + x_store + x_DE + x_CS >= 0.25 * x_total;

# variety for 3 bedroom: upper bound
subject to 3b_upperbound:
	x_jack + x_jack_lake + x_WR + x_orange + x_store + x_DE + x_CS <= 0.4 * x_total;
	
# variety for 4 bedroom: lower bound
subject to 4b_lowerbound:
	x_vand + x_vand_lake + x_hughes + x_hughes_lake + x_GC + x_GC_prem + x_LO 
	+ x_bay + x_bay_prem >= 0.25 * x_total;

# variety for 4 bedroom: upper bound
subject to 4b_upperbound:
	x_vand + x_vand_lake + x_hughes + x_hughes_lake + x_GC + x_GC_prem + x_LO 
	+ x_bay + x_bay_prem <= 0.4 * x_total;
	
# variety for 5 bedroom: lower bound
subject to 5b_lowerbound:
	x_trump + x_trump_lake >= 0.05 * x_total;	

# variety for 5 bedroom: upper bound
subject to 5b_upperbound:
	x_trump + x_trump_lake <= 0.15 * x_total;

# Grand Estate mix: lower bound
subject to GE_lowerbound:
	x_GE >= 0.15 * x_total;

# Grand Estate mix: upper bound
subject to GE_upperbound:
	x_GE <= 0.35 * x_total;

# Glen Wood mix: lower bound
subject to GWC_lowerbound:
	x_GWC >= 0.15 * x_total;

# Glen Wood mix: upper bound
subject to GWC_upperbound:
	x_GWC <= 0.35 * x_total;

# Lakeview Patio mix: lower bound
subject to LPH_lowerbound:
	x_LPH >= 0.15 * x_total;

# Lakeview Patio mix: upper bound
subject to LPH_upperbound:
	x_LPH <= 0.35 * x_total;

# Condos mix: lower bound
subject to CC_lowerbound:
	x_CC >= 0.15 * x_total;

# Condos mix: upper bound
subject to CC_upperbound:
	x_CC <= 0.35 * x_total;

# Trump mix: lower bound
subject to trump_lowerbound:
	x_trump + x_trump_lake >= 0.2 * x_GE;

# Vanderbilt mix: lower bound
subject to vand_lowerbound:
	x_vand + x_vand_lake >= 0.2 * x_GE;

# Hughes mix: lower bound
subject to hughes_lowerbound:
	x_hughes + x_hughes_lake >= 0.2 * x_GE;
	
# Jackson mix: lower bound
subject to jack_lowerbound:
	x_jack + x_jack_lake >= 0.2 * x_GE;

# Trump mix: upper bound
subject to trump_upperbound:
	x_trump + x_trump_lake <= 0.35 * x_GE;

# Vanderbilt mix: upper bound
subject to vand_upperbound:
	x_vand + x_vand_lake <= 0.35 * x_GE;

# Hughes mix: upper bound
subject to hughes_upperbound:
	x_hughes + x_hughes_lake <= 0.35 * x_GE;
	
# Jackson mix: upper bound
subject to jack_upperbound:
	x_jack + x_jack_lake <= 0.35 * x_GE;
	
# GC mix: lower bound
subject to GC_lowerbound:
	x_GC + x_GC_prem >= 0.2 * x_GWC;

# LO mix: lower bound
subject to LO_lowerbound:
	x_LO >= 0.2 * x_GWC;

# WR mix: lower bound
subject to WR_lowerbound:
	x_WR >= 0.2 * x_GWC;

# Orange mix: lower bound
subject to orange_lowerbound:
	x_orange >= 0.2 * x_GWC;

# GC mix: upper bound
subject to GC_upperbound:
	x_GC + x_GC_prem <= 0.35 * x_GWC;

# LO mix: upper bound
subject to LO_upperbound:
	x_LO <= 0.35 * x_GWC;

# WR mix: upper bound
subject to WR_upperbound:
	x_WR <= 0.35 * x_GWC;

# Orange mix: upper bound
subject to orange_upperbound:
	x_orange <= 0.35 * x_GWC;

# bay mix: lower bound
subject to bay_lowerbound:
	x_bay + x_bay_prem >= 0.2 * x_LPH;

# storeline mix: lower bound
subject to store_lowerbound:
	x_store >= 0.2 * x_LPH;

# DE mix: lower bound
subject to DE_lowerbound:
	x_DE >= 0.2 * x_LPH;
	
# GP mix: lower bound
subject to GP_lowerbound:
	x_GP >= 0.2 * x_LPH;

# bay mix: upper bound
subject to bay_upperbound:
	x_bay + x_bay_prem <= 0.35 * x_LPH;

# storeline mix: upper bound
subject to store_upperbound:
	x_store <= 0.35 * x_LPH;

# DE mix: upper bound
subject to DE_upperbound:
	x_DE <= 0.35 * x_LPH;
	
# GP mix: upper bound
subject to GP_upperbound:
	x_GP <= 0.35 * x_LPH;
	
# CS mix: lower bound
subject to CS_lowerbound:
	x_CS >= 0.2 * x_CC;	

# WW mix: lower bound
subject to WW_lowerbound:
	x_WW >= 0.2 * x_CC;	
	
# PF mix: lower bound
subject to PF_lowerbound:
	x_PF >= 0.2 * x_CC;	
	
# CS mix: upper bound
subject to CS_upperbound:
	x_CS <= 0.35 * x_CC;	

# WW mix: upper bound
subject to WW_upperbound:
	x_WW <= 0.35 * x_CC;	
	
# PF mix: upper bound
subject to PF_upperbound:
	x_PF <= 0.35 * x_CC;	
	
# Appearance's sake: 70% or less single family home could be two story units
subject to appearance:
	x_trump + x_trump_lake + x_vand + x_vand_lake + x_GC + x_GC_prem + x_LO + x_WR
	+ x_bay + x_bay_prem + x_store <= (x_GE + x_GWC + x_LPH) * 0.7;
	
# affordable housing must be at least 15% of total
subject to affordable:
	x_GP + x_WW + x_PF >= x_total * 0.15;









