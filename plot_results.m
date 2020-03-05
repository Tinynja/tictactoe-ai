function plot_results(rounds, varargin)

rates = zeros(4, length(rounds));

for i = 1:length(rounds)
	rates(:, i) = [i;
								 sum(rounds(1:i)==1)/i*100;
								 sum(rounds(1:i)==-1)/i*100;
								 sum(rounds(1:i)~=1 & rounds(1:i)~=-1)/i*100];
end

if isempty(varargin)
	figure();
else
	figure(varargin{1});
end
set(gcf, 'windowstate', 'maximized');

plot(rates(1,:), rates(2,:), 'linewidth', 1.5, 'displayname', 'Win'); hold on;
text(rates(1,end), rates(2, end), sprintf('%.1f%%', rates(2, end)), 'horizontalalignment', 'right', 'verticalalignment', 'bottom', 'fontsize', 12, 'fontweight', 'bold');
plot(rates(1,:), rates(3,:), 'linewidth', 1.5, 'displayname', 'Lose');
text(rates(1,end), rates(3, end), sprintf('%.1f%%', rates(3, end)), 'horizontalalignment', 'right', 'verticalalignment', 'bottom', 'fontsize', 12, 'fontweight', 'bold');
plot(rates(1,:), rates(4,:), 'linewidth', 1.5, 'displayname', 'Tie');
text(rates(1,end), rates(4, end), sprintf('%.1f%%', rates(4, end)), 'horizontalalignment', 'right', 'verticalalignment', 'bottom', 'fontsize', 12, 'fontweight', 'bold');
hold off;

box on; grid on; grid minor;
xlabel('Number of episodes')
ylabel('Rate [%]')
legend('-dynamiclegend')
legend('fontsize', 14)

end