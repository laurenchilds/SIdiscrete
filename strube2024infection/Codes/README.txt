#strube2024infection/Codes


Files:
------
averagepopulationplot.m

   	This function generates a heat map describing the long-time average 
   	population size over an array of bifurcation parameter values.

batchinputs_create.m
	This script prompts the user to enter desired run conditions for a series
	data simulations, each producing m x n arrays of data, in which the 
	values of some number of model parameters or initial conditions are set
	using Latin Hypercube sampling. 

calculatehydra.m
	This function calculates the degree of infection-induces hydra effect 
	of the system at each of element of a two-dimensional array of 
	bifurcation parameters.

	It allows the user to specify the numerical threshold at which to
	define the presence of an infection-induced hydra effect and returns
	three arrays: one for the construction of qualitative hydra-effect plot
	measured on a linear scale, one for the construction of a qualitative 
	hydra-effect plot measured on a fold-change scale, and one for a binary 
	hydra-effect plot.

cyclesizeanalyzer.m
	This function analyzes arrays of simulation data produced by
	datagenerator.m by calculating the limity-cycle size of the system
	corresponding to each specified bifurcation parameter pair for the 
	purpose of constructing two-parameter heat maps. It allows the user to 
	specify the degree of accuracy to use when comparing trajectory values 
	(for the purpose of quantifying the limit cycle size) and to specify 
	the limit cycle size threshold for the upper heat map bin. 

datagenerator.m
	This function generates an array of simmulation data using the discrete 
	SI model described by Strube et al. in 

	LF Strube, S Elgart, and LM Childs. Infection induced increases
	to population size during cycles in a discrete-time epidemic model. 
	Journal of Mathematical Biology. Vol:Article (2024). 

	for the purpose of construction one-parameter orbit maps, two-parameter 
	heat maps, and hydra effect diagrams. It allows users to specify the 
	system initial conditions and model parameters, the quantity of time 
	steps to be considered transient and discarded, the quantity of time 
	steps to be retained for the construction of orbit and heat maps, and 
	the quantity of time steps to be used in calculating trajectory 
	averages. It also allows users to specify which parameters to use as
	bifurcation parameters, which values of these parameters to use in
	simulations, and whether or not to run the simulations for the array
	using parallel computing. 

datastorage.m
	This function stores the user-inputted run conditions and resulting 
	simulation data into a .mat file that can be used to either generate
	figures from stored data or by resimulating the data from stored run
	conditions.

figuregenerator_manuscript.m
 	This script generates figures from the manuscript

	LF Strube, S Elgart, and LM Childs. Infection induced increases
	to population size during cycles in a discrete-time epidemic model. 
	Journal of Mathematical Biology. Vol:Article (2024). 



figuregenerator_userchoice.m

	This script generates 6 classes of figures:

	(1) Limit-Cycle Size Heat Maps (4 figures)
	(2) Average Population Size Heat Maps (4 figures)
	(3) Orbit Maps (5 fiugures)
	(4) Trajectory Plots (5 figures) 
	(5) Single Initial Condition Hydra Effect Plots (5 figures)
	(6) Batch Initial Condition Hydra Effect Plot (1 figure)

	For classes 1-4: Susceptible, Infectious, Total (With-Disease)
	Population, and Total (Disease-Free) Population Figures aregGenerated.

	For class 3-4: An Absolute Difference figure is generated for the
	comparison of the Total (WD) and Total (DF) populations.

	For class 5, five figures are created:

	(a) Linear-scale Population Growth ("hydra effect threshold = 0")
	(b) Log2 Population Growth ("hydra effect threshold = 0")
	(c) Binary Hydra Effect (Y/N infection-induced population growth)
	(d) Linear-scale Hydra Effect (user choice hyda effect threshold)
	(e) Log2 Hydra Effect (user choice hydra effect threshold)
	
	Depending on user choices in strube2024infection_driver.m, it uses the 
	simulation conditions loaded via one of the following:

               a stored data file
               newrunspecifications_noprompt.m
               newrunspecifications_prompt.m 

  	and figure specifications entered via either:
 
           figurespecifications_prompt.m
           figurespecification_noprompt.m

figurespecifications_noprompt.m
   	This script allows users to enter desired figure specifications 
   	manually to avoid the tedium of command line prompts.


figurespecifications_prompt.m
	This script allows users to enter desired figure specifications 
	in response to command line prompts. 


figurestorage.m
	This script automates the storage of figures currently in the
	workspace. 

filepaths.m
	This takes the user-inputted figchoice index and returns a corresponding
	filepath for a .mat file containing stored run conditions and data for
	figures in the manuscript:
	
	LF Strube, S Elgart, and LM Childs. Infection induced increases
	to population size during cycles in a discrete-time epidemic model. 
	Journal of Mathematical Biology. Vol:Article (2024). 

heatmapplot.m
	This function generates two-parameter heat maps from arrays of
	limit-cycle count data produced using cyclesizeanalyzer.m

	It allows the user to specify the axes labels and figure title and
	returns the resulting figure handle. 

growthfunction.m
	This function allows the user to construct figures illustrating the
	relative behaviors of linear, compensatory, and overcompensatory growth
	form.

hydraeffectplot.m
	This function constructs one of five distinct hydra effect plots
	depending on "plottype" and "threshold":
		(1) Binary Hydra Effect -- with disease population size is or is
		not above the disease-free population by a factor of "threshold". 
		(2) Linear-Scale Hydra Effect -- With-disease population size
		scaled by disease-free population size.
			- with hydra-effect below a threshold graphed in grey scale
			- with all hydra-effect graphed in a colorscale
	   		("threshold"=0).
		(3) Fold-Change Hydra Effect -- Log2 of with-disease population 
		size scaled by disease-free population size.
			- with hydra-effect below a threshold graphed in grey scale
			- with all hydra-effect graphed in a colorscale
			("threshold"=0).

	It allows users to enter a figure title, axis and colorbar labels, 
	and returns the figurehandle for the figure.

newrunspecification_noprompt.m

	This script allows users to enter their preferred data generation
	conditions manually. If preferred, these conditions may be entered via
	command line prompts by running the script:

	           newrunspecifications_prompt.m

	To simplify comparison between these two options, this script is 
	structured similarly to newrunspecification_prompt.m. 

	For ease of use, user-customizable inputs are tagged: 

	           #UserInput01, #UserInput02, ... #UserInput08

	so that they may be located using the search function. 

	The provided example generates data using the model parameters
	described in figure 02bc (right) of: 

	LF Strube, S Elgart, and LM Childs. Infection induced increases
	to population size during cycles in a discrete-time epidemic model. 
	Journal of Mathematical Biology. Vol:Article (2024). 
	
	Baseline model parameters are provided in the comments. 


newrunspecification_prompt.m	
	This script allows users to enter their preferred data generation
	conditions in response to command line prompts. If desired, data 
	generation conditions may be entered manually by editing the script:

	             newrunspecifications_noprompt.m

orbitplot.m

	This function generates a one-parameter orbit map with trajectory data 
	in black and averge trajectory in red using three input vectors of
	data.

	It allows the user to specify the axes labels and figure title and
	returns the resulting figure handle. 

reproductioninputs_create.m
	This script stores model parameters and algorithm parameters into the
	"ReproductionInputs" data structure.

reproductioninputs_extract.m	
	Extracts simulation conditions from a data structure "PrevReproduce
	created by either
		
		reproductioninputs_storage.m
		datastorage.m

	and necessary for reproduction of stored data. It also prints the these
	simulation conditions to the command line for viewing. 

reproductioninptus_storage.m

	This function stores the user-inputted run conditions into a .mat file 
	that can be used to generate figures by resimulating the data from 
	stored run conditions. 

trajectoryplot.m

	This function plots a single trajectory with user-supplied legend, axis
	label, and title text.

trajectorysimulator.m

	This function simulates a single trajectory of the discrete SI model 
	described by Strube et al. in 

	LF Strube, S Elgart, and LM Childs. Infection induced increases
	to population size during cycles in a discrete-time epidemic model. 
	Journal of Mathematical Biology. Vol:Article (2024). 

	It takes user-specified initial conditions, model parameters, and total
	time steps and returns trajectories for the susceptible, infectious,
	and total with-disease populations as well as the trajectory for the 
	corresponding disease-free system. 
