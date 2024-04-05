function filepath=strube2024multistability_filepaths(figchoice)

%==========================================================================
%% CODE DESCRIPTION
%==========================================================================
% This takes the user-inputted figchoice index and returns a corresponding
% filepath for a .mat file containing stored run conditions and data for
% figures in the manuscript:
%
%       LF Strube and LM Childs. Multistability in a discrete-time SI 
%       epidemic model with Ricker growth: Infection-induced changes in 
%       population dynamics. Contemporary Mathematics. 793, 167:190 (2024). 
%
%   INPUTS:
%   -------
%   figchoice:  Index of the desired figure [scalar]
%
%   OUTPUTS:
%   --------
%   filepath:   Name of the .mat file containing the run conditions and 
%               data for the desired figure.
%
%   DEPENDENCIES:
%   -------------
%   - None
%
%   USED BY:
%   --------
%   strube2024multistability_driver.m
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
%
%% ------------------------------------------------------------------------
%==========================================================================
%% CODE START
%==========================================================================

    if     figchoice == 01 % Figure 2a
        filepath='strube2024multistability_f02a_winfluence';
    elseif figchoice == 02 % Figure 2b
        filepath='strube2024multistability_f02b_winfluence';
    elseif figchoice == 03 % Figure 2c
        filepath='strube2024multistability_f02c_winfluence';
    elseif figchoice == 04 % Figure 2d
        filepath='strube2024multistability_f02d_winfluence';
    elseif figchoice == 05 % Figure 3a
        filepath='strube2024multistability_f03a_newdynreg';
    elseif figchoice == 06 % Figure 3b
        filepath='strube2024multistability_f03b_newdynreg';
    elseif figchoice == 07 % Figure 3c
        filepath='strube2024multistability_f03c_newdynreg';
    elseif figchoice == 08 % Figure 4ac
        filepath='strube2024multistability_f04ac_jumps';
    elseif figchoice == 09 % Figure 4bd
        filepath='strube2024multistability_f04bd_jumps';
    elseif figchoice == 10 % Figure 5a5b
        filepath='strube2024multistability_f05a_initcond';
    elseif figchoice == 11 % Figure 5c5d
        filepath='strube2024multistability_f05b_initcond';
    elseif figchoice == 12 % Figure 6,7,A02, and A04
        filepath='strube2024multistability_f06f07a02a04_multistab';
    elseif figchoice == 13 % Figure A01
        filepath='strube2024multistability_a01_wdheat';
    elseif figchoice == 14 % Figure A03
        filepath='strube2024multistability_a03_4to4jump';
    end
end
%==========================================================================
%% CODE END
%==========================================================================