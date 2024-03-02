%figuregenerator_userchoice

%==========================================================================
%% SCRIPT DESCRIPTION
%==========================================================================
%
%   This script generates 6 classes of figures:
%
%       (1) Limit-Cycle Size Heat Maps (4 figures)
%       (2) Average Population Size Heat Maps (4 figures)
%       (3) Orbit Maps (5 fiugures)
%       (4) Trajectory Plots (5 figures) 
%       (5) Single Initial Condition Hydra Effect Plots (5 figures)
%       (6) Batch Initial Condition Hydra Effect Plot (1 figure)
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
% Depending on user choices in strube2024infection_driver.m, it uses the 
% simulation conditions loaded via one of the following:
% 
%               a stored data file
%               newrunspecifications_noprompt.m
%               newrunspecifications_prompt.m 
%
%  and figure specifications entered via either:
% 
%           figurespecifications_prompt.m
%           figurespecification_noprompt.m
%
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
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
    filename=strcat(date,'_Susceptible_HeatMap');
    [figurehandle,figurecounter]=...
    heatmapplot(HS,bifpar1,bifpar2,increm1,increm2,lc,bp1label,...
    bp2label,figuretitle,figurecounter);
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

    % Infectious Population
    figuretitle={sprintf('%s:',latexdate),'Infected Population'};
    filename=strcat(date,'_Infectious_HeatMap');
    [figurehandle,figurecounter]=...
    heatmapplot(HI,bifpar1,bifpar2,increm1,increm2,lc,bp1label,...
    bp2label,figuretitle,figurecounter);
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

    % Total With-Disease Population
    figuretitle={sprintf('%s:',latexdate),'Total (WD) Population'};
    filename=strcat(date,'_TotalWD_HeatMap');
    [figurehandle,figurecounter]=...
    heatmapplot(HT,bifpar1,bifpar2,increm1,increm2,lc,bp1label,...
    bp2label,figuretitle,figurecounter);
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

     % Total Disease-Free Population
    figuretitle={sprintf('%s:',latexdate),'Total (DF) Population'};
    filename=strcat(date,'_TotalDF_HeatMap');
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
    filename=strcat(date,'_Suceptible_AvgMap');
    [figurehandle,figurecounter]=...
    averagepopulationplot(Savg,bifpar1,bifpar2,increm1,increm2,...
    bp1label,bp2label,figuretitle,figurecounter);
    figurehandles{figurecounter}=figurehandle;
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

    % Average Infectious Population 
    figuretitle={sprintf('%s:',latexdate),'Average Infectious Population'};
    filename=strcat(date,'_Infectious_AvgMap');
    [figurehandle,figurecounter]=...
        averagepopulationplot(Iavg,bifpar1,bifpar2,increm1,increm2,...
        bp1label,bp2label,figuretitle,figurecounter);
    figurehandles{figurecounter}=figurehandle;
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

     % Average Total (WD) Population 
     figuretitle={sprintf('%s:',latexdate),'Average Total (WD) Population'};
    filename=strcat(date,'_TotalWD_AvgMap');
    [figurehandle,figurecounter]=...
    averagepopulationplot(Tavg,bifpar1,bifpar2,increm1,increm2,...
    bp1label,bp2label,figuretitle,figurecounter);
    figurehandles{figurecounter}=figurehandle;
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

     % Average Total (DF) Population
    figuretitle={sprintf('%s:',latexdate),'Average Total (DF) Population'};
    filename=strcat(date,'_TotalDF_AvgMap');
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
    filename=strcat(date,'_InfectionInducedIncrease_Linear');
    colorbarlabel='Relative Percent Increase In Total Population';
    [figurehandle,figurecounter]=hydraeffectplot(...
        'LinearScaleHydra',ContinuousHydra,bifpar1,bifpar2,'none',...
        increm1,increm2,bp1label,bp2label,colorbarlabel,...
        figuretitle,figurecounter);
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

    % Plot Fold-Change Visualization of Infection-Induced Population Change 
    figuretitle={sprintf('%s:',latexdate),'Population Change (Fold Change)'};
    filename=strcat(date,'_InfectionInducedInrease_FoldChange');
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
    filename=strcat(date,'_InfectionInducedIncrease_Binary');
    colorbarlabel='HydraEffect';
    [figurehandle,figurecounter]=hydraeffectplot(...
        'BinaryHydra',BinaryHydra,bifpar1,bifpar2,0,increm1,increm2,...
        bp1label,bp2label,colorbarlabel,figuretitle,figurecounter);
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

    % Plot Linear-Scale Visualization of Infection-Induced Hydra-Effect 
    figuretitle={sprintf('%s:',latexdate),'Hydra Effect (Linear Scale)'};
    filename=strcat(date,'_InfectionInducedIncrease_LinearHydra');
    colorbarlabel='Relative Percent Increase In Total Population';
    [figurehandle,figurecounter]=hydraeffectplot(...
        'LinearScaleHydra',ContinuousHydra,bifpar1,bifpar2,hydrathreshold,...
        increm1,increm2,bp1label,bp2label,colorbarlabel,...
        figuretitle,figurecounter);
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

    % Plot Fold-Change Visualization of Infection-Induced Hydra-Effect 
    figuretitle={sprintf('%s:',latexdate),'Hydra Effect (Fold-Change)'};
    filename=strcat(date,'_InfectionInducedIncrease_FoldChangeHydra');
    colorbarlabel='Population Fold Change';
    [figurehandle,figurecounter]=hydraeffectplot(...
        'FoldChangeHydra',FoldChangeHydra,bifpar1,bifpar2,hydrathreshold,...
        increm1,increm2,bp1label,bp2label,colorbarlabel,figuretitle,...
        figurecounter);
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

end

%% (04) PLOT BATCH INITIAL CONDITION HYDRA PLOTS

    if batchhydra ==1
        filename=strcat(date,'_BatchHydra');


        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;
    end

%% (05) PLOT ORBIT MAPS

if orbit ==1
    for i=1:1:orbitcount

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
            sprintf('Susceptible Population [%s = %0.2f]',...
            bpconstant{i},bpconstantvalue(i))};
        filename=strcat(date,'_Suceptible_Orbit');
        legendentries={'Susceptible Population','Susceptible Average'};
        [figurehandle,figurecounter]=op(bifpar{i},S_plot,Savg_plot,...
            bpidentity(i),bpconstantvalue(i),figuretitle,bplabel{i},...
            'Quantity of Susceptible Individuals',legendentries,...
            figurecounter);
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;
    
        %Infectious Population
        figuretitle={sprintf('%s:',latexdate),...
            sprintf('Infectious Population [%s = %0.2f]',...
            bpconstant{i},bpconstantvalue(i))};
        filename=strcat(date,'_Infectious_Orbit');
        legendentries={'Infectious Population','Infectious Average'};
        [figurehandle,figurecounter]=op(bifpar{i},I_plot,Iavg_plot,...
            bpidentity(i),bpconstantvalue(i),figuretitle,bplabel{i},...
            'Quantity of Infected Individuals',legendentries,figurecounter);
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;
            
        %Total (WD) Population
        figuretitle={sprintf('%s:',latexdate),...
            sprintf('Total (WD) Population [%s = %0.2f]',...
            bpconstant{i},bpconstantvalue(i))};
        filename=strcat(date,'_TotalWD_Orbit');
        legendentries={'Total Population','Total Average'};
        [figurehandle,figurecounter]=op(bifpar{i},T_plot,Tavg_plot,...
            bpidentity(i),bpconstantvalue(i),figuretitle,bplabel{i},...
            'Total Quantity of Individuals (WD)',legendentries,...
            figurecounter);
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;
            
        %Total (DF) Population
        figuretitle={sprintf('%s:',latexdate),...
            sprintf('Total (DF) Population [%s = %0.2f]',...
            bpconstant{i},bpconstantvalue(i))};
        filename=strcat(date,'_TotalDF_Orbit');
        legendentries={'Disease-Free Population','Disease-Free Average'};
        [figurehandle,figurecounter]=op(bifpar{i},S_DFplot,SDFavg_plot,...
            bpidentity(i),bpconstantvalue(i),figuretitle,bplabel{i},...
            'Total Quantity of Individuals (DF)',legendentries,...
            figurecounter);
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;

        %Absolute Difference between WD and DF Populations
        AbsDiff=abs(T_plot - S_DFplot);
        AbsDiffavg=abs(Tavg_plot-SDFavg_plot);
        figuretitle={sprintf('%s:',latexdate),...
            sprintf('Abs. Diff. btwn WD and DF Populations [%s = %0.2f]',...
            bpconstant{i},bpconstantvalue(i))};
        filename=strcat(date,'_AbsoluteDifference_Orbit');
        legendentries={'Absolute Difference',''};
        [figurehandle,figurecounter]=op(bifpar{i},AbsDiff,AbsDiffavg,...
            bpidentity(i),bpconstantvalue(i),figuretitle,bplabel{i},...
            'Total Quantity of Individuals (DF)',legendentries,...
            figurecounter);
        avgline=figurehandle.Children(2).Children(1);
        delete(avgline)
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;

        clear S_plot I_plot T_plot S_DFplot Savg_plot Iavg_plot Tavg_plot SDFavg_plot
   end
end

%% (06) PLOT TRAJECTORIES

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
            filename=strcat(date,'_Suceptible_Trajectory_',traj_desc{i});
            legendentry='';
            ylabel='Susectible Population';
            [figurehandle, figurecounter] = trajectoryplot(...
                t,S,legendentry,ylabel,figuretitle,figurecounter);
            FileNames{figurecounter}=filename;
            FigHandles{figurecounter}=figurehandle;

            % Plot Infectious Population
            figuretitle={latexdate, traj_desc{i}};
            filename=strcat(date,'_Infectious_Trajectory_',traj_desc{i});
            legendentry='';
            ylabel='Infectious Population';
            [figurehandle, figurecounter] = trajectoryplot(...
                t,I,legendentry,ylabel,figuretitle,figurecounter);
            FileNames{figurecounter}=filename;
            FigHandles{figurecounter}=figurehandle;

            % Plot Total (WD) Population
            figuretitle={latexdate, traj_desc{i}};
            filename=strcat(date,'_TotalWD_Trajectory_',traj_desc{i});
            legendentry='';
            ylabel='Total (WD) Population';
            [figurehandle, figurecounter] = trajectoryplot(...
                t,Tot,legendentry,ylabel,figuretitle,figurecounter);
            FileNames{figurecounter}=filename;
            FigHandles{figurecounter}=figurehandle;

            % Plot Total (DF) Population
            figuretitle={latexdate, traj_desc{i}};
            filename=strcat(date,'_TotalDF_Trajectory_',traj_desc{i});
            legendentry='';
            ylabel= 'Total (DF) Population';
            [figurehandle, figurecounter] = trajectoryplot(...
                t,XDF,legendentry,ylabel,figuretitle,figurecounter);
            FileNames{figurecounter}=filename;
            FigHandles{figurecounter}=figurehandle;

            % Plot Absolute Difference (between WD and DF)
            figuretitle={latexdate, traj_desc{i}};
            filename=strcat(date,'_AbsoluteDifference_Trajectory_',traj_desc{i});
            legendentry='';
            [figurehandle, figurecounter] = trajectoryplot(...
                t,AbsDiff,legendentry,ylabel,figuretitle,figurecounter);
            FileNames{figurecounter}=filename;
            FigHandles{figurecounter}=figurehandle;

        end
    end

%==========================================================================
%% END SCRIPT
%==========================================================================