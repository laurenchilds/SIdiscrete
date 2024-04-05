function strube2024infection_driver(varargin)
%==========================================================================
%% CODE DESCRIPTION
%==========================================================================
%
%   IMPORTANT: Due to online storage limitations, the full data files are
%   available by request only. Without these files, manuscript figures must
%   be generated via simulation. 
%
%   If the full data files have been obtained, users may want to update
%   this script to use only the full data files (and not the files 
%   contained in the directory LightData.) Such an update is a simple task. 
%   For instructions search this file for: #DataNote .
%
%--------------------------------------------------------------------------
%
%   This script is the driver of the strube2024infection code set. It is
%   provided for the purpose of reproducing simulations and figures
%   presented in:
%
%       LF Strube and LM Childs. Multistability in a discrete-time SI 
%       epidemic model with Ricker growth: Infection-induced changes in 
%       population dynamics. Contemporary Mathematics. 793, 167:190 (2024). 
%
%   This script presents the user with 4 options via the command line
%   prompts
%
%       (1) To generate manuscript figures from stored simulation data
%
%       (2) To generate manuscript figures by resimulating the underlying 
%           data using stored parameter values.
%
%           [IMPORTANT: This option stores data files to the directory 
%           "strube2024infection_NewData" within the directory containing
%           this script.]
%
%       (3) To perform custom simulations/figure generation with 
%           user-provided model parameters and simulation conditions.
%
%           [IMPORTANT: This option stores data files to the directory 
%           "strube2024infection_NewData" within the directory containing
%           this script.]
%
%       (4) To perform custom figure generation with previously
%           stored, user-provided model parameters and simulation 
%           conditions. 
%
%           This option may also be used to generate additional
%           (non-manuscript) figure types from the stored manuscript data. 
%
%   Additionally, for choice (3) the user may elect to input run and figure
%   specifications via 
%
%                   newrunspecification_noprompt.m
%                   figurespecifications_noprompt.m
%
%   and in doing so avoid the command-line prompts. 
%
%   Finally, this script also includes the option of storing the generated 
%   figures and simulation data using hard coded filenames which include the
%   figure generation date and a short descriptor. However, as the quantity 
%   of figures and data arrays generated by this script can be significant,
%   this portion of the script is commented out. Users interested in this 
%   functionality can uncomment
%
%                       "(15) STORE DATA"
%                       "(16) STORE FIGURES"  
%
%   at the bottom of this script. 
%
%   Additionally, batch simulation files - even when stored using the
%   optional "(15) STORE DATA" described above will only store the total
%   population limit-cycle heat map and average heat map data. Alterations
%   to this behavior can be altered via hardcoding changes to section 09 of
%   this function.
%
%               Copyright (C) 2024 by Laura F. Strube
%
%   This program is free software: you can redistribute it and/or modify 
%   it under the terms of the GNU General Public License as published by
%   the Free Software Foundation, either version 3 of the License, or 
%   (at your option) any later version.
%
%   This program is distributed in the hope that it will be useful, but 
%   WITHOUT ANY WARRANTY; without even the implied warranty of 
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU 
%   General Public License for more details.
%
%    You should have received a copy of the GNU General Public License 
%   along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
%
%   INPUTS:
%   -------
%   - varargin  : Optional inputs as defined in 
%               strube2024multistability_generateall_driver.m and extracted
%               in section 03 of this function
%
%   - User choices as entered at the command line in response to prompts 
%   contained in this function or in the (automatically called) scripts:
%
%       - newrunspecification_prompt.m
%       - batchinputs_create.m
%       - figurespecifications_prompt.m
%  
%   - User choices as manually entered via the scripts
%
%       - newrunspecification_noprompt.m
%       - figurespecifications_noprompt.m
%
%   - .mat files stored in the directory "Data"
%   - .mat files stored in the directory "LightData"
%
%   OUTPUTS:
%   --------
%   - Requested Figures 
%     (optionally stored to strube2024multistability_NewFigures)
%
%   - Light .mat Data files 
%     (if a simulation option is selected, light .mat files are stored to 
%     strube2024multistability_NewData)
%
%   - Full .mat Data files
%     (optionally stored to strube2024multistability_NewData)
%
%   DEPENDENCIES:
%   -------------
%   - All functions and scripts in the directory "Codes" except 
%   growthforms.m
%
%   USED BY:
%   --------
%   strube2024multistability_generateall_driver.m
%
%   NOTE:
%   -----
%   The following .m files are scripts (not functions) and are used to
%   improve code readability for lengthy prompts or prompts which are
%   utilized multiple times throughout the code set. 
%
%   - strube2024multistability_batchfigchoices.m
%   - strube2024multistability_figureoptions.m
%   - strube2024multistability_filepaths.m
%   - strube2024multistability_filepaths_light.m
%   - reproductioninputs_create.m
%   - reproductioninputs_storage.m
%   - reproductioninputs_extract.m
%   - figuregenerator_manuscript.m
%
%
%   QUESTIONS about the strube2024multistability code set? 
%               Email Laura Strube at LFStrube@gmail.com
%
%% ------------------------------------------------------------------------
%==========================================================================
%% START CODE
%==========================================================================

%==========================================================================
%% (01) ADD SUBDIRECTORIES TO MATLAB PATH
%==========================================================================

    addpath('Codes')
    addpath('Data')
    addpath('LightData')
    addpath('strube2024multistability_NewData')

    % Define the following directories relative to directory containing
    % this driver function. 
    datastoragedirectory='strube2024multistability_NewData'; 
    figurestoragedirectory='strube2024multistability_NewFigures';

%==========================================================================
%% (02) CREATE HANDLES FOR MANUSCRIPT-SPECIFIC FUNCTIONS AND SCRIPTS
%==========================================================================
    
    % Indexed list of manuscript figures
    figureoptions='strube2024multistability_figureoptions';

    % Index for the manuscript figure requring batch generation of
    % limit-cycle heatmap data
    batchchoice=12;

    % Index list of data file paths (full data files)
    filepaths=@strube2024multistability_filepaths;

    % Indexed list of data file paths 
    % (light data files - reproduction conditions only - no trajectory data)
    filepaths_light=@strube2024multistability_filepaths_light;

    % Indexed list of figure generation scripts
    figuregenerator_manuscript='strube2024multistability_figuregenerator_manuscript';

    % List of types of figures to be generated in batch runs
    batchfigchoices='strube2024multistability_batchfigchoices';

%==========================================================================
%% (03) SET VALUES FOR RUNS VIA *_generateall_driver.m
%==========================================================================

if nargin>0
    
    % Define input parser to interpret varargin contents
    p=inputParser;
    validfig=@(x) x > 0 && mod(x,1)==0  && x<35;
    validchoice01=@(x) x==0 || x==1;
    validchoice02=@(x) x==1 || x==2;
    validcount=@(x) x>0 && mod(x,1)==0;
    addOptional(p,'FigureReproduction',2,validchoice02) % Default: Simulate from stored run conditions
    addOptional(p,'FigureChoice',1,validfig);           % Default: Figure 02a
    addOptional(p,'Parallelize',0,validchoice01);       % Default: Do not parallelize
    addOptional(p,'WorkerCount',1,validcount);          % Default: 1 worker
    addOptional(p,'StoreFigures',0,validchoice01);      % Default: Do not store figures
    addOptional(p,'StoreData',0,validchoice01);         % Default: Do not store data
    parse(p,varargin{:});

    % Reproduce manuscript figures
    manuscriptreproduction=1;           

    % Options:
    % (1) Generate from stored data
    % (2) Simulate from stored run conditions 
    figurereproduction=p.Results.FigureReproduction;           

    % Index of figure to reproduce
    figchoice=p.Results.FigureChoice;   

    % Parallelize simulations? (Y=1/N=0)
    parallelize=p.Results.Parallelize;  

    % Quantity of Workers for Parallel Processing
    workercount=p.Results.WorkerCount;  % Qty of workers for par. processing

    % Store Figures? (Y=1/N=0)
    storefigures=p.Results.StoreFigures;% Store Figures (Y=1/N=0)

    % Store Data? (Y=1/N=0)
    storedata=p.Results.StoreFigures;% Store Figures (Y=1/N=0)

    % Extract appropriate filepath
    if figurereproduction==1
        reproducefile=filepaths(figchoice);
    elseif figurereproduction==2
        reproducefile=filepaths_light(figchoice);
    end

    % If data is a batch file store to batchpath
    if figchoice==batchchoice
        batchpath=reproducefile;
    end
end
            
%==========================================================================
%% (04) USER PROMPT: REPRODUCE DATA AND FIGURES OR GENERATE NEW DATA
%==========================================================================
if nargin == 0
    
    % Users specifying custom run conditions must confirm permission to store
    % run conditions as a .mat file to escape the "continuescript" while loop.
    continuescript=0; 
    
    while continuescript==0
    
    %(A) USER PROMPT
        fprintf('\nYou have two options:\n')
        fprintf('(1) Reproduce the manuscript data and/or figures from the manuscript\n')
        fprintf('(2) Generate original data and figures\n')
        manuscriptreproduction=input("Enter your selection here >");
    
        if manuscriptreproduction == 1 % Reproduce data and/or figures
            %(B) 0PTION 01: USE MANUSCRIPT DATA 
                
                %(I) User Prompt: Select desired figure
    
                    fprintf('\nYou have the following figure options:\n')
                    
                    eval(figureoptions)
        
                    figchoice=input('Enter your choice > ');
    
                    % if figurereproduction==2 && figchoice==28
                    %     fprintf('This figure choice generates the case (S0,I0)=(180,20)')
                    %     fprintf('For (S0,I0)=(60,20), generate Figure 02e right.')
                    % end
        
                %(II) Option 01b: User Prompt: Use Stored Data or Simulate?
                    fprintf('\n\nYou have two options:')
                    fprintf('\n(1) Generate figures from stored data (Data available by request);')
                    fprintf('\n(2) Simulate data and figures from stored parameters and run conditions;')
                    figurereproduction=input('\nEnter your choice > ');
                    
                %(III) Extract necessary data file
                    if figurereproduction==1
                         
                        reproducefile=filepaths(figchoice);
                         if figchoice==batchchoice
                            batchpath=reproducefile; 
                         end
    
                        if ~isfile(fullfile('Data',strcat(reproducefile,'.mat')))
                            disp(fullfile('Data',reproducefile))
                            fprintf('\nThe data file you requested is not available on github but will be provided upon request. ')
                            fprintf('\nPlease contact Laura Strube: LFStrube@gmail.com.\n ')
                            return
                        end
    
                    elseif figurereproduction==2
                        fprintf('\nNote: This option uses the lightweight .mat files in the directory LightData.')
    
                        % Simulate using conditions stored in "LightData" files
                        % #DataNote: If full data files are available,
                        % simulations can be run using the run conditions
                        % stored in the full data files. If this is
                        % desired, uncomment the following. 


                        % Uncomment the following: 
                        % (Simulate using conditions stored in "Data" files)
                        % reproducefile=strube2024infection_filepaths(figchoice)

                        % And comment the following:
                        % (Simulate using conditions stored in "LightData files)
                        reproducefile=filepaths_light(figchoice);

                        if figchoice==batchchoice
                            batchpath=reproducefile;
                        end
                    end
    
        elseif  manuscriptreproduction ==2 
            %(B) OPTION 02: GENERATE ORIGINAL DATA AND FIGURES
            % To do: Notify user that files constructed in batch runs may not
            % contain the data necessary to run figures from stored data
    
                %(I) User Prompt: Use Stored Data or Simulate
                fprintf('\nYou have two options:\n')
                fprintf('(1) Generate figures from previously stored data;\n')
                fprintf('(2) Simulate new data and figures\n')
    
                    figurenew=input("Enter your selection here >");
        
                % Generate figures from previously stored data
                if figurenew==1
    
                    datatype=input("Is this data a batch file? [File name begins with ''Batch''] (Y=1/N=0) >");
    
                    if datatype ==1 
                        fprintf('\nPlease enter the full name of the .mat file that contains the batch data you would like to use in quotes.\n')
                        batchpath=input('(Tip: shift+right-click to copy file path) > ','s');
                        batchpath=batchpath(2:end-1); %#ok<*LOAD> %remove quote symbols %#ok<LOAD> 
                    else
                        fprintf('\nPlease enter the full name of the .mat file that contains the simulation data you would like to use in quotes.\n')
                        reproducefile=input('(Tip: shift+right-click to copy file path) > ','s');
                        reproducefile=reproducefile(2:end-1); %#ok<*LOAD> %remove quote symbols %#ok<LOAD> 
        
                        %Prompt for figure generation
                        figspecsentry=1;
                    end
    
                %(II) User prompt: Specify run conditions
                elseif figurenew==2
    
                    fprintf('\nYou have three choices.:\n')
                    fprintf('(1) Be prompted to enter your desired simulation conditions for a single run \n')
                    fprintf('(2) Load desired (single run) simulations conditions via the file: newrunspecification_noprompt.m \n')
                    fprintf('(3) Be prompted to enter your desired simulation conditions for a batch run\n')
                    runspecsentry=input("Which option would you prefer? >");
                    
                    % Collect user-specified single run conditions from prompts
                    if runspecsentry==1
    
                        %load appropriate script
                        newrunspecification_prompt;
    
                        %Prompt for figure generation below
                        figspecsentry=1;
    
                    % Collect user-specified run conditions from a file
                    elseif runspecsentry==2
                        %load appropriate script
                        newrunspecification_noprompt;
    
                        fprintf('\nAfter the simulations, you have two options:\n')
                        fprintf('(1) Be prompted to enter your desired figure specifications \n')
                        fprintf('(2) Load desired figure specifications via the file: figurespecifications_noprompt.m \n')
    
                        figspecsentry=input("Which option would you prefer? (1 or 2) >");
    
                    % Collect user-specfied batch run conditions
                    elseif runspecsentry==3
    
                        %load appropriate script 
                        % (automatically stores  light file for batch run 
                        % specifications)
                        batchpath=batchinputs_create(datastoragedirectory); 
    
                        % Do not prompt for figure generation below
                        figspecsentry=0;
                    end
                    
                end % "newchoice" statement
    
        end % "runchoice" statement
    
        %(C) PROMPT USER: CONFIRM CREATION OF DATA TO BE STORED
       
            % Prompt for all choices (above) that involve simulation of new data
            if (manuscriptreproduction==1 && figurereproduction==2) || (manuscriptreproduction==2 && figurenew==2)
                fprintf('\nYou chose to run new simulations. \n')
                fprintf('This will result in the storage of a light data file to the directory "strube2024multistability_NewData" \n')
                fprintf('[Est: 0.001 MB per pair of bifurcation parameter values.]\n')
                promptchoice=input("Do you wish to proceed? Y=1/N=0  >");
                % #Todo: Add an input error check
            
                if promptchoice==1
                    continuescript = 1;
                else
                    return
                end
            end
            
            % Do not prompt for choices (above) that do not involve simulation of new data
            if (manuscriptreproduction==1 && figurereproduction==1) || (manuscriptreproduction==2 && figurenew==1)
                continuescript=1;
            end
    
    end % end "continuescript" while loop

%==========================================================================
%% (05) STORE USER SPECIFICATIONS
%==========================================================================

    % If user requested brand new single-run simulations, store run specifications
    if (manuscriptreproduction==2 && figurenew==2 && runspecsentry ~=3)
    
        % Create a file name
        filename=fullfile(...
            sprintf('%s_strube2024infection',captureddate));
                    
        % Script to create ReproductionInputs
        reproductioninputs_create
    
        % Store ReproductionInputs;
        storagepath=reproductioninputs_storage(datastoragedirectory,ReproductionInputs);
    
        % Retain ReproductionInputs filepath
        reproducefile=strcat(ReproductionInputs.RunName,'_light');
    
    end

%==========================================================================
%% (06) USER PROMPT: PARALLELIZE SIMULATIONS?
%==========================================================================

    if (manuscriptreproduction==1 && figurereproduction==2) || ...          % Simulation of manuscript figures
            (manuscriptreproduction==2 && figurenew==2)                     % Simulation for custom figures
    %(D) USER PROMPT: RUN SIMULATIONS IN PARALLEL? 
        parallelize=input('\nWould you like to use parallel processing (Strongly recommended, requires the Parallel Computing Toolbox) Y=1/N=0 >');
        workercount=0;
        if parallelize==1
            fprintf('To view the quantity of cores available on your machine, escape this code a type:  \n')
            fprintf('evalc(''feature(''''numcores'''')'') in the command line.\n\n')
            workercount=input('How many workers would you like to use?> ');
            fprintf('\nNote: MATLAB will open the parallel pool with the maximum number of workers available on your machine.')
            fprintf('\nHowever, it will only utilize the quantity you specified above.\n\n')
        end
    end
end

%==========================================================================
%% (07) CLEAR UNNECESSARY VARIABLES
%==========================================================================

clearvars -except ...
    batchchoice datastoragedirectory figurestoragedirectory...
    batchfigchoices figureoptions figuregenerator_manuscript...
    manuscriptreproduction figchoice figurereproduction parallelize workercount storefigures storedata...
    continuescript figurenew datatype runspecsentry batchpath figspecsentry reproducefile 

%==========================================================================
%% (08) LOAD BATCH RUN SPECS/DATA
%==========================================================================

% Load Run Specifications File
if (manuscriptreproduction==2 && figurenew==1 && datatype==1) ||...                     % Generation of custom (batch) figures from stored data
        (manuscriptreproduction==2 && figurenew==2 && runspecsentry==3)||...            % Generation of custom (batch) figures via simulation
        (manuscriptreproduction==1 && figchoice==batchchoice)                           % Generation of manuscript (batch) figures

    filepath=split(batchpath,{'/','\'});
    load(fullfile(filepath{:}));
end

%==========================================================================
%% (09) GENERATE AND STORE BATCH RUN DATA
%==========================================================================

if (manuscriptreproduction==1 && figurereproduction==2 && figchoice==batchchoice)||...  % Reproduction of (batch) mansucript figures via simulation
        (manuscriptreproduction== 2 && figurenew==2 && runspecsentry == 3)              % Generation of custom (batch) figures via simulation
        

    for i=1:1:length(B)

        % Collect the Current Time of the Individual Simulation
            %Format: 'yyyymmddTHHMMSS' Ex: 20170224T121533
            currenttime = datestr(clock,30); 
            
        % Format CurrentTime into a Useable File Format
            %For file names: 
            captureddate = [currenttime(1:4),'_',currenttime(5:6),'_',...
                currenttime(7:8),'_',currenttime(10:11),'_',...
                currenttime(12:13),'_',currenttime(14:15),'_00'];
            
            %For figure titles
            latexdate =strcat([currenttime(1:4),'\_',currenttime(5:6),'\_',....
                currenttime(7:8),'\_',currenttime(10:11),'\_',...
                currenttime(12:13),'\_',currenttime(14:15)],'\_00');

        % Create a File Name for the Individual Simulation
            filename=fullfile(...
                sprintf('%s_strube2024infection_%.0f_%.0f_B',captureddate,i,length(B)));

        % Store Values to the Batch Data Structure
            B(i).D.RunName=filename;
            B(i).D.RunDate=captureddate;
            B(i).D.LatexRunDate=latexdate;
            B(i).D.ReproductionInputs.RunName=filename;
            B(i).D.ReproductionInputs.RunDate=captureddate;
            B(i).D.ReproductionInputs.LatexRunDate=latexdate;

        % Extract Reproduction Inputs from the Batch Data Structure
            ReproductionInputs=B(i).D.ReproductionInputs;

            batchdisplay=1;
            reproductioninputs_extract

        fprintf('\n\nRUNNING SIMULATION: %.0f of %.0f \n', i, length(B))

        %Simulate and Collect Long-Time and Average Trajectory Data
        [S,I,T,S_DF,Savg,Iavg,Tavg,SDFavg]=datagenerator(x,p,timetoequil,timeatequil,avgtime,bifpar1,bifpar2,bp1i,bp2i,sz1,sz2,parallelize,workercount);
    
        %Process Data for Heat Maps
        [HS,HI,HT,HSDF]=cyclesizeanalyzer(S,I,T,S_DF,sz1,sz2,accuracy,lc);

        % Write Simulation Data to the Batch File
        % Due to the memory cost of saving batch data, only data  essential 
        % for  the batchrun figures described in 
        % "figuregenerator_userchoice.m is retained.

        B(i).D.Heat_SDataArray=[];          % HS
        B(i).D.Heat_IDataArray=[];          % HI
        B(i).D.Heat_TDataArray=HT;          % HT
        B(i).D.Heat_DFDataArray=HSDF;       % HSDF
        B(i).D.Orbit_SDataArray=[] ;        % S
        B(i).D.Orbit_IDataArray=[];         % I
        B(i).D.Orbit_DFDataArray=[];        % S_DF              
        B(i).D.Average_SDataArray=[];       % Savg           
        B(i).D.Average_IDataArray=[];       % Iavg         
        B(i).D.Average_TDataArray=Tavg;     % Tavg         
        B(i).D.Average_DFDataArray=SDFavg;  % SDFavg 
        
    end
end
%==========================================================================
%% (10) GENERATE BATCH RUN FIGURES
%==========================================================================
if (manuscriptreproduction==1 && figchoice==batchchoice)                    % Reproduction of (batch) manuscript figures

    eval(figuregenerator_manuscript)

elseif (manuscriptreproduction==2 && figurenew==1 && datatype==1) ||...     % Generation of custom (batch) figures from stored data
        (manuscriptreproduction==2 && figurenew==2 && runspecsentry==3)     % Generation of custom (batch) figures via simulation

    % Figure choice: Do not prompt user.
    eval(batchfigchoices)

    % Figure generation
    figuregenerator_userchoice


else % not a batch run 
%==========================================================================
%% (11) LOAD DATA FILE AND EXTRACT SIMULATION SPECIFICATIONS
%==========================================================================

    filepath=split(reproducefile,{'/','\'});
    load(fullfile(filepath{:}));
    ReproductionInputs=D.ReproductionInputs; 

    % If using stored manuscript data update the filename for correct 
    % storage of reproduction data

    if manuscriptreproduction==1
        filename=fullfile(...
        sprintf('Reproduction_%s',ReproductionInputs.RunName));
        ReproductionInputs.RunName=filename;
    end

    batchdisplay=0
    reproductioninputs_extract

%==========================================================================
%% (12) EXTRACT STORED DATA OR GENERATE NEW DATA
%==========================================================================

%Extract stored data
if (manuscriptreproduction==1 && figurereproduction==1) || (manuscriptreproduction==2 && figurenew==1)

    if ~isfield(D,'Orbit_SDataArray')
        fprintf('\n\nThis data file was constructed during a batch run simulation.')
        fprintf('\nIt does not contain simulation data')
        fprintf('\nTo generate figures, manually enter the desired run conditions')
        fprintf('By selecting the ''Generate New Data and Figures''')

        return

    else

     %Extract Long-Time Behavior Data
     S=D.Orbit_SDataArray;
     I=D.Orbit_IDataArray;
     T=S+I;
     S_DF=D.Orbit_DFDataArray;

     %Extract Heat Map Data
     HS=D.Heat_SDataArray;
     HI=D.Heat_IDataArray;
     HT=D.Heat_TDataArray;
     HSDF=D.Heat_DFDataArray;

     %Extract Average Data
     Savg=D.Average_SDataArray;
     Iavg=D.Average_IDataArray;
     Tavg=D.Average_TDataArray;
     SDFavg=D.Average_DFDataArray;

    end
% Simulate new data 
elseif (manuscriptreproduction==1 && figurereproduction==2) || (manuscriptreproduction==2 && figurenew==2)
    %Run conditions are set when the following scripts are loaded above:
        % dataextraction:
        %   Used when the option to generates manuscript data or figures 
        %   from stored run conditions is selected.
        % newrunspecification: 
        %   Used when the option to generate new data and figures from user
        %   inputted run conditions is selected

    fprintf('\n\n RUNNING SIMULATIONS\n')

    %Simulate and Collect Long-Time and Average Trajectory Data
    [S,I,T,S_DF,Savg,Iavg,Tavg,SDFavg]=datagenerator(x,p,timetoequil,timeatequil,avgtime,bifpar1,bifpar2,bp1i,bp2i,sz1,sz2,parallelize,workercount);

    %Process Data for Heat Maps
    [HS,HI,HT,HSDF]=cyclesizeanalyzer(S,I,T,S_DF,sz1,sz2,accuracy,lc);

    %Collect Data into a single data structure for ease of storage
    SimulationData.S=S;
    SimulationData.I=I;
    SimulationData.T=T;
    SimulationData.S_DF=S_DF;
    SimulationData.Savg=Savg;
    SimulationData.Iavg=Iavg;
    SimulationData.Tavg=Tavg;
    SimulationData.SDFavg=SDFavg;
    SimulationData.HS=HS;
    SimulationData.HI=HI;
    SimulationData.HT=HT;
    SimulationData.HSDF=HSDF;
end

%==========================================================================
%% (13) CONSTRUCT BIFURCATION PARAMETER AXES LABELS
%==========================================================================

    %Default axis label formatting
    bp1label=sprintf('%s',bp1);
    bp2label=sprintf('%s',bp2);

    %Overwrite default and convert to a symbol if the parameter is a greek letter
    if bifpar1 == 5 || bifpar1 == 6
        bp1label= sprintf('$\\%s$',bp1);
        bp2label=sprintf('$%s$',bp2);
    end
    
    if bifpar2 == 5 || bifpar2 == 6
        bp1label=sprintf('$%s$',bp1);
        bp2label= sprintf('$\\%s$',bp2);
    end

%==========================================================================
%% (14a) GENERATE MANUSCRIPT FIGURES
%==========================================================================

if manuscriptreproduction == 1
    eval(figuregenerator_manuscript)
end

%==========================================================================
%% (14b) GENERATE USER-SPECIFIED FIGURES
%==========================================================================

if manuscriptreproduction == 2

    % Collect Figure Choices
    fprintf('\n\nThis script can produce 5 types of figures:\n')
    fprintf('-- Limit Cycle Size Heat Maps \n')
    fprintf('-- Average Population Heat Maps \n')
    fprintf('-- Single Initial-Condition Hydra Effect Plots \n')
    fprintf('-- Orbit Maps \n')
    fprintf('-- Trajectory Plots\n')

    if figspecsentry==1

        figurespecifications_prompt

    elseif figspecsentry==2

        figurespecifications_noprompt

    end

    % Create Figures

    figuregenerator_userchoice
end
    
end

% %==========================================================================
% %% (15) STORE DATA
% %==========================================================================
% 
% % If user requested new simulations, store run specifications and data
% 
% if (manuscriptreproduction==1 && figurereproduction==2 && figchoice~=batchchoice)||... % Reproduce manuscript figures via simulation
%         (manuscriptreproduction==2 && figurenew==2 && runspecsentry ~=3)                % Generate custom (non-batch) figures via simulation
% 
%     % Store Data
% 
%         if nargin==0
%             %-----Prompt-----% 
%             usercatch=0;
%             while usercatch==0
%                 storedata=input('\n\nWould you like to store the data from this run? Y=1/N=0> ');
%                 if any([0,1]==storedata) 
%                     usercatch=1;
%                 else
%                     fprintf('Invalid entry. Please try again.\n')
%                 end
%             end
%             %---------------%
%         end
% 
%         if storedata==1
%             datastorage(datastoragedirectory,ReproductionInputs,SimulationData);
%         end
% 
% elseif (manuscriptreproduction==1 && figurereproduction==2 && figchoice==batchchoice) ||... % Reproduce (batch) manuscript figures via simulation
%         (manuscriptreproduction== 2 && figurenew==2 && runspecsentry == 3)                  % Generate custom (batch) figures via simulation
% 
% 
%        if nargin==0
%             %-----Prompt-----% 
%             usercatch=0;
%             while usercatch==0
%                 fprintf('\nWARNING')
%                 fprintf('\nData from batch runs may require substantial memory to store.')
%                 storedata=input('\n\nWould you like to store the data from this run? Y=1/N=0> ');
%                 if any([0,1]==storedata) 
%                     usercatch=1;
%                 else
%                     fprintf('Invalid entry. Please try again.\n')
%                 end
%             end
%             %---------------%
%         end
% 
%        if storedata==1
%             filepath=B(1).BatchName;
%             save(fullfile(datastoragedirectory,filepath),'B');
%        end
% end
% 
% %==========================================================================
% %% (16) STORE FIGURES
% %==========================================================================
% 
%     if nargin==0
%         %-----Prompt-----% 
%         usercatch=0;
%         while usercatch==0
%             storefigures=input('\n\nWould you like to store these figures? Y=1/N=0> ');
%             if any([0,1]==storefigures) 
%                 usercatch=1;
%             else
%                 fprintf('Invalid entry. Please try again.\n')
%             end
%         end
%         %---------------%
%     end
% 
%     if storefigures==1
%         for i=1:1:figurecounter
%             figurestorage(FigHandles{i},fullfile(figurestoragedirectory,FileNames{i}))
%         end
%     end
end
%==========================================================================
%% END CODE
%==========================================================================
