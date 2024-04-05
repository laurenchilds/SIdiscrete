% strube2024multistability_batchfigures

%==========================================================================
%% SCRIPT DESCRIPTION
%==========================================================================
% This script specifies which of the 9 figure types included in this code
% set are to be generated when simulating batch data. In each case Y=1/N=0.
% The selected batch figures correspond to those contained in:
%
%       LF Strube and LM Childs. Multistability in a discrete-time SI 
%       epidemic model with Ricker growth: Infection-induced changes in 
%       population dynamics. Contemporary Mathematics. 793, 167:190 (2024).  
%
%  The compiledhydra figure type is not used in this manuscript. It is
%  used in: 
% 
%       LF Strube, S Elgart, and LM Childs. Infection induced increases
%       to population size during cycles in a discrete-time epidemic model. 
%       Journal of Mathematical Biology. Vol:Article (2024). 
%
%
%   INPUTS:
%   -------
%   None
%  
%   OUTPUTS:
%   --------
%   variable values shown below
%
%   DEPENDENCIES:
%   -------------
%   none
%
%   USED BY: 
%   --------
%   figuregenerator_userchoice.m
%   *_figuregenerator_manuscript.m
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
%
%% ------------------------------------------------------------------------
%==========================================================================
%% START SCRIPT
%==========================================================================

% Batch figures used in strube2024multistability
lhs=1;
compiledlimitcycleplot=1;
multistab=1;

% Batch figure not used in strube2024multistability
compiledhydra=0;

% Non-batch figures that cannot be generated using batch data files 
% (do not edit)

heatmap=0;
avgpop=0;
singlehydra=0;
orbit=0;
trajectory=0;

%==========================================================================
%% END SCRIPT
%==========================================================================