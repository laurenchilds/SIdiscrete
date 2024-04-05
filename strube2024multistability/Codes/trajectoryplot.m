function [figurehandle, figurecounter] = trajectoryplot(t,x,legendentry,ylab,figuretitle,figurecounter)

%==========================================================================
%% CODE DESCRIPTION
%==========================================================================
%   This function plots a single trajectory with user-supplied legend, axis
%   label, and title text.

%   INPUTS:
%   -------
%   t               :   row vector of independent variable values
%   x               :   row vector of dependent variable values
%   legendentry     :   Text for legend (string)
%   ylab            :   Y-axis label (string)
%   title           :   Figure title (string
%   figurecounter   :   Current value of the figure counter [dim: scalar]
%
%   OUTPUTS:
%   -------
%   figurehandle    : figure handle
%   figurecounter   : For the purpose of figure storage [dim: scalar]
%
%   DEPENDENCIES:
%   -------------
%   None
%
%   USED BY:
%   --------
%   *_figuregenerator_manuscript.m
%   figuregenerator_userchoice.m
%
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
%
%% ------------------------------------------------------------------------
%==========================================================================
%% CODE START
%==========================================================================

%% (A) SET LATEX AS THE DEFAULT INTERPRETER
    %"groot"= root of all graphics objects
    set(groot,'defaultAxesTickLabelInterpreter','latex');  
    set(groot,'defaultTextInterpreter','latex');
    set(groot,'defaultLegendInterpreter','latex');
    set(groot,'defaultColorBarTickLabelInterpreter','latex');

%% (B) PLOT FIGURE
    figurecounter=figurecounter+1;
    figurehandle=figure;
    
    plot(t,x,'DisplayName',legendentry)
    xlabel('Time')
    ylabel(ylab)
    title(figuretitle)
    
%% (C) RESET TEXT INTERPRETER TO DEFAULT
set(groot,'defaultAxesTickLabelInterpreter','none');  
set(groot,'defaultTextInterpreter','none') 
set(groot,'defaultLegendInterpreter','none')
set(groot,'defaultColorBarTickLabelInterpreter','none');  

%==========================================================================
%% CODE END
%==========================================================================
end
