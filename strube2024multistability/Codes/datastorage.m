function datastorage(...
    datastoragedirectory,ReproductionInputs,SimulationData)

%==========================================================================
%% CODE DESCRIPTION
%==========================================================================
%
%   This function stores the user-inputted run conditions and resulting 
%   simulation data into a .mat file that can be used to either generate
%   figures from stored data or by resimulating the data from stored run
%   conditions. 
%
%
%   INPUTS:
%   -------
%   datastoragedirectory: The filepath for the directory in which to store
%                         the data structure constructed by this function. 
%   ReproductionInputs  : Data structure contain the model and simulation
%                         parameter necessary to reproduce the stored data.
%                         Created via
%   SimulationData      : Data structure containing the following data
%                         arrays. (dim: mxn, each)
%                           
%                           Limit-Cycle Heat Map Data
%                           Heat_SDataArray     : Susceptible Population
%                           Heat_IDataArray     : Infectious Population
%                           Heat_TDataArray     : Total (WD) Population
%                           Heat_DFDataArray    : Total (DF) Population
%
%                           Average Population Heat Map Data
%                           Average_SDataArray  : Susceptible Population               
%                           Average_IDataArray  : Infectious Population           
%                           Average_TDataArray  : Total (WD) Population          
%                           Average_DFDataArray : Total (DF) Population
% 
%                           Long-time Trajectory Data 
%                           (transients discarded)
%                           Orbit_SDataArray    : Susceptible Population 
%                           Orbit_IDataArray    : Infectious Population  
%                           Orbit_DFDataArray   : Total (DF) Population                     
%
%   Note:
%       m = quantity of bifurcation parameter 1 increments
%       n - quantity of bifurcation parameter 2 increments
%
%       Each element in the above arrays corresponds to a bifurcation
%       parameter pair. 
%
%   OUTPUTS:
%   --------
%   .mat file named with the run date and time and stored in the directory:
%
%                   *_NewData
%
%
%   DEPENDENCIES:
%   -------------
%   None
%
%   USED BY:
%   --------
%   *_driver.m
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
%
%--------------------------------------------------------------------------
%==========================================================================
%% START CODE
%==========================================================================

%% CREATE ARRAY DESCRIPTIONS STRUCTURE
    ArrayDescriptions.ViewInitialConditions='Contains a labeled list of baseline initial conditions for this run';
    ArrayDescriptions.ViewParameters='Contains a labeled list of baseline parameter values for this run';
    ArrayDescriptions.NameOfFirstBifurcationParameter='y-axis bifurcation parameter';
    ArrayDescriptions.NameOfSecondBifurcationParameter='x-axis bifurcation parameter';
    ArrayDescriptions.FirstBifurcationParameterRange='[start,increment size, end]';
    ArrayDescriptions.SecondBifurcationParameterRange='[start, increment size, end]';
    ArrayDescriptions.ReproductionInputs= 'Structure containing the run conditions for reproducing the heat map data arrays and underlying orbit maps';
    ArrayDescriptions.Heat_SDataArray='dim:[bif1increm x bif2increm] Contains the cycle-size data for the Susceptible population heat map from this run';
    ArrayDescriptions.Heat_IDataArray='dim:[bif1increm x bif2increm] Contains the cycle-size data for the Infected population heat map from this run';
    ArrayDescriptions.Heat_TDataArray='dim:[bif1increm x bif2increm] Contains the cycle-size data for the Total population heat map from this run';
    ArrayDescriptions.Heat_DFDataArray='dim:[bif1increm x bif2increm] Contains the cycle-size data for the Disease-Free population heat map from this run';
    ArrayDescriptions.Orbit_SDataArray='dim:[bif1increm x bif2increm x retainedtime] Contains the long-time trajectory data underlying the Susceptible population heat map from this run. (if available)';
    ArrayDescriptions.Orbit_IDataArray='dim:[bif1increm x bif2increm x retainedtime] Contains the long-time trajectory data underlying the Infected population heat map from this run (if available)';
    ArrayDescriptions.Orbit_DFDataArray='dim:[bif1increm x bif2increm x retainedtime] Contains the long-time trajectory data underlying the Disease-Free population heat map from this run (if available)';
    ArrayDescriptions.Average_SDataArray='dim:[bif1increm x bif2increm] Contains the average Susceptible population size for each bifurcation parameter pair in this run (if available)';
    ArrayDescriptions.Average_IDataArray='dim:[bif1increm x bif2increm] Contains the average Infected population size for each bifurcation parameter pair in this run (if available)';
    ArrayDescriptions.Average_TDataArray='dim:[bif1increm x bif2increm] Contains the average Total population size for each bifurcation parameter pair in this run (if available)';
    ArrayDescriptions.Average_DFDataArray='dim:[bif1increm x bif2increm] Contains the average Disease-Free population size for each bifurcation parameter pair in this run (if available)';


%% CREATE DATA STRUCTURE
    D.RunName=ReproductionInputs.RunName;
    D.RunDate=ReproductionInputs.RunDate;
    D.LatexRunDate=ReproductionInputs.LatexRunDate;
    D.RunDescription=ReproductionInputs.RunDescription;
    D.ArrayDescriptions=ArrayDescriptions;

    for i=1:1:length(ReproductionInputs.BaselineInitialConditions)
        D.ViewBaselineInitialConditions{i,1}=ReproductionInputs.InitialConditionNames(i);
        D.ViewBaselineInitialConditions{i,2}=ReproductionInputs.BaselineInitialConditions(i);
    end
    
    for i=1:1:length(ReproductionInputs.BaselineParameterValues)
        D.ViewBaselineParameters{i,1}=ReproductionInputs.ParameterNames(i);
        D.ViewBaselineParameters{i,2}=ReproductionInputs.BaselineParameterValues(i);
    end
    D.NameOfFirstBifurcationParameter=ReproductionInputs.NameOfFirstBifurcationParameter;
    D.NameOfSecondBifurcationParameter=ReproductionInputs.NameOfSecondBifurcationParameter;
    D.FirstBifurcationParameterRange=ReproductionInputs.FirstBifurcationParameterIncrements;
    D.SecondBifurcationParameterRange=ReproductionInputs.SecondBifurcationParameterIncrements;
    D.ReproductionInputs=ReproductionInputs;
    D.Heat_SDataArray=SimulationData.HS;
    D.Heat_IDataArray=SimulationData.HI;
    D.Heat_TDataArray=SimulationData.HT;
    D.Heat_DFDataArray=SimulationData.HSDF;
    
    % Note: To conserve storage space, this function does not save the underlying full trajectory data for these runs
    % "Orbit" structures contain data from the "EquilibriumTimeStepsToRetain" time steps post-"TransientTimeStepsToDiscard".
    % "Average" structures contain the trajectory average of the "AverageCalculationTimeSteps" post-"TransientTimeStepsToDiscard"

    D.Orbit_SDataArray=SimulationData.S ; 
    D.Orbit_IDataArray=SimulationData.I;   
    D.Orbit_DFDataArray=SimulationData.S_DF;                      
    D.Average_SDataArray=SimulationData.Savg;                 
    D.Average_IDataArray=SimulationData.Iavg;               
    D.Average_TDataArray=SimulationData.Tavg;              
    D.Average_DFDataArray=SimulationData.SDFavg;           
    
%% STORE DATA FILE

    filepath=split(ReproductionInputs.RunName,{'/','\'});
    save(fullfile(datastoragedirectory,filepath{:}),'D')
end

%==========================================================================
%% END CODE
%==========================================================================