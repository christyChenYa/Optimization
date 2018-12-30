

#parameter
param M = 999999999; 

# decision variables
var x_total >= 0;
var x_GE >= 0;
var x_GWC >= 0;
var x_LPH >= 0;
var x_CC >= 0;
## GRAND ESTATES
var x_trump >= 0;
var x_trump_lake >= 0; # each of the Grand Estate series plans must have at least 8 units on the lake
var x_vand >= 0;
var x_vand_lake >= 0;
var x_hughes >= 0;
var x_hughes_lake >= 0;
var x_jack >= 0;
var x_jack_lake >= 0;
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

var y_GE binary; # GE sells more than CC = 1; 0 otherwise
var y_GWC binary;  # GWC sells more than CC = 1; 0 otherwise
var y_LPH binary;  # LPH sells more than CC = 1; 0 otherwise

var t_1 >= 0; # additional tax to be paid if CC sells more than GE 
var t_2 >= 0; # additional tax to be paid if CC sells more than GWC 
var t_3 >= 0; # additional tax to be paid if CC sells more than LPH 
var CC_tax >= 0; # total tax amount for Country condo. Created to linearize the objective function

var trump_lake_eight binary; # if trump has 8 units or more on the lake = 1; 0 otherwise
var vand_lake_eight binary; # if vanderbuilt has 8 units or more on the lake = 1; 0 otherwise
var hughes_lake_eight binary; # if hughes has 8 units or more on the lake = 1; 0 otherwise
var jackson_lake_eight binary; # if jackson has 8 units or more on the lake = 1; 0 otherwise

var recreation binary; # to build recreation complex or not
var a_1 >= 0; # additional $$$ from Grand Estate when recreation is built
var a_2 >= 0; # additional $$$ from Glen wood when recreation is built
var a_3 >= 0; # additional $$$ from LPH when recreation is built
var a_4 >= 0; # additional $$$ from CC when recreation is built
var rt_1 >= 0; # additional tax to be paid if CC sells more than GE and a recreational complex is built
var rt_2 >= 0; # additional tax to be paid if CC sells more than GWC and a recreational complex is built
var rt_3 >= 0; # additional tax to be paid if CC sells more than LPH and a recreational complex is built

 
# objective
maximize profit:
	a_1 + (0.22-0.08) * (x_trump_lake * 960 + x_trump * 700 + x_vand_lake * 934 + x_vand * 680 
	+ x_hughes_lake * 895 + x_hughes * 650 + x_jack_lake * 817 + x_jack * 590)
	+ a_2 + (0.18-0.08) * (x_GC * 420 + x_GC_prem * 460 + x_LO * 380 + x_WR * 320 + x_orange * 280)
	+ a_3 + (0.2-0.08) * (x_bay * 300 + x_bay_prem * 330 + x_store * 270 + x_DE * 240 + x_GP * 200)
	+ a_4 + 0.25 * (x_CS * 220  + x_WW * 160 + x_PF * 140) - CC_tax - recreation * 8000;

# New constraints

# Comparing the sells of GE to CC, if GE Sells more, y_GE = 1, 0 otherwise
subject to rank_CC_GE_1:
	x_GE >= x_CC - M*(1-y_GE);

subject to rank_CC_GE_2:
	x_GE <= x_CC +M*y_GE;

# Comparing the sells of GWC to CC, if GE Sells more, y_GE = 1, 0 otherwise
subject to rank_CC_GWC_1:
	x_GWC >= x_CC - M*(1-y_GWC);

subject to rank_CC_GWC_2:
	x_GWC <= x_CC +M*y_GWC;

# Comparing the sells of LPH to CC, if GE Sells more, y_GE = 1, 0 otherwise
subject to rank_CC_LPH_1:
	x_LPH >= x_CC - M*(1-y_LPH);

subject to rank_CC_LPH_2:
	x_LPH <= x_CC +M*y_LPH;
	
# CCTAX is the total amount of tax paid from the CC product line. This constraint is used to linearize cc_tax in objective function. Assuming 8% tax is taken, then if CC ranks higher in the product line, t_1, t_2 or t_3 amount of tax will be returned. 
subject to CCTAX:
	CC_tax = 0.08* (x_CS * 220  + x_WW * 160 + x_PF * 140) - t_1 - t_2 - t_3;

# If GE Sells more than CC, t_1 will be 2% of the total revenue of CC
subject to t1_1:
	t_1 <= (1 - y_GE) * M;

subject to t1_2:
	t_1 <= 0.02 * (x_CS * 220  + x_WW * 160 + x_PF * 140);

# If GWC Sells more than CC, t_2 will be 2% of the total revenue of CC
subject to t2_1:
	t_2 <= (1 - y_GWC) * M;

subject to t2_2:
	t_2 <= 0.02 * (x_CS * 220  + x_WW * 160 + x_PF * 140);

# If LPH Sells more than CC, t_3 will be 2% of the total revenue of CC
subject to t3_1:
	t_3 <= (1 - y_LPH) * M;

subject to t3_2:
	t_3 <= 0.02 * (x_CS * 220  + x_WW * 160 + x_PF * 140);
	
#At least three of the Grand Estate series plan must have at least eight units on the lake
subject to three_Grand_Estate:
trump_lake_eight + vand_lake_eight+ hughes_lake_eight+jackson_lake_eight >= 3;

#number of The Trump on the lake more than eight
subject to trump_eight_1:
x_trump_lake >= 8 - M*(1 - trump_lake_eight);

subject to trump_eight_2:
8 >= x_trump_lake - M*trump_lake_eight;

#number of The Vanderbilt on the lake more than eight
subject to vand_eight_1:
x_vand_lake >= 8 - M*(1 - vand_lake_eight);

subject to vand_eight_2:
8 >= x_vand_lake - M*vand_lake_eight;

#number of The Hughes on the lake more than eight
subject to hughes_eight_1:
x_hughes_lake >= 8 - M*(1 - hughes_lake_eight);

subject to hughes_eight_2:
8 >= x_hughes_lake - M*hughes_lake_eight;

#number of The Jackson on the lake more than eight
subject to jackson_eight_1:
x_jack_lake >= 8 - M*(1 - jackson_lake_eight);

subject to jackson_eight_2:
8 >= x_jack_lake - M*jackson_lake_eight;

# Additional profit if the recreational complex is built.
# linearize recreation * grand estates revenue
subject to a_11:
	a_1 <= recreation * M;
	
subject to a_12: # the 0.92 takes into account the 8% luxury tax
	a_1 <= 0.92 * 0.05 * (x_trump_lake * 960 + x_trump * 700 + x_vand_lake * 934 + x_vand * 680 
	+ x_hughes_lake * 895 + x_hughes * 650 + x_jack_lake * 817 + x_jack * 590);

# linearize recreation * glen wood revenue
subject to a_21:
	a_2 <= recreation * M;
	
subject to a_22:
	a_2 <= 0.92 * 0.03 * (x_GC * 420 + x_GC_prem * 460 + x_LO * 380 + x_WR * 320 + x_orange * 280);

# linearize recreation * lakeview revenue
subject to a_31:
	a_3 <= recreation * M;

subject to a_32:
	a_3 <= 0.92 * 0.02 * (x_bay * 300 + x_bay_prem * 330 + x_store * 270 + x_DE * 240 + x_GP * 200);

# linearize recreation * country condominium revenue
subject to a_41:
	a_4 <= recreation * M;
	
subject to a_42: # the rt_1, rt_2, rt_3 applies the same logic as the t_1, t_2, t_3 luxury tax section from above
	a_4 <= 0.92 * 0.03 * (x_CS * 220  + x_WW * 160 + x_PF * 140) + rt_1 + rt_2 + rt_3;

# If GE Sells more than CC, rt_1 will be 2% of the additional revenue of CC from the recreational complex
subject to rt1_1:
	rt_1 <= (1 - y_GE) * M;

subject to rt1_2:
	rt_1 <= 0.02 * 0.03 * (x_CS * 220  + x_WW * 160 + x_PF * 140);

# If GWC Sells more than CC, rt_2 will be 2% of the additional revenue of CC from the recreational complex
subject to rt2_1:
	rt_2 <= (1 - y_GWC) * M;

subject to rt2_2:
	rt_2 <= 0.02 * 0.03 * (x_CS * 220  + x_WW * 160 + x_PF * 140);

# If LPH Sells more than CC, rt_3 will be 2% of the additional revenue of CC from the recreational complex
subject to rt3_1:
	rt_3 <= (1 - y_LPH) * M;

subject to rt3_2:
	rt_3 <= 0.02 * 0.03 * (x_CS * 220  + x_WW * 160 + x_PF * 140);



# Original Constraints
# total number of properties is the sum of all properties
subject to total:
	x_total = x_GE + x_GWC+ x_LPH + x_CC;
	
subject to grand_estate:
	x_GE = x_trump_lake + x_trump + x_vand_lake + x_vand + x_hughes_lake + x_hughes
	+ x_jack_lake + x_jack;

subject to glen_wood:
	x_GWC = x_GC + x_GC_prem + x_LO + x_WR + x_orange;
	
subject to lakeview_patio:
	x_LPH = x_bay + x_bay_prem + x_store + x_DE + x_GP;
	
subject to condos:
	x_CC = x_CS  + x_WW + x_PF;

# available land to build properties on
subject to land:
	(x_trump_lake + x_trump) * 23180 + (x_vand_lake + x_vand + x_hughes_lake + x_hughes) * 22980
	+ (x_jack_lake + x_jack) * 22780 + x_GC * 6150 + x_GC_prem * 12090 + (x_LO + x_bay) * 5756
	+ (x_WR + x_orange + x_store + x_DE) * 5556 + x_bay_prem * 8660 + x_GP * 5356
	+ x_CS * 3100 + (x_WW + x_PF) * 2900 <= (300 - 10*recreation) * 43560;

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
	
# Appearance's sake
subject to appearance:
	x_trump + x_trump_lake + x_vand + x_vand_lake + x_GC + x_GC_prem + x_LO + x_WR
	+ x_bay + x_bay_prem + x_store <= (x_GE + x_GWC + x_LPH) * 0.7;

