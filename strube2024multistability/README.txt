# strube2024multistability 

# Code created by L. Strube (LFstrube@gmail.com) for the reproduction of data and figures in:

#	LF Strube and LM Childs. Multistability in a discrete-time SI epidemic model with Ricker growth: 
	Infection-induced changes in population dynamics. Contemporary Mathematics. 793, 167:190 (2024).

# and for the generation of manuscript figure types using custom model parameterization and numeric settings.

# These code versions developed and tested using MATLAB 2023a and 2023b.

directorystructure
------------------
Code/						                : Directory of MATLAB codes and scripts necessary for strube2024multistability_driver.m function
Data/						                : Empty Directory - Location for storage of data files that are available by request. See Notes 1 and 2 below.
strube2024multistability_NewFigures/	    			: Empty directory for storage of new figures. See Note 3 below.
strube2024multistability_NewData/				: Empty directory for storage of new data. See Note 3 below.
strube2024multistability_generateallfigures			: Wrapper script. Generates all manuscript figures via automated calls to strube2024infection_driver.m within a 								  single for-loop without command-line prompts. See Note 4 below.
strube2024multistability_driver.m				: Driver script. Prints prompts to the command line. Push "run" to get started for all data and figure 									  creation. Custom simulation options available. See Note 4 below.
License.txt                                     		: GNU General Public License, Version 03, 2007
Example.txt							: Describes prompt responses necessary to generate Figure 02a via a custom run using 											  strube2024multistability_driver.m

Notes:

(1) Data Files: 
Lightweight data files containing run conditions are provided on GitHub for the generation of manuscript figures via model simulation. The full data files are available by request from L. Strube (LFstrube@gmail.com). These "by-request" files may be used to generate figures from stored data without simulation.

(2) Data available by request: 
For a list of data files available by request please see: Code/strube2024multistability_filepaths

(3) Automated Data and Figure Storage:
Custom simulations, (Prompt 1, Option 2 in strube2024multistability_driver.m), will generate lightweight data files containing only run condition information. Due to the risk of accidentally storing large data files or large quantities of figure files, code functionality for the automated storage of simulation data and figures has been commented out of strube2024multistability_driver.m. Interested users may uncomment this code (sections 15 and 16) but should be sure they understand the memory requirements prior to using automated storage. 

(4) Documentation:
Each of the provided functions, including strube2024multistability_driver.m and strube2024multistability_generateallfigures.m, contain detailed descriptions of their functionality. Additionally, each data array in the "Data" and "LightData" directories is annotated internally. 

For convenience, the document Code/README.txt includes synopsis descriptions of all MATLAB codes used directly or indirectly when running strube2024multistability_driver.m or strube2024multistability_generateallfigures. With the exception of growthforms.m, the codes in the Code/ dirctory do not run independently without properly formatted inputs.


