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
epsilon = 0.3;
n = 10000;

% The index map contains the mapping from state to index as they are stored
% in the policy and action_values cell arrays.
% 
% The policy cell array contains A* for every state
% 
% the action_values cell array contains a cell for each state in the form:
% [action_1_value #_of_visits; action_2_value #_of_visits;...]

index_1 = containers.Map('epsilon', 1);
policy_1 = epsilon;
action_values = {};

index_2 = containers.Map('epsilon', 1);
policy_2 = epsilon;

rounds = zeros(n, 1);

for i = 1:n
	episode = generate_episode(index_1, policy_1, index_2, policy_2, '---------', 'o'+9*mod(i,2));
	rounds(i) = episode{3, end-1};
	
	G = 0;
	for j = size(episode,2)-1:-1:1
		G = gamma*G + episode{3,j};
		if all(cellfun(@(x) ~strcmp(x,episode{1,j}), episode(1,1:j-1), 'UniformOutput', true))
			if ~isKey(index_1, episode{1,j})
				index_1(episode{1,j}) = length(policy_1)+1;
				action_values{index_1(episode{1,j})} = zeros(sum(episode{1,j}=='-'),3);
				L = 0;
				for k = 1:9
					if episode{1,j}(k) == '-'
						L = L+1;
						action_values{index_1(episode{1,j})}(L,1) = k;
					end
				end
			end
			
			action_index = find(action_values{index_1(episode{1,j})}(:,1) == episode{2,j});
			action_value_old = action_values{index_1(episode{1,j})}(action_index,2);
			visits_old = action_values{index_1(episode{1,j})}(action_index,3);
			
			action_values{index_1(episode{1,j})}(action_index,2) = (action_value_old*visits_old+G)/(visits_old+1);
			action_values{index_1(episode{1,j})}(action_index,3) = visits_old+1;
			
			action_index = find(action_values{index_1(episode{1,j})}(:,2) == max(action_values{index_1(episode{1,j})}(:,2)), 1);
			policy_1(index_1(episode{1,j})) = action_values{index_1(episode{1,j})}(action_index,1);
		end
	end
end

fprintf('rounds  win    lose   tie\n')
fprintf('--------------------------\n')
fprintf('%5d%6.1f%%%6.1f%%%6.1f%%\n', n, sum(rounds==1)/n*100, sum(rounds==-1)/n*100, sum(rounds~=1 & rounds~=-1)/n*100);

plot_results(rounds, 1)

%% cleanup
clear i j k L action_index action_value_old visits_old