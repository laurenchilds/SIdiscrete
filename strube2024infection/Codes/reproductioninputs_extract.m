% reproductioninputs_extract.m 

%==========================================================================
%%  SCRIPT DESCRIPTION
%==========================================================================
%   Extracts simulation conditions from a data structure "PrevReproduce
%   created by either
%   
%                   reproductioninputs_storage.m
%                   datastorage.m
%
%   and necessary for reproduction of stored data. It also prints the these
%   simulation conditions to the command line for viewing. 
%
%
%   INPUTS:
%   -------
%   reproducefile   : data filepath 
%
%   OUTPUTS:
%   --------
%   InitialConditionNames   : Vector of initial condition names
%   ParameterNames          : Vector of parameter names
%   x                       : Vector of baseline initial conditions
%   p                       : Vector of baseline parameter values
%   bifpar1                 : Index of first bifurcation parameter
%   bifpar2                 : Index of second bifurcation parameter
%   bp1                     : Name of first bifurcation parameter 
%   bp2                     : Name of second bifurcation parameter
%   increm1                 : Values for the construction of bpl1 (below)
%   increm2                 : Values for the construction of bpl2 (below)
%   accuracy                : Threshold for comparison of trajectory values
%   lc                      : Value of highest recorded limit cycle size
%   timetoequil             : Qty of transient trajectory steps to discard
%   timeatequil             : Qty of long-time trajectory steps to retain
%   avgtime                 : Qty of long-time trajectory steps to be
%                               used in the calculation of average 
%                               trajectory values.
%   bp1i                    : Vector of first bif. parameter increments 
%   sz1                     : Quantity of first bif. parameter increments
%   bp2i                    : Vector of second bif. parameter increments
%   sz2                     : Quantity of second bif. parameter increments
%
%
%   DEPENDENCIES: 
%   -------------
%   None
%
%   USED BY: 
%   ---------
%   strube2024infection_driver.m
%   
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
%
%% ------------------------------------------------------------------------
%==========================================================================
%% START SCRIPT
%==========================================================================

%% (I) PRINT DESCRIPTION OF REPRODUCTION RUN TO THE COMMAND LINE 
    rundescription=ReproductionInputs.RunDescription;
    fprintf('\nDescription:')
    fprintf('%s',rundescription)

%% (II) EXTRACT RUN CONDITIONS 
    date=ReproductionInputs.RunDate;
    latexdate=ReproductionInputs.LatexRunDate;
    InitialConditionNames=ReproductionInputs.InitialConditionNames;
    ParameterNames=ReproductionInputs.ParameterNames;
    x=ReproductionInputs.BaselineInitialConditions;
    p=ReproductionInputs.BaselineParameterValues;
    bifpar1=ReproductionInputs.IndexOfFirstBifurcationParameter;
    bifpar2=ReproductionInputs.IndexOfSecondBifurcationParameter;
    bp1=ReproductionInputs.NameOfFirstBifurcationParameter;
    bp2=ReproductionInputs.NameOfSecondBifurcationParameter;
    increm1=ReproductionInputs.FirstBifurcationParameterIncrements;
    increm2=ReproductionInputs.SecondBifurcationParameterIncrements;
    accuracy=ReproductionInputs.RoundingAccuracy;
    lc=ReproductionInputs.LimitCycleThreshold;
    timetoequil=ReproductionInputs.TransientTimeStepsToDiscard;
    timeatequil=ReproductionInputs.EquilibriumTimeStepsToRetain;
    avgtime=ReproductionInputs.AverageCalculationTimeSteps;

    bp1i = increm1(1):increm1(2):increm1(3); 
    sz1 = size(bp1i,2); %qty of increments

    bp2i = increm2(1):increm2(2):increm2(3); 
    sz2 = size(bp2i,2); %qty of increments

%% (III) PRINT MODEL PARAMETERS TO THE COMMAND LINE
    fprintf('\n\nThe following initial conditions and model parameters were used to generate the desired figure: \n')
    fprintf('%s = %.4f\n',      InitialConditionNames(1),x(1))
    fprintf('%s = %.4f\n',      InitialConditionNames(2),x(2))
    fprintf('%s = %.4f\n',      ParameterNames(1),p(1))
    fprintf('%s = %.4f\n',      ParameterNames(2),p(2))
    fprintf('%s = %.4f\n',      ParameterNames(3),p(3))
    fprintf('%s = %.4f\n',      ParameterNames(4),p(4))
    fprintf('%s = %.4f\n',      ParameterNames(5),p(5))    
    fprintf('%s = %.4f\n',      ParameterNames(6),p(6))

%% (IV) PRINT RUN CONDITIONS TO THE COMMAND LINE
    fprintf('\nThe following run conditions were used to generate the desired figure: \n')
    fprintf('Bifurcation parameter 1: %s = [%.4f:%.4f:%.4f]\n', bp1,increm1(1),increm1(2),increm1(3))
    fprintf('Bifurcation parameter 2: %s = [%.4f:%.4f:%.4f]\n', bp2,increm2(1),increm2(2),increm2(3))
    fprintf('Rounding Accuracy: %.0f\n',accuracy)
    fprintf('Limit cycle count threshold: %.0f\n',lc)
    fprintf('Simulation burn-in: %.0f\n',timetoequil)
    fprintf('Quantity of retained time-steps: %.0f\n',timeatequil)
    fprintf('Quantity of post burn-in time steps used in average population size calculations: %.0f\n',avgtime)

%==========================================================================
%% END SCRIPT
%==========================================================================