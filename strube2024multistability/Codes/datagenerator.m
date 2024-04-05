function [S,I,T,S_DF,AS,AI,AT,AS_DF]=...
    datagenerator(x0,param,timetoequil,timeatequil,avgtime,...
    bifpar1,bifpar2,bp1i,bp2i,sz1,sz2,parallelize,workercount)

%==========================================================================
%%  CODE DESCRIPTION
%==========================================================================
%   This function generates an array of simmulation data using the discrete 
%   SI model described by Strube et al. in: 
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
%   for the purpose of construction one-parameter orbit maps, two-parameter 
%   heat maps, and hydra effect diagrams. It allows users to specify the 
%   system initial conditions and model parameters, the quantity of time 
%   steps to be considered transient and discarded, the quantity of time 
%   steps to be retained for the construction of orbit and heat maps, and 
%   the quantity of time steps to be used in calculating trajectory 
%   averages. It also allows users to specify which parameters to use as
%   bifurcation parameters, which values of these parameters to use in
%   simulations, and whether or not to run the simulations for the array
%   using parallel computing. 
%
%
%   [S,I,T,S_DF,AS,AI,AT,AS_DF]=...
%               datagenerator(x0,param,timetoequil,timeatequil,avgtime,...
%               bifpar1,bifpar2,bp1i,bp2i,sz1,sz2,parallelize,workercount)

%   INPUTS:
%   -------
%   x0          : vector of model initial conditions (dim: )
%   param       : vector of model parameters (dim: )
%   timetoequil : qty of transient time steps at which to discard data 
%                   (scalar)
%   timeatequil : qty of time steps at which to retain data (scalar)
%   avgtime     : qty of (post-transient) time steps to use in average
%                   population calculations (scalar)
%   bifpar1     : index of the first bifurcation parameter (scalar)
%   bifpar2     : index of the second bifurcation parameter (scalar)
%   bp1i        : first bifurcation parameter increments (dim: 1,sz1 )
%   bp2i        : second bifurcation parameter increments (dim: 1,sz2)
%   sz1         : qty of first bifurcation parameter increments (scalar)
%   sz2         : qty of second bifurcation parameter increments (scalar)
%   parallelize : user choice of whether or not to parallelize simulations
%                   (Y=1, N=0)
%   workercount : qty of workers to use in parallel processing 
    
%   OUTPUTS:
%   --------
%   S           : Suceptible Population (dim: sz1,sz2,timeatequil)
%   I           : Infected Population (dim: sz1,sz2,timeatequil)
%   T           : Total Population of the With-Disease System 
%                   (dim: sz1,sz2,timeatequil)
%   S_DF        : Total Population of the Disease-Free System 
%                   (dim: sz1,sz2,timeatequil)
%   AS          : Average Susceptible Population (dim: sz1,sz2)
%   AI          : Average Infected Population (dim: sz1,sz2)
%   AT          : Average Total Population (dim: sz1,sz2)
%   AS_DF       : Average Total Population of the Disease-Free System 
%                   (dim: sz1,sz2)
%
%   DEPENDENCIES: 
%   -------------
%   generator [Local function, below]
%   trajectorysimulator.m
%
%   USED BY: 
%   ---------
%   *_driver.m
%
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
%
%% ------------------------------------------------------------------------
%==========================================================================
%%  START CODE
%==========================================================================

%% (A) PREALLOCATE SIMULATION STORAGE MATRICES

    S=NaN(sz1,sz2,timeatequil);
    I=NaN(sz1,sz2,timeatequil);
    T=NaN(sz1,sz2,timeatequil);
    S_DF=NaN(sz1,sz2,timeatequil);
    AS=NaN(sz1,sz2);
    AI=NaN(sz1,sz2);
    AT=NaN(sz1,sz2);
    AS_DF=NaN(sz1,sz2);

if parallelize==1 %use parallel processing
    
    %% (B01) CONDUCT SIMULATIONS IN PARALLEL
        if sz1>sz2 %parallelize along the larger dimension
            parfor (i = 1:sz1,workercount)  %For all values of bif param 1
                for j=1:1:sz2 %For all values of bifurcation parameter 2
        
                    %Simulate the system (retain only long-time behavior)
                    [S(i,j,:),I(i,j,:),T(i,j,:),S_DF(i,j,:),AS(i,j),...
                        AI(i,j),AT(i,j),AS_DF(i,j)]=...
                        generator(x0,param,timetoequil,timeatequil,...
                        avgtime,bifpar1,bifpar2,bp1i,bp2i,i,j)
            
                end 
            end 
        else % i.e. sz2 > sz1 
            parfor (i = 1:sz1,workercount)  %For all values of bif param 1
                for j=1:1:sz2 %For all values of bifurcation parameter 2
                   
                %Simulate the system (retaining only the long-time behavior)    
                [S(i,j,:),I(i,j,:),T(i,j,:),S_DF(i,j,:),AS(i,j),AI(i,j),...
                    AT(i,j),AS_DF(i,j)]=...
                    generator(x0,param,timetoequil,timeatequil,avgtime,...
                    bifpar1,bifpar2,bp1i,bp2i,i,j)
                     
                end 
            end 
        end

else %do not use parallel processing

    %% (B02) CONDUCT SIMULATIONS IN SERIAL
        if sz1>sz2 
            for i = 1:1:sz1  %For all values of bifurcation parameter 1
                for j=1:1:sz2 %For all values of bifurcation parameter 2
        
                    %Simulate the system (retaining only the long-time behavior)
                    [S(i,j,:),I(i,j,:),T(i,j,:),S_DF(i,j,:),AS(i,j),...
                        AI(i,j),AT(i,j),AS_DF(i,j)]=...
                        generator(x0,param,timetoequil,timeatequil,...
                        avgtime,bifpar1,bifpar2,bp1i,bp2i,i,j);
            
                end 
            end 
        else % i.e. sz2 > sz1 
            for i = 1:1:sz1  %For all values of bifurcation parameter 1
                for j=1:1:sz2 %For all values of bifurcation parameter 2
                   
                %Simulate the system (retaining only the long-time behavior)    
                [S(i,j,:),I(i,j,:),T(i,j,:),S_DF(i,j,:),AS(i,j),AI(i,j),...
                    AT(i,j),AS_DF(i,j)]=...
                    generator(x0,param,timetoequil,timeatequil,avgtime,...
                    bifpar1,bifpar2,bp1i,bp2i,i,j);
                     
                end 
            end 
        end
end
end

%==========================================================================
%% END CODE
%==========================================================================
%% ------------------------------------------------------------------------
%==========================================================================
%% LOCAL FUNCTION: GENERATOR
%==========================================================================
function [susceptible,infected,total,diseasefree,avg_susceptible,...
    avg_infected,avg_total,avg_diseasefree]=...
    generator(x0,param,timetoequil,timeatequil,avgtime,bifpar1,...
    bifpar2,bp1i,bp2i,i,j)

%==========================================================================
%% CODE DESCRIPTION:
%==========================================================================
%
%   This function extracts a single set of parameters from the vectors of
%   inputted bifurcation parameters values and uses those parameters to 
%   simulated the system described in trajectory simulator. 
%
%   [susceptible,infected,total,diseasefree,avg_susceptible,...
%       avg_infected,avg_total,avg_diseasefree]=...
%       generator(x0,param,timetoequil,timeatequil,avgtime,bifpar1,...
%       bifpar2,bp1i,bp2i,i,j)
%
%   INPUTS:
%   -------
%   x           : vector of model initial conditions           (dim: )
%   p           : vector of model parameters                   (dim: )
%   timeatequil : qty of time steps at which to retain data    (scalar)
%   bifpar1     : index of the first bifurcation parameter     (scalar)
%   bifpar2     : index of the second bifurcation parameter    (scalar)
%   bp1i        : first bifurcation parameter increments       (dim: 1,sz1)
%   bp2i        : second bifurcation parameter increments      (dim: 1,sz2)
%   i           : index of current bifurcation parameter value (scalar)
%   j           : index of current bifurcation parameter value (scalar) 
%
%
%   OUTPUTS:
%   --------
%   susceptible : a single susceptible population trajectory 
%                   (dim: 1,timeatequil)
%
%   infected    : a single infected population trajectory       
%                   (dim:1,timeatequil)
%
%   total       : a single total population trajectory
%
%   diseasefree : a single diseasefree population trajectory 
%                   (dim: 1,timeatequil)
%
%   DEPENDENCIES: 
%   -------------
%   trajectorysimulator.m
%
%   USED BY: 
%   ---------
%   *_driver.m
%
%    QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com   
%
%==========================================================================
%%   START CODE
%==========================================================================

%% (A) SET BIFURCATION PARAMETER VALUES
    bp1increm=bp1i(i);
    bp2increm=bp2i(j);

%% (B) UPDATE MODEL CONDITIONS WITH BIFURCATION PARAMETER VALUES
    
    %(I) If the Bifurcation Parameters are Model Parameters

        if (0<bifpar1) && (bifpar1<7) 
            param(bifpar1)=bp1increm;
        end

        if (0<bifpar2) && (bifpar2<7)
            param(bifpar2)=bp2increm;
        end

    %(II) If the Bifurcation Parameters are Initial Conditions

        if (6<bifpar1) && (bifpar1<9)
            x0(bifpar1-6)=bp1increm; 
        end

        if (6<bifpar2) && (bifpar2<9) 
            x0(bifpar2-6)=bp2increm;
        end

%% (C) SIMULATE THE SYSTEM
        [~,x,tot,s_df]=trajectorysimulator(x0,param,timetoequil+timeatequil);

%% (D) RETAIN THE LONG-TIME SIMULATION DATA
        susceptible=x(1,timetoequil+1+1:timetoequil+1+timeatequil);
        infected=x(2,timetoequil+1+1:timetoequil+1+timeatequil);
        total=tot(timetoequil+1+1:timetoequil+1+timeatequil);
        diseasefree=s_df(timetoequil+1+1:timetoequil+1+timeatequil);

%% (E) CALCULATE THE POPULATION AVERAGE
        avg_susceptible=mean(x(1,end-avgtime+1:end));
        avg_infected=mean(x(2,end-avgtime+1:end));
        avg_total=mean(tot(end-avgtime+1:end));
        avg_diseasefree=mean(s_df(1,end-avgtime+1:end));
        
end
%==========================================================================
%% END CODE
%==========================================================================

