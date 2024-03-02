
function [figurehandle,newfigurecounter]=...
    hydraeffectplot(plottype,HydraArray,bifpar1,bifpar2,threshold,...
    increm1,increm2,bp1label,bp2label,colorbarlabel,figuretitle,...
    oldfigurecounter)

%==========================================================================
%% CODE DESCRIPTION
%==========================================================================
%  This function constructs one of five distinct hydra effect plots
%  depending on "plottype" and "threshold":
%       (1) Binary Hydra Effect -- with disease population size is or is
%       not above the disease-free population by a factor of "threshold". 
%       (2) Linear-Scale Hydra Effect -- With-disease population size
%       scaled by disease-free population size.
%           - with hydra-effect below a threshold graphed in grey scale
%           - with all hydra-effect graphed in a colorscale
%           ("threshold"=0).
%       (2) Fold-Change Hydra Effect -- Log2 of with-disease population 
%           size scaled by disease-free population size.
%           - with hydra-effect below a threshold graphed in grey scale
%           - with all hydra-effect graphed in a colorscale
%           ("threshold"=0).
%
%   It allows users to enter a figure title, axis and colorbar labels, 
%   and returns the figurehandle for the figure.
%
%   [figurehandle,newfigurecounter]=...
%       hydraeffectplot(plottype,HydraArray,threshold,increm1,increm2,...
%       bifpar1,bifpar2,bp1label,bp2label,colorbarlabel,figuretitle,...
%       oldfigurecounter)
%
%   INPUTS:
%   -------
%   plottype            :
%   HydraArray          :
%   threshold           :
%   increm1             :
%   increm2             :
%   bifpar1             :
%   bifpar2             :
%   bp1label            :
%   bp2label            :
%   colorbarlabel       :
%   figuretitle         :
%   oldfigurecounter    :
%
%   OUTPUTS:
%   --------
%   figurehandle        :
%   figurecounter       :
%
%   DEPENDENCIES: 
%   -------------
%   hydrafigure [Local function, below]
%
%   USED BY: 
%   ---------
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

%% (I) SET NORMALIZATION FACTOR AND COLORBAR THRESHOLDS

    % First Threshold
    Cmin=min(HydraArray(:));   
    
    % Second Threshold
    Cnone=1;
    if strcmp(plottype,'FoldChangeHydra')
        Cnone=log2(Cnone);
    end
   
    % Third Threshold
    if ~strcmp(threshold,'none') 
        if ~strcmp(plottype,'FoldChangeHydra')
            Cthreshold=threshold+1;
        else
            Cthreshold=log2(threshold+1);
        end
    end

    % Fourth Threshold
    Cmax=max(HydraArray(:)); 

    % Normalization Factor

        % Choose for aesthetics
        if strcmp(threshold,'none') || threshold==0
            if ~strcmp(plottype,'FoldChangeHydra')
                normalizationfactor=abs((1+0.05) - 1);
            else
                normalizationfactor=abs(log2(1+0.05) - log2(1));
            end
        %Set to the height of grey region
        else
            normalizationfactor=abs(Cthreshold-Cnone); 
        end

%% (II) CALCULATE THE COLORBAR LENGTHS

    if strcmp(threshold,'none')
        colorlength=abs(Cmax-Cmin)/normalizationfactor;
        greylength=0;
        blacklength=0;
    else
       colorlength=abs(Cmax-Cthreshold)/normalizationfactor;
       greylength=abs(Cthreshold - Cnone)/normalizationfactor;
       blacklength=abs(Cnone-Cmin)/normalizationfactor;
    end
    
%% (III) NORMALIZE THE COLORBAR LENGTHS
    normalizedblacklength=blacklength/normalizationfactor;
    normalizedgreylength=greylength/normalizationfactor;
    normalizedcolorlength=colorlength/normalizationfactor;

%% (IV) CONSTRUCT COLOR ORDER

    if strcmp(plottype,'BinaryHydra')
        col=[1 1 1; 0 0 0];
    else
        resolution = 50;
 
        qtyblack=resolution*normalizedblacklength;
        qtygrey=resolution*normalizedgreylength;
        qtycolor=resolution*normalizedcolorlength;
    
        col1= ones(floor(qtyblack),1)*[0 0 0];
        col2 = gray(qtygrey+1); 
        col3 = turbo(qtycolor);    

        col = cat(1,col1,col2(2:end,:),col3);
    end

%% (V) DEFINE COLORBAR LIMITS

    if strcmp(plottype,'BinaryHydra')
        cmin=0;
        cmax=2;
    elseif strcmp(threshold,'None')
        cmin=min(HydraArray(:));
        cmax=max(HydraArray(:));
    else
        cmin=0; %no need for a large black region in the colorbar
        cmax=max(HydraArray(:));
    end

%% (VI) GENERATE HYDRA EFFECT FIGURE

 [figurehandle,newfigurecounter]=...
     hydrafigure(plottype,HydraArray,bifpar1,bifpar2,increm1,increm2,...
     [cmin,cmax],col,colorbarlabel,bp1label,bp2label,figuretitle,...
     oldfigurecounter);
end
%==========================================================================
%% END CODE
%==========================================================================
%% ------------------------------------------------------------------------
%==========================================================================
%% LOCAL FUNCTION: GENERAL HYDRA EFFECT
%==========================================================================
function [figurehandle,figurecounter]=...
    hydrafigure(plottype,HydraArray,bifpar1,bifpar2,increm1,increm2,...
    clim,colororder,colorbarlabel,bp1label,bp2label,figuretitle,...
    oldfigurecounter)
%% START CODE
%% (I) SET LATEX AS THE DEFAULT INTERPRETER
    %"groot"= root of all graphics objects
    set(groot,'defaultAxesTickLabelInterpreter','latex');  
    set(groot,'defaultTextInterpreter','latex');
    set(groot,'defaultLegendInterpreter','latex');
    set(groot,'defaultColorBarTickLabelInterpreter','latex');

%% (II) INITIALIZE FIGURE
    figurehandle=figure;
    figurecounter=oldfigurecounter+1;

%% (III) PLOT DATA  
    %   Note: 'AlphaData' ~isnan(HydraArray) causes HydraEffect values of 0 
    % to be transparent in the fold change diagram.
   imagesc([increm2(1),increm2(3)],[increm1(1),increm1(3)],HydraArray,clim);

%% (IV) REORIENT AXES IF NEEDED
    % Note: If the bifurcation parameter is "w" perform a change of
    % variables "w_tilde"="-w".


    if bifpar1 ~= 4 %(for all bifurcation parameters except w)
        % flip matrix data and tick labels so y-origin is bottom left.
        set(gca,'YDir','normal') 
    end
    
    if bifpar2 == 4 %(when w is used as a bifurcation parameter)
        % flip matrix data and tick labels so x-origin is bottom right.
        set(gca,'XDir','reverse')
    end

    if bifpar1==4
        %bp1label='\tilde{w}'; % Note: Have to relabel ticks of using this
        %functionality
    end

    if bifpar2==4
        %bp2label='\tilde{w}'; % Note: Have to relabel ticks if using this
        %functionality.
    end
  
 %% (V) FORMAT THE FIGURE
    c=colorbar;
    colormap(colororder)
    ylabel(c, colorbarlabel,'Interpreter','latex')
    title(figuretitle)

    if strcmp(bp1label,'mu')
        bp1label='\mu';
    end

    if strcmp(bp2label,'mu') 
        bp2label='\mu';
    end

    ylabel(strcat('$',bp1label,'$'))
    xlabel(strcat('$',bp2label,'$'))

%% (VI) FORMAT COLORBAR TICK LABELS

    if strcmp(plottype,'BinaryHydra')
        c.Ticks=[0.5:1:1.5];
        c.TickLabels={'No','Yes'};
    end

    if strcmp(plottype,'FoldChangeHydra')
        c.Ticks=[0:1:4];
        c.TickLabels={...
            '$1\times$','$2\times$','$4\times$','$8\times$','$16\times$'};
    end


%% (VII) RESET TEXT INTERPRETER TO DEFAULT
    set(groot,'defaultAxesTickLabelInterpreter','none');  
    set(groot,'defaultTextInterpreter','none');
    set(groot,'defaultLegendInterpreter','none');
    set(groot,'defaultColorBarTickLabelInterpreter','none');  
end
%==========================================================================
%% END CODE
%==========================================================================
