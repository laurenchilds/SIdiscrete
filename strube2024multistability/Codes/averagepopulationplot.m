function [figurehandle,newfigurecounter]=...
    averagepopulationplot(averagepopulationdata,bifpar1,bifpar2,increm1,increm2,...
    bp1label,bp2label,figuretitle,oldfigurecounter)

%==========================================================================
%% CODE DESCRIPTION
%==========================================================================
%   This function generates a heat map describing the long-time average 
%   population size over an array of bifurcation parameter values.
%
%   function [figurehandle,newfigurecounter]=...
%       averagepopulationplot(averagepopulationdata,bifpar1,bifpar2,increm1,increm2,...
%       bp1label,bp2label,figuretitle,oldfigurecounter)
%
%   INPUTS:
%   -------
%   averagepopulationdata   : Array of long-time avg. pop. size (dim: mxn)
%   bifpar1                 : Index (scalar identifier) of first bif param.
%   bifpar2                 : Index (scalar identifier) of second bif param
%   increm1                 : vector of bif param 1 increments (dim: 1xm)
%   increm2                 : vector of bif param 2 increments (dim: 1xn)
%   bplabel1                : latex formatted name for bif param 1 (string)
%   bplabel2                : latex formatted name for bif param 2 (string)
%   figuretitle             : figure title (string)
%   oldfigurecounter        : most recent figure counter value
%
%
%   OUTPUTS:
%   --------
%   figurehandle            : Figure Handle
%   newfigurecounter        : Counter value for the current figure
%
%   DEPENDENCIES: 
%   -------------
%   None
%
%   USED BY: 
%   ---------
%   figuregenerator_userchoice.m
%   figuregenerator_manuscript.m
%
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
%
%% ------------------------------------------------------------------------
%==========================================================================
%% START CODE
%==========================================================================

%% (A) SET LATEX AS THE DEFAULT INTERPRETER
    %"groot"= root of all graphics objects
    set(groot,'defaultAxesTickLabelInterpreter','latex');  
    set(groot,'defaultTextInterpreter','latex') 
    set(groot,'defaultLegendInterpreter','latex')
    set(groot,'defaultColorBarTickLabelInterpreter','latex');  

%% (B) SET THE DEFAULT FONT SIZE
    set(0,'defaultAxesFontSize',14)

%% (C) INITIALIZE THE FIGURE
    figurehandle=figure;
    newfigurecounter=oldfigurecounter+1;

%% (D) PLOT DATA

    imagesc([increm2(1),increm2(3)],[increm1(1),increm1(3)],averagepopulationdata)

%% (E) FORMAT FIGURE
    if bifpar1 ~= 4 %(for all bifurcation parameters except w)
        % Note: If the bifurcation parameter is "w" perform a change of
        % variables "w_tilde"="-w".
        set(gca,'YDir','normal') % flip matrix data so y-origin is left.
    end

    if bifpar2 == 4 %(when w is used as a bifurcation parameter)
        % Note: If the bifurcation parameter is "w" perform a change of
        % variables "w_tilde"="-w".
        set(gca,'XDir','reverse') % flip matrix data so x-origin is right.
    end

    if bifpar1==4
        %bp1label='\tilde{w}'; %Note: Have to relable ticks if using this
        %functionality
    end

    if bifpar2==4
        %bp2label='\tilde{w}'; %Note: Have to relable ticks if using this
        %functionality
    end

%% (F) FORMAT COLORBAR
    c=colorbar;
    ylabel(c,'Population Size','Interpreter','latex')

%% (G) LABEL FIGURE
    title(figuretitle)

    if strcmp(bp1label,'mu')
        bp1label='\mu';
    end

    if strcmp(bp2label,'mu') 
        bp2label='\mu';
    end

    ylabel(strcat('$',bp1label,'$'))
    xlabel(strcat('$',bp2label,'$'))

%% (H) RESET TEXT INTERPRETER TO DEFAULT
    set(groot,'defaultAxesTickLabelInterpreter','none');  
    set(groot,'defaultTextInterpreter','none') 
    set(groot,'defaultLegendInterpreter','none')
    set(groot,'defaultColorBarTickLabelInterpreter','none');  
end
%==========================================================================
%% END CODE
%==========================================================================
