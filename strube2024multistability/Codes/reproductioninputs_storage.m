function storagepath=reproductioninputs_storage(datastoragedirectory,ReproductionInputs)

%==========================================================================
%% CODE DESCRIPTION
%==========================================================================
%
%   This function stores the user-inputted run conditions into a lightweight
%   .mat file that can be used to generate figures by resimulating the data 
%   from stored run conditions. 
%
%   INPUTS:
%   -------
%   ReproductionInputs  : Data structure contain the model and simulation
%                         parameter necessary to reproduce the stored data.
%                         Created via reproductioninputs_create.m                   
%
%
%   OUTPUTS:
%   --------
%   .mat file named with the run date and time and stored in the directory:
%
%                   strube2024infection_NewData
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

    D.Heat_SDataArray=[];
    D.Heat_IDataArray=[];
    D.Heat_TDataArray=[];
    D.Heat_DFDataArray=[];
    D.Orbit_SDataArray=[]; 
    D.Orbit_IDataArray=[];   
    D.Orbit_DFDataArray=[];                      
    D.Average_SDataArray=[];                 
    D.Average_IDataArray=[];               
    D.Average_TDataArray=[];              
    D.Average_DFDataArray=[];   
    
%% STORE DATA FILE
    
    storagepath=strcat(ReproductionInputs.RunName,'_light.mat');
    storagepath=fullfile(datastoragedirectory,storagepath);
    save(fullfile(storagepath),'D')

end

%==========================================================================
%% END CODE
%==========================================================================