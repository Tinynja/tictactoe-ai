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

%Choose who is player_2 between: random, ai_1, ai_2
player_2 = 'ai_2';

gamma = 0.8;
epsilon = 0.2;
n = 5000;

% The index map contains the mapping from state to index as they are stored
% in the policy and action_values cell arrays.
% 
% The policy cell array contains A* for every state
% 
% the action_values cell array contains a cell for each state in the form:
% [action_1_value #_of_visits; action_2_value #_of_visits;...]

gamma_1 = gamma;
index_1 = containers.Map('epsilon', 1);
policy_1 = epsilon;
action_values_1 = {};

gamma_2 = gamma;
index_2 = containers.Map('epsilon', 1);
policy_2 = epsilon;
action_values_2 = {};

rounds = zeros(n, 1);

for i = 1:n
	if ~mod(i,500)
		fprintf('Training... %.1f%%\n', round(i/n*100, 1))
	end
	
	[episode_1, episode_2] = generate_episode(index_1, policy_1, index_2, policy_2, '---------', 1+mod(i,2));
	
	rounds(i) = episode_1{3, end-1};
	
	[index_1, policy_1, action_values_1] = update_agent(episode_1, gamma_1, index_1, policy_1, action_values_1);
	if strcmp(player_2, 'ai_1')
		index_2 = index_1;
		policy_2 = policy_1;
		action_values_2 = action_values_1;
	elseif strcmp(player_2, 'ai_2')
		[index_2, policy_2, action_values_2] = update_agent(episode_2, gamma_2, index_2, policy_2, action_values_2);
	end
end

fprintf('rounds  win    lose   tie\n')
fprintf('--------------------------\n')
fprintf('%5d%6.1f%%%6.1f%%%6.1f%%\n', n, sum(rounds==1)/n*100, sum(rounds==-1)/n*100, sum(rounds~=1 & rounds~=-1)/n*100);

plot_results(rounds, 1)

%% cleanup
