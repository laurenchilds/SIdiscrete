function strube2024multistability_generateallmanuscriptfigures
%==========================================================================
%% CODE DESCRIPTION
%==========================================================================
% 
%   This function allows the user to generate all figures from the
%   manuscript 
%
%       LF Strube and LM Childs. Multistability in a discrete-time SI 
%       epidemic model with Ricker growth: Infection-induced changes in 
%       population dynamics. Contemporary Mathematics. 793, 167:190 (2024).
%
%   automatically. 
%
%   The user has two primary options:
%       (1) To generate the figures from stored data (available upon request)
%       (2) To generate the figures via simulation from stored run conditions
%
%   For the simulation option, parallelization is strongly recommended. 
%   This requires the use of the MATLAB Parallel Computing Toolbox.
% 
%   To view the quantity of cores (aka "workers") available on your machine
%   type:  
%               evalc(''feature(''numcores'')'')
%
%   in the MATLAB command line. If 'WorkerCount' (below) is left at its
%   default value of 1, use of the parallel pool will not provide a
%   computational speed up. 
%   
%   A few notes: 
% 
%   On a 12th Gen Intel(R) Core(TM) i7-12700H 2.30GHz 32.0 GB windows
%   computer with 14 parallel pool workers, simulation of all the
%   manuscript figures takes 12-18 hours. 
%
%   The user has the option of automatically storing the simulated 
%   data and figures if they uncomment Section 15 and Secton 16 of 
%   "strube2024multistability_driver.m". This will create ~ 10GB of data
%   and ~60MB of figure files. 
%
%   Prior to selecting figure and data storage options in this script, it
%   is recommened that the user generate and store data and figures for a
%   single manuscript figure (say Figure 02a) by following the prompts in
%   "strube2024multistability_driver.m" to verify correct file storage
%   location and to establish a reasonable expectation of file sizes. 
%
%   As the data underlying Figures 06,07, A02, and A04 is from 100 distinct
%   parameter sets, the file sizes for these figures will be substantially 
%   larger than that of the files underlying Figure 02a which requires only 
%   a single parameter set. 
%
%   INPUTS:
%   -------
%   user specifications manually entered below
%
%   OUTPUTS:
%   --------
%   - user specifications maually entered below
%   - the resulting figures and data generated via a call to "strube2024multistability.m"
%   
%   DEPENDENCIES:
%   -------------
%   strube2024multistability_driver.m
%   Files in the directory Codes 
%   Files in the directory Data (when generating figures from stored data)
%   Files in the directory LightData (when simulating figures from stored run conditions)
%
%
%   USED BY:
%   --------
%   none
%
%
%   QUESTIONS about the strube2024infection code set? 
%               Email Laura Strube at LFStrube@gmail.com
%
% -------------------------------------------------------------------------
%==========================================================================
%% START CODE
%==========================================================================

    for i=1:1:14                    % To generate all figures: i=1:1:14
    % Optional Choices. Defaults in annotations.
    Choices=struct(...
        'FigureReproduction',2,...  % Default: 2 (Generate from stored data=1/Simulate from stored run conditions=2)
        'FigureChoice', i,...       % Default: 1 (Figure index. See Codes/strube2024multistability_figureoptions.mat)  
        'Parallelize',  0,...       % Default: 0 (Parallelize? Y=1/N=0)
        'WorkerCount',  1,...       % Default: 1 (How may workers to use from parallel pool)
        'StoreFigures', 0,...       % Default: 0 (Store? Y=1/N=0)
        'StoreData',    0);         % Default: 0 (Store? Y=1/N=0)
    
    strube2024multistability_driver(Choices)
    end

end
%==========================================================================
%% END CODE
%==========================================================================