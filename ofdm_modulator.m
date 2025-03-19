function [modulated_symbol] = ofdm_modulator(qpsk_symbols, delta_Rs, T_CP, C)
    N_data = length(qpsk_symbols);

    N_subcarrier = calculate_N_subcarrier(N_data, delta_Rs);

    N_RS = floor((N_subcarrier - 1) / delta_Rs) + 1;

    rs_indices = 1:delta_Rs:N_subcarrier;

    subcarriers = zeros(1, N_subcarrier);

    rs_signal = 0.707 + 1j * 0.707;
    subcarriers(rs_indices) = rs_signal;

    all_indices = 1:N_subcarrier;
    data_indices = setdiff(all_indices, rs_indices);

    if length(data_indices) ~= N_data
        error('Mismatch between data length and available subcarriers');
    end

    subcarriers(data_indices) = qpsk_symbols;

    N_0 = round(C * (N_subcarrier + N_RS));

    left_zeros = zeros(1, N_0);
    right_zeros = zeros(1, N_0);
    full_subcarriers = [left_zeros, subcarriers, right_zeros];

    ofdm_temp = ifft(full_subcarriers);

    if T_CP > length(ofdm_temp)
        error('Cyclic prefix length exceeds OFDM symbol length');
    end

    cp = ofdm_temp(end - T_CP + 1:end);
    modulated_symbol = [cp, ofdm_temp];
end

function N_subcarrier = calculate_N_subcarrier(N_data, delta_Rs)
    x = N_data;

    while true
        current_N_RS = floor((x - 1) / delta_Rs) + 1;

        if x - current_N_RS == N_data
            break;
        else
            x = x + 1;
        end

    end

    N_subcarrier = x;
end
