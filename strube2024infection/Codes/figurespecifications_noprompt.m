%figurespecifications_noprompt

%==========================================================================
%% SCRIPT DESCRIPTION
%==========================================================================
%   This script allows users to enter desired figure specifications 
%   manually to avoid the tedium of command line prompts.
%
%   To view the corresponding command line prompt file see:
%   
%               figuresspecifications_prompt.m
%
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
%
%% ------------------------------------------------------------------------
%==========================================================================
%% START SCRIPT
%==========================================================================

%% (01) USER PROMPT: GENERATE FIGURES?

   %Would you like to generate figures with this data? Y=1/N=0
   generatefigures=1;

if generatefigures==1
    %% (02) WHICH TYPE OF FIGURES?

    %Would you like to create a Limit Cycle Size Heat Maps? Y=1/N=0> 

        % #USERINPUT01
        heatmap=1;

    %Would you like to create a Average Total Population Heat Maps? Y=1/N=0>

        % #USERINPUT02
        avgpop=1;
        
    % Would you like to create Single Initial-Condition Hydra Effect Plots? Y=1/N=0> 

        % #USERINPUT03
        singlehydra=1;

    %Would you like to create a Batch Initial-Condition Hyda Effect Plot? Y=1/N=0> 
    
        % #USERINPUT04
        batchhydra=0;

    %Would you like to create any Orbit Maps? Y=1/N=0> 
    
        % #USERINPUT05
        orbit=1;

    %Would you like to create any Trajectory Plots? Y=1/N=0> 

        % #USERINPUT06
        trajectory=1;

    
    %% (03) SINGLE INITIAL CONDITION HYDRA SPECIFICATIONS

        if singlehydra==1
            %This script will automatically generate zero-threshold hydra effect plots.
            %What additional non-zero threshold would you like to use (enter a decimal greater than 0.01.

            % #USERINPUT07
            hydrathreshold=0.05;
        end

    %% (04) BATCH INITIAL CONDITION HYDRA SPECIFICATIONS
    
     if batchhydra ~=0
        
     end

    %% (05) ORBIT MAP PROMPTS
    
        if orbit==1
            %How many orbit maps would you like to generate?
        
                % #USERINPUT08
                orbitcount = 4;
    
            % Each element in the following vectors corresponds to a single figure.
            % The chosen examples assume the following simulation conditions:
            %   bifurcation parameter 1: w in [0,0.001,1]
            %   bifurcation parameter 2: u in [0,0.001,1]
    
                % Which of the two bifurcation parameter specified in the
                % simulation conditions will be used as the bifurcation parameter
                % in these one-parameter bifurcation diagrams?
    
                % Enter a vector of 1's and 2's:
    
                    % #USERINPUT09
                    bpchoice = [1 1 2 2];   % i.e. [w w u u]
    
                % For each figure, if parameter "1" is chosen as the bifurcation
                % parameter, then parameter "2" must be fixed at one of its
                % incremented values in the simulation conditions. 
    
                    % #USERINPUT10
                    bpset= [0 .5 1 .5];
    
                % This loop is automatic, do not edit. 
    
                for i=1:1:orbitcount
                    if bpchoice(i) == 1
                        bp{i}=bp1; %name of bifurcation parameter
                        bpidentity(i)=bifpar1;
                        bplabel{i}=bp1label;
                        bifpar{i} = bp1i; %bifurcation parameter increments
                        bpconstant{i}=bp2; %name of "fixed" bifurcation parameter
                        bpindex(i)=find(bp2i>=bpset(i),1,'first');
                        bpconstantvalue(i)=bp2i(bpindex(i)); %value of "fixed" bifurcation parameter
                        bpconststr{i}=strrep(sprintf('%0.4f',bpconstantvalue(i)),'.','p'); %str describing value of "fixed" parameter
                        fprintf('You have chosen %s as your bifurcation parameter, and to fix %s at %.4f.\n',bp1,bp2,bp2i(bpindex(i)))
        
                    elseif bpchoice(i) == 2
                        bp{i}=bp2; %name of bifurcation parameter
                        bpidentity(i)=bifpar2;
                        bplabel{i}=bp2label;
                        bifpar{i} = bp2i; %bifurcation parameter increments
                        bpconstant{i}=bp1; %name of "fixed" bifurcation parameter
                        bpindex(i)=find(bp1i>=bpset(i),1,'first');
                        bpconstantvalue(i)=bp1i(bpindex(i)); %value of "fixed bifurcation parameter
                        bpconststr{i}=strrep(sprintf('%0.4f',bpconstantvalue(i)),'.','p'); %string describing value of "fixed" parameter
                        fprintf('You have chosen %s as your bifurcation parameter, and to fix %s at %.4f.\n',bp2,bp1,bp1i(bpindex(i)))
                    end
                end
        end
    
    %% (06) TRAJECTORY PROMPTS
    
    if trajectory~=0

        %How many Trajectory plots would you like to generate?> '

            % #USERINPUT11
            trajectorycount=5;
 
        % Each element in the following vectors corresponds to a single figure.
        % The chosen examples assume the following simulation conditions:
        %   First bifurcation parameter: r in [0,0.5,320]
        %   Second bifurcation parameter: d in [0,0.001,1]

        % What values would you like to use for the  bifurcation parameters?
        % The number of elements in each vector must equal "trajectorycount" above. 

            % #USERINPUT12
            pchoice1 = [0.0 0.0 0.5 0.0 1.0]; % bif par 1 (Ex: w)
            pchoice2 = [0.0 0.5 0.0 0.0 1.0]; % bif par 2 (Ex: u)

        % How long would you like to run the simulation

            % #USERINPUT12
            traj_time=[10000 10000 10000 10000 10000];


        % This following is automatic, do not edit
           
        % Initialize Parameter and Initial Condition Vectors    
        traj_param = p; %Baseline Parameters
        traj_param= repmat(traj_param,1,trajectorycount);
       
        traj_init=x; %Baseline Initial Conditions
        traj_init=repmat(traj_init,1,trajectorycount);

        for i=1:1:trajectorycount

            % Update parameter vectors
            if (0<bifpar1) && (bifpar1<7)
                traj_param(bifpar1,i)=pchoice1(i);
            elseif bifpar1>6
                traj_init(bifpar1,i)=pchoice1(i);
            end

            if (0<bifpar2) && (bifpar2<7)
                traj_param(bifpar2,i)=pchoice2(i);
            elseif bifpar2>6
                traj_init(bifpar2,i)=pchoice2(i);
            end

            if strcmp(bp1label,'mu')
                bp1label='\mu'; 
            end
        
            if strcmp(bp2label,'mu') 
                bp2label='\mu'; 
            end

            % Create strings to describe this simulation
            value1=strrep(sprintf('%0.4f',pchoice1),'.','p'); %string describing value of "fixed" parameter
            value2=strrep(sprintf('%0.4f',pchoice2),'.','p'); %string describing value of "fixed" parameter

            traj_desc{i}=sprintf('%s=%0.4f %s=%0.4f',bp1label,pchoice1,bp2label,pchoice2);
            traj_filename{i}=sprintf('%s_%s_%s_%s_t_%.0f',bp1,value1,bp2,value2,traj_time(i));

        end

    end

end % generate figures if-statement

fprintf('\n\nGENERATING FIGURES\n\n')

%==========================================================================
%% END SCRIPT
%==========================================================================