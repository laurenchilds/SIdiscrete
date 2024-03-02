% newrunspecification_prompt.m

%==========================================================================
%% SCRIPT DESCRIPTION
%==========================================================================
%   This script allows users to enter their preferred data generation
%   conditions in response to command line prompts. If desired, data 
%   generation conditions may be entered manually by editing the script:
%   
%               newrunspecifications_noprompt.m
%
%   INPUTS:
%   -------
%
%   User responses to command line prompts
%
%   OUTPUTS:
%   --------
%
%   The model parameters and algorithm parameters necessary for data
%   simulation. 
%
%
%   DEPENDENCIES:
%   -------------
%   None
%
%
%   USED BY: 
%   ---------
%   strube2024infection_driver.m
%   batchinputs_create.m
%   
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
%
%
%% ------------------------------------------------------------------------
%==========================================================================
%% START SCRIPT
%==========================================================================

%% (A) COLLECT THE CURRENT TIME
    %Format: 'yyyymmddTHHMMSS' Ex: 20170224T121533
    currenttime = datestr(clock,30); 
    
%% (B) FORMAT THE CURRENT TIME INTO A USABLE FORMAT: 
    %For file names: 
    date = [currenttime(1:4),'_',currenttime(5:6),'_',...
        currenttime(7:8),'_',currenttime(10:11),'_',...
        currenttime(12:13),'_',currenttime(14:15),'_00'];
    
    %For figure titles
    latexdate =strcat([currenttime(1:4),'\_',currenttime(5:6),'\_',....
        currenttime(7:8),'\_',currenttime(10:11),'\_',...
        currenttime(12:13),'\_',currenttime(14:15)],'\_00');

%% (C) USER PROMPT: OPTIONAL RUN DESCRIPTION

    fprintf('\n\nStored data and figures will be labeled with the time stamp: %s',strcat(date))
    
    %-----Prompt-----% 
    usercatch=0;
    while usercatch==0
        descriptionchoice=input('\n\nWould you like to record a run description? (Y=1/N=0) > ');
        if (descriptionchoice==0)||(descriptionchoice==1)
            usercatch=1;
        else
            fprintf('Invalid entry. Please try again.\n')
        end
    end
    %----------------%
    
    if descriptionchoice==1
        rundescription=input('Enter a brief description here: > ','s');
    elseif descriptionchoice==0
        rundescription='none';
    end
    
%% (D) USER PROMPT: PARAMETER VALUES?
    %(I) Construct an Array of Parameter Names
        ParameterNames=[
            "r",...     %p(1)
            "b",...     %p(2)
            "d",...     %p(3)
            "w",...     %p(4)
            "beta",...  %p(5)
            "mu"];      %p(6)

    %(II)Set Baseline Parameter Values 
        r = exp(4);     %p(1)
        b = 0.1;        %p(2)
        d = 0.5;        %p(3)
        w = 1;          %p(4)
        beta = 0.056;   %p(5)
        mu = 0;         %p(6)
    
    %(III) Construct A Parameter Vector
            
        p = [r b d w beta mu]'; %Dimensions (rows,columns)=(6,1)
    
    %(IV) Display Baseline Parameter Values
        fprintf(['\n','This code uses the following baseline parameters:','\n'])   
            
            fprintf('(01) %s = %.4f\n',     ParameterNames(1),p(1))
            fprintf('(02) %s = %.4f\n',     ParameterNames(2),p(2))
            fprintf('(03) %s = %.4f\n',     ParameterNames(3),p(3))
            fprintf('(04) %s = %.4f\n',     ParameterNames(4),p(4))
            fprintf('(05) %s = %.4f\n',     ParameterNames(5),p(5))
            fprintf('(06) %s = %.4f\n',     ParameterNames(6),p(6))

    %(V) User Prompt: Update Parameters?
        %Always prompt.
        paramcorrect=0; 
        while paramcorrect==0
            %(a) User prompt: Is a change in parameter value desired?
            
                %-----Prompt-----% 
                usercatch=0;
                while usercatch==0
                    paramchange=input('Would you like to change any of them? (Y=1/N=0) > ' );
                    if (paramchange==0)||(paramchange==1)
                        usercatch=1;
                    else
                        fprintf('Invalid entry. Please try again.\n')
                    end
                end
                %---------------%

                if paramchange==0
                    paramcorrect=1;
                end
        
            %(b) User prompt: What new parameter value?
                while paramchange==1
                    %-----Prompt-----% 
                    usercatch=0;
                    while usercatch==0
                        paramindex=input('Enter the index of the parameter you would like to change: > ');
                        if any([1:1:6]==paramindex) 
                            usercatch=1;
                        else
                            fprintf('Invalid entry. Please try again.\n')
                        end
                    end
                    %---------------%

                    fprintf('The current value of %s is %d.\n',ParameterNames(paramindex),p(paramindex))
                    paramvalue=input(sprintf('Enter a new value for the parameter %s : > ',ParameterNames(paramindex)));
                    p(paramindex)=paramvalue;
                 
                    
                    %-----Prompt-----% 
                    usercatch=0;
                    while usercatch==0
                        paramchange=input('Would you like to change another parameters? (Y=1/N=0) > ' );
                        if paramchange==0||paramchange==1
                            usercatch=1;
                        else
                            fprintf('Invalid entry. Please try again.\n')
                        end
                    end
                    %---------------%
                    
                end
                

            %(c) User Prompt: Verify updated parameters
                if paramcorrect == 0
                    fprintf(['The updated parameters are:','\n']) 
                        fprintf('(01) %s = %.4f\n',ParameterNames(1),p(1))
                        fprintf('(02) %s = %.4f\n',ParameterNames(2),p(2))
                        fprintf('(03) %s = %.4f\n',ParameterNames(3),p(3))
                        fprintf('(04) %s = %.4f\n',ParameterNames(4),p(4))
                        fprintf('(05) %s = %.4f\n',ParameterNames(5),p(5))
                        fprintf('(06) %s = %.4f\n',ParameterNames(6),p(6))
                    
                    %-----Prompt-----% 
                    usercatch=0;
                    while usercatch==0
                        paramcorrect=input('Is this correct? (Y=1/N=0) > ' );
                        if (paramcorrect==0)||(paramcorrect==1)
                            usercatch=1;
                        else
                            fprintf('Invalid entry. Please try again.\n')
                        end
                    end
                    %----------------%
                end
        end

        
%% (E) USER PROMPT: INITIAL CONDITIONS?

    %(I) Construct an Array of Initial Condition Names
        InitialConditionNames=[
            "S0",...
            "I0"];

    %(II) Set Baseline Initial Conditions
        Sinit = 150;
        Iinit = 20;

    %(III) Construct an Initial Conditions Vector
        x=[Sinit,Iinit]'; %Dimensions (rows,columns) = (2,1)
      
    %(IV) Display Baseline Initial-Condition Values
        fprintf('\n')
        fprintf('This code uses the following initial conditions:\n')            
            fprintf('(1) %s = %.4f\n', InitialConditionNames(1),x(1))
            fprintf('(2) %s = %.4f\n', InitialConditionNames(2),x(2))
        
        fprintf(...
            'Which leads to a total population of %.0f individuals. \n',...
            sum([x(1) x(2)]))

    %(V) User Prompt: Update Initial Conditions?
        %Always prompt.
        initcorrect=0; 
        while initcorrect==0
            %(a) User prompt: Change an initial condition?
                initchange=input('Would you like to change any of them? (Y=1/N=0) > ' );
                if initchange==0
                    initcorrect=1;
                end
        
            %(b) User prompt: What new initial condition?
                while initchange==1
                    totalpopulation=input('Enter a desired total population size: >');
                        x(2)=input('Enter a new infected individual count:> ');
                        x(1) = totalpopulation-x(2); 
                        fprintf('%s is now set to: %0.f.\n',InitialConditionNames(1),x(1))
                        fprintf('%s is now set to: %0.f.\n',InitialConditionNames(2),x(2))
                        initchange=0;
                
            %(c) User Prompt: Verify updated initial conditions
                    if initcorrect == 0
                        fprintf('The updated initial conditions are:\n')           
                            fprintf('(1) %s = %.4f\n', InitialConditionNames(1),x(1))
                            fprintf('(2) %s = %.4f\n', InitialConditionNames(2),x(2))
                
                        %-----Prompt-----% 
                        usercatch=0;
                        while usercatch==0
                            initcorrect=input('Is this correct? (Y=1/N=0) > ' );
                            if initcorrect==0||initcorrect==1
                                usercatch=1;
                            else
                                fprintf('Invalid entry. Please try again.\n')
                            end
                        end
                        %---------------%
    
                    end %End: Initial condition verification
                end %End: Initial condition change prompts
        end %End: Initial condition selection
            
%% (F) USER PROMPT: BIFURCATION PARAMETER CHOICES
    %(I) Display Parameter Names and Indices
        fprintf(['\n','Given the following parameters:','\n'])

            fprintf('(01) %s\n',ParameterNames(1))
            fprintf('(02) %s\n',ParameterNames(2))
            fprintf('(03) %s\n',ParameterNames(3))
            fprintf('(04) %s\n',ParameterNames(4))
            fprintf('(05) %s\n',ParameterNames(5))
            fprintf('(06) %s\n',ParameterNames(6))
            fprintf('(07) %s\n',InitialConditionNames(1))
            fprintf('(08) %s\n',InitialConditionNames(2))

    %(II) User Prompt: Select Desired Bifurcation Parameters
    
        %-----Prompt-----% 
        usercatch=0;
        while usercatch==0
            fprintf('Enter the indices of your desired bifurcation parameters: \n')
            bifpar1=input('First Bifurcation Parameter:> ');
            bifpar2=input('Second Bifurcation Parameter:> ');

            if any([1:1:8]==bifpar1)&& any([1:1:8]==bifpar2) 
                usercatch=1;
            else
                fprintf('Invalid entry. Please try again.\n')
            end
        end
        %---------------%

    %(III) Select Bifurcation Parameter Names for File Storage
    
        %(a) Construct an array of possible bifurcation parameter names 
            Names={ParameterNames{:},InitialConditionNames{:}};
            
        %(b) Extract bifurcation parameter names for file storage
            bp1=Names{bifpar1};
            bp2=Names{bifpar2};
            
    %(III) Select the Desired Bifurcation Parameter Increments
        %Vectors of bifurcation parameter increments are constructed in part 7 below.
        fprintf('You have chosen %s and %s as your bifurcation parameters. \n',bp1,bp2)
        fprintf('IMPORTANT: Parameter incrementation vectors must include at least two elements. (i.e. start and stop must be distinct values) \n')
        increm1=input('Enter the desired increments for the first bifurcation parameter: [start,size,stop]> ');
        increm2=input('Enter the desired increments for the second bifurcation parameter: [start,size,stop]> ');

        bp1i = increm1(1):increm1(2):increm1(3); 
        sz1 = size(bp1i,2); %qty of increments
   
        bp2i = increm2(1):increm2(2):increm2(3); 
        sz2 = size(bp2i,2); %qty of increments
    
%% (G) USER PROMPT: ROUNDING ACCURACY
    fprintf('\nWhen constructing the heat map,\n')
    fprintf('equilibria are considered distinct if they are identical (with rounding) to the nth decimal place.\n')
    accuracy=input('Enter your desired value of n. (recommended: 7) > ');

%% (H) HEAT MAP BINNING
    fprintf('\n');
    fprintf('This code generates heat maps depicting limit cycle size as a function of parameters.\n')
    fprintf('Limit cycle sizes above a threshold are binned together.\n')
    lc = input('What is your desired limit cycle threshold size? (recommended: 16) > ');

%% (I) USER PROMPT: SIMULATION TIMES?
    fprintf('\n');
    fprintf('This code simulates the system for a user-defined quantity of time steps which are then discarded as transients.\n')
    fprintf('Further simulation is then used to generate the orbit maps and hydra-effect diagrams.\n')
    timetoequil = input('Enter the desired quantity of "transient" simulation time steps: (recommended: 10,000) > ');
    timeatequil = input('How many time steps would you like to use in the generation of the orbit maps? (recommended: 48) > ');
    avgtime=input('How many time steps would you like to use in the population average calculations? (recommended: 2,000) > ');

%==========================================================================
%% END SCRIPT
%==========================================================================