L = 2;
T = 5;
a = 2;

A = @(k) (2/L) * (integral(@(x) x.^3 .* (x - 1).^2 .* sin(k * pi * x / L), 0, 1) + ...
                 integral(@(x) (2 - x).^3 .* (x - 1).^2 .* sin(k * pi * x / L), 1, 2));
B = @(k) 0;

function res = u(x, t, A, B, L, a)
    res = zeros(size(x));
    for k = 1:40
        res = res + ...
            sin(k * pi * x / L) .* ...
            (A(k) * cos(k * pi * a * t / L) + ...
             B(k) * sin(k * pi * a * t / L));
    end
end

x_axis = 0:0.01:L;
figure;
% Animation
for t = 0:0.025:T
    plot(x_axis, u(x_axis, t, A, B, L, a));
    axis([0, L, -0.1, 0.1])
    title(sprintf('t = %.3f', t));
    xlabel('x'); ylabel('u(x,t)');
    pause(0.1)
end

% Snapshots
snapshotTimes = [1, 2, 3, 4];
figure;
for i = 1:4
    tSnap = snapshotTimes(i);
    subplot(4, 1, i);
    plot(x_axis, u(x_axis, tSnap, A, B, L, a), 'r', 'LineWidth', 2);
    title(sprintf('Snapshot at t = %.1f', tSnap));
    xlabel('x'); ylabel('u(x,t)');
    axis([0, L, -0.1, 0.1]);
end

