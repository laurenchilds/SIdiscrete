function [figurehandle,newfigurecounter]=multistabilityplot(qtybehaviors,BatchDataStructure,ArrayName,figuretitle,oldfigurecounter)

%==========================================================================
%% CODE DESCRIPTION
%==========================================================================
%  This function constructs a heatmap in which each pixel is colored to 
%  represent the quantity of distinct qualitative dynamics at a single set 
%  of parameter values.
%
% [figurehandle,newfigurecounter]=
% multistabilityplot(BatchDataStructure,ArrayName,oldfigurecounter)

%   INPUTS:
%   -------
%   qtyregions          : The desired quantity of multistability regions
%   BatchDataStructure  : 
%       Data structure constructed via batchinputs_create.m
%   ArrayName           : BatchDataStructure data field to be plotted*
%   figuretitle         : Cell array of strings
%   oldfigurecounter    : scalar
%
%   *Current options: 
%           'Heat_TDataArray'    For total DF population
%           'Heat_DFDataArray'   For total WD population
%  
%   If the hardcoded data storage in *_driver.m is changed to store
%   Susceptible and Infectious population data, then the following two
%   options are also available:
%
%           'Heat_SDataArray'    For Susceptible population
%           'Heat_IDataArray'    For Infectious population
%
%   OUTPUTS:
%   --------
%   figurehandle        : Handle for the figure generated by this script
%   figurecounter       : Figure counter value corresponding to the figure
%                           generated by this script
%
%   DEPENDENCIES: 
%   -------------
%   None
%
%   USED BY: 
%   ---------
%   figuregenerator_userchoice.m
%   *_figuregenerator_manuscript.m
%   
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com


%% ------------------------------------------------------------------------
%==========================================================================
%% START CODE
%==========================================================================
    % Set Latex as the default interpreter
    %"groot"= root of all graphics objects
    set(groot,'defaultAxesTickLabelInterpreter','latex');  
    set(groot,'defaultTextInterpreter','latex');
    set(groot,'defaultLegendInterpreter','latex');
    set(groot,'defaultColorBarTickLabelInterpreter','latex');


%% (I) EXTRACT THE NECESSARY DATA DIMENSIONS 
    qtysimulations=length(BatchDataStructure);
    heatmapsize=size(BatchDataStructure(1).D.Heat_TDataArray);
    lcthresh=BatchDataStructure(1).D.ReproductionInputs.LimitCycleThreshold;

%% (II) INCREMENT FIGURE COUNTER
    
    newfigurecounter=oldfigurecounter+1;

%% (III) EXTRACT RUN CONDITIONS
    ReproductionInputs=BatchDataStructure(1).D.ReproductionInputs;
    batchdisplay=1;
    reproductioninputs_extract

%% (IV) FORMAT AXIS LABELS

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
    
%% (V) INITIALIZE ARRAYS FOR COMPILED LIMIT CYCLE DATA 
        for i=1:1:lcthresh+1
            Data{i}=zeros(heatmapsize);
        end
        
%% (VI) EXTRACT LIMIT CYCLE DATA
        for i = 1:1:qtysimulations
            T=BatchDataStructure(i).D.(ArrayName);
        
            for j=1:1:lcthresh
                Data{j}=Data{j}+(T==(j));
            end
        
            Data{lcthresh+1}=Data{lcthresh+1}+(T>lcthresh);
        end

%==========================================================================
%% GENERATE MULTISTABILITY FIGURE
%==========================================================================
    
    % Initialize arrays for compiled limit cycle data
    FinalDataM=zeros(heatmapsize);

    % Process Data
    for i=1:1:lcthresh+1
        DataM{i}=1*(Data{i}>0.5);
    end

    % Construct Multistability Array
    for i=1:1:lcthresh+1
        FinalDataM=FinalDataM+DataM{i};
    end

    %Plot Data
    figurehandle=figure;
    imagesc([increm2(1),increm2(3)],[increm1(1),increm1(3)],FinalDataM,[1,qtybehaviors+1])
    %Formatting
    set(gca,'YDir','normal') % flip matrix data and y-axis tick labels vertically so origin is bottom left.

    if qtybehaviors==2
        colorvalues=[...
            000 000 000     %(01) -- black    
            255 255 255     %(02) -- white
                    ]/255;
    elseif qtybehaviors==3        
        colorvalues=[...
            000 000 125     %(01) -- blue1
            061 112 034     %(05) -- green1
            242 206 006     %(08) -- yellow1   
                    ]/255;
    else
         colorvalues=seventeencolormap(qtybehaviors);
    end

    colormap(colorvalues)
    c=colorbar; % show colorbar
    c.Ticks=[1.5:1:3+2.5]; 
    c.TickLabels=[string(1:1:2),sprintf('%s+',string(qtybehaviors))];
    ylabel(c,'Distict Qualitative Behaviors','Interpreter','latex')
    title(figuretitle)
    ylabel(bp1label)
    xlabel(bp2label)
    
    % Reset Text Interpreter to Default
    set(groot,'defaultAxesTickLabelInterpreter','none');  
    set(groot,'defaultTextInterpreter','none');
    set(groot,'defaultLegendInterpreter','none');
    set(groot,'defaultColorBarTickLabelInterpreter','none');  

end 

%==========================================================================
%% LOCAL FUNCTION: SEVENTEENCOLORMAP
%==========================================================================
function selectedvalues=seventeencolormap(x)

        colorvalues=[
            000 000 125     %(01) -- blue1
            000 000 255     %(02) -- blue2
            040 150 235     %(03) -- blue3    
            127 202 255     %(04) -- blue4
            061 112 034     %(05) -- green1
            129 204 089     %(06) -- green2
            192 229 172     %(07) -- green3
            242 206 006     %(08) -- yellow1     
            255 151 000     %(09) -- orange1
            252 096 052     %(10) -- orange3
            255 000 000     %(11) -- red1
            220 000 000     %(12) -- red2
            180 000 000     %(13) -- red3
            140 000 000     %(14) -- red4
            100 000 000     %(15) -- red5
            060 000 000     %(16) -- red6
            000 000 000     %(17) -- black
        ]/255;
        
        selectedvalues=colorvalues(1:x,:);
end