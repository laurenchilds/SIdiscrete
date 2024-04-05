function[figurehandles,filenames,newfigurecounter] = compiled_limitcycleplot(BatchDataStructure,ArrayName,figuretitle,oldfigurecounter)

%==========================================================================
%% CODE DESCRIPTION
%==========================================================================
%  This function constructs n compiled limit cycle plots, where (n-1) is
%  the limit cycle threshold specified in the simulation run conditions. 
%
% [figurehandles,filenames] =...
%                  compiled_limitcycleplot(BatchDataStructure,ArrayName)
%
%
%   INPUTS:
%   -------
%   BatchDataStructure : Batch data structure constructed via
%                                               batchinputs_create.m
%   ArrayName          : The data structure fieldname such that
%                           B(1).D.ArrayName is the data to be used in the
%                           construction of the compiled limit cycle plots.
%                           ex: 'Heat_TDataArray. 
%   figuretitle         : Cell array of strings
%   oldfigurecounter    : Total quantity of figures generated prior to 
%                           execution of this script [scalar]
%
%   OUTPUTS:
%   --------
%   figurehandles        : Cell Array of figure handles
%   filenames            : Cell Array of filenames
%   newfigurecounter     : Total quantity of figures generated after
%                           execution of this script [scalar]
%
%   DEPENDENCIES: 
%   -------------
%   figureplot [Local function, below]
%   eighteencolormap [Local function, below]
%
%   USED BY: 
%   ---------
%   figuregenerator_userchoice.m
%   *_figuregenerator_manuscript.m
%   
%
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
%
%% ------------------------------------------------------------------------
%==========================================================================
%% START CODE
%==========================================================================

%% (I) EXTRACT THE NECESSARY DATA DIMENSIONS 
    qtysimulations=length(BatchDataStructure);
    heatmapsize=size(BatchDataStructure(1).D.Heat_TDataArray);
    lcthresh=BatchDataStructure(1).D.ReproductionInputs.LimitCycleThreshold;

%% (II) INCREMENT FIGURE COUNTER
    
    newfigurecounter=oldfigurecounter+lcthresh+1;

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

%% (VII) PROCESS DATA FOR USE IN COMPILED LIMIT CYCLE FIGURES 
    % All non-zero array entries are set to their limit cycle size
    
    for i=1:1:17
        CompiledData{i}=(i)*(Data{i}>0.5);
    end

%% (VIII) GRAPH COMPILED LIMIT CYCLE FIGURES

    for i=1:1:lcthresh+1
        [figurehandles{i},filenames{i}]=figureplot(i,CompiledData{i},ArrayName,bp1label,bp2label,lcthresh,increm1,increm2,figuretitle);
    end
end

%==========================================================================
%% FUNCTION: FIGUREPLOT
%==========================================================================

function [figurehandle,filename]=figureplot(n,data,ArrayName,bp1label,bp2label,lcthresh,increm1,increm2,figuretitle)
    
    % Set Latex as the default interpreter
    %"groot"= root of all graphics objects
    set(groot,'defaultAxesTickLabelInterpreter','latex');  
    set(groot,'defaultTextInterpreter','latex');
    set(groot,'defaultLegendInterpreter','latex');
    set(groot,'defaultColorBarTickLabelInterpreter','latex');

    % Initialize Figure
    figurehandle=figure;

    % File Name
    filename=sprintf('CompiledHeatMap_%02d',n);

    %Figure Title
    if ArrayName(6)=='T'
        PopName='Total (WD)';
    elseif ArrayName(6)=='S'
        PopName='Susceptible';
    elseif ArrayName(6)=='I'
        PopName="Infectious";
    elseif ArrayName(6)=='D'
        PopName='Total (DF)';
    end
    
    mytitle=[figuretitle,sprintf('Compiled %s Population Heat Map',PopName),sprintf('Limit Cycle Size: $%02d$',n)];

    %Plot Data
    imagesc([increm2(1),increm2(3)],[increm1(1),increm1(3)],data,[0,lcthresh+2])

    %Formatting
    set(gca,'YDir','normal') % flip matrix data and y-axis tick labels vertically so origin is bottom left.
    colormap(eighteencolormap(18))
    c=colorbar; % show colorbar
    c.Ticks=[.5:1:lcthresh+2.5]; 
    c.TickLabels=['background',string(1:1:lcthresh),sprintf('%d+',lcthresh+1)];
    ylabel(c,'Unique Points','Interpreter','latex')
    title(mytitle)
    ylabel(bp1label)
    xlabel(bp2label)

    % Reset Text Interpreter to Default
    set(groot,'defaultAxesTickLabelInterpreter','none');  
    set(groot,'defaultTextInterpreter','none');
    set(groot,'defaultLegendInterpreter','none');
    set(groot,'defaultColorBarTickLabelInterpreter','none');  
end

%==========================================================================
%% LOCAL FUNCTION: EIGHTEENCOLORMAP
%==========================================================================
function selectedvalues=eighteencolormap(x)

        colorvalues=[
            220 220 220     %null -- grey
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