function [S_out] = channel_model(S_tx, N_path, N0_dB, f0, B)
    c = 3e8;
    L = length(S_tx);

    D = 10 + 490 * rand(1, N_path);
    D = D(:);
    D1 = min(D);

    T_s = 1 / B;
    tau = round((D - D1) ./ (c * T_s));

    if any(tau < 0)
        error('Отрицательная задержка - ошибка расчета!');
    end

    G = c ./ (4 * pi * D .* f0);

    max_tau = max(tau);
    S_i = cell(N_path, 1);

    for i = 1:N_path
        S_i{i} = [zeros(1, tau(i)), S_tx];

        current_len = length(S_i{i});

        if current_len < L + max_tau
            S_i{i} = [S_i{i}, zeros(1, L + max_tau - current_len)];
        end

    end

    S_mpy = zeros(1, L + max_tau, 'like', 1i);

    for i = 1:N_path
        S_mpy = S_mpy + G(i) * S_i{i};
    end

    M = length(S_mpy);
    n = wgn(M, 1, N0_dB, 'complex');
    S_rx = S_mpy + n;

    S_out = S_rx(1:L);
end
