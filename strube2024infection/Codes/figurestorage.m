function FigureStorage(figurehandle,storagedirectory)

%==========================================================================
%% CODE DESCRIPTION
%==========================================================================
%   This script automates the storage of figures currently in the
%   workspace. 
%
%   INPUTS:
%   ------
%   A single figure handle and the filepath to the directory where it
%   should be stored.
%
%   OUTPUTS:
%   --------
%   Four file types;
%       - .fig 
%       - .jpg
%       - .eps
%       - .pdf
%
%   DEPENDENCIES:
%   -------------
%   None
%
%   USED BY:
%   -------
%   strube2024infection_driver.m (See end of function)
%
%   QUESTIONS about the code set? 
%               Email Laura Strube at LFStrube@gmail.com
%
%% ------------------------------------------------------------------------
%==========================================================================
%% CODE START
%==========================================================================

%% (A) SET PAPER SIZE FOR PDF STORAGE
    figurehandle.Units='inches';
    figureposition=get(figurehandle,'Position'); %[left, bottom, width, height]
    figurewidth=figureposition(3);
    figureheight=figureposition(4);
    figurehandle.PaperUnits = 'inches';
    set(figurehandle, 'PaperSize', [figurewidth figureheight]); %paper size
    set(figurehandle, 'PaperPositionMode', 'manual');
    figurehandle.PaperPosition = [0 0 figurewidth figureheight]; %figure position on paper

%% (B) STORE FIGURE
    %pdf
    print(figurehandle,'-dpdf','-r300',storagedirectory)
    
    %.fig
    savefig(figurehandle,strcat(storagedirectory,'.fig'))
    
    %.eps
    print(figurehandle,'-dpsc2','-r300',strcat(storagedirectory,'.eps'))
    
    %.jpg
    saveas(figurehandle,storagedirectory,'jpeg')
end
%==========================================================================
%% CODE START
%==========================================================================