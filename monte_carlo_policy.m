%%
clear all

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

gamma = 1;
epsilon = 0;
n = 100;

policy = containers.Map('epsilon', epsilon);

rounds = zeros(n, 1);

for i = 1:n
	episode = generate_episode(policy, policy, '---------', 'x');
	rounds(i) = episode{3, end-1};
	G = 0;
	for j = length(episode,2)-1:-1:1
		G = gamma*G + episode{3,j};
		if all(cellfun(@(x) ~strcmp(x,episode(1,j)), episode(1,1:j-1), 'UniformOutput', true))
		end
end

fprintf('rounds  win    lose   tie\n')
fprintf('--------------------------\n')
fprintf('%5d%6.1f%%%6.1f%%%6.1f%%\n', n, sum(rounds==1)/n*100, sum(rounds==-1)/n*100, sum(rounds~=1 & rounds~=-1)/n*100);

plot_results(rounds, 1)