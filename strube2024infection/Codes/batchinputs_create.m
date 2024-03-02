function storagepath=batchinputs_create

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
%   strube2024infection_driver.m
%   Necessary for production of batch run hydra effect figures such as 
%   Figure 04a and 04b in:
%
%       LF Strube, S Elgart, and LM Childs. Infection induced increases
%       to population size during cycles in a discrete-time epidemic model. 
%       Journal of Mathematical Biology. Vol:Article (2024). 
%
%
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
%
%% ------------------------------------------------------------------------
%==========================================================================
%% START SCRIPT
%==========================================================================
%% COLLECT THE CURRENT TIME AND FORMAT IT FOR USE IN FILE STORAGE

    %Format: 'yyyymmddTHHMMSS' Ex: 20170224T121533
    currenttime = datestr(clock,30); 
    
    %For file names: 
    date = [currenttime(1:4),'_',currenttime(5:6),'_',...
        currenttime(7:8),'_',currenttime(10:11),'_',...
        currenttime(12:13),'_',currenttime(14:15),'_00'];

    %For figure titles
    latexdate =strcat([currenttime(1:4),'\_',currenttime(5:6),'\_',....
        currenttime(7:8),'\_',currenttime(10:11),'\_',...
        currenttime(12:13),'\_',currenttime(14:15)],'\_00');

%% CONSTRUCT THE FILE PATH FOR STORAGE OF BATCH RUN SPECIFICATION .MAT FILE

    directory='strube2024infection_NewData';
    filename=strcat('Batch_',date,'_strube2024infection');

%% USER PROMPT: HOW MANY RUNS IN THE BATCH

fprintf('\n\n This script will guide you in the set-up of a batch run of data simulations.')
qtyruns=input('\n How many distinct run conditions would you like to specify?> ');

%% INITIALIZE BATCH RUN SPECIFICATIONS DATA STRUCTURE

    % Initialize
    BatchRun=struct();

    % These fields will contain the same content for all individual runs:
    BatchRun.BatchName=[];
    BatchRun.BatchDate=[];
    BatchRun.LatexBatchDate=[];
    BatchRun.BatchDescription=[];
    BatchRun.LHSSpecs=[];

    % These fields will contain auto-generated content
    BatchRun.ReproductionInputs.RunName=[];
    BatchRun.ReproductionInputs.RunDate=[];
    BatchRun.ReproductionInputs.LatexRunDate=[];
    BatchRun.ReproductionInputs.RunDescription=[];
    BatchRun.ReproductionInputs.InitialConditionNames=[];
    BatchRun.ReproductionInputs.ParameterNames=[];

    % The contents of these fields will be specified by the user
    BatchRun.ReproductionInputs.BaselineInitialConditions=[];
    BatchRun.ReproductionInputs.BaselineParameterValues=[];
    BatchRun.ReproductionInputs.IndexOfFirstBifurcationParameter=[];
    BatchRun.ReproductionInputs.IndexOfSecondBifurcationParameter=[];
    BatchRun.ReproductionInputs.NameOfFirstBifurcationParameter=[];
    BatchRun.ReproductionInputs.NameOfSecondBifurcationParameter=[];
    BatchRun.ReproductionInputs.FirstBifurcationParameterIncrements=[];
    BatchRun.ReproductionInputs.SecondBifurcationParameterIncrements=[];
    BatchRun.ReproductionInputs.RoundingAccuracy=[];
    BatchRun.ReproductionInputs.LimitCycleThreshold=[];
    BatchRun.ReproductionInputs.TransientTimeStepsToDiscard=[];
    BatchRun.ReproductionInputs.EquilibriumTimeStepsToRetain=[];
    BatchRun.ReproductionInputs.AverageCalculationTimeSteps=[];

%% INITIALIZE THE DATA STRUCTURE SIZE

for i=1:1:qtyruns
    BatchRun(i).BatchDescription=[];
end

%% SHOW USER DATA STRUCTURE
fprintf('\nYour run choices will be stored in the following data structure:\n')

BatchRun
ReproductionInputs=BatchRun.ReproductionInputs;
ReproductionInputs

clear ReproductionInputs

fprintf('\n Press any key to continue.')
pause

%% PROMPT USER TO SET THE BASELINE RUN CONDITIONS

% Repeat baseline run conditions loop until user confirms that the
% entered baseline parameter values are correct. 

continuescript=0;
while continuescript==0 

    fprintf('\n\n STEP 1: DEFINE BASELINE RUN CONDITIONS')
    fprintf('\n (You will have the option of editing individual runs in a later step.)')

    fprintf('\n The following printed time and your provided run description, will be stored as the batch time and description.')

    % This script prompts user to enter baseline run conditions. 
    newrunspecification_prompt;
    
    
    %% STORE BASELINE RUN CONDITIONS
        
        BatchRun(1).ReproductionInputs.BaselineInitialConditions=x;
        BatchRun(1).ReproductionInputs.BaselineParameterValues=p;
        BatchRun(1).ReproductionInputs.IndexOfFirstBifurcationParameter=bifpar1;
        BatchRun(1).ReproductionInputs.IndexOfSecondBifurcationParameter=bifpar2;
        BatchRun(1).ReproductionInputs.NameOfFirstBifurcationParameter=bp1;
        BatchRun(1).ReproductionInputs.NameOfSecondBifurcationParameter=bp2;
        BatchRun(1).ReproductionInputs.FirstBifurcationParameterIncrements=increm1;
        BatchRun(1).ReproductionInputs.SecondBifurcationParameterIncrements=increm2;
        BatchRun(1).ReproductionInputs.RoundingAccuracy=accuracy;
        BatchRun(1).ReproductionInputs.LimitCycleThreshold=lc;
        BatchRun(1).ReproductionInputs.TransientTimeStepsToDiscard=timetoequil;
        BatchRun(1).ReproductionInputs.EquilibriumTimeStepsToRetain=timeatequil;
        BatchRun(1).ReproductionInputs.AverageCalculationTimeSteps=avgtime;
    
    %% PRINT THE USER-SPECIFIED MODEL PARAMETERS TO THE COMMAND LINE
        fprintf('\n\nThe following initial conditions and model parameters were specified: \n')
        fprintf('%s = %.4f\n',      InitialConditionNames(1),x(1))
        fprintf('%s = %.4f\n',      InitialConditionNames(2),x(2))
        fprintf('%s = %.4f\n',      ParameterNames(1),p(1))
        fprintf('%s = %.4f\n',      ParameterNames(2),p(2))
        fprintf('%s = %.4f\n',      ParameterNames(3),p(3))
        fprintf('%s = %.4f\n',      ParameterNames(4),p(4))
        fprintf('%s = %.4f\n',      ParameterNames(5),p(5))    
        fprintf('%s = %.4f\n',      ParameterNames(6),p(6))
    
    %% PRINT THE USER-SPECIFIED RUN CONDITIONS TO THE COMMAND LINE
        fprintf('\nThe following run conditions were specified: \n')
        fprintf('Bifurcation parameter 1: %s = [%.4f:%.4f:%.4f]\n', bp1,increm1(1),increm1(2),increm1(3))
        fprintf('Bifurcation parameter 2: %s = [%.4f:%.4f:%.4f]\n', bp2,increm2(1),increm2(2),increm2(3))
        fprintf('Rounding Accuracy: %.0f\n',accuracy)
        fprintf('Limit cycle count threshold: %.0f\n',lc)
        fprintf('Simulation burn-in: %.0f\n',timetoequil)
        fprintf('Quantity of retained time-steps: %.0f\n',timeatequil)
        fprintf('Quantity of post burn-in time steps used in average population size calculations: %.0f\n',avgtime)
    
    %% USER PROMPT: ARE THE STORED BASELINE VALUES CORRECT? 
    
    baselinecorrect=input('\n Are these values correct? Y=1/N=0 > ');
    
    if baselinecorrect == 1
        continuescript=1;
    else
        fprintf('\n\n RESTARTING ENTRY OF BASELINE RUN CONDITIONS\n\n')
    end
end

%% COPY BASELINE VALUES ACROSS DATA STRUCTURE ENTRIES

for i=2:1:qtyruns
    BatchRun(i)=BatchRun(1);
end

%% SELECT PARAMETERS TO CHANGE FOR INDIVIDUAL RUNS

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
   
    batchparameters=input('Enter your choices as a row vector > ');
    fprintf('\n\n For each model parameter, specify the range of parameter space you would like to sample.')

    for i=1:1:length(batchparameters)
        sprintf('Parameter: %s',ChoiceNames(batchparameters(i)))
        Range(i,:)= input('Enter your choices using the form [min,max] > ');
    end
        
    
%% USE LATIN HYPERCUBE SAMPLING TO RANDOMLY ASSIGN PARAMETER VALUES

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
        param=BatchRun(i).ReproductionInputs.BaselineParameterValues;
        initcond=BatchRun(i).ReproductionInputs.BaselineInitialConditions;
        runparameters=[param; initcond];
        
        for j=1:1:length(batchparameters)
            runparameters(batchparameters(j))=ParameterValues(i,j);
        end

        BatchRun(i).ReproductionInputs.BaselineParameterValues=runparameters(1:6);
        BatchRun(i).ReproductionInputs.BaselineInitialConditions=runparameters(7:8);
    end

%% RECORD LHS PARAMETERS AND VALUES TO THE DATA STRUCTURE

    for i=1:1:qtyruns
        for j=1:1:length(batchparameters)
            BatchRun(i).LHSSpecs.(ChoiceNames(batchparameters(j)))=ParameterValues(i,j);
        end
    end

%% WRITE INDIVIDUAL RUN DESCRIPTIONS USING RUN-SPECIFIC PARAMETER VALUES

for i=1:1:qtyruns
    for j=1:1:length(batchparameters)
        singledescription{j}=sprintf('%s = %.4f, ', ChoiceNames{batchparameters(j)},ParameterValues(i,j));
    end
    BatchRun(i).ReproductionInputs.RunDescription=sprintf('Batch run simulation %.0f of %.0f: %s',i,qtyruns,strcat(singledescription{:}));
end

%% RECORD REMAINING BATCH RUN SPECIFICATIONS

    for i=1:1:qtyruns
        for j=1:1:length(batchparameters)
            batchdescription{j}=sprintf('_%s ', ChoiceNames{batchparameters(j)});
        end
        
        BatchRun(i).BatchName=fullfile(directory,strcat(filename,batchdescription{:}));
        BatchRun(i).BatchDate=date;
        BatchRun(i).LatexBatchDate=latexdate;
        BatchRun(i).BatchDescription=rundescription;
        BatchRun(i).ReproductionInputs.InitialConditionNames=InitialConditionNames;
        BatchRun(i).ReproductionInputs.ParameterNames=ParameterNames;

    end

%% STORE BATCH RUN SPECIFICATIONS
B=BatchRun;
storagepath=BatchRun(1).BatchName;
save(storagepath,'B')
end
