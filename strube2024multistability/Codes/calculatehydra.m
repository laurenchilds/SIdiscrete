function [ContinuousHydra,FoldChangeHydra,BinaryHydra]=...
    calculatehydra(Tavg,S_DFavg,hydrathreshold)

%==========================================================================
%% CODE DESCRIPTION
%==========================================================================
%   This function calculates the degree of infection-induces hydra effect 
%   of the system at each of element of a two-dimensional array of 
%   bifurcation parameters.
%
%   It allows the user to specify the numerical threshold at which to
%   define the presence of an infection-induced hydra effect and returns
%   three arrays: one for the construction of qualitative hydra-effect plot
%   measured on a linear scale, one for the construction of a qualitative 
%   hydra-effect plot measured on a fold-change scale, and one for a binary 
%   hydra-effect plot.
%
%   [ContinuousHydra,FoldChangeHydra,BinaryHydra]=...
%                       calculatehydra(Tavg,S_DFavg,binaryhydrathreshold)
%
%   INPUTS:
%   -------
%   Tavg                    : Array, Total (WD) Pop. Avg. Values (dim:mxn)
%   S_DFavg                 : Array, Total (DF) Pop. Avg. Values (dim:mxn)
%   binaryhydrathreshold    : Threshold for calculating the BinaryHydra
%                             values (scalar > 0.01)
%
%   Note: 
%       m = qty of bifurcation parameter 1 increments
%       n = qty of bifurcation parameter 2 increments
%
%       Each value in each array corresponds to a single bifurcation
%       parameter pair. 
%
%   OUTPUTS:
%   --------
%   ContinuousHydra         : Array of Total (WD) Poplation Average scaled
%                             by corresponding Total (DF) Population Avg 
%                             values.
%                             (dim: mxn)
%
%   FoldChangeHydra         : Log2 (Fold change) of the ContinuousHydra
%                             Array elements
%                             (dim: mxn)
%
%   BinaryHydra             : Array of binary values (dim: mxn)
%                               (1) Element in the ContinuousHydra Array
%                                   is above binaryhydrathreshold
%                               (0) Element in the ContinuousHydra Array
%                                   is not above the binaryhydrathreshold
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
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
%
%% ------------------------------------------------------------------------
%==========================================================================
%% START CODE
%==========================================================================

%% (I) INITIALIZE THE BINARY HYDRA ARRAY
    [sz1,sz2]=size(Tavg);
    BinaryHydra=NaN(sz1,sz2);

%% (II) CALCULATE THE DEGREE OF HYDRA EFFECT FOR EACH PARAMETER PAIR 
    ContinuousHydra=Tavg./S_DFavg;  

%% (III) CALCULATE THE HYDRA EFFECT AS A FOLD CHANGE RELATIVE TO THE CORRESPONDING DISEASE-FREE SYSTEM 
    FoldChangeHydra=ContinuousHydra;
    FoldChangeHydra=log2(FoldChangeHydra);

%% (IV) EXPRESS EXISTANE OF A HYDRA-EFFECT AS A BINARY PROPERTY 
%       (above or below a specified threshold)
    for i=1:1:sz1
        for j=1:1:sz2
            if ContinuousHydra(i,j)>(hydrathreshold+1)
                BinaryHydra(i,j)=1;
            else
                BinaryHydra(i,j)=0;
            end
        end
    end
end % end function
%==========================================================================
%% END CODE
%==========================================================================
