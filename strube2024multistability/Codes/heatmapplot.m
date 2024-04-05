function [figurehandle,newfigurecounter]=...
    heatmapplot(heatmapdata,bifpar1,bifpar2,increm1,increm2,lc,bp1label,...
    bp2label,figuretitle,oldfigurecounter)

%==========================================================================
%% CODE DESCRIPTION
%==========================================================================
%   This function generates two-parameter heat maps from arrays of
%   limit-cycle count data produced using cyclesizeanalyzer.m
% 
%   It allows the user to specify the axes labels and figure title and
%   returns the resulting figure handle. 
%
%   [figurehandle,newfigurecounter]=...
%       heatmapplot(heatmapdata,bifpar1,bifpar2,increm1,increm2,lc,...
%       bp1label,bp2label,figuretitle,oldfigurecounter)
%
%   INPUTS:
%   -------
%   heat map data       : Array of limit-cycle size data [dim: mxn]
%   bifpar1             : Index of first bifurcation parameter (scalar)
%   bifpar2             : Index of second bifurcation parameter (scalar)
%   increm1             : Vector containing 1st bif param increment specs  
%                           [min,stepsize,max]
%   increm2             : Vector containing 1st bif param increment specs  
%                           [min,stepsize,max]
%   lc                  : Value of maximum limit cycle size represented in 
%                           thebheat map colorbar
%   bp1label            : Latex-formatted name of first bif. parameter
%                           (for figure labels)
%   bp2label            : Latex-formatted name of first bif. parameter
%                           (for figure labels)
%   figuretitle         : Figure title
%   oldfigure counter   : Current figure counter value 
%
%   OUTPUTS:
%   --------
%   figure handle       : Figure handle
%   newfigurecounter    : Corresponding figure counter value 
%                           (used in file storage)
%
%   DEPENDENCIES: 
%   -------------
%   seventeencolormap [Local function, below]
%
%   USED BY: 
%   ---------
%
%   *_figuregenerator_manuscript.m
%   figuregenerator_userchoice.m
%   
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
%
%% ------------------------------------------------------------------------
%==========================================================================
%%  START CODE
%==========================================================================

%% (A) LOAD THE HEATMAP COLORMAP
    %Defined at the end of this file
    cm=@seventeencolormap;

%% (B) SET LATEX AS THE DEFAULT INTERPRETER
    %"groot"= root of all graphics objects
    set(groot,'defaultAxesTickLabelInterpreter','latex');  
    set(groot,'defaultTextInterpreter','latex') 
    set(groot,'defaultLegendInterpreter','latex')
    set(groot,'defaultColorBarTickLabelInterpreter','latex');  

%% (C) SET THE DEFAULT FONT SIZE
    set(0,'defaultAxesFontSize',14)

%% (D) INITIALIZE THE FIGURE
    figurehandle=figure;
    newfigurecounter=oldfigurecounter+1;

%% (E) PLOT DATA
     imagesc([increm2(1),increm2(3)],[increm1(1),increm1(3)],...
         heatmapdata,[1,lc+2])

%% (F) FORMAT FIGURE
    % Note: If the bifurcation parameter is "w" perform a change of
    % variables "w_tilde"="-w".

    if bifpar1 ~= 4 %(for all bifurcation parameters except w)
        % flip matrix data and tick labels so y-origin is bottom left.
        set(gca,'YDir','normal') 
    end

    if bifpar2 == 4 %(when w is used as a bifurcation parameter)
        % flip matrix data and tick labels so x-origin is bottom right.
        set(gca,'XDir','reverse') 
    end

    if bifpar1 == 4
        %bp1label='\tilde{w}'; %Note: have to relable ticks if using this
        %functionality
    end

    if bifpar2 == 4
        %bp2label='\tilde{w}'; %Note: have to relable ticks if using this
        %functionality
    end


%% (G) FORMAT COLORBAR
    colormap(cm(lc+1))
    c=colorbar;
    c.Ticks=1.5:1:lc+2.5; 
    c.TickLabels=[string(1:1:lc),'17+'];
    ylabel(c,'Unique Points','Interpreter','latex')

%% (H) LABEL FIGURE
    title(figuretitle)

    if strcmp(bp1label,'mu')
        bp1label='\mu'; 
    end

    if strcmp(bp2label,'mu') 
        bp2label='\mu'; 
    end

    ylabel(strcat('$',bp1label,'$'))
    xlabel(strcat('$',bp2label,'$'))

%% (I) RESET TEXT INTERPRETER TO DEFAULT
    set(groot,'defaultAxesTickLabelInterpreter','none');  
    set(groot,'defaultTextInterpreter','none') 
    set(groot,'defaultLegendInterpreter','none')
    set(groot,'defaultColorBarTickLabelInterpreter','none');  
end

%==========================================================================
%% END CODE
%==========================================================================
%% ------------------------------------------------------------------------
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
