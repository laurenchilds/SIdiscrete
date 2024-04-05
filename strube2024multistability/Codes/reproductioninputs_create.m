%reproductioninputs_create.m

%==========================================================================
%% SCRIPT DESCRIPTION
%==========================================================================
%
%  This script stores model parameters and algorithm parameters into the
%  "ReproductionInputs" data structure.
%
%   INPUTS:
%   -------
%   Variables previously entered into the workspace by the user or
%   strube2024infection_driver.m script:
%
%   filename
%   date
%   latexdate
%   rundescription
%   InitialConditionNames
%   ParameterNames
%   x
%   p
%   bifpar1
%   bifpar2
%   bp1
%   bp2
%   increm1
%   increm2
%   accuracy
%   lc
%   timetoequil
%   timeatequil
%   avgtime
%
%   See "ReproductionInputs" field names below for descriptions of each
%   variable.
%
%   OUTPUTS:
%   -------
%   ReproductionInputs: Data Structure
%
%   DEPENDENCIES:
%   -------------
%   *_driver.m (Creates the workspace variables)
%
%   USED BY:
%   -------
%   *_driver.m
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
%% ------------------------------------------------------------------------
%==========================================================================
%% SCRIPT START
%==========================================================================

    ReproductionInputs.RunName=filename;                            %(01)
    ReproductionInputs.RunDate=captureddate;                        %(02)
    ReproductionInputs.LatexRunDate=latexdate;                      %(03)
    ReproductionInputs.RunDescription=rundescription;               %(04)
    ReproductionInputs.InitialConditionNames=InitialConditionNames; %(05)
    ReproductionInputs.ParameterNames=ParameterNames;               %(06)
    ReproductionInputs.BaselineInitialConditions=x;                 %(07)
    ReproductionInputs.BaselineParameterValues=p;                   %(08)
    ReproductionInputs.IndexOfFirstBifurcationParameter=bifpar1;    %(09)
    ReproductionInputs.IndexOfSecondBifurcationParameter=bifpar2;   %(10)    
    ReproductionInputs.NameOfFirstBifurcationParameter=bp1;         %(11)
    ReproductionInputs.NameOfSecondBifurcationParameter=bp2;        %(12)
    ReproductionInputs.FirstBifurcationParameterIncrements=increm1; %(13)
    ReproductionInputs.SecondBifurcationParameterIncrements=increm2;%(14)
    ReproductionInputs.RoundingAccuracy=accuracy;                   %(15)
    ReproductionInputs.LimitCycleThreshold=lc;                      %(16)
    ReproductionInputs.TransientTimeStepsToDiscard=timetoequil;     %(17)
    ReproductionInputs.EquilibriumTimeStepsToRetain=timeatequil;    %(18)
    ReproductionInputs.AverageCalculationTimeSteps=avgtime;         %(19)

%==========================================================================
%% SCRIPT END
%==========================================================================