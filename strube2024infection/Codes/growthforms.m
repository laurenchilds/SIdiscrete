% growthforms.m

%==========================================================================
%% CODE DESCRIPTION
%==========================================================================
% This function allows the user to construct figures illustrating the
% relative behaviors of linear, compensatory, and overcompensatory growth
% form.
%
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
%--------------------------------------------------------------------------
%==========================================================================
%% CODE START
%==========================================================================

    figuretitle='Growth Forms';
    filename='Reproduction_strube2024infection_F01b';

    x=[0:.1:210];
    
    %Linear
    d=50;
    linear=d*x;
    
    %Compensatory
    r=500;
    b=0.1;
    compensatory=r*(1-exp(-b*x));
    
    %Ricker
    r=exp(4);
    b=0.1;
    ricker=r*x.*exp(-b*x);
    
    
    %Growth Forms
    figure
    plot(x,linear,'LineWidth',2)
    hold on
    plot(x,compensatory,'LineWidth',2)
    hold on
    plot(x,ricker,'LineWidth',2)
    axis([0,60,0,600])
    xlabel('Population Size')
    ylabel('Population Growth')
    legend({'Linear', 'Compensatory', 'Overcompensatory'}, 'Location','SouthOutside')
%==========================================================================
%% CODE END
%==========================================================================