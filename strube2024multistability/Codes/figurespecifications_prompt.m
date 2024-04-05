%figurespecification_prompt

%==========================================================================
%% SCRIPT DESCRIPTION
%==========================================================================
%   This script allows users to enter desired figure specifications 
%   in response to command line prompts. 
%
%   For an alternate manual entry option see:
%   
%               figuresspecifications_prompt.m
%   INPUT:
%   ------
%   - none. All specifications must be entered in response to command line
%   prompts. Do not edit this script. 
%
%   OUPUT:
%   ------
%   - user-specified figures specifications in response to command line
%   prompts
%
%   DEPENDENCIES:
%   -------------
%   - None
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


%% (01) USER PROMPT: GENERATE FIGURES?

    %-----Prompt-----% 
    usercatch=0;
    while usercatch==0
        generatefigures=input('\n\nWould you like to generate figures with this data? Y=1/N=0> ');
        if any([0,1]==generatefigures) 
            usercatch=1;
        else
            fprintf('Invalid entry. Please try again.\n')
        end
    end
    %---------------%

if generatefigures==1
    %% (02) USER PROMPT: WHICH TYPE OF FIGURES
    
        % (A) Limit Cycle Heat Maps?
            %-----Prompt-----% 
            usercatch=0;
            while usercatch==0
                heatmap=input('\n\nWould you like to create a Limit Cycle Size Heat Maps? Y=1/N=0> ');
                if any([0,1]==heatmap) 
                    usercatch=1;
                else
                    fprintf('Invalid entry. Please try again.\n')
                end
            end
            %---------------%
        
        % (B) Average Population Heat Map?
            %-----Prompt-----% 
            usercatch=0;
            while usercatch==0
                avgpop=input('Would you like to create a Average Total Population Heat Maps? Y=1/N=0> ');
                if any([0,1]==avgpop) 
                    usercatch=1;
                else
                    fprintf('Invalid entry. Please try again.\n')
                end
            end
            %---------------%
        
        
        % (C) Single Initial Condition Hydra Effect Plots?
            %-----Prompt-----% 
            usercatch=0;
            while usercatch==0
                singlehydra=input('Would you like to create Single Initial-Condition Hydra Effect Plots? Y=1/N=0> ');
                if any([0,1]==singlehydra) 
                    usercatch=1;
                else
                    fprintf('Invalid entry. Please try again.\n')
                end
            end
            %---------------%
        
        % (D) Orbit Map?
            %-----Prompt-----% 
            usercatch=0;
            while usercatch==0
                orbit=input('Would you like to create any Orbit Maps? Y=1/N=0> ');
                if any([0,1]==orbit) 
                    usercatch=1;
                else
                    fprintf('Invalid entry. Please try again.\n')
                end
            end
            %---------------%
        
        % (E) Trajectory Plots?
            %-----Prompt-----% 
            usercatch=0;
            while usercatch==0
                trajectory=input('Would you like to create any Trajectory Plots? Y=1/N=0> ');
                if any([0,1]==trajectory) 
                    usercatch=1;
                else
                    fprintf('Invalid entry. Please try again.\n')
                end
            end
            %---------------%

        % (F) Do not prompt for batch plots
        compiledhydra=0;
        lhs=0;
        compiledlimitcycleplot=0;
         multistab=0;
    
    %% (03) SINGLE INITIAL CONDITION HYDRA PROMPTS
    
    if singlehydra~=0
        fprintf('\n\nSINGLE-INITIAL CONDITION HYDRA EFFECT PLOTS:\n')
    
        % Non-Zero Hydra Effect Threshold
    
            %-----Prompt-----% 
            usercatch=0;
            while usercatch==0
                fprintf('This script will automatically generate zero-threshold hydra effect plots.\n')
                hydrathreshold=input('What additional non-zero threshold would you like to use (enter a decimal greater than 0.01 )> ');
                if hydrathreshold >= 0.01 
                    usercatch=1;
                else
                    fprintf('Invalid entry. Please try again.\n')
                end
            end
            %---------------%
    end

    
    %% (04) ORBIT MAP PROMPTS
    
    if orbit ~=0
    
        fprintf('\n\nORBIT MAPS:\n')
        
            % (A) Quantity of Orbit Maps
        
                %-----Prompt-----% 
                usercatch=0;
                while usercatch==0
                    orbitcount =input('How many orbit maps would you like to generate> ');
                    if orbitcount>0 
                        usercatch=1;
                    else
                        fprintf('Invalid entry. Please try again.\n')
                    end
                end
        
               %---------------%
        
      
            for i=1:1:orbitcount
           
                fprintf('\n\nFor Orbit Map %.0d:\n',i)
    
                %(B) User Prompt: Choose Bifurcation Parameter
                    fprintf('(1) The bifurcation parameter %s is incremented from %.4f:%.4f:%.4f. \n',bp1,increm1(1),increm1(2),increm1(3))
                    fprintf('(2) The bifurcation parameter %s is incremented from %.4f:%.4f:%.4f. \n',bp2,increm2(1),increm2(2),increm2(3))
            
                    %-----Prompt-----%
                    usercatch=0;
                    while usercatch==0
                        bpchoice(i)=input('Which parameter would you like to use in the diagram? 1 or 2: > ');
                        if bpchoice(i)==1||bpchoice(i)==2
                            usercatch=1;
                        else
                            fprintf('Invalid entry. Please try again.\n')
                        end
                    end       
                    %----------------%
                    
                 
                %(C) Fix the Other Bifurcation Parameter at a Constant Value
                    %Remind user of options for bifurcation parameter value
                        if bpchoice(i)==1
                            fprintf('The parameter %s must be fixed at a constant value.\n',bp2)
                            fprintf('Recall, it was incremented from %.4f:%.4f:%.4f. \n',increm2(1),increm2(2),increm2(3))
                            fprintf('And its baseline value is %s=%.4f.\n',bp2,p(bifpar2));
            
                        elseif bpchoice(i)==2
                            fprintf('The parameter %s must be fixed at a constant value.\n',bp1)
                            fprintf('Recall, it was incremented from %.4f:%.4f:%.4f. \n',increm1(1),increm1(2),increm1(3))
                            fprintf('And its baseline value is %s=%.4f.\n',bp1,p(bifpar1));
                        end
            
                    %User Prompt: Select value at which to fix the bifurcation parameter
                        bpset(i)=input('Enter your value choice: > ');
                 
                    %User Prompt: Confirm choice
                        if bpchoice(i) == 1
                            bp{i}=bp1; %name of bifurcation parameter
                            bpidentity(i)=bifpar1;
                            bplabel{i}=bp1label;
                            bifpar{i} = bp1i; %bifurcation parameter increments
                            bpconstant{i}=bp2; %name of "fixed" bifurcation parameter
                            % #ToDo: Add an error catch
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
                            % #ToDo: Add an error catch
                            bpindex(i)=find(bp1i>=bpset(i),1,'first');
                            bpconstantvalue(i)=bp1i(bpindex(i)); %value of "fixed bifurcation parameter
                            bpconststr{i}=strrep(sprintf('%0.4f',bpconstantvalue(i)),'.','p'); %string describing value of "fixed" parameter
                            fprintf('You have chosen %s as your bifurcation parameter, and to fix %s at %.4f.\n',bp2,bp1,bp1i(bpindex(i)))
                        end
            
            end
    
    end
    
    %% (05) TRAJECTORY PROMPTS
    
    if trajectory~=0
    
    fprintf('\n\n TRAJECTORY PLOTS:\n')
    
        % (A) Quantity of Orbit Maps
    
            %-----Prompt-----% 
            usercatch=0;
            while usercatch==0
                trajectorycount =input('How many Trajectory plots would you like to generate?> ');
                if trajectorycount>0 
                    usercatch=1;
                else
                    fprintf('Invalid entry. Please try again.\n')
                end
            end
    
           %---------------%

           % Initialize Parameter and Initial Condition Vectors
                        
            traj_param = p ; %Baseline Parameters
            traj_param= repmat(traj_param,1,trajectorycount);
           
            traj_init = x; %Baseline Initial Conditions
            traj_init=repmat(traj_init,1,trajectorycount);

    
        for i=1:1:trajectorycount
       
            fprintf('\n\nFor Trajectory Plot %.0d:\n',i)
    
            %(B) User Prompt: Choose Bifurcation Parameter
                fprintf('-- In the stored data, %s is incremented from %.4f:%.4f:%.4f. \n',bp1,increm1(1),increm1(2),increm1(3))
                fprintf('-- In the stored data, %s is incremented from %.4f:%.4f:%.4f. \n',bp2,increm2(1),increm2(2),increm2(3))
        
                %-----Prompt-----%
                usercatch=0;
                while usercatch==0
                    pchoice1(i)=input(sprintf('What value would you like to use for %s?> ',bp1));
                    if any([increm1(1):increm1(2):increm1(3)]==pchoice1(i))
                        usercatch=1;
                    else
                        fprintf('Invalid entry. Please try again.\n')
                    end
                end       
                %----------------%
    
                %-----Prompt-----%
                usercatch=0;
                while usercatch==0
                    pchoice2(i)=input(sprintf('What value would you like to use for %s?> ',bp2));
                    if any([increm2(1):increm2(2):increm2(3)]==pchoice2(i))
                        usercatch=1;
                    else
                        fprintf('Invalid entry. Please try again.\n')
                    end
                end       
                %----------------%

                %-----Prompt-----%
                usercatch=0;
                while usercatch==0
                    traj_time(i)=input('How long would you like to run the simulation?> ');
                    usercatch=1;
                end       
                %----------------%


                % Update the parameter vectors
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
                value1{i}=strrep(sprintf('%0.4f',pchoice1(i)),'.','p'); %string describing value of "fixed" parameter
                value2{i}=strrep(sprintf('%0.4f',pchoice2(i)),'.','p'); %string describing value of "fixed" parameter

                traj_desc{i}=sprintf('%s=%0.4f %s=%0.4f',bp1label,pchoice1(i),bp2label,pchoice2(i));
                traj_filename{i}=sprintf('%s_%s_%s_%s_t_%.0f',bp1,value1{i},bp2,value2{i},traj_time(i));

        end
    
    end
end % generate figures if-statement

fprintf('\n\nGENERATING FIGURES\n\n')

%==========================================================================
%% END SCRIPT
%==========================================================================