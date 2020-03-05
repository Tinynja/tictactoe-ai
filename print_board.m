function print_board(board, varargin)

if isempty(varargin)
	last_move = 0;
else
	last_move = varargin{1};
end

% Sample grid:
%      |     |
%  (1) | (2) | (3)
% -----+-----+-----
%  (4) | (5) | (6)
% -----+-----+-----
%  (7) | (8) | (9)
%      |     |
% 

grid = strings(9,1);

for i = 1:length(board)
	if board(i) == '-'
		grid(i) = strcat("(",num2str(i),")");
	else
		if i == last_move
			grid(i) = strcat(" ",upper(board(i))," ");
		else
			grid(i) = strcat(" ",board(i)," ");
		end
	end
end

fprintf('      |     |\n')
fprintf('  %s | %s | %s\n', grid(1:3))
fprintf(' -----+-----+-----\n')
fprintf('  %s | %s | %s\n', grid(4:6))
fprintf(' -----+-----+-----\n')
fprintf('  %s | %s | %s\n', grid(7:9))
fprintf('      |     |\n')

end