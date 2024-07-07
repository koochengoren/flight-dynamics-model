% AE 165 Computer Project
% filename: dateme.m
% class:    function
%
% PURPOSE:  Applies the current date to the current figure window.
%
% USAGE: "dateme" will add today's date to current figure window
%        "dateme off" will hide all dateme dates in the c.f.w.
%        "dateme on" will show any hidden dateme dates in the
%                    c.f.w., or add the date if none exists yet.
%        "dateme( X )" will add dates to all the figures whos
%                      handles are given in vector X
%		
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% START OF FUNCTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	function [dateax, datetxt] = dateme( fig )

%-----------------------------------------------------------------------------
%	Verify inputs
%-----------------------------------------------------------------------------
	if nargin < 1; 		
		fig = gcf;
	else;	
		if isstr('fig');
			datehand = findobj( gcf, 'UserData', 'datetext' );
			if strcmp( lower(fig), 'off' ) & ~isempty( 'datehand' )
				set( datehand, 'visible', 'off' ); return;
			elseif strcmp( lower(fig), 'on' )
				if isempty( datehand )
					fig = gcf;
				else
					set( datehand, 'visible', 'on' ); return;
				end
			else
				error('Could not apply command; ''on'' or ''off'' expected')
			end;
		else
			fig = fig( : );
		end;
	end;
%-----------------------------------------------------------------------------
%	Initialize variables
%-----------------------------------------------------------------------------
	datehand1	= zeros( size( fig ) );
	datehand2 	= datehand1;
%-----------------------------------------------------------------------------
%	Apply the current date to all figures listed 
%-----------------------------------------------------------------------------
	for idx = 1 : length( fig )
	  figure( fig( idx ) );
	  oldunits = get( gcf, 'Units' );
	  set( gcf, 'Units', 'normalized' )
	  datehand1( idx ) = axes(  'Visible', 'off', 'UserData', 'dateaxes',...
								'Position', [ .95 .7 .01 .01] ); 
	  datehand2( idx ) = text( 	'Units','data', 'Position',   [ -97.33 28.14 0.00 ],...
								'String', date, 'Rotation', 360,...
								'Userdata', 'datetext' );
	  set( datehand2( idx ),...
			'Fontsize', 	10,...
         'FontWeight', 	'normal',...
        	'FontName','Tempus Sans ITC', ...
         'FontWeight','bold', ...	
			'ButtonDownFcn','moveobj',...
			'UserData',		'datetext' );
	  set( gcf, 'Units', oldunits )
  end;
 % [ 0.1, 0.7 ]
%-----------------------------------------------------------------------------
%	Verify Outputs
%-----------------------------------------------------------------------------
	if nargout > 0;			dateax  = datehand1;			end;
	if nargout > 1;			datetxt = datehand2;			end
	

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END FUNCTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
