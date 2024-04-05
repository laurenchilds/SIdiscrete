function [t,X,Tot,XDF]= trajectorysimulator(x0,params,totaltime)
%==========================================================================
%% CODE DESCRIPTION
%==========================================================================
%   This function simulates a single trajectory of the discrete SI model 
%   described by Strube et al. in 
%
%       LF Strube, S Elgart, and LM Childs. Infection induced increases
%       to population size during cycles in a discrete-time epidemic model. 
%       Journal of Mathematical Biology. Vol:Article (2024). 
%
%   and in:
%
%       LF Strube and LM Childs. Multistability in a discrete-time SI 
%       epidemic model with Ricker growth: Infection-induced changes in 
%       population dynamics. Contemporary Mathematics. 793, 167:190 (2024).
% 
%   It takes user-specified initial conditions, model parameters, and total
%   time steps and returns trajectories for the susceptible, infectious,
%   and total with-disease populations as well as the trajectory for the 
%   corresponding disease-free system. 
%
%
%   [x_exp,T_exp,xdf_exp]= trajectorysimulator(x0,params,totaltime)
%
%   INPUTS:
%   -------
%   x0              : vector of model initial conditions    (dim: )
%   params          : vector of model parameters            (dim: )
%   totaltime       : total qty of simulations time steps   (scalar)
%
%   OUTPUTS:
%   --------
%   t              : a vector of time points (dim: 1 x totaltime)
%
%   X              : a single pair of trajectories for the with-disease 
%                       system produced using parameter vector params.     
%                       (dim: 2 x totaltime)
%                       Susceptible population trajectory: x_exp(1,:)
%                       Infected population trajectory: x_exp(2,:)
%
%   Tot            : a single trajectory of the total with-disease system 
%                       produced using parameter vector params.          
%                       (dim:1 x totaltime)
%
%   XDF             : a single trajectory of the disease-free system 
%                       produced using parameter vector params.                
%                       (dim:1 x totaltime)
%
%   DEPENDENCIES: 
%   -------------
%   None
%
%   USED BY: 
%   ---------
%   datagenerator.m
%
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
%
%% ------------------------------------------------------------------------
%==========================================================================
%% START CODE
%==========================================================================

%% (A) EXTRACT MODEL PARAMETERS
    Er = params(1);
    Eb = params(2);
    Ed = params(3);
    Ew = params(4);
    Ebetai = params(5);
    Emu = params(6);

%% (B) SET INITIAL CONDITIONS

    % Time
    t=0;
    
    % With-disease system
    X=x0;                   %dimensions: 
    Tot=x0(1)+x0(2);        %dimensions: scalar
    
    % Disease-free system
    XDF=Tot;                %dimensions: scalar
   
%% (C) SIMULATE THE SYSTEM 

    for k=1:1:totaltime+1
        
        % t (Time)
        t(1,k+1)=k;

        % S (Susceptible Population):
        X(1,k+1) = ...
            Er*(X(1,k)+Ew*X(2,k))*exp(-Eb*(X(1,k)+...
            Ew*X(2,k)))+(1-Ed)*X(1,k)*(exp(-Ebetai*X(2,k)));

        % I (Infectious Population):
        X(2,k+1) = (1-Ed)*X(1,k)*(1-exp(-Ebetai*X(2,k)))+...
            (1-Ed)*(1-Emu)*X(2,k);

        % T (Total Population)
        Tot(k+1)= ...
            Er*(X(1,k)+Ew*X(2,k))*exp(-Eb*(X(1,k)+...
            Ew*X(2,k)))+(1-Ed)*X(1,k)+(1-Ed)*(1-Emu)*X(2,k);

        % DFS (Disease-Free Population):
        XDF(1,k+1) = Er*XDF(1,k)*exp(-Eb*XDF(1,k))+...
            (1-Ed)*XDF(1,k);
    end
end

%==========================================================================
%% START CODE
%==========================================================================



