% newrunspecification_noprompt.m

%==========================================================================
%% SCRIPT DESCRIPTION
%==========================================================================
%   This script allows users to enter their preferred data generation
%   conditions manually. If preferred, these conditions may be entered via
%   command line prompts by running the script:
%   
%               newrunspecifications_prompt.m
%
%   To simplify comparison between these two options, this script is 
%   structured similarly to newrunspecification_prompt.m. 
% 
%   For ease of use, user-customizable inputs are tagged: 
%    
%            #UserInput01, #UserInput02, ... #UserInput08
%
%   so that they may be located using the search function. 
%
%   The provided example generates data using the model parameters
%   described in figure 02bc (right) of: 
%
%       LF Strube, S Elgart, and LM Childs. Infection induced increases
%       to population size during cycles in a discrete-time epidemic model. 
%       Journal of Mathematical Biology. Vol:Article (2024). 
%
%   Baseline model parameters are provided in the comments. 
%
%   INPUTS:
%   -------
%
%   Hard coded run specifications entered by the user below
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
%   
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
%
%% ------------------------------------------------------------------------
%==========================================================================
%% START SCRIPT
%==========================================================================

%% (A) COLLECT AND FORMAT THE CURRENT TIME
    %Format: 'yyyymmddTHHMMSS' Ex: 20170224T121533
    currenttime = datestr(clock,30); 
    
    %For file names: 
    %The '00' prevents overwriting when running batch simulations

    date = [currenttime(1:4),'_',currenttime(5:6),'_',...
            currenttime(7:8),'_',currenttime(10:11),'_',...
            currenttime(12:13),'_',currenttime(14:15),'_00'];
    
    %For figure titles
    latexdate =strcat([currenttime(1:4),'\_',currenttime(5:6),...
        '\_',currenttime(7:8),'\_',currenttime(10:11),'\_',...
        currenttime(12:13),'\_',currenttime(14:15)],'\_00');


%% (B) RUN DESCRIPTION ( #UserInput01 )
    rundescription='Enter a brief description here.';
    
%% (C) PARAMETER VALUES (User Input 02)
    %(I) Construct an Array of Parameter Names
        ParameterNames=[
            "r",...     %p(1)
            "b",...     %p(2)
            "d",...     %p(3)
            "w",...     %p(4)
            "beta",...  %p(5)
            "mu"];      %p(6)

    %(II) #UserInput02 -- Set Baseline Parameter Values
        r = 260;        %p(1) default: exp(4)
        b = 0.1;        %p(2) default: 0.1
        d = 0.21;       %p(3) default: 0.5
        w = 1;          %p(4) default: 1
        beta = 0.056;   %p(5) default: 0.056
        mu = 0;         %p(6) default 0
    
    %(III) Construct A Parameter Vector
            
        p = [r b d w beta mu]'; %Dimensions (rows,columns)=(6,1)
    

%% (E) INITIAL CONDITIONS? (User Input 03)

    %(I) Construct an Array of Initial Condition Names
        InitialConditionNames=[
            "S0",...
            "I0"];

    %(II) #UserInput03 --  Baseline Initial Conditions 
        Sinit = 60;     % x(1) default: 150
        Iinit = 20;     % x(2) default: 20

    %(III) Construct an Initial Conditions Vector
        x=[Sinit,Iinit]'; %Dimensions (rows,columns) = (2,1)
     
            
%% (F) BIFURCATION PARAMETER CHOICES (User Input 04 and 05)
    %(I) Parameter Names and Indices
            %(01) r
            %(02) b
            %(03) d
            %(04) beta
            %(05) w
            %(06) u
            %(07) S0
            %(08) I0

    %(II) #UserInput04 -- Select Desired Bifurcation Parameters
        % Enter the desured parameter indices from the list above

        bifpar1=4;  % default: 1 (i.e. r)
        bifpar2=6;  % default: 3 (i.e. d) 

    %(III) Select Bifurcation Parameter Names for File Storage
    
        %(a) Construct an array of possible bifurcation parameter names 
            Names={ParameterNames{:},InitialConditionNames{:}};
            
        %(b) Extract bifurcation parameter names for file storage
            bp1=Names{bifpar1};
            bp2=Names{bifpar2};
            
    %(III) Select the Desired Bifurcation Parameter Increments
        
        %(a) #UserInput05 -- Enter your desired bifurcation parameter increments

            %'IMPORTANT: Start and stop values must be distinct
            increm1= [0,0.001,1];   %Format: [start,size,stop]; Default (for r): [0,0.5,320]; (i.e. 641 values in [0:0.5:320])
            increm2= [0,0.001,1];   %Format: [start,size,stop]; Default (for d): [0,0.001,1]; (i.e. 1001 values in [0:0.001:1])

        %(b) Construct vector of bifurcation parameeter values
            bp1i = increm1(1):increm1(2):increm1(3); 
            sz1 = size(bp1i,2); %qty of increments
       
            bp2i = increm2(1):increm2(2):increm2(3); 
            sz2 = size(bp2i,2); %qty of increments
    
%% (G) ROUNDING ACCURACY ( #UserInput 06 )
    %When constructing the heat map,
    %equilibria are considered distinct if they are identical (with rounding) to the nth decimal place

    %Enter your desired value of n. (recommended: 7)
    accuracy=7; % default: 7

%% (H) HEAT MAP BINNING ( #UserInput07 )
    % This code generates heat maps depicting limit cycle size as a function of parameters.
    % Limit cycle sizes above a threshold are binned together.

    % What is your desired limit cycle threshold size? (recommended: 16) 
    lc = 16; % default: 16

%% (I) SIMULATION TIMES? ( #UserInput08 )
    %This code simulates the system for a user-defined quantity of time steps which are then discarded as transients.
    %Further simulation is then used to generate the orbit maps and hydra-effect diagrams.

    %Enter the desired quantity of "transient" simulation time steps: (recommended: 10,000)
    timetoequil = 10000; % default: 10,000

    %How many time steps would you like to use in the generation of the orbit maps? (recommended: 48)
    timeatequil = 48; % default: 48

    %How many time steps would you like to use in the population average calculations? (recommended: 2,000)
    avgtime=2000; % default 2000

%==========================================================================
%% START SCRIPT
%==========================================================================