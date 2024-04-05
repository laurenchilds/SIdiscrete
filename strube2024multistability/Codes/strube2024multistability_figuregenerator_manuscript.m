% strube2024multistability_figuregenerator_manuscript

%==========================================================================
%% SCRIPT DESCRIPTION
%==========================================================================
    % This function contains indexed figure generation instructions for the 
    % generation of figures in:
%
%       LF Strube and LM Childs. Multistability in a discrete-time SI 
%       epidemic model with Ricker growth: Infection-induced changes in 
%       population dynamics. Contemporary Mathematics. 793, 167:190 (2024). 
%
%
%   INPUTS:
%   -------
%   Workspace variables created by the user in strube2024multistability_driver.m
%
%   OUTPUTS:
%   --------
%   FileNames:              Array of figure filenames for figure storage
%   FigHandles:             Array of figure handles for figure storage
%   Generation of the figure corresponding to figchoice 
%   
%   DEPENDENCIES:
%   -------------
%   None
%
%   USED BY:
%   --------
%   strube2024multistability_driver.m
%
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
%
%% -----------------------------------------------------------------------
%==========================================================================
%% SCRIPT START
%==========================================================================

%% INITIALIZE FIGURE COUNTER AND FIGURE HANDLES ARRAY

    figurecounter=0;
    FileNames={};
    FigHandles={};

%% Choice 01: Figure 02a
if figchoice == 01     % Figure 2a - Total Population Heat Map & Orbit Maps

    %Left
        figuretitle={'Figure 02a left' 'Total Population (WD) Limit Cycle Sizes'};
        filename = 'Reproduction_strube2024multistability_F02aleft';
    
        [figurehandle,figurecounter]=heatmapplot(HT,bifpar1,bifpar2,increm1,increm2,lc,bp1label,bp2label,...
            figuretitle,figurecounter);
        
        hold on
        plot([0 1],[60,60],'-','Color','white','LineWidth',4)
    
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;

    % Middle
    
        % Set parameter choices
        bp=bp2; %name of bifurcation parameter
        bpidentity=bifpar2;
        bplabel=bp2label;
        bifpar = bp2i; %bifurcation parameter increments
        bpset=60;
        bpindex=find(bp1i>=bpset,1,'first');
        bpconstantvalue=bp1i(bpindex); %value of "fixed bifurcation parameter
        bpconststr=strrep(sprintf('%0.4f',bpconstantvalue),'.','p'); %string describing value of "fixed" parameter
    
        figuretitle={'Figure 02a middle',sprintf('Total (WD) Population [%s = %0.3f]',bp1label,bpconstantvalue)};
        filename = 'Reproduction_strube2024multistability_F02amiddle';
    
        % Collect Orbit Map Data
        T_plot(:,:)=T(bpindex,:,:);
        Tavg_plot=Tavg(bpindex,:);
    
        % Total (WD) Population
        legendentries={'Total Population','Total Population Average'};
        [figurehandle,figurecounter]=orbitplot(bifpar,T_plot,Tavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'Total Quantity of Individuals (WD)',legendentries,figurecounter);

        % Delete Population Average Line
        delete(figurehandle.Children(2).Children(1))

        % Set axis ranges
        xlim([0 1])
        ylim([0 400])

        % Store File Name and Figure Handle
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;

    % Right

        % Set parameter choices
        bp=bp2; %name of bifurcation parameter
        bpidentity=bifpar2;
        bplabel=bp2label;
        bifpar = bp2i; %bifurcation parameter increments
        bpset=60;
        bpindex=find(bp1i>=bpset,1,'first');
        bpconstantvalue=bp1i(bpindex); %value of "fixed bifurcation parameter
        bpconststr=strrep(sprintf('%0.4f',bpconstantvalue),'.','p'); %string describing value of "fixed" parameter
    
        figuretitle={'Figure 02a right',sprintf('Total (WD) Population [%s = %0.3f]',bp1label,bpconstantvalue)};
        filename = 'Reproduction_strube2024multistability_F02aright';
    
        % Collect Orbit Map Data
        I_plot(:,:)=I(bpindex,:,:);
        Iavg_plot=Iavg(bpindex,:);

        %Total (WD) Population
        legendentries={'Infectious Population','Infectious Population Average'};
        [figurehandle,figurecounter]=orbitplot(bifpar,I_plot,Iavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'Infectious Individuals',legendentries,figurecounter);

        %Delete Population Average Line
        delete(figurehandle.Children(2).Children(1))

        % Set axis ranges
        xlim([0 1])
        ylim([0 400])

        % Store File Name and Figure Handle
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;

%% Choice 02: Figure 02b
elseif figchoice == 02 % Figure 2b - Total Population Heat Map & Orbit Maps
    
    %Left
        figuretitle={'Figure 02b left' 'Total Population (WD) Limit Cycle Sizes'};
        filename = 'Reproduction_strube2024multistability_F02bleft';
    
        [figurehandle,figurecounter]=heatmapplot(HT,bifpar1,bifpar2,increm1,increm2,lc,bp1label,bp2label,...
            figuretitle,figurecounter);
    
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;


    % Middle
    
        % Set parameter choices
        bp=bp2; %name of bifurcation parameter
        bpidentity=bifpar2;
        bplabel=bp2label;
        bifpar = bp2i; %bifurcation parameter increments
        bpset=60;
        bpindex=find(bp1i>=bpset,1,'first');
        bpconstantvalue=bp1i(bpindex); %value of "fixed bifurcation parameter
        bpconststr=strrep(sprintf('%0.4f',bpconstantvalue),'.','p'); %string describing value of "fixed" parameter
    
        figuretitle={'Figure 02b middle',sprintf('Total (WD) Population [%s = %0.3f]',bp1label,bpconstantvalue)};
        filename = 'Reproduction_strube2024multistability_F02bmiddle';
    
        % Collect Orbit Map Data
        T_plot(:,:)=T(bpindex,:,:);
        Tavg_plot=Tavg(bpindex,:);

        %Total (WD) Population
        legendentries={'Total Population','Total Population Average'};
        [figurehandle,figurecounter]=orbitplot(bifpar,T_plot,Tavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'Total Quantity of Individuals (WD)',legendentries,figurecounter);

        %Delete Population Average Line
        delete(figurehandle.Children(2).Children(1))

        % Set axis ranges
        xlim([0 1])
        ylim([0 400])

        % Store File Name and Figure Handle
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;

    % Right

        % Set parameter choices
        bp=bp2; %name of bifurcation parameter
        bpidentity=bifpar2;
        bplabel=bp2label;
        bifpar = bp2i; %bifurcation parameter increments
        bpset=60;
        bpindex=find(bp1i>=bpset,1,'first');
        bpconstantvalue=bp1i(bpindex); %value of "fixed bifurcation parameter
        bpconststr=strrep(sprintf('%0.4f',bpconstantvalue),'.','p'); %string describing value of "fixed" parameter
    
        figuretitle={'Figure 02b right',sprintf('Total (WD) Population [%s = %0.3f]',bp1label,bpconstantvalue)};
        filename = 'Reproduction_strube2024multistability_F02bright';
    
        % Collect Orbit Map Data
        I_plot(:,:)=I(bpindex,:,:);
        Iavg_plot=Iavg(bpindex,:);

        %Total (WD) Population
        legendentries={'Infectious Population','Infectious Population Average'};
        [figurehandle,figurecounter]=orbitplot(bifpar,I_plot,Iavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'Infectious Individuals',legendentries,figurecounter);

        %Delete Population Average Line
        delete(figurehandle.Children(2).Children(1))

        % Set axis ranges
        xlim([0 1])
        ylim([0 400])

        % Store File Name and Figure Handle
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;


%% Choice 03: Figure 02c
elseif figchoice == 03 % Figure 2c - Total Population Heat Map & Orbit Maps
        
    %Left
        figuretitle={'Figure 02c left' 'Total Population (WD) Limit Cycle Sizes'};
        filename = 'Reproduction_strube2024multistability_F02cleft';
    
        [figurehandle,figurecounter]=heatmapplot(HT,bifpar1,bifpar2,increm1,increm2,lc,bp1label,bp2label,...
            figuretitle,figurecounter);
    
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;


    % Middle
    
        % Set parameter choices
        bp=bp2; %name of bifurcation parameter
        bpidentity=bifpar2;
        bplabel=bp2label;
        bifpar = bp2i; %bifurcation parameter increments
        bpset=60;
        bpindex=find(bp1i>=bpset,1,'first');
        bpconstantvalue=bp1i(bpindex); %value of "fixed bifurcation parameter
        bpconststr=strrep(sprintf('%0.4f',bpconstantvalue),'.','p'); %string describing value of "fixed" parameter
    
        figuretitle={'Figure 02c middle',sprintf('Total (WD) Population [%s = %0.3f]',bp1label,bpconstantvalue)};
        filename = 'Reproduction_strube2024multistability_F02cmiddle';
    
        % Collect Orbit Map Data
        T_plot(:,:)=T(bpindex,:,:);
        Tavg_plot=Tavg(bpindex,:);
    
        %Total (WD) Population
        legendentries={'Total Population','Total Population Average'};
        [figurehandle,figurecounter]=orbitplot(bifpar,T_plot,Tavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'Total Quantity of Individuals (WD)',legendentries,figurecounter);

        %Delete Population Average Line
        delete(figurehandle.Children(2).Children(1))

        % Set axis ranges
        xlim([0 1])
        ylim([0 400])

        % Store File Name and Figure Handle
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;

    % Right

        % Set parameter choices
        bp=bp2; %name of bifurcation parameter
        bpidentity=bifpar2;
        bplabel=bp2label;
        bifpar = bp2i; %bifurcation parameter increments
        bpset=60;
        bpindex=find(bp1i>=bpset,1,'first');
        bpconstantvalue=bp1i(bpindex); %value of "fixed bifurcation parameter
        bpconststr=strrep(sprintf('%0.4f',bpconstantvalue),'.','p'); %string describing value of "fixed" parameter
    
        figuretitle={'Figure 02c right',sprintf('Total (WD) Population [%s = %0.3f]',bp1label,bpconstantvalue)};
        filename = 'Reproduction_strube2024multistability_F02cright';
    
        % Collect Orbit Map Data
        I_plot(:,:)=I(bpindex,:,:);
        Iavg_plot=Iavg(bpindex,:);

        %Total (WD) Population
        legendentries={'Infectious Population','Infectious Population Average'};
        [figurehandle,figurecounter]=orbitplot(bifpar,I_plot,Iavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'Infectious Individuals',legendentries,figurecounter);

        %Delete Population Average Line
        delete(figurehandle.Children(2).Children(1))

        % Set axis ranges
        xlim([0 1])
        ylim([0 400])

        % Store File Name and Figure Handle
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;



%% Choice 04: Figure 02d
elseif figchoice == 04 % Figure 2d - Total Population Heat Map & Orbit Maps
        
    %Left
        figuretitle={'Figure 02d left' 'Total Population (WD) Limit Cycle Sizes'};
        filename = 'Reproduction_strube2024multistability_F02dleft';
    
        [figurehandle,figurecounter]=heatmapplot(HT,bifpar1,bifpar2,increm1,increm2,lc,bp1label,bp2label,...
            figuretitle,figurecounter);
    
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;


    % Middle
    
        % Set parameter choices
        bp=bp2; %name of bifurcation parameter
        bpidentity=bifpar2;
        bplabel=bp2label;
        bifpar = bp2i; %bifurcation parameter increments
        bpset=60;
        bpindex=find(bp1i>=bpset,1,'first');
        bpconstantvalue=bp1i(bpindex); %value of "fixed bifurcation parameter
        bpconststr=strrep(sprintf('%0.4f',bpconstantvalue),'.','p'); %string describing value of "fixed" parameter
    
        figuretitle={'Figure 02d middle',sprintf('Total (WD) Population [%s = %0.3f]',bp1label,bpconstantvalue)};
        filename = 'Reproduction_strube2024multistability_F02dmiddle';
    
        % Collect Orbit Map Data
        T_plot(:,:)=T(bpindex,:,:);
        Tavg_plot=Tavg(bpindex,:);

        %Total (WD) Population
        legendentries={'Total Population','Total Population Average'};
        [figurehandle,figurecounter]=orbitplot(bifpar,T_plot,Tavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'Total Quantity of Individuals (WD)',legendentries,figurecounter);

        %Delete Population Average Line
        delete(figurehandle.Children(2).Children(1))

        % Set axis ranges
        xlim([0 1])
        ylim([0 400])

        % Store File Name and Figure Handle
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;

    % Right

        % Set parameter choices
        bp=bp2; %name of bifurcation parameter
        bpidentity=bifpar2;
        bplabel=bp2label;
        bifpar = bp2i; %bifurcation parameter increments
        bpset=60;
        bpindex=find(bp1i>=bpset,1,'first');
        bpconstantvalue=bp1i(bpindex); %value of "fixed bifurcation parameter
        bpconststr=strrep(sprintf('%0.4f',bpconstantvalue),'.','p'); %string describing value of "fixed" parameter
    
        figuretitle={'Figure 02d right',sprintf('Total (WD) Population [%s = %0.3f]',bp1label,bpconstantvalue)};
        filename = 'Reproduction_strube2024multistability_F02dright';
    
        % Collect Orbit Map Data
        I_plot(:,:)=I(bpindex,:,:);
        Iavg_plot=Iavg(bpindex,:);

        %Total (WD) Population
        legendentries={'Infectious Population','Infectious Population Average'};
        [figurehandle,figurecounter]=orbitplot(bifpar,I_plot,Iavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'Infectious Individuals',legendentries,figurecounter);

        %Delete Population Average Line
        delete(figurehandle.Children(2).Children(1))

        % Set axis ranges
        xlim([0 1])
        ylim([0 400])

        % Store File Name and Figure Handle
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;



%% Choice 05: Figure 03a
elseif figchoice == 05 % Figure 3a Total Pop. Limit Cycle Sizes
    
    figuretitle={'Figure 03a' 'Total Population (WD) Limit Cycle Sizes'};
    filename = 'Reproduction_strube2024multistability_F03a';

    [figurehandle,figurecounter]=heatmapplot(HT,bifpar1,bifpar2,increm1,increm2,lc,bp1label,bp2label,...
        figuretitle,figurecounter);

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 06: Figure 03b
elseif figchoice == 06 % Figure 3b - Total Pop. Limit Cycle Sizes
    
    figuretitle={'Figure 03b' 'Total Population (WD) Limit Cycle Sizes'};
    filename = 'Reproduction_strube2024multistability_F03b';

    [figurehandle,figurecounter]=heatmapplot(HT,bifpar1,bifpar2,increm1,increm2,lc,bp1label,bp2label,...
        figuretitle,figurecounter);

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 07: Figue 03c
elseif figchoice == 07 % Figure 3c - Total Pop. Limit Cycle Sizes

    figuretitle={'Figure 03c' 'Total Population (WD) Limit Cycle Sizes'};
    filename = 'Reproduction_strube2024multistability_F03c';

    [figurehandle,figurecounter]=heatmapplot(HT,bifpar1,bifpar2,increm1,increm2,lc,bp1label,bp2label,...
        figuretitle,figurecounter);

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 08: Figure 04ac
elseif figchoice == 08 % Figure 4a Total Pop. Limit Cycle Size and 4c Orbit Map

    % Figure 04a
        figuretitle={'Figure 04a' 'Total Population (WD) Limit Cycle Sizes'};
        filename = 'Reproduction_strube2024multistability_F04a';
    
        [figurehandle,figurecounter]=heatmapplot(HT,bifpar1,bifpar2,increm1,increm2,lc,bp1label,bp2label,...
            figuretitle,figurecounter);
    
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;


    % Figure 04c

        % Set parameter choices
        bp=bp1; %name of bifurcation parameter
        bpidentity=bifpar1;
        bplabel=bp1label;
        bifpar = bp1i; %bifurcation parameter increments
        bpset=0.475;
        bpindex=find(bp2i>=bpset,1,'first');
        bpconstantvalue=bp2i(bpindex); %value of "fixed bifurcation parameter
        bpconststr=strrep(sprintf('%0.4f',bpconstantvalue),'.','p'); %string describing value of "fixed" parameter
    
        figuretitle={'Figure 04c',sprintf('Total (WD) Population [%s = %0.3f]',bp2label,bpconstantvalue)};
        filename = 'Reproduction_strube2024multistability_F04c';
    
        % Collect Orbit Map Data
        T_plot(:,:)=T(:,bpindex,:);
        Tavg_plot=Tavg(:,bpindex,:);

        %Total (WD) Population
        legendentries={'Total (WD) Population','Total Population Average'};
        [figurehandle,figurecounter]=orbitplot(bifpar,T_plot,Tavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'individuals',legendentries,figurecounter);

        %Delete Population Average Line
        delete(figurehandle.Children(2).Children(1))

        % Add Red Line
        hold on
        plot([130.5,130.5],[0,450],'--r','LineWidth',2,'HandleVisibility', 'off');

        % Axis Limits
        xlim([0 150])
        ylim([0 450])

        % Store File Name and Figure Handle
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;
   

%% Choice 09: Figure 04bd
elseif figchoice == 09 % Figure 4b Total Pop. Limit Cycle Size and 4d Orbit Map

    % Figure 04b
        figuretitle={'Figure 04b' 'Total Population (WD) Limit Cycle Sizes'};
        filename = 'Reproduction_strube2024multistability_F04b';
    
        [figurehandle,figurecounter]=heatmapplot(HT,bifpar1,bifpar2,increm1,increm2,lc,bp1label,bp2label,...
            figuretitle,figurecounter);
    
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;

    % Figure 04d

        % Set parameter choices
        bp=bp1; %name of bifurcation parameter
        bpidentity=bifpar1;
        bplabel=bp1label;
        bifpar = bp1i; %bifurcation parameter increments
        bpset=0.475;
        bpindex=find(bp2i>=bpset,1,'first');
        bpconstantvalue=bp2i(bpindex); %value of "fixed bifurcation parameter
        bpconststr=strrep(sprintf('%0.4f',bpconstantvalue),'.','p'); %string describing value of "fixed" parameter
    
        figuretitle={'Figure 04d',sprintf('Total (WD) Population [%s = %0.3f]',bp2label,bpconstantvalue)};
        filename = 'Reproduction_strube2024multistability_F04d';
    
        % Collect Orbit Map Data
        T_plot(:,:)=T(:,bpindex,:);
        Tavg_plot=Tavg(:,bpindex,:);

        % Total (WD) Population
        legendentries={'Total (WD) Population','Total Population Average'};
        [figurehandle,figurecounter]=orbitplot(bifpar,T_plot,Tavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'individuals',legendentries,figurecounter);

        % Delete Population Average Line
        delete(figurehandle.Children(2).Children(1))

        % Add Red Line
        hold on
        plot([115.5,115.5],[0,450],'--r','LineWidth',2,'HandleVisibility', 'off');

        % Axis Limits
        xlim([0 150])
        ylim([0 450])

        % Store File Name and Figure Handle
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;
    

%% Choice 10: Figure 05a
elseif figchoice == 10 % Figure 5a

    % Figure 05a
        figuretitle={'Figure 05a left' 'Total Population (WD) Limit Cycle Sizes'};
        filename = 'Reproduction_strube2024multistability_F05aleft';
    
        [figurehandle,figurecounter]=heatmapplot(HT,bifpar1,bifpar2,increm1,increm2,lc,bp1label,bp2label,...
            figuretitle,figurecounter);

        hold on

        % Add white dots
        plot([45,20],[125,150],'o','MarkerFaceColor','white','MarkerEdgeColor','white','MarkerSize',5)
    
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;

    % Figure 05b
        figuretitle={'Figure 05a right' 'Total Population (WD) Limit Cycle Sizes'};
        filename = 'Reproduction_strube2024multistability_F05aright';
    
        [figurehandle,figurecounter]=heatmapplot(HT,bifpar1,bifpar2,increm1,increm2,lc,bp1label,bp2label,...
            figuretitle,figurecounter);

        hold on

        % Add white dots
        plot([45,20],[125,150],'o','MarkerFaceColor','white','MarkerEdgeColor','white','MarkerSize',5)
    
        % Set axis limits
        xlim([0 100])
        ylim([100 200])
    
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;

%% Choice 11: Figure 05b
elseif figchoice == 11 % Figure 5b
    
    % Figure 05c
        figuretitle={'Figure 05b left' 'Total Population (WD) Limit Cycle Sizes'};
        filename = 'Reproduction_strube2024multistability_F05bleft';
    
        [figurehandle,figurecounter]=heatmapplot(HT,bifpar1,bifpar2,increm1,increm2,lc,bp1label,bp2label,...
            figuretitle,figurecounter);
    
        hold on

        % Add white dots
        plot([45,20],[125,150],'o','MarkerFaceColor','white','MarkerEdgeColor','white','MarkerSize',5)
    
        % Store file name and handle
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;
   
    % Figure 05c
        figuretitle={'Figure 05b right' 'Total Population (WD) Limit Cycle Sizes'};
        filename = 'Reproduction_strube2024multistability_F05bright';
    
        [figurehandle,figurecounter]=heatmapplot(HT,bifpar1,bifpar2,increm1,increm2,lc,bp1label,bp2label,...
            figuretitle,figurecounter);

        hold on

        % Add white dots
        plot([45,20],[125,150],'o','MarkerFaceColor','white','MarkerEdgeColor','white','MarkerSize',5)
    
        % Set axis limits
        xlim([0 100])
        ylim([100 200])

        % Store file name and handle
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;

%% Choice 12: Figure 06, 07, A02, and A04
elseif figchoice == 12 

    % LATIN HYPERCUBE VISUALIZATION (Figure A02

    figuretitle={'Figure A02','LHS Values'};
    filename='Reproduction_strube2024multistability_A02';
    [figurehandle,figurecounter]=lhsvisualization(B,figuretitle,figurecounter);
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;


    % COMPILED LIMIT CYCLE PLOTS
    figuretitle={'Figure 06'};
    [figurehandles,filenames,figurecounter]=compiled_limitcycleplot(B,'Heat_TDataArray',figuretitle,figurecounter);
    for i=1:1:length(filenames)
        FileNames=[FileNames,sprintf('Reproduction_strube2024multistability_F06_%02d',i)];
    end
    FigHandles=[FigHandles,figurehandles];


    %TOTAL WITH-DISEASE POPULATION MULTISTABILITY PLOT
    figuretitle={'Figure 07','Regions of Multistability'};
    filename='Reproduction_strube2024multistability_F07';
    [figurehandle,figurecounter]= multistabilityplot(3,B,'Heat_TDataArray',figuretitle,figurecounter);

    hold on

    plot(0.424,103.5,'.','Color','white','MarkerSize',20)
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

    % TOTAL DISEASE-FREE POPULATION MULTISTABILITY PLOT
    figuretitle={'Figure A04','Numerical Error: False detection of multistability','r incremented in steps of 0.5','d incremented in steps of 0.001'};
    filename='Reproduction_strube2024multistability_A04';
    [figurehandle,figurecounter]= multistabilityplot(2,B,'Heat_DFDataArray',figuretitle,figurecounter);

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;


%% Choice 14: Figure A01
elseif figchoice == 13 % Figure A01
    
    % Figure A01 left
        figuretitle={'Figure A01 left' 'Total Population (WD) Limit Cycle Sizes'};
        filename = 'Reproduction_strube2024multistability_A01left';
    
        [figurehandle,figurecounter]=heatmapplot(HT,bifpar1,bifpar2,increm1,increm2,lc,bp1label,bp2label,...
            figuretitle,figurecounter);
    
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;

    % Figure A01 middle
        figuretitle={'Figure A01 middle' 'Susceptible Population Limit Cycle Sizes'};
        filename = 'Reproduction_strube2024multistability_A01middle';
    
        [figurehandle,figurecounter]=heatmapplot(HS,bifpar1,bifpar2,increm1,increm2,lc,bp1label,bp2label,...
            figuretitle,figurecounter);
    
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;

     % Figure A01 right
        figuretitle={'Figure A01 right' 'Infectious Population Limit Cycle Sizes'};
        filename = 'Reproduction_strube2024multistability_A01right';
    
        [figurehandle,figurecounter]=heatmapplot(HI,bifpar1,bifpar2,increm1,increm2,lc,bp1label,bp2label,...
            figuretitle,figurecounter);
    
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;

%% Choice 16: Figure A03
elseif figchoice == 14 % Figure A03

        % Set parameter choices
        bp=bp1; %name of bifurcation parameter
        bpidentity=bifpar1;
        bplabel=bp1label;
        bifpar = bp1i; %bifurcation parameter increments
        bpset=0.424;
        bpindex=find(bp2i>=bpset,1,'first');
        bpconstantvalue=bp2i(bpindex); %value of "fixed bifurcation parameter
        bpconststr=strrep(sprintf('%0.4f',bpconstantvalue),'.','p'); %string describing value of "fixed" parameter
    
        figuretitle={'Figure A03',sprintf('Total (WD) Population [%s = %0.3f]',bp1label,bpconstantvalue)};
        filename = 'Reproduction_strube2024multistability_A03';
    
        % Collect Orbit Map Data
        T_plot(:,:)=T(:,bpindex,:);
        Tavg_plot=Tavg(:,bpindex,:);

        %Total (WD) Population
        legendentries={'Total (WD) Population','Total Population Average'};
        [figurehandle,figurecounter]=orbitplot(bifpar,T_plot,Tavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'Infectious Individuals',legendentries,figurecounter);

        %Delete Population Average Line
        delete(figurehandle.Children(2).Children(1))

        % Add Red Line
        hold on
        plot([103.5,103.5],[0,450],'--r','LineWidth',2,'HandleVisibility', 'off');

        % Set axes limits
        xlim([0 150])
        ylim([0 450])

        % Store File Name and Figure Handle
        FileNames{figurecounter}=filename;
        FigHandles{figurecounter}=figurehandle;
end

%==========================================================================
%% SCRIPT END
%==========================================================================
