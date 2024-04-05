function [HS,HI,HT,HSDF]=cyclesizeanalyzer(S,I,T,S_DF,sz1,sz2,accuracy,lc)
%==========================================================================
%%  CODE DESCRIPTION
%==========================================================================
%   This function analyzes arrays of simulation data produced by
%   datagenerator.m by calculating the limity-cycle size of the system
%   corresponding to each specified bifurcation parameter pair for the 
%   purpose of constructing two-parameter heat maps. It allows the user to 
%   specify the degree of accuracy to use when comparing trajectory values 
%   (for the purpose of quantifying the limit cycle size) and to specify 
%   the limit cycle size threshold for the upper heat map bin. 
%
%
%   [HS,HI,HT,HSDF]=cyclesizeanalyzer(S,I,T,S_DF,sz1,sz2,accuracy,lc)
%
%   INPUTS:
%   --------
%   X           : Long-time trajectories of the with-disease system
%                   (dim: 2,sz1,sz2,timeatequil)
%   X_DF        : Long-time trajectories of the disease-free system
%                   (dim: 1,sz1,sz2,timeatequil)
%   sz1         : qty of first bifurcation parameter increments (scalar)
%   sz2         : qty of second bifurcation parameter increments (scalar)
%   accuracy    : rounding decimal place (scalar)
%   lc          : maximum recorded limit cycle size (scalar)
%
%   Note: This input arrays X and X_SF *must* contain only long-time
%   trajectory data. Inclusion of early transient behavior will lead to
%   erroneous limit cycle size counts. 
%    
%   OUTPUTS:
%   ---------
%   HS          : Susceptible population array of limit cycle sizes 
%                 (dim: sz1,sz2)
%   HI          : Infected population array of limit cycle sizes 
%                 (dim: sz1,sz2)
%   HT          : Total with-disease population array of limit cycle sizes 
%                 (dim: sz1,sz2)
%   HSDF        : Total disease-free population array of limit cycle sizes 
%                 (dim: sz1,sz2)
%
%   DEPENDENCIES: 
%   -------------
%   None
%
%   USED BY: 
%   ---------
%   *_driver.m
%       Necessary for use of heatmapplot.m
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
%
%% ------------------------------------------------------------------------
%==========================================================================
%%  START CODE
%==========================================================================

%% (A) CONSTRUCT ARRAYS OF ROUNDED TO DATA 
    %Round array entries to allow for identification of distinct equilibria 

    rounding=accuracy;

    Sround=round(S,rounding,'decimals');
    Iround=round(I,rounding,'decimals');
    Tround=round(T,rounding,'decimals');

    S_DFround=round(S_DF,rounding,'decimals');

%% (B) COUNT THE QTY OF UNIQUE EQUILIBRIA FOR EACH BIFURCATION PARAMETER PAIR

    %(I) Initialize arrays for efficiency

        HS=NaN(sz1,sz2);
        HI=NaN(sz1,sz2);
        HT=NaN(sz1,sz2);

        HSDF=NaN(sz1,sz2);

    %(II) Count unique equilibria 

        for i=1:1:sz1
            for j=1:1:sz2
                %Count the unique equilibria
                HS(i,j)=size(unique(Sround(i,j,:)),1);
                HI(i,j)=size(unique(Iround(i,j,:)),1);
                HT(i,j)=size(unique(Tround(i,j,:)),1);
                
                HSDF(i,j)=size(unique(S_DFround(i,j,:)),1);
            end
        end

%% (C) BIN LIMIT-CYCLE COUNTS ABOVE THE CHOSEN THRESHOLD VALUE

    HS(HS>lc)=lc+1;
    HI(HI>lc)=lc+1;
    HT(HT>lc)=lc+1;

    HSDF(HSDF>lc)=lc+1;
    
end
%==========================================================================
%%  END CODE
%==========================================================================
