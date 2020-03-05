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

n = 10000;

policy = containers.Map('epsilon', 0);

wins = 0;
loses = 0;
rounds = zeros(n, 1);

for i = 1:n
	episode = generate_episode(policy, '---------', 1);
	rounds(i) = episode{3, end-1};
end

fprintf('rounds  win    lose   tie\n')
fprintf('--------------------------\n')
fprintf('%5d%6.1f%%%6.1f%%%6.1f%%\n', n, sum(rounds==1)/n*100, sum(rounds==-1)/n*100, sum(rounds~=1 & rounds~=-1)/n*100);