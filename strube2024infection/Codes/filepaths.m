function filepath=filepaths(figchoice)

%==========================================================================
%% CODE DESCRIPTION
%==========================================================================
% This takes the user-inputted figchoice index and returns a corresponding
% filepath for a .mat file containing stored run conditions and data for
% figures in the manuscript:
%
%       LF Strube, S Elgart, and LM Childs. Infection induced increases
%       to population size during cycles in a discrete-time epidemic model. 
%       Journal of Mathematical Biology. Vol:Article (2024). 
%
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
%% ------------------------------------------------------------------------
%==========================================================================
%% CODE START
%=========================================================================
    if figchoice == 01     % Figure 1b
        fprintf("To generate figures like Figure 01b, escape this script and see the function Code/growthforms.m\n\n")
        pause
    elseif figchoice == 02 % Figure 2a
        filepath="Data\strube2024infection_f02a_wuinf.mat";
    elseif figchoice == 03 % Figure 2b left
        filepath="Data\strube2024infection_f02bcleft_wuinf.mat";
    elseif figchoice == 04 % Figure 2b right
        filepath="Data\strube2024infection_f02bcright_wuinf.mat";
    elseif figchoice == 05 % Figure 2c left
        filepath="Data\strube2024infection_f02bcleft_wuinf.mat";
    elseif figchoice == 06 % Figure 2c right
        filepath="Data\strube2024infection_f02bcright_wuinf.mat";
    elseif figchoice == 07 % Figure 2d left
        filepath='Data\strube2024infection_f02dleft_wuinf_manuscript.mat';
    elseif figchoice == 08 % Figure 2d right
        filepath="Data\strube2024infection_f02dright_wuinf_manuscript.mat";
    elseif figchoice == 09 % Figure 2e left
        filepath="Data\strube2024infection_f02eleft_wuinf_manuscript.mat";
    elseif figchoice == 10 % Figure 2e right
        filepath="Data\strube2024infection_f02eright_wuinf_manuscript.mat";
    elseif figchoice == 11 % Figure 3a
        filepath="Data\strube2024infection_f03ab_fecund.mat";
    elseif figchoice == 12 % Figure 3b
        filepath="Data\strube2024infection_f03ab_fecund.mat";
    elseif figchoice == 13 % Figure 4a
        filepath="Data\strube2024infection_f04a_hydrafront.mat";
    elseif figchoice == 14 % Figure 4b
        filepath="Data\strube2024infection_f04b_hydrafront.mat";
    elseif figchoice == 15 % Figure 5 top
        filepath="Data\strube2024infection_f05_chaos.mat";
    elseif figchoice == 16 % Figure 5 middle
        filepath="Data\strube2024infection_f05_chaos.mat";
    elseif figchoice == 17 % Figure 5 bottom
        filepath="Data\strube2024infection_f05_chaos.mat";
    elseif figchoice == 18 % Figure 6a
        filepath="Data\strube2024infection_f0607a_initcond.mat";
    elseif figchoice == 19 % Figure 6b
        filepath="Data\strube2024infection_f0607b_initcond.mat";
    elseif figchoice == 20 % Figure 6c
        filepath="Data\strube2024infection_f0607c_initcond.mat";
    elseif figchoice == 21 % Figure 6d
        filepath="Data\strube2024infection_f0607d_initcond.mat";
    elseif figchoice == 22 % Figure 7a
        filepath="Data\strube2024infection_f0607a_initcond.mat";
    elseif figchoice == 23 % Figure 7b
        filepath="Data\strube2024infection_f0607b_initcond.mat";
    elseif figchoice == 24 % Figure 7c
        filepath="Data\strube2024infection_f0607c_initcond.mat";
    elseif figchoice == 25 % Figure 7d
        filepath="Data\strube2024infection_f0607d_initcond.mat";
    elseif figchoice == 26 % Figure 8a
        filepath="Data\strube2024infection_f08a_hydraex_manuscript.mat";
    elseif figchoice == 27 % Figure 8b
        filepath="Data\strube2024infection_f08b_hydraex_manuscript.mat";
    elseif figchoice == 28 % Figure 8c
        filepath="Data\strube2024infection_f08c2_hydraex.mat";
    elseif figchoice == 29 % Figure 8d
        filepath="Data\strube2024infection_f08d_hydraex.mat";
    elseif figchoice == 30 % Figure C01 top
        filepath="Data\strube2024infection_c01a_sens_manuscript.mat";
    elseif figchoice == 31 % Figure C01 middle
        filepath="Data\strube2024infection_c01b_sens_manuscript.mat";
    elseif figchoice == 32 % Figure C01 bottom
        filepath="Data\strube2024infection_c01c_sens_manuscript.mat";
    elseif figchoice == 33 % Figure C02a
        filepath="Data\strube2024infection_c02_numerr.mat";
    elseif figchoice == 34 % Figure C02a
        filepath="Data\strube2024infection_c02_numerr.mat";
    end
end
%==========================================================================
%% CODE START
%==========================================================================