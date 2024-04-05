%figuregenerator_userchoice

%==========================================================================
%% SCRIPT DESCRIPTION
%==========================================================================
%
%   This script generates 9 classes of figures:
%
%       (1) Limit-Cycle Size Heat Maps (4 figures)
%       (2) Average Population Size Heat Maps (4 figures)
%       (3) Orbit Maps (5 fiugures)
%       (4) Trajectory Plots (5 figures) 
%       (5) Single Initial Condition Hydra Effect Plots (5 figures)
%       (6) Compiled Hydra Effect Plot (1 figure)
%       (7) Latin Hypercube Sampling Visualization (1 figure)
%       (8) Compiled Limit Cycle Size Plots (n+1 figures), where n=the
%       limit-cycle size threshold entered by the user.
%       (9) Multistability Plot (1 figure)
%
%  For classes 1-4: Susceptible, Infectious, Total (With-Disease)
%  Population, and Total (Disease-Free) Population Figures aregGenerated.
%
%   For class 3-4: An Absolute Difference figure is generated for the
%   comparison of the Total (WD) and Total (DF) populations.
%
%  For class 5, five figures are created:
%   
%       (a) Linear-scale Population Growth ("hydra effect threshold = 0")
%       (b) Log2 Population Growth ("hydra effect threshold = 0")
%       (c) Binary Hydra Effect (Y/N infection-induced population growth)
%       (d) Linear-scale Hydra Effect (user choice hyda effect threshold)
%       (e) Log2 Hydra Effect (user choice hydra effect threshold)
%
%   For class 6, a single black-and-white binary hydra effect plot is
%   created. 
%
%   For class 7, a single plot depicting the LHS values is created.
%
%   For class 8, a series of 17 figures, one for each limit-cycle size, is
%   created, each depicting the net region of parameter space exhibiting
%   that limit cycle size for any one of the LHS values. 
%
%   For class 9, a single multistability plot. 
% 
% Depending on user choices in *_driver.m, it uses the 
% simulation conditions loaded via one of the following:
% 
%               a stored data file
%               newrunspecifications_noprompt.m
%               newrunspecifications_prompt.m 
%               batch_inputs_create.m
%
%  and figure specifications entered via either:
% 
%           figurespecifications_prompt.m
%           figurespecification_noprompt.m
%           *_batchfigchoices.m
%
%
%   INPUTS:
%   -------
%   Figure choices stored in the variables:
%       heatmap
%       avgpop
%       singlehydra
%       orbit
%       trajectory
%       compiledhydra
%       lhs
%       compiledlimitcycleplot
%       multistab
%
%
%   OUTPUTS:
%   --------
%   generated figures
%   FileNames           : Cell Array of file names for figure storage
%   FigHandles          : Cell Array of figure handles for figure storage
%   figurecounter       : Total quantity of figures generated
%
%   DEPENDENCIES:
%   -------------
%   heatmapplot
%   averagepopulationplot
%   singlehydra
%   orbitplot
%   trajectoryplot
%   compiled_hydraplot
%   lhsvisualization
%   compiled_limitcycleplot
%   multistabilityplot
%   
%
%   USED BY:
%   --------
%   *_driver.m
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
%
%
%% ------------------------------------------------------------------------
%==========================================================================
%% START SCRIPT
%==========================================================================

%% (01) INITIALIZE FIGURE COUNTER (FOR FIGURE STORAGE)
    
    figurecounter = 0;

%% (01) PLOT LIMIT CYCLE SIZE HEAT MAPS
 
if heatmap ==1
    % Susceptible Population
    figuretitle={sprintf('%s:',latexdate),'Susceptible Population'};
    filename=strcat(captureddate,'_HeatMap_Susceptible');
    [figurehandle,figurecounter]=...
        heatmapplot(HS,bifpar1,bifpar2,increm1,increm2,lc,bp1label,...
        bp2label,figuretitle,figurecounter);
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

    % Infectious Population
    figuretitle={sprintf('%s:',latexdate),'Infected Population'};
    filename=strcat(captureddate,'_HeatMap_Infectious');
    [figurehandle,figurecounter]=...
        heatmapplot(HI,bifpar1,bifpar2,increm1,increm2,lc,bp1label,...
        bp2label,figuretitle,figurecounter);
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

    % Total With-Disease Population
    figuretitle={sprintf('%s:',latexdate),'Total (WD) Population'};
    filename=strcat(captureddate,'_HeatMap_TotalWD');
    [figurehandle,figurecounter]=...
        heatmapplot(HT,bifpar1,bifpar2,increm1,increm2,lc,bp1label,...
        bp2label,figuretitle,figurecounter);
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

     % Total Disease-Free Population
    figuretitle={sprintf('%s:',latexdate),'Total (DF) Population'};
    filename=strcat(captureddate,'_HeatMap_TotalDF');
    [figurehandle,figurecounter]=...
        heatmapplot(HSDF,bifpar2,bifpar2,increm1,increm2,lc,bp1label,...
        bp2label,figuretitle,figurecounter);
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

end

%% (02) PLOT AVERAGE TOTAL POPULATION HEAT MAPS
    
if avgpop ==1

    % Average Susceptible Population 
    figuretitle={sprintf('%s:',latexdate),'Average Susceptible Population'};
    filename=strcat(captureddate,'_AvgMap_Suceptible');
    [figurehandle,figurecounter]=...
        averagepopulationplot(Savg,bifpar1,bifpar2,increm1,increm2,...
        bp1label,bp2label,figuretitle,figurecounter);
    figurehandles{figurecounter}=figurehandle;
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

    % Average Infectious Population 
    figuretitle={sprintf('%s:',latexdate),'Average Infectious Population'};
    filename=strcat(captureddate,'_AvgMap_Infectious');
    [figurehandle,figurecounter]=...
        averagepopulationplot(Iavg,bifpar1,bifpar2,increm1,increm2,...
        bp1label,bp2label,figuretitle,figurecounter);
    figurehandles{figurecounter}=figurehandle;
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

     % Average Total (WD) Population 
    figuretitle={sprintf('%s:',latexdate),'Average Total (WD) Population'};
    filename=strcat(captureddate,'_AvgMap_TotalWD');
    [figurehandle,figurecounter]=...
        averagepopulationplot(Tavg,bifpar1,bifpar2,increm1,increm2,...
        bp1label,bp2label,figuretitle,figurecounter);
    figurehandles{figurecounter}=figurehandle;
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

     % Average Total (DF) Population
    figuretitle={sprintf('%s:',latexdate),'Average Total (DF) Population'};
    filename=strcat(captureddate,'_AvgMap_TotalDF');
    [figurehandle,figurecounter]=...
        averagepopulationplot(SDFavg,bifpar1,bifpar2,increm1,increm2,...
        bp1label,bp2label,figuretitle,figurecounter);
    figurehandles{figurecounter}=figurehandle;
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

end

%% (03) PLOT SINGLE INITIAL CONDITION HYDRA PLOTS

if singlehydra ==1

    % Process Data for Hydra Effect Plots
    binaryhydrathreshold=0;
    [ContinuousHydra,FoldChangeHydra,BinaryHydra]=calculatehydra(...
        Tavg,SDFavg,binaryhydrathreshold);
    
    % Plot Linear-Scale Visualization of Infection-Induced Population Change 
    figuretitle={sprintf('%s:',latexdate),'Population Change (Linear Scale)'};
    filename=strcat(captureddate,'_InfectionInducedIncrease_Linear');
    colorbarlabel='Relative Percent Increase In Total Population';
    [figurehandle,figurecounter]=hydraeffectplot(...
        'LinearScaleHydra',ContinuousHydra,bifpar1,bifpar2,'none',...
        increm1,increm2,bp1label,bp2label,colorbarlabel,...
        figuretitle,figurecounter);
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

    % Plot Fold-Change Visualization of Infection-Induced Population Change 
    figuretitle={sprintf('%s:',latexdate),'Population Change (Fold Change)'};
    filename=strcat(captureddate,'_InfectionInducedIncrease_FoldChange');
    colorbarlabel='Population Fold Change';
    [figurehandle,figurecounter]=hydraeffectplot(...
        'FoldChangeHydra',FoldChangeHydra,bifpar1,bifpar2,'none',...
        increm1,increm2,bp1label,bp2label,colorbarlabel,figuretitle,...
        figurecounter);
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

    % Plot Binary Visualization of Hydra-Effect 
    figuretitle={sprintf(...
        '%s:',latexdate),'Presence of an Infection-Induced Hydra Effect'};
    filename=strcat(captureddate,'_InfectionInducedIncrease_Binary');
    colorbarlabel='HydraEffect';
    [figurehandle,figurecounter]=hydraeffectplot(...
        'BinaryHydra',BinaryHydra,bifpar1,bifpar2,0,increm1,increm2,...
        bp1label,bp2label,colorbarlabel,figuretitle,figurecounter);
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

    % Plot Linear-Scale Visualization of Infection-Induced Hydra-Effect 
    figuretitle={sprintf('%s:',latexdate),'Hydra Effect (Linear Scale)'};
    filename=strcat(captureddate,'_InfectionInducedIncrease_LinearHydra');
    colorbarlabel='Relative Percent Increase In Total Population';
    [figurehandle,figurecounter]=hydraeffectplot(...
        'LinearScaleHydra',ContinuousHydra,bifpar1,bifpar2,hydrathreshold,...
        increm1,increm2,bp1label,bp2label,colorbarlabel,...
        figuretitle,figurecounter);
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

    % Plot Fold-Change Visualization of Infection-Induced Hydra-Effect 
    figuretitle={sprintf('%s:',latexdate),'Hydra Effect (Fold-Change)'};
    filename=strcat(captureddate,'_InfectionInducedIncrease_FoldChangeHydra');
    colorbarlabel='Population Fold Change';
    [figurehandle,figurecounter]=hydraeffectplot(...
        'FoldChangeHydra',FoldChangeHydra,bifpar1,bifpar2,hydrathreshold,...
        increm1,increm2,bp1label,bp2label,colorbarlabel,figuretitle,...
        figurecounter);
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

end

%% (04) PLOT ORBIT MAPS

if orbit ==1
    for i=1:1:orbitcount

        %Format value of fixed bifurcation parameter for use in filename
        bpconstantfilename=...
            strrep(sprintf('%09.4f',bpconstantvalue(i)),'.','p');

        % Collect Orbit Map Data
        if bpchoice(i)==1
            %Fix the second bifurcation parameter at a constant value
            S_plot(:,:)=S(:,bpindex(i),:); 
            I_plot(:,:)=I(:,bpindex(i),:); 
            T_plot(:,:)=T(:,bpindex(i),:);
            S_DFplot(:,:)=S_DF(:,bpindex(i),:); 

            Savg_plot=Savg(:,bpindex(i))'; 
            Iavg_plot=Iavg(:,bpindex(i))'; 
            Tavg_plot=Tavg(:,bpindex(i))';
            SDFavg_plot=SDFavg(:,bpindex(i))'; 

        elseif bpchoice(i)==2
            %Fix the first bifurcation parameter at a constant value
            S_plot(:,:)=S(bpindex(i),:,:); 
            I_plot(:,:)=I(bpindex(i),:,:); 
            T_plot(:,:)=T(bpindex(i),:,:);
            S_DFplot(:,:)=S_DF(bpindex(i),:,:); 

            Savg_plot=Savg(bpindex(i),:); 
            Iavg_plot=Iavg(bpindex(i),:); 
            Tavg_plot=Tavg(bpindex(i),:);
            SDFavg_plot=SDFavg(bpindex(i),:);
        end

        %Susceptible Population
        figuretitle={sprintf('%s:',latexdate),...
            sprintf('Susceptible Population [%s = %0.4f]',...
            bplabel{i},bpconstantvalue(i))};
        filename=strcat(captureddate,...
            sprintf(...
            '_Orbit_%s_var_%s_Suceptible',bpconstant{i},bpconstantfilename));
        legendentries={'Susceptible Population','Susceptible Average'};
        [figurehandle,figurecounter]=orbitplot(bifpar{i},S_plot,Savg_plot,...
            bpidentity(i),bpconstantvalue(i),figuretitle,bplabel{i},...
            'Quantity of Susceptible Individuals',legendentries,...
            figurecounter);
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;
    
        %Infectious Population
        figuretitle={sprintf('%s:',latexdate),...
            sprintf('Infectious Population [%s = %0.4f]',...
            bplabel{i},bpconstantvalue(i))};
        filename=strcat(captureddate,...
            sprintf(...
            '_Orbit_%s_var_%s_Infectious',bpconstant{i},bpconstantfilename));
        legendentries={'Infectious Population','Infectious Average'};
        [figurehandle,figurecounter]=orbitplot(bifpar{i},I_plot,Iavg_plot,...
            bpidentity(i),bpconstantvalue(i),figuretitle,bplabel{i},...
            'Quantity of Infected Individuals',legendentries,figurecounter);
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;
            
        %Total (WD) Population
        figuretitle={sprintf('%s:',latexdate),...
            sprintf('Total (WD) Population [%s = %0.4f]',...
            bplabel{i},bpconstantvalue(i))};
        filename=strcat(captureddate,...
            sprintf(...
            '_Orbit_%s_var_%s_TotalWD',bpconstant{i},bpconstantfilename));
        legendentries={'Total Population','Total Average'};
        [figurehandle,figurecounter]=orbitplot(bifpar{i},T_plot,Tavg_plot,...
            bpidentity(i),bpconstantvalue(i),figuretitle,bplabel{i},...
            'Total Quantity of Individuals (WD)',legendentries,...
            figurecounter);
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;
            
        %Total (DF) Population
        figuretitle={sprintf('%s:',latexdate),...
            sprintf('Total (DF) Population [%s = %0.4f]',...
            bplabel{i},bpconstantvalue(i))};
        filename=strcat(captureddate,...
            sprintf(...
            '_Orbit_%s_var_%s_TotalDF',bpconstant{i},bpconstantfilename));
        legendentries={'Disease-Free Population','Disease-Free Average'};
        [figurehandle,figurecounter]=orbitplot(bifpar{i},S_DFplot,SDFavg_plot,...
            bpidentity(i),bpconstantvalue(i),figuretitle,bplabel{i},...
            'Total Quantity of Individuals (DF)',legendentries,...
            figurecounter);
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;

        %Absolute Difference between WD and DF Populations
        AbsDiff=abs(T_plot - S_DFplot);
        AbsDiffavg=abs(Tavg_plot-SDFavg_plot);
        figuretitle={sprintf('%s:',latexdate),...
            sprintf('Abs. Diff. btwn WD and DF Populations [%s = %0.4f]',...
            bplabel{i},bpconstantvalue(i))};
        filename=strcat(captureddate,...
            sprintf(...
            '_Orbit_%s_var_%s_AbsDiff',bpconstant{i},bpconstantfilename));
        legendentries={'Absolute Difference',''};
        [figurehandle,figurecounter]=orbitplot(bifpar{i},AbsDiff,AbsDiffavg,...
            bpidentity(i),bpconstantvalue(i),figuretitle,bplabel{i},...
            'Total Quantity of Individuals',legendentries,...
            figurecounter);
        avgline=figurehandle.Children(2).Children(1);
        delete(avgline)
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;

        clear S_plot I_plot T_plot S_DFplot Savg_plot Iavg_plot Tavg_plot SDFavg_plot
   end
end

%% (05) PLOT TRAJECTORIES

    if trajectory ==1

        for i=1:1:trajectorycount

            % Simulate the system
            [t,X,Tot,XDF]= trajectorysimulator(traj_init(:,i),...
                traj_param(:,i),traj_time(i));

            % Extract Trajectory data
            S=X(1,:);
            I=X(2,:);
            AbsDiff=abs(Tot-XDF);

            % Plot Susceptible Population 
            figuretitle={sprintf('%s',latexdate), sprintf('%s',traj_desc{i})};
            filename=strcat(captureddate,'_Traj_Suceptible_',traj_filename{i});
            legendentry='';
            ylabel='Susceptible Population';
            [figurehandle, figurecounter] = trajectoryplot(...
                t,S,legendentry,ylabel,figuretitle,figurecounter);
            FileNames{figurecounter}=filename;
            FigHandles{figurecounter}=figurehandle;

            % Plot Infectious Population
            figuretitle={latexdate, traj_desc{i}};
            filename=strcat(captureddate,'_Traj_Infectious_',traj_filename{i});
            legendentry='';
            ylabel='Infectious Population';
            [figurehandle, figurecounter] = trajectoryplot(...
                t,I,legendentry,ylabel,figuretitle,figurecounter);
            FileNames{figurecounter}=filename;
            FigHandles{figurecounter}=figurehandle;

            % Plot Total (WD) Population
            figuretitle={latexdate, traj_desc{i}};
            filename=strcat(captureddate,'_Traj_TotalWD_',traj_filename{i});
            legendentry='';
            ylabel='Total (WD) Population';
            [figurehandle, figurecounter] = trajectoryplot(...
                t,Tot,legendentry,ylabel,figuretitle,figurecounter);
            FileNames{figurecounter}=filename;
            FigHandles{figurecounter}=figurehandle;

            % Plot Total (DF) Population
            figuretitle={latexdate, traj_desc{i}};
            filename=strcat(captureddate,'_Traj_TotalDF_',traj_filename{i});
            legendentry='';
            ylabel= 'Total (DF) Population';
            [figurehandle, figurecounter] = trajectoryplot(...
                t,XDF,legendentry,ylabel,figuretitle,figurecounter);
            FileNames{figurecounter}=filename;
            FigHandles{figurecounter}=figurehandle;

            % Plot Absolute Difference (between WD and DF)
            figuretitle={latexdate, traj_desc{i}};
            filename=strcat(captureddate,'_Traj_AbsDiff_',traj_filename{i});
            legendentry='';
            ylabel= 'Abs. Diff. between WD and DF Populations';
            [figurehandle, figurecounter] = trajectoryplot(...
                t,AbsDiff,legendentry,ylabel,figuretitle,figurecounter);
            FileNames{figurecounter}=filename;
            FigHandles{figurecounter}=figurehandle;

        end
    end


%% (06) COMPILED HYDRA EFFECT PLOT

    if compiledhydra==1

        filename=strcat(B(1).BatchDate,'_CompiledBinaryHydraEffect');
        [figurehandle,figurecounter]=compiled_hydraplot(B,figurecounter);
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;

    end

%% (07) LATIN HYPERCUBE VISUALIZATION

    if lhs==1

        figuretitle={latexdate, 'Latin Hypercube Visualization'};
        filename=strcat(B(1).BatchDate,'_LHSamples');
        [figurehandle,figurecounter]=lhsvisualization(B,figuretitle,figurecounter);
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;

    end

%% (08) COMPILED LIMIT CYCLE PLOT

    if compiledlimitcycleplot==1

        figuretitle={latexdate};
        [figurehandles,filenames,figurecounter]=compiled_limitcycleplot(B,'Heat_TDataArray',figuretitle,figurecounter);
        for i=1:1:length(filenames)
            FileNames=[FileNames,strcat(B(1).BatchDate,'_',filenames{i})];
        end
        FigHandles=[FigHandles,figurehandles];

    end

%% (09) MULITSTABILITY PLOT

    if multistab==1

        figuretitle={latexdate, 'Total (WD) Population', 'Multistable Regions', '*see discussion of possible numerical error in strube2024multistability'};
        filename=strcat(B(1).BatchDate,'_','MultistabilityPlot_WD');
        [figurehandle,figurecounter]= multistabilityplot(3,B,'Heat_TDataArray',figuretitle,figurecounter);

        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;

        figuretitle={latexdate, 'Total (DF) Population', 'Multistable Regions','*see discussion of possible numerical error in strube2024multistability'};
        [figurehandle,figurecounter]= multistabilityplot(2,B,'Heat_DFDataArray',figuretitle,figurecounter);

        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;


    end
%==========================================================================
%% END SCRIPT
%==========================================================================