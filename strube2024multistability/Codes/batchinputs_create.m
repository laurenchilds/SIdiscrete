function storagepath=batchinputs_create(datastoragedirectory)

%==========================================================================
%% SCRIPT DESCRIPTION
%==========================================================================
% This script prompts the user to enter desired run conditions for a series
% data simulations, each producing m x n arrays of data, in which the 
% values of some number of model parameters or initial conditions are set
% using Latin Hypercube sampling. 
%
%   INPUTS:
%   -------
%   Command line responses to user prompts
%
%   OUTPUTS:
%   --------
%   Stored array: Batch_YYYY_MM_DD_HH_MM_SS_00_strube2024infection_*_*.m
%   *=name of parameters varied using Latin Hypercube sampling
%
%   DEPENDENCIES:
%   -------------
%   newrunspecification_prompt.m
%
%   USED BY:
%   --------
%   *_driver.m
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
%
%% ------------------------------------------------------------------------
%==========================================================================
%% START SCRIPT
%==========================================================================
%% (01) COLLECT THE CURRENT TIME AND FORMAT IT FOR USE IN FILE STORAGE

    %Format: 'yyyymmddTHHMMSS' Ex: 20170224T121533
    currenttime = datestr(clock,30); 
    
    %For file names: 
    captureddate = [currenttime(1:4),'_',currenttime(5:6),'_',...
        currenttime(7:8),'_',currenttime(10:11),'_',...
        currenttime(12:13),'_',currenttime(14:15),'_00'];

    %For figure titles
    latexdate =strcat([currenttime(1:4),'\_',currenttime(5:6),'\_',....
        currenttime(7:8),'\_',currenttime(10:11),'\_',...
        currenttime(12:13),'\_',currenttime(14:15)],'\_00');

%% (02) CONSTRUCT THE FILE PATH FOR STORAGE OF BATCH RUN SPECIFICATION .MAT FILE

    filename=strcat('Batch_',captureddate,'_strube2024infection');

%% (03) USER PROMPT: HOW MANY RUNS IN THE BATCH

fprintf('\n\n This script will guide you in the set-up of a batch run of data simulations.')
qtyruns=input('\n How many distinct run conditions would you like to specify?> ');

%% (04) CREATE ARRAY DESCRIPTIONS STRUCTURE
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

%% (05) INITIALIZE BATCH RUN SPECIFICATIONS DATA STRUCTURE

    % Initialize
    BatchRun=struct();

    % These fields will contain the same content for all individual runs:
    BatchRun.BatchDate=[];
    BatchRun.BatchName=[];
    BatchRun.LatexBatchDate=[];
    BatchRun.BatchDescription=[];
    BatchRun.LHSSeed=[];
    BatchRun.LHSRange=[];

    % These fields will contain auto-generated content
    BatchRun.LHSSpecs=[];

    % Individual simulation specifications will be stored "D" data 
    % structures for compatibility with single-run figure
    % generation scripts. 

    BatchRun.D.RunName=[];
    BatchRun.D.RunDate=[];
    BatchRun.D.LatexRunDate=[];
    BatchRun.D.RunDescription=[];
    BatchRun.D.ArrayDescriptions=[];
    BatchRun.D.ViewBaselineInitialConditions=[];
    BatchRun.D.ViewBaselineParameters=[];
    BatchRun.D.NameOfFirstBifurcationParameter=[];
    BatchRun.D.NameOfSecondBifurcationParameter=[];
    BatchRun.D.FirstBifurcationParameterRange=[];
    BatchRun.D.SecondBifurcationParameterRange=[];
    BatchRun.D.ReproductionInputs=[];
    BatchRun.D.Heat_SDataArray=[];
    BatchRun.D.Heat_IDataArray=[];
    BatchRun.D.Heat_TDataArray=[];
    BatchRun.D.Heat_DFDataArray=[];
    BatchRun.D.Orbit_SDataArray=[]; 
    BatchRun.D.Orbit_IDataArray=[];   
    BatchRun.D.Orbit_DFDataArray=[];                      
    BatchRun.D.Average_SDataArray=[];   
    BatchRun.D.Average_IDataArray=[];               
    BatchRun.D.Average_TDataArray=[];              
    BatchRun.D.Average_DFDataArray=[];  

    % Reproduction Conditions
    BatchRun.D.ReproductionInputs.RunName=[];
    BatchRun.D.ReproductionInputs.RunDate=[];
    BatchRun.D.ReproductionInputs.LatexRunDate=[];
    BatchRun.D.ReproductionInputs.RunDescription=[];
    BatchRun.D.ReproductionInputs.InitialConditionNames=[];
    BatchRun.D.ReproductionInputs.ParameterNames=[];
    BatchRun.D.ReproductionInputs.BaselineInitialConditions=[];
    BatchRun.D.ReproductionInputs.BaselineParameterValues=[];
    BatchRun.D.ReproductionInputs.IndexOfFirstBifurcationParameter=[];
    BatchRun.D.ReproductionInputs.IndexOfSecondBifurcationParameter=[];
    BatchRun.D.ReproductionInputs.NameOfFirstBifurcationParameter=[];
    BatchRun.D.ReproductionInputs.NameOfSecondBifurcationParameter=[];
    BatchRun.D.ReproductionInputs.FirstBifurcationParameterIncrements=[];
    BatchRun.D.ReproductionInputs.SecondBifurcationParameterIncrements=[];
    BatchRun.D.ReproductionInputs.RoundingAccuracy=[];
    BatchRun.D.ReproductionInputs.LimitCycleThreshold=[];
    BatchRun.D.ReproductionInputs.TransientTimeStepsToDiscard=[];
    BatchRun.D.ReproductionInputs.EquilibriumTimeStepsToRetain=[];
    BatchRun.D.ReproductionInputs.AverageCalculationTimeSteps=[];

%% (06) INITIALIZE THE DATA STRUCTURE SIZE

for i=1:1:qtyruns
    BatchRun(i).BatchDescription=[];
end

%% (07) SHOW USER DATA STRUCTURE
fprintf('\nYour run choices will be stored in the following data structure:\n')
fprintf('\nPress the spacebar to view.\n')
pause

% Lack of semi-colons is intentional
BatchRun
D=BatchRun(1).D
ReproductionInputs=BatchRun(1).D.ReproductionInputs

clear ReproductionInputs D

fprintf('\n Press any key to continue.')
pause

%% (08) PROMPT USER TO SET THE BASELINE RUN CONDITIONS

% Repeat baseline run conditions loop until user confirms that the
% entered baseline parameter values are correct. 

continuescript=0;
while continuescript==0 

    fprintf('\n\n STEP 1: DEFINE BASELINE RUN CONDITIONS')
    fprintf('\n (You will have the option of editing individual runs in a later step.)')

    fprintf('\n The following printed time and your provided run description, will be stored as the batch time and description.')

    % This script prompts user to enter baseline run conditions. 
    newrunspecification_prompt;
    
    
    %% (09) STORE BASELINE RUN CONDITIONS

        %These values will be stored at simulation run time
        %BatchRun.D.RunName=[];
        %BatchRun.D.RunDate=[];
        %BatchRun.D.LatexRunDate=[];

        %This value will be stored below
        %BatchRun.D.RunDescription=[];


        BatchRun(1).D.ArrayDescriptions=ArrayDescriptions;

        for i=1:1:length(x)
            BatchRun(1).D.ViewBaselineInitialConditions{i,1}=InitialConditionNames(i);
            BatchRun(1).D.ViewBaselineInitialConditions{i,2}=x(i);
        end
        
        for i=1:1:length(p)
            BatchRun(1).D.ViewBaselineParameters{i,1}=ParameterNames(i);
            BatchRun(1).D.ViewBaselineParameters{i,2}=p(i);
        end

        BatchRun(1).D.NameOfFirstBifurcationParameter=bp1;
        BatchRun(1).D.NameOfSecondBifurcationParameter=bp2;
        BatchRun(1).D.FirstBifurcationParameterRange=increm1;
        BatchRun(1).D.SecondBifurcationParameterRange=increm2;

        %These values will be stored at simulation run time
        %BatchRun(1).D.ReproductionInputs.RunName=[];
        %BatchRun(1).D.ReproductionInputs.RunDate=[];
        %BatchRun(1).D.ReproductionInputs.LatexRunDate=[];
        %BatchRun(1).D.ReproductionInputs.RunDescription=[];

        BatchRun(1).D.ReproductionInputs.InitialConditionNames=InitialConditionNames;
        BatchRun(1).D.ReproductionInputs.ParameterNames=ParameterNames;
        BatchRun(1).D.ReproductionInputs.BaselineInitialConditions=x;
        BatchRun(1).D.ReproductionInputs.BaselineParameterValues=p;
        BatchRun(1).D.ReproductionInputs.IndexOfFirstBifurcationParameter=bifpar1;
        BatchRun(1).D.ReproductionInputs.IndexOfSecondBifurcationParameter=bifpar2;
        BatchRun(1).D.ReproductionInputs.NameOfFirstBifurcationParameter=bp1;
        BatchRun(1).D.ReproductionInputs.NameOfSecondBifurcationParameter=bp2;
        BatchRun(1).D.ReproductionInputs.FirstBifurcationParameterIncrements=increm1;
        BatchRun(1).D.ReproductionInputs.SecondBifurcationParameterIncrements=increm2;
        BatchRun(1).D.ReproductionInputs.RoundingAccuracy=accuracy;
        BatchRun(1).D.ReproductionInputs.LimitCycleThreshold=lc;
        BatchRun(1).D.ReproductionInputs.TransientTimeStepsToDiscard=timetoequil;
        BatchRun(1).D.ReproductionInputs.EquilibriumTimeStepsToRetain=timeatequil;
        BatchRun(1).D.ReproductionInputs.AverageCalculationTimeSteps=avgtime;
    
    %% (10) PRINT THE USER-SPECIFIED MODEL PARAMETERS TO THE COMMAND LINE
        fprintf('\n\nThe following initial conditions and model parameters were specified: \n')
        fprintf('%s = %.4f\n',      InitialConditionNames(1),x(1))
        fprintf('%s = %.4f\n',      InitialConditionNames(2),x(2))
        fprintf('%s = %.4f\n',      ParameterNames(1),p(1))
        fprintf('%s = %.4f\n',      ParameterNames(2),p(2))
        fprintf('%s = %.4f\n',      ParameterNames(3),p(3))
        fprintf('%s = %.4f\n',      ParameterNames(4),p(4))
        fprintf('%s = %.4f\n',      ParameterNames(5),p(5))    
        fprintf('%s = %.4f\n',      ParameterNames(6),p(6))
    
    %% (11) PRINT THE USER-SPECIFIED RUN CONDITIONS TO THE COMMAND LINE
        fprintf('\nThe following run conditions were specified: \n')
        fprintf('Bifurcation parameter 1: %s = [%.4f:%.4f:%.4f]\n', bp1,increm1(1),increm1(2),increm1(3))
        fprintf('Bifurcation parameter 2: %s = [%.4f:%.4f:%.4f]\n', bp2,increm2(1),increm2(2),increm2(3))
        fprintf('Rounding Accuracy: %.0f\n',accuracy)
        fprintf('Limit cycle count threshold: %.0f\n',lc)
        fprintf('Simulation burn-in: %.0f\n',timetoequil)
        fprintf('Quantity of retained time-steps: %.0f\n',timeatequil)
        fprintf('Quantity of post burn-in time steps used in average population size calculations: %.0f\n',avgtime)
    
    %% (12) USER PROMPT: ARE THE STORED BASELINE VALUES CORRECT? 
    
    baselinecorrect=input('\n Are these values correct? Y=1/N=0 > ');
    
    if baselinecorrect == 1
        continuescript=1;
    else
        fprintf('\n\n RESTARTING ENTRY OF BASELINE RUN CONDITIONS\n\n')
    end
end

%% (13) COPY BASELINE VALUES ACROSS DATA STRUCTURE ENTRIES

for i=2:1:qtyruns
    BatchRun(i)=BatchRun(1);
end

%% (14) SELECT PARAMETERS TO CHANGE FOR INDIVIDUAL RUNS

    fprintf('\n\n STEP 2: DEFINE INDIVIDUAL RUN CONDITIONS')
    fprintf('\n\n  You now have the option to specify individual run \n')
    fprintf('conditions by perturbing model parameters from their baseline\n')
    fprintf('values using Latin Hypercube sampling of a specified region \n')
    fprintf('of parameter space.\n')

    fprintf('\n\n Which of the following parameters would you like to\n')
    fprintf('\n vary across individual runs in this batch?\n\n')
    fprintf('(01) %s\n',ParameterNames(1))
    fprintf('(02) %s\n',ParameterNames(2))
    fprintf('(03) %s\n',ParameterNames(3))
    fprintf('(04) %s\n',ParameterNames(4))
    fprintf('(05) %s\n',ParameterNames(5))
    fprintf('(06) %s\n',ParameterNames(6))
    fprintf('(07) %s\n',InitialConditionNames(1))
    fprintf('(08) %s\n',InitialConditionNames(2))

    ChoiceNames=[ParameterNames,InitialConditionNames];
   
    % #ToDo: Add an input error check
    batchparameters=input('Enter your choices as a row vector. Do not use previously specified bifurcation parameters. > ');

    fprintf('\n\n For each model parameter, specify the range of parameter space you would like to sample.')

    for i=1:1:length(batchparameters)
        sprintf('Parameter: %s',ChoiceNames(batchparameters(i)))
        Range(i,:)= input('Enter your choices using the form [min,max] > ');
    end
        
    
%% (15) USE LATIN HYPERCUBE SAMPLING TO RANDOMLY ASSIGN PARAMETER VALUES

    % Use Latin Hypercube Sampling to generate a set of random parameter values
    RangeSize=Range(:,2)-Range(:,1);

    rng default % for reproducibility
    LHS=lhsdesign(qtyruns,length(batchparameters));
    
    for i=1:1:length(batchparameters)

        % Do not round model parameters
        if batchparameters<7 
            ParameterValues(:,i)=RangeSize(i)*LHS(:,i); 

        % Round initial conditions to the nearest integer    
        elseif batchparameters>6 
             ParameterValues(:,i)=round(RangeSize(i)*LHS(:,i));
        end

    end
    
    % Update Run Conditions
    for i=1:1:qtyruns
        newparams=ParameterValues(i,:);
        param=BatchRun(i).D.ReproductionInputs.BaselineParameterValues;
        initcond=BatchRun(i).D.ReproductionInputs.BaselineInitialConditions;
        runparameters=[param; initcond];
        
        for j=1:1:length(batchparameters)
            runparameters(batchparameters(j))=ParameterValues(i,j);
        end

        BatchRun(i).D.ReproductionInputs.BaselineParameterValues=runparameters(1:6);
        BatchRun(i).D.ReproductionInputs.BaselineInitialConditions=runparameters(7:8);
    end

%% (16) RECORD LHS PARAMETERS AND VALUES TO THE DATA STRUCTURE

    for i=1:1:qtyruns
        for j=1:1:length(batchparameters)
            BatchRun(i).LHSRange.(ChoiceNames(batchparameters(j)))=[Range(j,1),Range(j,2)];
            BatchRun(i).LHSSpecs.(ChoiceNames(batchparameters(j)))=ParameterValues(i,j);
        end
    end

%% (17) WRITE INDIVIDUAL RUN DESCRIPTIONS USING RUN-SPECIFIC PARAMETER VALUES

for i=1:1:qtyruns
    for j=1:1:length(batchparameters)
        singledescription{j}=sprintf('%s = %.4f, ', ChoiceNames{batchparameters(j)},ParameterValues(i,j));
    end
    BatchRun(i).D.ReproductionInputs.RunDescription=sprintf('Batch run simulation %.0f of %.0f: %s',i,qtyruns,strcat(singledescription{:}));
    BatchRun(i).D.RunDescription=sprintf('Batch run simulation %.0f of %.0f: %s',i,qtyruns,strcat(singledescription{:}));
end

%% (18) RECORD REMAINING BATCH RUN SPECIFICATIONS

    for i=1:1:qtyruns
        for j=1:1:length(batchparameters)
            batchdescription{j}=sprintf('_%s ', ChoiceNames{batchparameters(j)});
        end
        
        BatchRun(i).BatchDate=captureddate;
        BatchRun(i).BatchName=strcat(filename,batchdescription{:});
        BatchRun(i).LatexBatchDate=latexdate;
        BatchRun(i).BatchDescription=rundescription;
        BatchRun(i).LHSSeed='default';

    end

%% (19) STORE BATCH RUN SPECIFICATIONS
    B=BatchRun;
    storagepath=fullfile(datastoragedirectory,strcat(BatchRun(1).BatchName,'_light'));
    save(storagepath,'B')

end

%==========================================================================
%% END SCRIPT
%==========================================================================