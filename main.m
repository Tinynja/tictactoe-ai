%%
clear all
close all

%%
% States are represented as strings. Each character corresponds to the
% state of the cell as shown in the following grid. Possible cell states
% are "x", "o", or "-".
% 
%    1 | 2 | 3
%   -----------
%    4 | 5 | 6
%		-----------
%		 7 | 8 | 9
%

%% Main code

epsilon = 0;
gamma = 1;

