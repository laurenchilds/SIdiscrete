%figuregenerator_manuscript

%==========================================================================
%% SCRIPT DESCRIPTION
%==========================================================================
% This script generates figures from the manuscript
%
%       LF Strube, S Elgart, and LM Childs. Infection induced increases
%       to population size during cycles in a discrete-time epidemic model. 
%       Journal of Mathematical Biology. Vol:Article (2024). 
%
%
%   INPUTS:
%   -------
%   Workspace variables created by the user in strube2024infection_driver.m
%
%   OUTPUTS:
%   --------
%   Figure generation 
%
%
%   DEPENDENCIES:
%   -------------
%   None
%
%   USED BY:
%   --------
%   strube2024infection_driver.m
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
%% -----------------------------------------------------------------------
%==========================================================================
%% SCRIPT START
%==========================================================================

%% INITIALIZE FIGURE COUNTER AND FIGURE HANDLES ARRAY
figurecounter=0;
FigHandles={};

%% Choice 01: Figure 01b
if figchoice == 01     % Figure 1b

%% Choice 02: Figure 02a
elseif figchoice == 02 % Figure 2a - Total Population Heat Map
    
    figuretitle={'Figure 02a' 'Total Population (WD) Limit Cycle Sizes'};
    filename = 'Reproduction_strube2024infection_F02a';

    points_x=[0.52,0.52,0.21,0.35];
    points_y=[8.5,50,260,260];
    [figurehandle,figurecounter]=hmp(HT,bifpar1,bifpar2,increm1,increm2,lc,bp1label,bp2label,...
        figuretitle,figurecounter);
    hold on
    plot(points_x,points_y,'w.','MarkerSize',20)
    hold off

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 03: Figure 02b left
elseif figchoice == 03 % Figure 2b left - Total Population Heat Map
    
    figuretitle={'Figure 02b left','Total Population (WD) Limit Cycle Sizes'};
    filename = 'Reproduction_strube2024infection_F02a';

    [figurehandle,figurecounter]=hmp(HT,bifpar1,bifpar2,increm1,increm2,lc,bp1label,bp2label,...
        figuretitle,figurecounter);

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 04: Figure 02b right
elseif figchoice == 04 % Figure 2b right - Total Population Heat Map
    
    figuretitle={'Figure 02b right','Total Population (WD) Limit Cycle Sizes'};
    filename = 'Reproduction_strube2024infection_F02b';

    [figurehandle,figurecounter]=hmp(HT,bifpar1,bifpar2,increm1,increm2,lc,bp1label,bp2label,...
        figuretitle,figurecounter);

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 05: Figure 02c left
elseif figchoice == 05 % Figure 2c left - Average Total Pop. Heat Map
    
    figuretitle={'Figure 02c left','Average Total (WD) Population Size'};
    filename = 'Reproduction_strube2024infection_F02c';

    [figurehandle,figurecounter]=avgplot(Tavg,bifpar1,bifpar2,increm1,increm2,bp1label,bp2label,...
        figuretitle,figurecounter);

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 06: Figure 02c right
elseif figchoice == 06 % Figure 2c right - Average Total Pop. Heat Map
    
    figuretitle={'Figure 02c right','Average Total (WD) Population Size'};
    filename = 'Reproduction_strube2024infection_F02c';

    [figurehandle,figurecounter]=avgplot(Tavg,bifpar1,bifpar2,increm1,increm2,bp1label,bp2label,...
        figuretitle,figurecounter);

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 07: Figue 02d left
 elseif figchoice == 07 % Figure 2d left - Orbit Map

    % Set parameter choices
    bp=bp1; %name of bifurcation parameter
    bpidentity=bifpar1;
    bplabel=bp1label;
    bifpar = bp1i; %bifurcation parameter increments
    bpset=0;
    bpindex=find(bp2i>=bpset,1,'first');
    bpconstantvalue=bp2i(bpindex); %value of "fixed bifurcation parameter
    bpconststr=strrep(sprintf('%0.4f',bpconstantvalue),'.','p'); %string describing value of "fixed" parameter

    figuretitle={'Figure 02d left',sprintf('Total (WD) Population [%s = %0.2f]','$\mu$',bpconstantvalue)};
    filename = 'Reproduction_strube2024infection_F02dleft';

    % Collect Orbit Map Data
    T_plot(:,:)=T(:,bpindex,:);
    S_DFplot(:,:)=S_DF(:,bpindex,:);  
    Tavg_plot=Tavg(:,bpindex);
    SDFavg_plot=SDFavg(:,bpindex);

    %Total (WD) Population
    figtit='';
    legendentries2={'Total Population','Total Population Average'};
    [tempfig,~]=op(bifpar,T_plot,Tavg_plot,bpidentity,bpconstantvalue,figtit,bplabel,'Total Quantity of Individuals (WD)',legendentries2,figurecounter);

    % Extract average line
    wd_orbitavg=tempfig.Children(2).Children(1);
    wd_xavg=wd_orbitavg.XData;
    wd_yavg=wd_orbitavg.YData;

    % Extract average line
    wd_orbit=tempfig.Children(2).Children(2);
    wd_x=wd_orbit.XData;
    wd_y=wd_orbit.YData;
    close(tempfig)
    clear tempfig

    %Total (DF) Population
    legendentries1={'Disease-Free Population','Disease-Free Population Average'};
    [figurehandle,figurecounter]=op(bifpar,S_DFplot,SDFavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'Total Quantity of Individuals (DF)',legendentries1,figurecounter);
    
    hold  on
    plot(wd_xavg,wd_yavg,'.')
    hold on
    plot(wd_x,wd_y,'.')

    FullLegend={legendentries1{:},legendentries2{:}};
    figurehandle.Children(2).Children(1).Color=[0 0 0];
    figurehandle.Children(2).Children(2).Color=[0 0 0];
    figurehandle.Children(2).Children(3).Color=[1 0 0];
    figurehandle.Children(2).Children(4).Color=[1 0 0];
    legend(FullLegend);
    hold off

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 08: Figure 02d right
elseif figchoice == 08 % Figure 2d right - Orbit Map

    % Set parameter choices
    bp=bp2; %name of bifurcation parameter
    bpidentity=bifpar2;
    bplabel=bp2label;
    bifpar = bp2i; %bifurcation parameter increments
    bpset=1;
    bpindex=find(bp1i>=bpset,1,'first');
    bpconstantvalue=bp1i(bpindex); %value of "fixed bifurcation parameter
    bpconststr=strrep(sprintf('%0.4f',bpconstantvalue),'.','p'); %string describing value of "fixed" parameter

    figuretitle={'Figure 02d right',sprintf('Total (WD) Population [%s = %0.2f]','$\tilde{w}$',1-bpconstantvalue)};
    filename = 'Reproduction_strube2024infection_F02dright';

    % Collect Orbit Map Data
    T_plot(:,:)=T(bpindex,:,:);
    S_DFplot(:,:)=S_DF(bpindex,:,:);  
    Tavg_plot=Tavg(bpindex,:);
    SDFavg_plot=SDFavg(bpindex,:);

    %Total (WD) Population
    figtit='';
    legendentries2={'Total Population','Total Population Average'};
    [tempfig,~]=op(bifpar,T_plot,Tavg_plot,bpidentity,bpconstantvalue,figtit,bplabel,'Total Quantity of Individuals (WD)',legendentries2,figurecounter);

    % Extract average line
    wd_orbitavg=tempfig.Children(2).Children(1);
    wd_xavg=wd_orbitavg.XData;
    wd_yavg=wd_orbitavg.YData;

    % Extract average line
    wd_orbit=tempfig.Children(2).Children(2);
    wd_x=wd_orbit.XData;
    wd_y=wd_orbit.YData;
    close(tempfig)
    clear tempfig

    %Total (DF) Population
    legendentries1={'Disease-Free Population','Disease-Free Population Average'};
    [figurehandle,figurecounter]=op(bifpar,S_DFplot,SDFavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'Total Quantity of Individuals (DF)',legendentries1,figurecounter);
    
    hold  on
    plot(wd_xavg,wd_yavg,'.')
    hold on
    plot(wd_x,wd_y,'.')

    FullLegend={legendentries1{:},legendentries2{:}};
    figurehandle.Children(2).Children(1).Color=[0 0 0];
    figurehandle.Children(2).Children(2).Color=[0 0 0];
    figurehandle.Children(2).Children(3).Color=[1 0 0];
    figurehandle.Children(2).Children(4).Color=[1 0 0];
    legend(FullLegend);
    hold off
    
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 09: Figure 02e left
elseif figchoice == 09 % Figure 2e left - Orbit Map

     % Set parameter choices
    bp=bp1; %name of bifurcation parameter
    bpidentity=bifpar1;
    bplabel=bp1label; %formatted name of fixed parameter
    bifpar = bp1i; %bifurcation parameter increments
    bpset=0;
    bpindex=find(bp2i>=bpset,1,'first');
    bpconstantvalue=bp2i(bpindex); %value of "fixed bifurcation parameter
    bpconststr=strrep(sprintf('%0.4f',bpconstantvalue),'.','p'); %string describing value of "fixed" parameter

    figuretitle={'Figure 02e left',sprintf('Total (WD) Population [%s = %0.2f]','$\mu$',bpconstantvalue)};
    filename = 'Reproduction_strube2024infection_F02eleft';

    % Collect Orbit Map Data
    T_plot(:,:)=T(:,bpindex,:);
    S_DFplot(:,:)=S_DF(:,bpindex,:);  
    Tavg_plot=Tavg(:,bpindex);
    SDFavg_plot=SDFavg(:,bpindex);

    %Total (WD) Population
    figtit='';
    legendentries2={'Total Population','Total Population Average'};
    [tempfig,~]=op(bifpar,T_plot,Tavg_plot,bpidentity,bpconstantvalue,figtit,bplabel,'Total Quantity of Individuals (WD)',legendentries2,figurecounter);

    % Extract average line
    wd_orbitavg=tempfig.Children(2).Children(1);
    wd_xavg=wd_orbitavg.XData;
    wd_yavg=wd_orbitavg.YData;

    % Extract average line
    wd_orbit=tempfig.Children(2).Children(2);
    wd_x=wd_orbit.XData;
    wd_y=wd_orbit.YData;
    close(tempfig)
    clear tempfig

    %Total (DF) Population
    legendentries1={'Disease-Free Population','Disease-Free Population Average'};
    [figurehandle,figurecounter]=op(bifpar,S_DFplot,SDFavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'Total Quantity of Individuals (DF)',legendentries1,figurecounter);
    
    hold  on
    plot(wd_xavg,wd_yavg,'.')
    hold on
    plot(wd_x,wd_y,'.')

    FullLegend={legendentries1{:},legendentries2{:}};
    figurehandle.Children(2).Children(1).Color=[0 0 0];
    figurehandle.Children(2).Children(2).Color=[0 0 0];
    figurehandle.Children(2).Children(3).Color=[1 0 0];
    figurehandle.Children(2).Children(4).Color=[1 0 0];
    legend(FullLegend);
    hold off
    
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 10: Figure 02e right
elseif figchoice == 10 % Figure 2e right - Orbit Map

    % Set parameter choices
    bp=bp2; %name of bifurcation parameter
    bpidentity=bifpar2;
    bplabel=bp2label; %formatted name of fixed parameter
    bifpar = bp2i; %bifurcation parameter increments
    bpset=1;
    bpindex=find(bp1i>=bpset,1,'first');
    bpconstantvalue=bp1i(bpindex); %value of "fixed bifurcation parameter
    bpconststr=strrep(sprintf('%0.4f',bpconstantvalue),'.','p'); %string describing value of "fixed" parameter

    figuretitle={'Figure 02e right',sprintf('Total (WD) Population [%s = %0.2f]','$\tilde{w}$',1-bpconstantvalue)};
    filename = 'Reproduction_strube2024infection_F02eright';

    % Collect Orbit Map Data
    T_plot(:,:)=T(bpindex,:,:);
    S_DFplot(:,:)=S_DF(bpindex,:,:);  
    Tavg_plot=Tavg(bpindex,:);
    SDFavg_plot=SDFavg(bpindex,:);

    %Total (WD) Population
    figtit='';
    legendentries2={'Total Population','Total Population Average'};
    [tempfig,~]=op(bifpar,T_plot,Tavg_plot,bpidentity,bpconstantvalue,figtit,bplabel,'Total Quantity of Individuals (WD)',legendentries2,figurecounter);

    % Extract average line
    wd_orbitavg=tempfig.Children(2).Children(1);
    wd_xavg=wd_orbitavg.XData;
    wd_yavg=wd_orbitavg.YData;

    % Extract average line
    wd_orbit=tempfig.Children(2).Children(2);
    wd_x=wd_orbit.XData;
    wd_y=wd_orbit.YData;
    close(tempfig)
    clear tempfig

    %Total (DF) Population
    legendentries1={'Disease-Free Population','Disease-Free Population Average'};
    [figurehandle,figurecounter]=op(bifpar,S_DFplot,SDFavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'Total Quantity of Individuals (DF)',legendentries1,figurecounter);
    
    hold  on
    plot(wd_xavg,wd_yavg,'.')
    hold on
    plot(wd_x,wd_y,'.')

    FullLegend={legendentries1{:},legendentries2{:}};
    figurehandle.Children(2).Children(1).Color=[0 0 0];
    figurehandle.Children(2).Children(2).Color=[0 0 0];
    figurehandle.Children(2).Children(3).Color=[1 0 0];
    figurehandle.Children(2).Children(4).Color=[1 0 0];
    legend(FullLegend);
    hold off
    
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 11: Figure 03a 
elseif figchoice == 11 % Figure 3a - Orbit Map

    % Set parameter choices
    bp=bp1; %name of bifurcation parameter
    bpidentity=bifpar1;
    bplabel=bp1label; %formatted name of bifurcation parameter
    bifpar = bp1i; %bifurcation parameter increments
    bpset=0;
    bpindex=find(bp2i>=bpset,1,'first');
    bpconstantvalue=bp2i(bpindex); %value of "fixed bifurcation parameter
    bpconststr=strrep(sprintf('%0.4f',bpconstantvalue),'.','p'); %string describing value of "fixed" parameter

    figuretitle={'Figure 03a',sprintf('[%s = %0.2f]','$\tilde{w}$',1-bpconstantvalue)};
    filename = 'Reproduction_strube2024infection_F03a';

    % Collect Orbit Map Data
    S_plot(:,:)=S(:,bpindex,:);
    I_plot(:,:)=I(:,bpindex,:);
    T_plot(:,:)=T(:,bpindex,:);
    S_DFplot(:,:)=S_DF(:,bpindex,:);  
    Savg_plot=Savg(:,bpindex,:);
    Iavg_plot=Iavg(:,bpindex,:);
    Tavg_plot=Tavg(:,bpindex,:);
    SDFavg_plot=SDFavg(:,bpindex,:);
    ReprodPop_plot=S_plot+repmat(bifpar',1,size(I_plot,2)).*I_plot;
    ReprodPopavg_plot=Savg_plot'+bifpar.*Iavg_plot';

    %Susceptible Population
    figtit='';
    legendentries2={'Susceptible Population','Susceptible Average'};
    [tempfig,~]=op(bifpar,S_plot,Savg_plot,bpidentity,bpconstantvalue,figtit,bplabel,'Total Quantity of Individuals (WD)',legendentries2,figurecounter);

    % Populationline
    S_orbit=tempfig.Children(2).Children(2);
    S_x=S_orbit.XData;
    S_y=S_orbit.YData;
    close(tempfig)
    clear tempfig

    %Infectious Population
    figtit='';
    legendentries3={'Infectious Population','Infectious Average'};
    [tempfig,~]=op(bifpar,S_plot,Savg_plot,bpidentity,bpconstantvalue,figtit,bplabel,'Total Quantity of Individuals (WD)',legendentries3,figurecounter);

    % Population line
    I_orbit=tempfig.Children(2).Children(2);
    I_x=I_orbit.XData;
    I_y=I_orbit.YData;
    close(tempfig)
    clear tempfig

    %Reproducing Population 
    figtit='';
    legendentries4={'Reproducing Population','Reproducing Population Average'};
    [tempfig,~]=op(bifpar,ReprodPop_plot,ReprodPopavg_plot,bpidentity,bpconstantvalue,figtit,bplabel,'Total Quantity of Individuals (WD)',legendentries4,figurecounter);

    % Population line
    Rep_avg=tempfig.Children(2).Children(1);
    Repavg_x=Rep_avg.XData;
    Repavg_y=Rep_avg.YData;

    % Orbit line
    Rep=tempfig.Children(2).Children(2);
    Rep_x=Rep.XData;
    Rep_y=Rep.YData;

    close(tempfig)
    clear tempfig

    %Disease-Free Population
    figtit='';
    legendentries4={'Total (DF) Population','Disease-Free Average'};
    [tempfig,~]=op(bifpar,S_DFplot,SDFavg_plot,bpidentity,bpconstantvalue,figtit,bplabel,'Total Quantity of Individuals (WD)',legendentries4,figurecounter);

    % Population line
    DF_orbit=tempfig.Children(2).Children(2);
    DF_x=DF_orbit.XData;
    DF_y=DF_orbit.YData;
    close(tempfig)
    clear tempfig

    %Total (WD) Population
    legendentries1={'With-Disease Total Population','With-Disease Average'};
    [figurehandle,figurecounter]=op(bifpar,T_plot,Tavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'Total Quantity of Individuals (DF)',legendentries1,figurecounter);
    
    % Extract average line
    wd_orbitavg=figurehandle.Children(2).Children(1);
    figurehandle.Children(2).Children(2).Color=[1 0 0];
    delete(wd_orbitavg)
    hold  on
    plot(DF_x,DF_y,'k.')
    hold on
    plot(Rep_x,Rep_y,'d','color','b','markerfacecolor','b')
    legend({'Total population ($S$+$I$)','Disease-free population ($S_{DF}$)','Reproducing population ($S+wI$)'})
    hold off
    
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;


%% Choice 12: Figure 03b
elseif figchoice == 12 % Figure 3b - Ricker Growth
    
    %% SET LATEX AS THE DEFAULT INTERPRETER
    %"groot"= root of all graphics objects
    set(groot,'defaultAxesTickLabelInterpreter','latex');  
    set(groot,'defaultTextInterpreter','latex');
    set(groot,'defaultLegendInterpreter','latex');
    set(groot,'defaultColorBarTickLabelInterpreter','latex');
    figuretitle={'Figure 03b', 'Overcompensatory Growth'};
    filename = 'Reproduction_strube2024infection_03b';
    
    r=p(1);
    b=p(2);
    X=0:1:100;
    g=r*X.*exp(-b*X);
    figurehandle=figure;
    figurecounter=figurecounter+1;
    plot(X,g);
    hold on 
    plot(24.77,17.68,'db','MarkerFaceColor','b')
    plot(34.00,9.64,'or')
    xlabel('x')
    ylabel('g(x)')
    title(figuretitle)
    legend({'Growth Form','$x$=24.77, $g(x)$=17.68', '$x$=34.00, $g(x)$=9.64'})

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

    %% RESET TEXT INTERPRETER TO DEFAULT
    set(groot,'defaultAxesTickLabelInterpreter','none');  
    set(groot,'defaultTextInterpreter','none') 
    set(groot,'defaultLegendInterpreter','none')
    set(groot,'defaultColorBarTickLabelInterpreter','none');  

%% Choice 13: Figure 04a
elseif figchoice == 13 % Figure 4a - Batch Binary Hydra
    
   figuretitle={'Figure 04a','Hydra Effect $r=8.5$'};
   filename = 'Reproduction_strube2024infection_04a';

    % Extract Run Conditions
    ReproductionInputs=B(1).ReproductionInputs;
    reproductioninputs_extract
    
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
    
    %Initialize Array
    HHydra=zeros(size(B(1).Tavg));
    
    for i=1:1:length(B)
        IndividualHydra=B(i).BinaryHydra;
        [hydra_m,hydra_n]=size(IndividualHydra);
        for j=1:1:hydra_m
            for k=1:1:hydra_n
                if IndividualHydra(j,k)==1
                    HHydra(j,k)=1;
                end
            end
        end
    end
    
    colorbarlabel='Hydra Effect';
    figuretitle={B(i).LatexBatchDate, 'Net Hydra Effect Across the Range of Sampled Parameters'};
    figurecounter=0;
    [figurehandle,figurecounter]=hydraeffectplot('BinaryHydra',HHydra,bifpar1,bifpar2,'none',...
        increm1,increm2,bp1label,bp2label,colorbarlabel,figuretitle,...
        figurecounter);

   FileNames{figurecounter}=filename;
   FigHandles{figurecounter}=figurehandle;

%% Choice 14: Figure 04b
elseif figchoice == 14 % Figure 4b - Batch Binary Hydra
    
    figuretitle={'Figure 04b','Hydra Effect $r=45$'};
    filename = 'Reproduction_strube2024infection_04b';

    % Extract Run Conditions
    ReproductionInputs=B(1).ReproductionInputs;
    reproductioninputs_extract
    
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
    
    %Initialize Array
    HHydra=zeros(size(B(1).Tavg));
    
    for i=1:1:length(B)
        IndividualHydra=B(i).BinaryHydra;
        [hydra_m,hydra_n]=size(IndividualHydra);
        for j=1:1:hydra_m
            for k=1:1:hydra_n
                if IndividualHydra(j,k)==1
                    HHydra(j,k)=1;
                end
            end
        end
    end
    
    colorbarlabel='Hydra Effect';
    figuretitle={B(i).LatexBatchDate, 'Net Hydra Effect Across the Range of Sampled Parameters'};
    figurecounter=0;
    [figurehandle,figurecounter]=hydraeffectplot('BinaryHydra',HHydra,bifpar1,bifpar2,'none',...
        increm1,increm2,bp1label,bp2label,colorbarlabel,figuretitle,...
        figurecounter);

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 15: Figure 05 top
elseif figchoice == 15 % Figure 5 top - Trajectory Plot

    figuretitle = {'Figure 05 top', 'Population Trajectory'};
    filename = 'Reproduction_strube2024infection_05top';

    parameters=p;
    parameters(1)=200;
    [t,x,Tot,XDF]= trajectorysimulator(x,parameters,120);
    ylab='quantity of individuals';
    legendentry2='Total (DF) Population';
    [tempfig, ~] = trajectoryplot(t,XDF,legendentry2,ylab,figuretitle,figurecounter);
   
    %Extractline
    df_traj=tempfig.Children.Children(1);
    df_x=df_traj.XData;
    df_y=df_traj.YData;
    close(tempfig)
    clear tempfig

    ylab='quantity of individuals';
    legendentry1='Total (DF) Population';
    [figurehandle,figurecounter] = trajectoryplot(t,Tot,legendentry1,ylab,figuretitle,figurecounter);
    hold on
    plot(df_x,df_y)
    legend(legendentry1,legendentry2)
    xlim([80,120])

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 16: Figure 05 middle
elseif figchoice == 16 % Figure 5 middle - Trajectory Plot


    figuretitle = {'Figure 05 middle', 'Population Trajectory'};
    filename = 'Reproduction_strube2024infection_05middle';

    parameters=p;
    parameters(1)=200;
    [t,x,Tot,XDF]= trajectorysimulator(x,parameters,10500);
    ylab='quantity of individuals';
    legendentry2='Total (DF) Population';
    [tempfig, ~] = trajectoryplot(t,XDF,legendentry2,ylab,figuretitle,figurecounter);
   
    %Extractline
    df_traj=tempfig.Children.Children(1);
    df_x=df_traj.XData;
    df_y=df_traj.YData;
    close(tempfig)
    clear tempfig

    ylab='quantity of individuals';
    legendentry1='Total (DF) Population';
    [figurehandle,figurecounter] = trajectoryplot(t,Tot,legendentry1,ylab,figuretitle,figurecounter);
    hold on
    plot(df_x,df_y)
    legend(legendentry1,legendentry2)
    xlim([10001,10041])

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 17: Figure 05 bottom
elseif figchoice == 17 % Figure 5 bottom - Absolute Difference Plot
    


    figuretitle = {'Figure 05 bottom', 'Absolute Difference between Total','With-Disease and Disease-Free Trajectories'};
    filename = 'Reproduction_strube2024infection_05bottom';

    parameters=p;
    parameters(1)=200;
    [t,x,Tot,XDF]= trajectorysimulator(x,parameters,10500);
    ylab='quantity of individuals';
    legendentry2='Total (DF) Population';
    [tempfig, ~] = trajectoryplot(t,XDF,legendentry2,ylab,figuretitle,figurecounter);
   
    %Extractline
    df_traj=tempfig.Children.Children(1);
    df_x=df_traj.XData;
    df_y=df_traj.YData;
    close(tempfig)
    clear tempfig

    ylab='quantity of individuals';
    legendentry1='Total (DF) Population';
    [figurehandle,figurecounter] = trajectoryplot(t,Tot,legendentry1,ylab,figuretitle,figurecounter);
    hold on

    %Extract line
    wd_traj=figurehandle.Children.Children(1);
    wd_x=wd_traj.XData;
    wd_y=wd_traj.YData;
    delete(wd_traj)

    absdiff=abs(wd_y-df_y);
    plot(df_x,absdiff,'b')

    xlim([0,200])
    set(gca,'yscale','log')

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 18: Figure 06a
elseif figchoice == 18 % Figure 6a - Single Fold-Change Hydra

    % Process Data for Hydra Effect Plots
    binaryhydrathreshold=0;
    [ContinuousHydra,FoldChangeHydra,BinaryHydra]=calculatehydra(...
        Tavg,SDFavg,binaryhydrathreshold);

    figuretitle={'Figure 06a','Hydra Effect (Fold-Change)'};
    filename = 'Reproduction_strube2024infection_06a';

    %Plot
    hydrathreshold=0.05;
    colorbarlabel='Population Fold Change';
    [figurehandle,figurecounter]=hydraeffectplot(...
        'FoldChangeHydra',FoldChangeHydra,bifpar1,bifpar2,...
        hydrathreshold,increm1,increm2,bp1label,bp2label,...
        colorbarlabel,figuretitle,figurecounter);

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 19: Figure 06b
elseif figchoice == 19 % Figure 6b - Single Fold-Change Hydra
    
    % Process Data for Hydra Effect Plots
    binaryhydrathreshold=0;
    [ContinuousHydra,FoldChangeHydra,BinaryHydra]=calculatehydra(...
        Tavg,SDFavg,binaryhydrathreshold);

    figuretitle={'Figure 06b','Hydra Effect (Fold-Change)'};
    filename = 'Reproduction_strube2024infection_06b';

    % Plot
    hydrathreshold=0.05;
    colorbarlabel='Population Fold Change';
    [figurehandle,figurecounter]=hydraeffectplot(...
        'FoldChangeHydra',FoldChangeHydra,bifpar1,bifpar2,...
        hydrathreshold,increm1,increm2,bp1label,bp2label, ...
        colorbarlabel,figuretitle,figurecounter);

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 20: Figure 06c
elseif figchoice == 20 % Figure 6c - Single Fold-Change Hydra

    % Process Data for Hydra Effect Plots
    binaryhydrathreshold=0;
    [ContinuousHydra,FoldChangeHydra,BinaryHydra]=calculatehydra(...
        Tavg,SDFavg,binaryhydrathreshold);

    figuretitle={'Figure 06c','Hydra Effect (Fold-Change)'};
    filename = 'Reproduction_strube2024infection_06c';
    
    % Plot
    hydrathreshold=0.05;
    colorbarlabel='Population Fold Change';
    [figurehandle,figurecounter]=hydraeffectplot(...
        'FoldChangeHydra',FoldChangeHydra,bifpar1,bifpar2,...
        hydrathreshold,increm1,increm2,bp1label,bp2label,colorbarlabel,...
        figuretitle,figurecounter);

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 21: Figure 06d
elseif figchoice == 21 % Figure 6d - Single Fold-Change Hydra

    % Process Data for Hydra Effect Plots
    binaryhydrathreshold=0;
    [ContinuousHydra,FoldChangeHydra,BinaryHydra]=calculatehydra(...
        Tavg,SDFavg,binaryhydrathreshold);

    figuretitle={'Figure 06d','Hydra Effect (Fold-Change)'};
    filename = 'Reproduction_strube2024infection_06d';

    % Plot
    hydrathreshold=0.05;
    colorbarlabel='Population Fold Change';
    [figurehandle,figurecounter]=hydraeffectplot(...
        'FoldChangeHydra',FoldChangeHydra,bifpar1,bifpar2,...
        hydrathreshold,increm1,increm2,bp1label,bp2label,colorbarlabel,...
        figuretitle,figurecounter);

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 22: Figure 07a
elseif figchoice == 22 % Figure 7a - Total Population Heat Map
    
    figuretitle={'Figure 07a','Total Population (WD) Limit Cycle Sizes'};
    filename = 'Reproduction_strube2024infection_07a';

    [figurehandle,figurecounter]=hmp(HT,bifpar1,bifpar2,increm1,increm2,...
        lc,bp1label,bp2label,figuretitle,figurecounter);

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 23: Figure 07b
elseif figchoice == 23 % Figure 7b - Total Population Heat Map
    
    figuretitle={'Figure 07b','Total Population (WD) Limit Cycle Sizes'};
    filename = 'Reproduction_strube2024infection_07b';

    [figurehandle,figurecounter]=hmp(HT,bifpar1,bifpar2,increm1,increm2,...
        lc,bp1label,bp2label,figuretitle,figurecounter);

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 24: Figure 07c
elseif figchoice == 24 % Figure 7c - Total Population Heat Map
    
    figuretitle={'Figure 07c','Total Population (WD) Limit Cycle Sizes'};
    filename = 'Reproduction_strube2024infection_07c';

    [figurehandle,figurecounter]=hmp(HT,bifpar1,bifpar2,increm1,increm2,...
        lc,bp1label,bp2label,figuretitle,figurecounter);

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 25: Figure 07d
elseif figchoice == 25 % Figure 7d - Total Population Heat Map
    
    figuretitle={'Figure 07d','Total Population (WD) Limit Cycle Sizes'};
    filename = 'Reproduction_strube2024infection_07d';

    [figurehandle,figurecounter]=hmp(HT,bifpar1,bifpar2,increm1,increm2,...
        lc,bp1label,bp2label,figuretitle,figurecounter);

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 26: Figure 08a
elseif figchoice == 26 % Figure 8a - Total Population Orbit Map

 
    % Set parameter choices
    bp=bp2; %name of bifurcation parameter
    bpidentity=bifpar2;
    bplabel=bp2label;
    bifpar = bp2i; %bifurcation parameter increments
    bpset=1;
    bpindex=find(bp1i>=bpset,1,'first');
    bpconstantvalue=bp1i(bpindex); %value of "fixed bifurcation parameter
    bpconststr=strrep(sprintf('%0.4f',bpconstantvalue),'.','p'); %string describing value of "fixed" parameter

    figuretitle={'Figure 08 a','Comparison between Total WD and Total DF Populations', sprintf('[%s = %0.2f]','$\tilde{w}$',1-bpconstantvalue)};
    filename = 'Reproduction_strube2024infection_F08a';

    % Collect Orbit Map Data
    T_plot(:,:)=T(bpindex,:,:);
    S_DFplot(:,:)=S_DF(bpindex,:,:);  
    Tavg_plot=Tavg(bpindex,:);
    SDFavg_plot=SDFavg(bpindex,:);

    %Total (WD) Population
    figtit='';
    legendentries2={'Total Population','Total Population Average'};
    [tempfig,~]=op(bifpar,T_plot,Tavg_plot,bpidentity,bpconstantvalue,figtit,bplabel,'Total Quantity of Individuals (WD)',legendentries2,figurecounter);

    % Extract average line
    wd_orbitavg=tempfig.Children(2).Children(1);
    wd_xavg=wd_orbitavg.XData;
    wd_yavg=wd_orbitavg.YData;

    % Extract average line
    wd_orbit=tempfig.Children(2).Children(2);
    wd_x=wd_orbit.XData;
    wd_y=wd_orbit.YData;
    close(tempfig)
    clear tempfig

    %Total (DF) Population
    legendentries1={'Disease-Free Population','Disease-Free Population Average'};
    [figurehandle,figurecounter]=op(bifpar,S_DFplot,SDFavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'Total Quantity of Individuals (DF)',legendentries1,figurecounter);
    
    hold  on
    plot(wd_xavg,wd_yavg,'.')
    hold on
    plot(wd_x,wd_y,'.')
    xlim([0,.7])
    ylim([30,70])

    FullLegend={legendentries1{:},legendentries2{:}};
    figurehandle.Children(2).Children(1).Color=[0 0 0];
    figurehandle.Children(2).Children(2).Color=[0 0 0];
    figurehandle.Children(2).Children(3).Color=[1 0 0];
    figurehandle.Children(2).Children(4).Color=[1 0 0];
    legend(FullLegend);
    hold off
    
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;


%% Choice 27: Figure 08b
elseif figchoice == 27 % Figure 8b - Total Population Orbit Map
    
    figuretitle = {'Figure 08b','Orbit Map'};

 % Set parameter choices
    bp=bp1; %name of bifurcation parameter
    bpidentity=bifpar1;
    bplabel=bp1label;
    bifpar = bp1i; %bifurcation parameter increments
    bpset=0;
    bpindex=find(bp2i>=bpset,1,'first');
    bpconstantvalue=bp2i(bpindex); %value of "fixed bifurcation parameter
    bpconststr=strrep(sprintf('%0.4f',bpconstantvalue),'.','p'); %string describing value of "fixed" parameter

    figuretitle={'Figure 08b','Comparison between Total WD and Total DF Populations', sprintf('[%s = %0.2f]','$u$',bpconstantvalue)};
    filename = 'Reproduction_strube2024infection_F08b';

    % Collect Orbit Map Data
    T_plot(:,:)=T(:,bpindex,:);
    S_DFplot(:,:)=S_DF(:,bpindex,:);  
    Tavg_plot=Tavg(:,bpindex);
    SDFavg_plot=SDFavg(:,bpindex);

    %Total (WD) Population
    figtit='';
    legendentries2={'Total Population','Total Population Average'};
    [tempfig,~]=op(bifpar,T_plot,Tavg_plot,bpidentity,bpconstantvalue,figtit,bplabel,'Total Quantity of Individuals (WD)',legendentries2,figurecounter);

    % Extract average line
    wd_orbitavg=tempfig.Children(2).Children(1);
    wd_xavg=wd_orbitavg.XData;
    wd_yavg=wd_orbitavg.YData;

    % Extract average line
    wd_orbit=tempfig.Children(2).Children(2);
    wd_x=wd_orbit.XData;
    wd_y=wd_orbit.YData;
    close(tempfig)
    clear tempfig

    %Total (DF) Population
    legendentries1={'Disease-Free Population','Disease-Free Population Average'};
    [figurehandle,figurecounter]=op(bifpar,S_DFplot,SDFavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'Total Quantity of Individuals (DF)',legendentries1,figurecounter);
    
    hold  on
    plot(wd_xavg,wd_yavg,'.')
    hold on
    plot(wd_x,wd_y,'.')

    xlim([.3 1])
    ylim([20,180])

    FullLegend={legendentries1{:},legendentries2{:}};
    figurehandle.Children(2).Children(1).Color=[0 0 0];
    figurehandle.Children(2).Children(2).Color=[0 0 0];
    figurehandle.Children(2).Children(3).Color=[1 0 0];
    figurehandle.Children(2).Children(4).Color=[1 0 0];
    legend(FullLegend);
    hold off

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 28: Figure 08c
 elseif figchoice == 28 % Figure 8c - Total Population Orbit Map

 
    % Set parameter choices
    bp=bp2; %name of bifurcation parameter
    bpidentity=bifpar2;
    bplabel=bp2label;
    bifpar = bp2i; %bifurcation parameter increments
    bpset=1;
    bpindex=find(bp1i>=bpset,1,'first');
    bpconstantvalue=bp1i(bpindex); %value of "fixed bifurcation parameter
    bpconststr=strrep(sprintf('%0.4f',bpconstantvalue),'.','p'); %string describing value of "fixed" parameter

    figuretitle={'Figure 08c','Comparison between Total WD and Total DF Populations', sprintf('[%s = %0.2f]','$\tilde{w}$',1-bpconstantvalue)};
    filename = 'Reproduction_strube2024infection_F08c';

    % Collect Orbit Map Data
    T_plot(:,:)=T(bpindex,:,:);
    S_DFplot(:,:)=S_DF(bpindex,:,:);  
    Tavg_plot=Tavg(bpindex,:);
    SDFavg_plot=SDFavg(bpindex,:);

    %Total (WD) Population
    figtit='';
    legendentries3={'Total Population','Total Population Average'};
    [tempfig,~]=op(bifpar,T_plot,Tavg_plot,bpidentity,bpconstantvalue,figtit,bplabel,'Total Quantity of Individuals (WD)',legendentries3,figurecounter);

    % Extract average line
    wd_orbitavg=tempfig.Children(2).Children(1);
    wd_xavg=wd_orbitavg.XData;
    wd_yavg=wd_orbitavg.YData;

    % Extract average line
    wd_orbit=tempfig.Children(2).Children(2);
    wd_x=wd_orbit.XData;
    wd_y=wd_orbit.YData;
    close(tempfig)
    clear tempfig

    %Total (DF) Population
    legendentries2={'Total (DF) Population','Total (DF) Population Average'};
    [figurehandle,figurecounter]=op(bifpar,S_DFplot,SDFavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'Total Quantity of Individuals (DF)',legendentries2,figurecounter);
    
    hold  on
    plot(wd_xavg,wd_yavg,'o')
    hold on
    plot(wd_x,wd_y,'o')
    hold on

    clear T S_DF Tavg SDFavg T_plot S_DFplot Tavgplot SDFavgplot
    load("Data/strube2024infection_f08c1_hydraex.mat")

     %Extract Long-Time Behavior Data
     S=D.Orbit_SDataArray;
     I=D.Orbit_IDataArray;
     T=S+I;
     S_DF=D.Orbit_DFDataArray;

     %Extract Average Data
     Tavg=D.Average_TDataArray;
     SDFavg=D.Average_DFDataArray;

    % Collect Orbit Map Data
    T_plot(:,:)=T(bpindex,:,:);
    S_DFplot(:,:)=S_DF(bpindex,:,:);  
    Tavg_plot=Tavg(bpindex,:);
    SDFavg_plot=SDFavg(bpindex,:);

    %Total (WD) Population
    figtit='';
    legendentries1={'Total (WD) Population','Total (WD) Population Average'};
    [tempfig,~]=op(bifpar,T_plot,Tavg_plot,bpidentity,bpconstantvalue,figtit,bplabel,'Total Quantity of Individuals (WD)',legendentries1,figurecounter);

    % Extract average line
    wd_orbitavg=tempfig.Children(2).Children(1);
    wd_xavg=wd_orbitavg.XData;
    wd_yavg=wd_orbitavg.YData;

    % Extract average line
    wd_orbit=tempfig.Children(2).Children(2);
    wd_x=wd_orbit.XData;
    wd_y=wd_orbit.YData;
    close(tempfig)
    clear tempfig

    plot(wd_xavg,wd_yavg,'.')
    hold on
    plot(wd_x,wd_y,'.')
    hold off

    xlim([0,.7])
    ylim([25,275])

    FullLegend={legendentries1{:},legendentries2{:},legendentries3{:}};
    figurehandle.Children(2).Children(1).Color=[0 0 0];
    figurehandle.Children(2).Children(2).Color=[0 0 0];
    figurehandle.Children(2).Children(3).Color=[0 0 1];
    figurehandle.Children(2).Children(4).Color=[0 0 1];
    figurehandle.Children(2).Children(5).Color=[1 0 0];
    figurehandle.Children(2).Children(6).Color=[1 0 0];
    legend(FullLegend);

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;


%% Choice 29: Figure 08d
elseif figchoice == 29 % Figure 8d - Total Population Orbit Map

    % Set parameter choices
    bp=bp2; %name of bifurcation parameter
    bpidentity=bifpar2;
    bplabel=bp2label;
    bifpar = bp2i; %bifurcation parameter increments
    bpset=1;
    bpindex=find(bp1i>=bpset,1,'first');
    bpconstantvalue=bp1i(bpindex); %value of "fixed bifurcation parameter
    bpconststr=strrep(sprintf('%0.4f',bpconstantvalue),'.','p'); %string describing value of "fixed" parameter

    figuretitle={'Figure 08d','Comparison between Total WD and Total DF Populations', sprintf('[%s = %0.2f]','$\tilde{w}$',1-bpconstantvalue)};
    filename = 'Reproduction_strube2024infection_F08c';

    % Collect Orbit Map Data
    T_plot(:,:)=T(bpindex,:,:);
    S_DFplot(:,:)=S_DF(bpindex,:,:);  
    Tavg_plot=Tavg(bpindex,:);
    SDFavg_plot=SDFavg(bpindex,:);

    %Total (WD) Population
    figtit='';
    legendentries2={'Total Population','Total Population Average'};
    [tempfig,~]=op(bifpar,T_plot,Tavg_plot,bpidentity,bpconstantvalue,figtit,bplabel,'Total Quantity of Individuals (WD)',legendentries2,figurecounter);

    % Extract average line
    wd_orbitavg=tempfig.Children(2).Children(1);
    wd_xavg=wd_orbitavg.XData;
    wd_yavg=wd_orbitavg.YData;

    % Extract average line
    wd_orbit=tempfig.Children(2).Children(2);
    wd_x=wd_orbit.XData;
    wd_y=wd_orbit.YData;
    close(tempfig)
    clear tempfig

    %Total (DF) Population
    legendentries1={'Disease-Free Population','Disease-Free Population Average'};
    [figurehandle,figurecounter]=op(bifpar,S_DFplot,SDFavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'Total Quantity of Individuals (DF)',legendentries1,figurecounter);
    
    hold  on
    plot(wd_xavg,wd_yavg,'.')
    hold on
    plot(wd_x,wd_y,'.')
    hold off
    xlim([0,.7])
    ylim([25 375])

    FullLegend={legendentries1{:},legendentries2{:}};
    figurehandle.Children(2).Children(1).Color=[0 0 0];
    figurehandle.Children(2).Children(2).Color=[0 0 0];
    figurehandle.Children(2).Children(3).Color=[1 0 0];
    figurehandle.Children(2).Children(4).Color=[1 0 0];
    legend(FullLegend);
    
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;


%% Choice 30: Figure C01 top
elseif figchoice == 30 % Figure C01 top - Average Population Trajectory
% Set parameter choices
    bp=bp2; %name of bifurcation parameter
    bpidentity=bifpar2;
    bplabel=bp2label;
    bifpar = bp2i; %bifurcation parameter increments
    bpset=1;
    bpindex=find(bp1i>=bpset,1,'first');
    bpconstantvalue=bp1i(bpindex); %value of "fixed bifurcation parameter
    bpconststr=strrep(sprintf('%0.4f',bpconstantvalue),'.','p'); %string describing value of "fixed" parameter

    figuretitle={'Figure C01 top left','Average Population Trajectories',sprintf('[%s = %0.2f]','$r$',175)};
    filename = 'Reproduction_strube2024infection_C01topleft';

    % Collect Orbit Map Data
    T_plot(:,:)=T(bpindex,:,:);
    S_DFplot(:,:)=S_DF(bpindex,:,:);  
    Tavg_plot=Tavg(bpindex,:);
    SDFavg_plot=SDFavg(bpindex,:);
    AbsDiff_plot=abs(T_plot-S_DFplot);
    AbsDiffavg_plot=abs(Tavg_plot-SDFavg_plot);

    %Total (WD) Population
    figtit='';
    legendentries2={'Total (WD) Population','Total (WD) Population Average'};
    [tempfig,~]=op(bifpar,T_plot,Tavg_plot,bpidentity,bpconstantvalue,figtit,bplabel,'Total Quantity of Individuals (WD)',legendentries2,figurecounter);

    % Extract average line
    wd_orbitavg=tempfig.Children(2).Children(1);
    wd_xavg=wd_orbitavg.XData;
    wd_yavg=wd_orbitavg.YData;

    close(tempfig)
    clear tempfig

    %Total (DF) Population
    legendentries1={'Total (DF) Population','Total (DF) Population Average'};
    [figurehandle,figurecounter]=op(bifpar,S_DFplot,SDFavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'Total Quantity of Individuals (DF)',legendentries1,figurecounter);
    
    % Extract average line
    wf_orbit=figurehandle.Children(2).Children(2);
    delete(wf_orbit)

    hold  on
    plot(wd_xavg,wd_yavg,'o')

    figurehandle.Children(2).Children(1).Color=[0 0 1]; %WD
    figurehandle.Children(2).Children(2).Color=[1 0 0]; %DF
    legend('Total (DF) Population','Total (WD) Population')
    hold off
    
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

    figuretitle={'Figure C01 top right','Average Population Trajectories',sprintf('[%s = %0.2f]','$r$',175)};
    filename = 'Reproduction_strube2024infection_C01topright';
    legendentries1={'Absolute Difference','Absolute Difference Average'};
    [figurehandle,figurecounter]=op(bifpar,AbsDiff_plot,AbsDiffavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'Total Quantity of Individuals (DF)',legendentries1,figurecounter);
    
    % Extract orbitline
    trashout=figurehandle.Children(2).Children(2);
    delete(trashout)

    figurehandle.Children(2).Children(1).Color=[0 1 0]; %Abs Diff
    ylim([0,7])

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;
%% Choice 31: Figure C01 middle
elseif figchoice == 31 % Figure C01 middle - Average Population Trajectory

% Set parameter choices
    bp=bp2; %name of bifurcation parameter
    bpidentity=bifpar2;
    bplabel=bp2label;
    bifpar = bp2i; %bifurcation parameter increments
    bpset=1;
    bpindex=find(bp1i>=bpset,1,'first');
    bpconstantvalue=bp1i(bpindex); %value of "fixed bifurcation parameter
    bpconststr=strrep(sprintf('%0.4f',bpconstantvalue),'.','p'); %string describing value of "fixed" parameter

    figuretitle={'Figure C01 middle left','Average Population Trajectories',sprintf('[%s = %0.2f]','$r$',175)};
    filename = 'Reproduction_strube2024infection_C01middleleft';

    % Collect Orbit Map Data
    T_plot(:,:)=T(bpindex,:,:);
    S_DFplot(:,:)=S_DF(bpindex,:,:);  
    Tavg_plot=Tavg(bpindex,:);
    SDFavg_plot=SDFavg(bpindex,:);
    AbsDiff_plot=abs(T_plot-S_DFplot);
    AbsDiffavg_plot=abs(Tavg_plot-SDFavg_plot);

    %Total (WD) Population
    figtit='';
    legendentries2={'Total (WD) Population','Total (WD) Population Average'};
    [tempfig,~]=op(bifpar,T_plot,Tavg_plot,bpidentity,bpconstantvalue,figtit,bplabel,'Total Quantity of Individuals (WD)',legendentries2,figurecounter);

    % Extract average line
    wd_orbitavg=tempfig.Children(2).Children(1);
    wd_xavg=wd_orbitavg.XData;
    wd_yavg=wd_orbitavg.YData;

    close(tempfig)
    clear tempfig

    %Total (DF) Population
    legendentries1={'Total (DF) Population','Total (DF) Population Average'};
    [figurehandle,figurecounter]=op(bifpar,S_DFplot,SDFavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'Total Quantity of Individuals (DF)',legendentries1,figurecounter);
    
    % Extract average line
    wf_orbit=figurehandle.Children(2).Children(2);
    delete(wf_orbit)

    hold  on
    plot(wd_xavg,wd_yavg,'o')

    figurehandle.Children(2).Children(1).Color=[0 0 1]; %WD
    figurehandle.Children(2).Children(2).Color=[1 0 0]; %DF
    legend('Total (DF) Population','Total (WD) Population')
    hold off
    
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

    figuretitle={'Figure C01 middle right','Average Population Trajectories',sprintf('[%s = %0.2f]','$r$',175)};
    filename = 'Reproduction_strube2024infection_C01middleright';

    legendentries1={'Absolute Difference','Absolute Difference Average'};
    [figurehandle,figurecounter]=op(bifpar,AbsDiff_plot,AbsDiffavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'Total Quantity of Individuals (DF)',legendentries1,figurecounter);
    
    % Extract orbitline
    trashout=figurehandle.Children(2).Children(2);
    delete(trashout)

    figurehandle.Children(2).Children(1).Color=[0 1 0]; %Abs Diff
    ylim([0,7])
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 32: Figure C01 bottom
elseif figchoice == 32 % Figure C01 bottom - Absolute Difference Plot

% Set parameter choices
    bp=bp2; %name of bifurcation parameter
    bpidentity=bifpar2;
    bplabel=bp2label;
    bifpar = bp2i; %bifurcation parameter increments
    bpset=1;
    bpindex=find(bp1i>=bpset,1,'first');
    bpconstantvalue=bp1i(bpindex); %value of "fixed bifurcation parameter
    bpconststr=strrep(sprintf('%0.4f',bpconstantvalue),'.','p'); %string describing value of "fixed" parameter

    figuretitle={'Figure C01 bottom left','Average Population Trajectories',sprintf('[%s = %0.2f]','$r$',175)};
    filename = 'Reproduction_strube2024infection_C01bottomleft';

    % Collect Orbit Map Data
    T_plot(:,:)=T(bpindex,:,:);
    S_DFplot(:,:)=S_DF(bpindex,:,:);  
    Tavg_plot=Tavg(bpindex,:);
    SDFavg_plot=SDFavg(bpindex,:);
    AbsDiff_plot=abs(T_plot-S_DFplot);
    AbsDiffavg_plot=abs(Tavg_plot-SDFavg_plot);

    %Total (WD) Population
    figtit='';
    legendentries2={'Total (WD) Population','Total (WD) Population Average'};
    [tempfig,~]=op(bifpar,T_plot,Tavg_plot,bpidentity,bpconstantvalue,figtit,bplabel,'Total Quantity of Individuals (WD)',legendentries2,figurecounter);

    % Extract average line
    wd_orbitavg=tempfig.Children(2).Children(1);
    wd_xavg=wd_orbitavg.XData;
    wd_yavg=wd_orbitavg.YData;

    % Extract orbit line
    wd_orbit=tempfig.Children(2).Children(2);
    wd_x=wd_orbit.XData;
    wd_y=wd_orbit.YData;
    close(tempfig)
    clear tempfig

    %Total (DF) Population
    legendentries1={'Total (DF) Population','Total (DF) Population Average'};
    [figurehandle,figurecounter]=op(bifpar,S_DFplot,SDFavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'Total Quantity of Individuals (DF)',legendentries1,figurecounter);


    % Extract orbit line
    df_orbit=figurehandle.Children(2).Children(2);
    delete(df_orbit)

    hold  on
    plot(wd_xavg,wd_yavg,'o')

    figurehandle.Children(2).Children(1).Color=[0 0 1]; %WD
    figurehandle.Children(2).Children(2).Color=[1 0 0]; %DF
    legend('Total (DF) Population','Total (WD) Population')
    hold off
    
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

    figuretitle={'Figure C01 bottom right','Average Population Trajectories',sprintf('[%s = %0.2f]','$r$',175)};
    filename = 'Reproduction_strube2024infection_C01bottomright';

    legendentries1={'Absolute Difference','Absolute Difference Average'};
    [figurehandle,figurecounter]=op(bifpar,AbsDiff_plot,AbsDiffavg_plot,bpidentity,bpconstantvalue,figuretitle,bplabel,'Total Quantity of Individuals (DF)',legendentries1,figurecounter);
    
    % Extract orbit line
    trashout=figurehandle.Children(2).Children(2);
    delete(trashout)

    figurehandle.Children(2).Children(1).Color=[0 1 0]; %Abs Diff
    ylim([0,7])
    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 33: Figure C02a
elseif figchoice == 33 % Figure C02a-Total Disease-Free Population Heat Map
   
    figuretitle = {'Figure C02a','Limit Cycle Heat Map'};
    filename = 'Reproduction_strube2024infection_C02a';

    [figurehandle,figurecounter]=hmp(HT,bifpar1,bifpar2,increm1,increm2,...
        lc,bp1label,bp2label,figuretitle,figurecounter);

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;

%% Choice 34: Figure C02b
elseif figchoice == 34 % Figure C02b - Disease-Free Binary Hydra Plot

    % Process Data for Hydra Effect Plots
    binaryhydrathreshold=0;
    [ContinuousHydra,FoldChangeHydra,BinaryHydra]=calculatehydra(...
        Tavg,SDFavg,binaryhydrathreshold);

    figuretitle={'Figure 02b','Presence of an Infection-Induced Hydra Effect'};
    filename = 'Reproduction_strube2024infection_C02b';

    %Plot
    hydrathreshold=0.05;
    colorbarlabel='HydraEffect';
   [figurehandle,figurecounter] = hydraeffectplot(...
       'FoldChangeHydra',FoldChangeHydra,bifpar1,bifpar2,hydrathreshold,...
       increm1,increm2,bp1label,bp2label,colorbarlabel,...
       figuretitle,figurecounter);

    FileNames{figurecounter}=filename;
    FigHandles{figurecounter}=figurehandle;
end

%==========================================================================
%% SCRIPT END
%==========================================================================
